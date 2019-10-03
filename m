Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89B9CAF11
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfJCTUl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 15:20:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:61339 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfJCTUl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 15:20:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 12:20:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="192213607"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2019 12:20:40 -0700
Date:   Thu, 3 Oct 2019 12:20:40 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v7 7/7] PCI: Skip Enhanced Allocation (EA) initialization
 for VF device
Message-ID: <20191003192040.GA54240@otc-nc-03>
References: <ecff2638-7a5a-3d5d-6f30-f9517b139696@linux.intel.com>
 <20191003185747.GA178031@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003185747.GA178031@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 03, 2019 at 01:57:47PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 03, 2019 at 10:21:24AM -0700, Kuppuswamy Sathyanarayanan wrote:
> > Hi Bjorn,
> > 
> > On 8/28/19 3:14 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > As per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced Allocation
> > > Capability. So skip pci_ea_init() for virtual devices.
> > > 
> > > Cc: Ashok Raj <ashok.raj@intel.com>
> > > Cc: Keith Busch <keith.busch@intel.com>
> > > Suggested-by: Ashok Raj <ashok.raj@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > This patch was also dropped in your v8. Is this also intentional?
> 
> Yes, I dropped it because I didn't think there was much motivation for
> it.

Agreed!

> 
> If a device is broken, i.e., a VF has an EA capability, this patch
> silently returns.  The existing code would try to use the EA
> capability and something would probably blow up, so in that sense,
> this patch makes the hardware issue less visible.
> 
> If a device is correct, i.e., a VF does *not* have an EA capability,
> pci_find_capability() will fail anyway, so this patch doesn't change
> the functional behavior.


But do you think while at this can we atleast do a warning
to make sure HW probably messed up just after the EA capability
is read? Atleast it would be an early warning vs. it trying to break
later. Like the other issues we ran into with the PIN interrupt
accidently set in some hardware for VF's for instance. 

> 
> This patch *does* avoid the pci_find_capability() in that case, which
> is a performance optimization.  We could merge it on that basis, but
> we should try to quantify the benefit to see if it's really worthwhile
> and the commit log should use that as the explicit motivation.
> 
> > > ---
> > >   drivers/pci/pci.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 1b27b5af3d55..266600a11769 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -3025,6 +3025,13 @@ void pci_ea_init(struct pci_dev *dev)
> > >   	int offset;
> > >   	int i;
> > > +	/*
> > > +	 * Per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced
> > > +	 * Allocation Capability.
> > > +	 */
> > > +	if (dev->is_virtfn)
> > > +		return;
> > > +
> > >   	/* find PCI EA capability in list */
> > >   	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> > >   	if (!ea)
> > 
> > -- 
> > Sathyanarayanan Kuppuswamy
> > Linux kernel developer
> > 
