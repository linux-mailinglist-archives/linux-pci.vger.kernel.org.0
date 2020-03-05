Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7877B179E6D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 04:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgCEDxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 22:53:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47928 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgCEDxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 22:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583380423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dRwSfMa7qKrmqL7MdtHbIwI2LezXgxKe/a4kDF36F0=;
        b=Ll+tdUpDitdARv9Fvx9NieWzCQvHiAsrPpeSbVwlpr6EJfTr91pyFlRr6BwcEBpVWDrXvL
        hH6LL3+JbRY/U5nUalenrTECXhOcX5z8vQ/laHyJI+JTTAwCCstId4tjVkVsFAjA9hKUfy
        MGJXg9F8qWYwMtgNIMh/4toYIySfEso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-xvX7mDflP-2_S1QXHKaujw-1; Wed, 04 Mar 2020 22:53:39 -0500
X-MC-Unique: xvX7mDflP-2_S1QXHKaujw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4AC018A5505;
        Thu,  5 Mar 2020 03:53:37 +0000 (UTC)
Received: from localhost (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F54E5C219;
        Thu,  5 Mar 2020 03:53:31 +0000 (UTC)
Date:   Thu, 5 Mar 2020 11:53:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Kairui Song <kasong@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Randy Wright <rwright@hpe.com>, Dave Young <dyoung@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>, jroedel@suse.de
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200305035329.GD4433@MiWiFi-R3L-srv>
References: <20191225192118.283637-1-kasong@redhat.com>
 <20200222165631.GA213225@google.com>
 <CACPcB9dv1YPhRmyWvtdt2U4g=XXU7dK4bV4HB1dvCVMTpPFdzA@mail.gmail.com>
 <CABeXuvqm1iUGt1GWC9eujuoaACdPiZ2X=3LjKJ5JXKZcXD_z_g@mail.gmail.com>
 <CABeXuvonZpwWfcUef4PeihTJkgH2ZC_RCKuLR3rH3Re4hx36Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvonZpwWfcUef4PeihTJkgH2ZC_RCKuLR3rH3Re4hx36Aw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Joerg to CC.

On 03/03/20 at 01:01pm, Deepa Dinamani wrote:
> I looked at this some more. Looks like we do not clear irqs when we do
> a kexec reboot. And, the bootup code maintains the same table for the
> kexec-ed kernel. I'm looking at the following code in

I guess you are talking about kdump reboot here, right? Kexec and kdump
boot take the similar mechanism, but differ a little.

> intel_irq_remapping.c:
> 
>         if (ir_pre_enabled(iommu)) {
>                 if (!is_kdump_kernel()) {
>                         pr_warn("IRQ remapping was enabled on %s but
> we are not in kdump mode\n",
>                                 iommu->name);
>                         clear_ir_pre_enabled(iommu);
>                         iommu_disable_irq_remapping(iommu);
>                 } else if (iommu_load_old_irte(iommu))

Here, it's for kdump kernel to copy old ir table from 1st kernel.

>                         pr_err("Failed to copy IR table for %s from
> previous kernel\n",
>                                iommu->name);
>                 else
>                         pr_info("Copied IR table for %s from previous kernel\n",
>                                 iommu->name);
>         }
> 
> Would cleaning the interrupts(like in the non kdump path above) just
> before shutdown help here? This should clear the interrupts enabled
> for all the devices in the current kernel. So when kdump kernel
> starts, it starts clean. This should probably help block out the
> interrupts from a device that does not have a driver.

I think stopping those devices out of control from continue sending
interrupts is a good idea. While not sure if only clearing the interrupt 
will be enough. Those devices which will be initialized by their driver
will brake, but devices which drivers are not loaded into kdump kernel
may continue acting. Even though interrupts are cleaning at this time,
the on-flight DMA could continue triggerring interrupt since the ir
table and iopage table are rebuilt.

