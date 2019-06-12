Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB98442F6C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 20:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfFLS6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 14:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfFLS6T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 14:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3F5230C1AE7;
        Wed, 12 Jun 2019 18:58:18 +0000 (UTC)
Received: from x1.home (ovpn-116-190.phx2.redhat.com [10.3.116.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68ECF5D9D5;
        Wed, 12 Jun 2019 18:58:18 +0000 (UTC)
Date:   Wed, 12 Jun 2019 12:58:17 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com, mike.campin@intel.com
Subject: Re: [PATCH v2 1/1] PCI/IOV: Fix incorrect cfg_size for VF > 0
Message-ID: <20190612125817.42909d83@x1.home>
In-Reply-To: <0b21c76e-53f3-c35e-cebf-00719e451b11@linux.intel.com>
References: <20190612170647.43220-1-sathyanarayanan.kuppuswamy@linux.intel.com>
        <20190612121910.231368e2@x1.home>
        <0b21c76e-53f3-c35e-cebf-00719e451b11@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 18:58:19 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 12 Jun 2019 11:41:36 -0700
sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
wrote:

> On 6/12/19 11:19 AM, Alex Williamson wrote:
> > On Wed, 12 Jun 2019 10:06:47 -0700
> > sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> >  
> >> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >>
> >> Commit 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
> >> other VFs") calculates and caches the cfg_size for VF0 device before
> >> initializing the pcie_cap of the device which results in using incorrect
> >> cfg_size for all VF devices > 0. So set pcie_cap of the device before
> >> calculating the cfg_size of VF0 device.
> >>
> >> Fixes: 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
> >> other VFs")
> >> Cc: Ashok Raj <ashok.raj@intel.com>
> >> Suggested-by: Mike Campin <mike.campin@intel.com>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> ---
> >>
> >> Changes since v1:
> >>   * Fixed a typo in commit message.
> >>
> >>   drivers/pci/iov.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> >> index 3aa115ed3a65..2869011c0e35 100644
> >> --- a/drivers/pci/iov.c
> >> +++ b/drivers/pci/iov.c
> >> @@ -160,6 +160,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> >>   	virtfn->device = iov->vf_device;
> >>   	virtfn->is_virtfn = 1;
> >>   	virtfn->physfn = pci_dev_get(dev);
> >> +	virtfn->pcie_cap = pci_find_capability(virtfn, PCI_CAP_ID_EXP);
> >>   
> >>   	if (id == 0)
> >>   		pci_read_vf_config_common(virtfn);  
> > Why not re-order until after we've setup pcie_cap?
> >
> > https://lore.kernel.org/linux-pci/20190604143617.0a226555@x1.home/T/#  
> 
> pci_read_vf_config_common() also caches values for properties like 
> class, hdr_type, susbsystem_vendor/device. These values are read/used in 
> pci_setup_device(). So if we can use cached values in 
> pci_setup_device(), we don't have to read them from registers twice for 
> each device.

Sorry, I missed that dependency, a bit too subtle.  It's still pretty
ugly that pci_setup_device()->set_pcie_port_type() is the canonical
location for setting pcie_cap and now we need to kludge it earlier.
What about the question in the self follow-up to my patch in the link
above, can we simply assume 4K config space on a VF?  Thanks,

Alex
