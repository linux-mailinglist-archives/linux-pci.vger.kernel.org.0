Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2898E210906
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 12:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgGAKOG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 06:14:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:37068 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbgGAKOF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 06:14:05 -0400
IronPort-SDR: MRfYXTeqkEMfpTrdRfK/AsaGSUb3YdmMeCY9luwRr8GN1sJZqRgZwQ6Ix33sUpHXCKX+sdS+yq
 7S7yVY7WeUwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134800497"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="134800497"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 03:14:04 -0700
IronPort-SDR: yMH6MNDClaCKcvFcAaXtGOdIA+O2gPh34c5ZIiSQ4/oaHhml3+97i7XHRE34sSGZXNTf/71fF8
 rAN8Vy4VNojA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="386969002"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 01 Jul 2020 03:14:01 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 01 Jul 2020 13:14:00 +0300
Date:   Wed, 1 Jul 2020 13:14:00 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Make pcie_find_root_port() work for PCIe root ports
 as well
Message-ID: <20200701101400.GN5180@lahna.fi.intel.com>
References: <20200622161248.51099-1-mika.westerberg@linux.intel.com>
 <20200630220107.GA3489322@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630220107.GA3489322@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 30, 2020 at 05:01:07PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 22, 2020 at 07:12:48PM +0300, Mika Westerberg wrote:
> > Commit 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
> > pci_find_pcie_root_port()") unified the root port finding functionality
> > into a single function but missed the fact that the passed in device may
> > already be a root port. This causes the kernel to block power management
> > of PCIe hierarchies in recent systems because ->bridge_d3 started to
> > return false for such ports after the commit in question.
> > 
> > Fixes: 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and pci_find_pcie_root_port()")
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  include/linux/pci.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index c79d83304e52..c17c24f5eeed 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2169,8 +2169,13 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
> >   */
> >  static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
> >  {
> > -	struct pci_dev *bridge = pci_upstream_bridge(dev);
> > +	struct pci_dev *bridge;
> >  
> > +	/* If dev is already root port */
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> > +		return dev;
> > +
> > +	bridge = pci_upstream_bridge(dev);
> >  	while (bridge) {
> >  		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
> >  			return bridge;
> 
> I applied the patch below, which is slightly simplified but I think
> still equivalent, to for-linus for v5.8.  Let me know if it's not.

Thanks I just tested and it also works fine.

> I dropped the stable tag because 6ae72bfa656e was merged for v5.8-rc1,
> and I assume v5.7 works correctly so it doesn't need any change.

Right, makes sense.
