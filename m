Return-Path: <linux-pci+bounces-13776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5598F507
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 19:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CB41C20967
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D71A7270;
	Thu,  3 Oct 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oI7zp2D2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53BA1A7065
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976250; cv=none; b=VsB8jXUwex1J+bv5PmvpFtVrrJQI3xPTrse3CpU6RFuoPA3AXPyMjksnQf7usJkkPq929lM+4QDcLzTbOO+Dn0QcdNsXdfT+Ut0UgmRGMCfDv6yLKfI13KAEbGWp3VTGZHSx5WCIuEis2QCJSdYN8uqgXwEWFD+Dl3ZHZ21YOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976250; c=relaxed/simple;
	bh=HsyFajdGNcsL0df2CmRKGR6l8NQOGYEfAp5goNZI1D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWq4PSTRMKuJP8n2nR+w/5UHwQYDGzr8cjZhnKIgzRiXHaHBMtSmJay8gmVVBd9KaLBS9Eh3jYLU7carQkPQi+rlwANuSldV6hBzR4YfOZiXVWyTlR282zZPPNr7RWrKgDVaRVeoAgcj2fl6fdbDbG0RNxb6YG7mC8QmI3TSY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oI7zp2D2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b0b2528d8so13754195ad.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Oct 2024 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727976248; x=1728581048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXD9OrTHHnhr2W1xER2ep56xRrfl6ZDonATSMbm4ufI=;
        b=oI7zp2D2YEGf1A78qEnBh2w8k0sOIQ4JRqJEmuRssL0qmcGrUKNnkp8M5HXbTXwJD6
         dyqCmdhtYdAZpGBxXlXYgKOcAC9RZHbCZv3gxoLjlyU4O8+NhIpHsfE6aKq2UZqrsLOD
         QPWCCfK/+fyBrT8/1rCBkgr99pFfw/kaE0eMTiQ0XRqhvIUaA07mFdlhQTb50Y0TsW+P
         nJ/Ict82Wrd/rwqHo19pfe8Mbk+bWnRDtH2SaKeyO8y3I38zAY2RA+lIrs70+YXuVB4F
         M22vHlIxkdyaD80fpl2MkBykkLnlHW41ED6HYzoXoEg+w319InUJFEozc+kl68XVBAsI
         LCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976248; x=1728581048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXD9OrTHHnhr2W1xER2ep56xRrfl6ZDonATSMbm4ufI=;
        b=oMso19RFjUy6hpPTYZdyBAGM8EUivYP/0Ip8NX+S50LAreVsWVeYGWDxWBS0vkktE3
         FWd5cKI3SfohY3PbCnQbEy0T82dOy46qga1XvfQuWL+0YQThoChEkChePBM2ZbC6SKtH
         6CKIDAGNn71buguvFD1+fpz9vMaJrGrQLZjUjbkopP4546mwBXBSoVQnxoHZQB9naH5/
         eDGj9rFGU/tQcYcZqVG6+Iap2THYoxUsKGP72VhP0eLW4LcA6Uz7VioqFb0CIIReydD7
         5l6FJpm/LssHxR1eXBfGNRjab8RIxS4j5UoiEgPz+9AGlSHggmYRMlD4mw42mltDT/1M
         liXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIdvKr3rsvVnYU3sFuhb3pGgPfWz1xSvUjaCyg5Y3GQUNUscGNo9vHTgkCzWbxjZoL7t6kkiAluNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzalU4SEzceoaAaL/IGEOPQVDizEjcHIOTtEHA6q4N4xgVP2Ed8
	bUMwqZ9+Ub8LaedoAZOrSFw8KdfSsvpUWLJb//ZRfzYYEXv+CPrF5XKEdh6vKw==
X-Google-Smtp-Source: AGHT+IHT15X4qRiIP9HFPy8dxKranzrln0o9FDf9BeiecBM32cttCUq37HWHldCkjQFLD4sCGxwLRg==
X-Received: by 2002:a17:902:d2c5:b0:20b:6d8c:461 with SMTP id d9443c01a7336-20bc59f1c11mr120424165ad.5.1727976247720;
        Thu, 03 Oct 2024 10:24:07 -0700 (PDT)
