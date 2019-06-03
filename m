Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F017433B83
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 00:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfFCWkp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 18:40:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfFCWko (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jun 2019 18:40:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DDA130018E9;
        Mon,  3 Jun 2019 22:40:44 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 395545B684;
        Mon,  3 Jun 2019 22:40:43 +0000 (UTC)
Date:   Mon, 3 Jun 2019 16:40:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     JD Zheng <jiandong.zheng@broadcom.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        keith.busch@intel.com, bcm-kernel-feedback-list@broadcom.com,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: SSD surprise removal leads to long wait inside pci_dev_wait()
 and FLR 65s timeout
Message-ID: <20190603164042.2276076d@x1.home>
In-Reply-To: <78f95dfe-ac2b-408f-0e2a-b3b9d69575dd@broadcom.com>
References: <8f2d88a5-9524-c4c3-a61f-7d55d97e1c18@broadcom.com>
        <20190603004414.GA189360@google.com>
        <20190602194011.51ceaa23@x1.home>
        <78f95dfe-ac2b-408f-0e2a-b3b9d69575dd@broadcom.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 03 Jun 2019 22:40:44 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 3 Jun 2019 14:17:36 -0700
JD Zheng <jiandong.zheng@broadcom.com> wrote:

> On 6/2/19 6:40 PM, Alex Williamson wrote:
> > On Sun, 2 Jun 2019 19:44:14 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >   
> >> [+cc Alex, Lukas]
> >>
> >> On Fri, May 31, 2019 at 09:55:20AM -0700, JD Zheng wrote:  
> >>> Hello,
> >>>
> >>> I am running DPDK 18.11+SPDK 19.04 with v5.1 kernel. DPDK/SPDK uses SSD vfio
> >>> devices and after running SPDK's nvmf_tgt, unplugging a SSD cause kernel to
> >>> print out following:
> >>> [  105.426952] vfio-pci 0000:04:00.0: not ready 2047ms after FLR; waiting
> >>> [  107.698953] vfio-pci 0000:04:00.0: not ready 4095ms after FLR; waiting
> >>> [  112.050960] vfio-pci 0000:04:00.0: not ready 8191ms after FLR; waiting
> >>> [  120.498953] vfio-pci 0000:04:00.0: not ready 16383ms after FLR; waiting
> >>> [  138.418957] vfio-pci 0000:04:00.0: not ready 32767ms after FLR; waiting
> >>> [  173.234953] vfio-pci 0000:04:00.0: not ready 65535ms after FLR; giving up
> >>>
> >>> Looks like it is a PCI hotplug racing condition between DPDK's
> >>> eal-intr-thread thread and kernel's pciehp thread. And it causes lockup in
> >>> pci_dev_wait() at kernel side.
> >>>
> >>> When SSD is removed, eal-intr-thread immediately receives
> >>> RTE_INTR_HANDLE_ALARM and handler calls rte_pci_detach_dev() and at kernel
> >>> side vfio_pci_release() is triggered to release this vfio device, which
> >>> calls pci_try_reset_function(), then _pci_reset_function_locked().
> >>> pci_try_reset_function acquires the device lock but
> >>> _pci_reset_function_locked() doesn't return, therefore lock is NOT released.  
> > 
> > To what extent does vfio-pci need to learn about surprise hotplug?  My
> > expectation is that the current state of the code would only support
> > cooperative hotplug.  When a device is surprise removed, what backs a
> > user's mmaps?  AIUI, we don't have a revoke interface to invalidate
> > these.  We should probably start with an RFE or some development effort
> > to harden vfio-pci for surprise hotplug, it's not surprising it doesn't
> > just work TBH.  Thanks,
> > 
> > Alex
> > 
> >   
> 
> I did see other issues that DPDK unmap vifo device memory was stuck due 
> to surprise removal.
> 
> Are you saying that vfio-pci surprise removal is not fully implemented yet?

Has not even been evaluated for that use case afaik.  You are in
unknown and expected broken territory.  If this is an area you'd like
to contribute, great, but expect more than a bug fix here and there.
Thanks,

Alex
