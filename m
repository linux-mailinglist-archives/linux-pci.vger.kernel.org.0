Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED8DACAEAF
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfJCS5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 14:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbfJCS5u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 14:57:50 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D69D220862;
        Thu,  3 Oct 2019 18:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570129069;
        bh=VUZms35WLEMfQ6ssxS4VLvjvBarYopl2qOJcmQeQmeI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RNwwd/5hECe7dXysVQIqYWlbAQIU8/uvWdCbqRnnEuqFDTHjsQCBbuDXngb64VYuu
         GoHVAY/hXo9GraY0zIW+LixdiNA7JN6hfEyldB8+QvvQeKwnBKCuGOxqy8lc9jH/9E
         LAku9d9Z65l0/es2xvtAKnVLeIneWSgbk15M/+Hk=
Date:   Thu, 3 Oct 2019 13:57:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v7 7/7] PCI: Skip Enhanced Allocation (EA) initialization
 for VF device
Message-ID: <20191003185747.GA178031@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecff2638-7a5a-3d5d-6f30-f9517b139696@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 03, 2019 at 10:21:24AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Bjorn,
> 
> On 8/28/19 3:14 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > As per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced Allocation
> > Capability. So skip pci_ea_init() for virtual devices.
> > 
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Suggested-by: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> This patch was also dropped in your v8. Is this also intentional?

Yes, I dropped it because I didn't think there was much motivation for
it.

If a device is broken, i.e., a VF has an EA capability, this patch
silently returns.  The existing code would try to use the EA
capability and something would probably blow up, so in that sense,
this patch makes the hardware issue less visible.

If a device is correct, i.e., a VF does *not* have an EA capability,
pci_find_capability() will fail anyway, so this patch doesn't change
the functional behavior.

This patch *does* avoid the pci_find_capability() in that case, which
is a performance optimization.  We could merge it on that basis, but
we should try to quantify the benefit to see if it's really worthwhile
and the commit log should use that as the explicit motivation.

> > ---
> >   drivers/pci/pci.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 1b27b5af3d55..266600a11769 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3025,6 +3025,13 @@ void pci_ea_init(struct pci_dev *dev)
> >   	int offset;
> >   	int i;
> > +	/*
> > +	 * Per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced
> > +	 * Allocation Capability.
> > +	 */
> > +	if (dev->is_virtfn)
> > +		return;
> > +
> >   	/* find PCI EA capability in list */
> >   	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> >   	if (!ea)
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux kernel developer
> 