Received: from google.com (1.243.198.35.bc.googleusercontent.com. [35.198.243.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead257esm11468795ad.29.2024.10.03.10.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:24:07 -0700 (PDT)
Date: Thu, 3 Oct 2024 22:53:58 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <Zv7TLs9_CMaYQ--b@google.com>
References: <20241003132503.2279433-1-ajayagarwal@google.com>
 <20241003170122.GA310049@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003170122.GA310049@bhelgaas>

On Thu, Oct 03, 2024 at 12:01:22PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 03, 2024 at 06:55:03PM +0530, Ajay Agarwal wrote:
> > The current sequence in the driver for L1ss update is as follows.
> > 
> > Disable L1ss
> > Disable L1
> > Enable L1ss as required
> > Enable L1 if required
> > 
> > With this sequence, a bus hang is observed during the L1ss
> > disable sequence when the RC CPU attempts to clear the RC L1ss
> > register after clearing the EP L1ss register.
> 
> Thanks for this.  What exactly does the bus hang look like to a user?
>
The CPU is just hung on reading the RC PCI_L1SS_CTL1 register. After
some time, the CPU watchdog expires and the system reboots.

> I guess the problem happens in pcie_config_aspm_l1ss(), where we do:
> 
>   pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ... 0)
>   pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ... 0)
> 
> where clearing the child (endpoint) PCI_L1SS_CTL1_L1_2_MASK works, but
> something goes wrong when clearing the parent (RP) mask?  The
> clear_and_set will do a read followed by a write, and one of those
> causes some kind of error?
>
During ASPM disable, in pcie_config_aspm_l1ss(), we do:
   1. pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ... 0)
   2. pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ... 0)
   3. pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ... 0)
   4. pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ... 0)

We observe that the steps 1 and 2 go through just fine. But the read of
PCI_L1SS_CTL1 register in the step 3 hangs. I am not sure why.
The issue is pretty difficult to reproduce, and adding prints around
these steps masks the issue.

> > It looks like the
> > RC attempts to enter L1ss again and at the same time, access to
> > RC L1ss register fails because aux clk is still not active.
> 
> I assume "access to RC L1ss register fails" means something like
> "reading the Root Port PCI_L1SS_CTL1 register returns ~0" which I
> guess would be the read part of the pci_clear_and_set_config_dword()?
> 
> ~0 data might be returned because of some PCIe error like Unsupported
> Request, Completion Timeout, etc?  Such an error should be logged in
> the AER Capability.
>
This is not a PCIe bus transaction. This is CPU on the RC side accessing
the RC side config register, so the link is not involved at all. Hence,
no timeout or other AER errors logged/reported. The AXI-DBI bus just
hangs.

> This *sounds* like it would be a hardware defect in the Root Port.
> This register is on the upstream end of the link, so I would think it
> would be readable no matter what state the link is in.
> 
Exactly. As described above, this is not a PCIe transaction.

> Sec 5.5.4 requires that L1 be disabled in PCI_EXP_LNKCTL while
> *setting* either of the ASPM L1 PM Substates enable bits.  I don't see
> anything there about requiring that for *clearing* those enable bits.
> But maybe it is required, and in any event I guess it's simpler to do
> it as you do here and have L1 (indeed *all* ASPM) disabled while
> configuring L1 SS.
> 
Right. The spec does not talk about the sequence when one wants to clear
these L1ss bits. But I am interpreting the word "setting" as "setting to
1" as well as "setting to 0".

> > PCIe spec r6.2, section 5.5.4, recommends that setting either
> > or both of the enable bits for ASPM L1 PM Substates must be done
> > while ASPM L1 is disabled. My interpretation here is that
> > clearing L1ss should also be done when L1 is disabled. Thereby,
> > change the sequence as follows.
> > 
> > Disable L1
> > Disable L1ss
> > Enable L1ss as required
> > Enable L1 if required
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 50 ++++++++++++++++++++---------------------
> >  1 file changed, 24 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index cee2365e54b8..c172886129f3 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -848,17 +848,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> >  /* Configure the ASPM L1 substates */
> >  static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
> >  {
> > -	u32 val, enable_req;
> > +	u32 val;
> >  	struct pci_dev *child = link->downstream, *parent = link->pdev;
> >  
> > -	enable_req = (link->aspm_enabled ^ state) & state;
> > -
> >  	/*
> > -	 * Here are the rules specified in the PCIe spec for enabling L1SS:
> > +	 * Spec r6.2, section 5.5.4, mentions the rules for enabling L1SS:
> >  	 * - When enabling L1.x, enable bit at parent first, then at child
> >  	 * - When disabling L1.x, disable bit at child first, then at parent
> > -	 * - When enabling ASPM L1.x, need to disable L1
> > -	 *   (at child followed by parent).
> >  	 * - The ASPM/PCIPM L1.2 must be disabled while programming timing
> >  	 *   parameters
> >  	 *
> > @@ -871,16 +867,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
> >  				       PCI_L1SS_CTL1_L1SS_MASK, 0);
> >  	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> >  				       PCI_L1SS_CTL1_L1SS_MASK, 0);
> > -	/*
> > -	 * If needed, disable L1, and it gets enabled later
> > -	 * in pcie_config_aspm_link().
> > -	 */
> > -	if (enable_req & (PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2)) {
> > -		pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
> > -					   PCI_EXP_LNKCTL_ASPM_L1);
> > -		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
> > -					   PCI_EXP_LNKCTL_ASPM_L1);
> > -	}
> >  
> >  	val = 0;
> >  	if (state & PCIE_LINK_STATE_L1_1)
> > @@ -937,21 +923,33 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
> >  		dwstream |= PCI_EXP_LNKCTL_ASPM_L1;
> >  	}
> >  
> > +	/*
> > +	 * Spec r6.2, section 5.5.4, recommends that setting either or both of
> > +	 * the enable bits for ASPM L1 PM Substates must be done while ASPM L1
> > +	 * is disabled. So disable L1 here, and it gets enabled later after the
> > +	 * L1ss configuration has been completed.
> > +	 *
> > +	 * Spec r6.2, section 7.5.3.7, mentions that ASPM L1 must be enabled by
> > +	 * software in the Upstream component on a Link prior to enabling ASPM
> > +	 * L1 in the Downstream component on the Link. When disabling L1,
> > +	 * software must disable ASPM L1 in the Downstream component on a Link
> > +	 * prior to disabling ASPM L1 in the Upstream component on that Link.
> > +	 *
> > +	 * Spec doesn't mention L0s.
> > +	 *
> > +	 * Disable L1 and L0s here, and they get enabled later after the L1ss
> > +	 * configuration has been completed.
> > +	 */
> > +	list_for_each_entry(child, &linkbus->devices, bus_list)
> > +		pcie_config_aspm_dev(child, 0);
> > +	pcie_config_aspm_dev(parent, 0);
> > +
> >  	if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
> >  		pcie_config_aspm_l1ss(link, state);
> >  
> > -	/*
> > -	 * Spec 2.0 suggests all functions should be configured the
> > -	 * same setting for ASPM. Enabling ASPM L1 should be done in
> > -	 * upstream component first and then downstream, and vice
> > -	 * versa for disabling ASPM L1. Spec doesn't mention L0S.
> > -	 */
> > -	if (state & PCIE_LINK_STATE_L1)
> > -		pcie_config_aspm_dev(parent, upstream);
> > +	pcie_config_aspm_dev(parent, upstream);
> >  	list_for_each_entry(child, &linkbus->devices, bus_list)
> >  		pcie_config_aspm_dev(child, dwstream);
> > -	if (!(state & PCIE_LINK_STATE_L1))
> > -		pcie_config_aspm_dev(parent, upstream);
> 
> I think the reason for having pcie_config_aspm_dev(parent) both before
> and after configuring the children is because pcie_config_aspm_link()
> may be called either to enable L1 or to disable it.
> 
> I guess your change always disables ASPM completely (disabling the
> downstream (child) component first, then the upstream), and here we
> are either leaving L1 disabled or enabling it, and in either case it
> should be safe to configure the upstream (parent) component first,
> then the downstream one.
> 
> Of course, we may also enable L0s here, and AFAICS it should always be
> safe to do that in the upstream component first, followed by the
> downstream one.
> 
> Bottom line, this looks good to me, and I think it's nice that this
> removes the "parent then child" or "child then parent" logic here.
> 
Agreed with all the points.

> >  	link->aspm_enabled = state;
> >  
> > -- 
> > 2.46.1.824.gd892dcdcdd-goog
> > 

