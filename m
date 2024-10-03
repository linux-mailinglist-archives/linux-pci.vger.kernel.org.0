Return-Path: <linux-pci+bounces-13768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBDF98EFF2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF64E1C209A8
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB2174EFC;
	Thu,  3 Oct 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyEUt6ND"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1EE10A1E
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960672; cv=none; b=OBid6Q/9quECzS4tWVImnla7XmS4r8tKmTNOG7CSMpllQt31VOxLFEiN96uZ/FYvHQWpQxXdLurojJ/zHOdOTduIXdIG+B6EkbeOiRljM7NBTe9KX5YMAEJ0WrgKeXlADJgbg785oujqHkzvVDZTfA/H0NcvE34D7s1J1PgJTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960672; c=relaxed/simple;
	bh=YDZB9jXBihgzuJ0nCJOO7T9coyoXhnNKSE3IY4zLPNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLsLo240BPqudwiYEcYUqKkp54vfv7o2xTJ3AuFWIE1SMwZBZZClPbeAbKn++YfEDanUDIvGnBmRu5YMYoyvUEet20IvlMPrG3uDNBVr1o8CSCagX61Q+ojCySmLIPr/V9S3B8kQQ+D6qqXcszALQy+xRd/yKGlA6pIz20L3OZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyEUt6ND; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20bb39d97d1so7497025ad.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Oct 2024 06:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727960670; x=1728565470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oc1agfQ35AR/QRxz2L23CX3KBZEIT0UsSC37vvnqTE8=;
        b=VyEUt6ND2NU444OO0eGtPG+dHF99hHDk0TCokL+axBYpDpQmwDBpuDWuwlX7excGC/
         DCZNpndqmR2f6O9ZMYLIWIJzQSMCT7Asnaizi49Dbv0k3S3cJ3EOun1VPFNBlM1ZshLQ
         hv+X8gNGByvrCMKMaQdGAKBkw/4krZoTNKuciq2RimXBGIKumR6UjisKAW1Wi/M4uhg9
         xGTX7C9oVVdVHw3gg6L9CDUK5hdnoE73oZeNl4EH0CK1hEy+3TUNXnUix2c6w7YsUpcc
         bUN93zvws8VB8DrIt3yDzfZwwSq8Zplzw/xAAKfmvYnuDa1b4zlhJmDE+UwEt/u+N5NG
         fGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960670; x=1728565470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oc1agfQ35AR/QRxz2L23CX3KBZEIT0UsSC37vvnqTE8=;
        b=q3gZx2ascXrGQGgwifNE+5CVF+0qZ/XjftIkcOojAq8atyNSBCjqj2FsC/aMmh9Ys1
         YAOJXcCQ7mZ+HaJFlP2mxW2VspTdXHjpM0u9aV4lbE9xzVFDydEo9IALoa9t80WxQP8m
         rmLpx+e6XJoT6g/QnCxKhdEXwC0awQUOx5fgN3gm2eA30u2v5SK8ayljMpYqildnAcke
         Shm7NUfbbCvjp34wgv4gsqoREqTe8v+tY2Gs3QWez/o6/Vtf43rbvCcbeoFkdYU7K5Hv
         pmho6G+dSPHsb8hI000b76O7IX0cZw7ORIha8herAcBBmBC+RnXiCMrFu3I8DqUhyzuv
         C09g==
X-Forwarded-Encrypted: i=1; AJvYcCUdb/rZvkjdc/6hrQ+Gu4YXXDw8rGynNrgxPrD6kdcinL+ttB62SWZI3sgUXwktTrdGbKomz5kfQFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBu/32zXhlriOznij/pxBNeOO8jQj9zcYb3OovMD6GA8oEZ4wQ
	SGshoo5F2JKMwKAad+ZySKnY5EkTzIkRLex7HCHd3Bwdw61XloaHUlTuWxLeuQ==
X-Google-Smtp-Source: AGHT+IFmCMGVIfiUtqflNx3v8/3lll7ud6q84psD277aJ6VF7fosbphdTEBCdw4/wA0tBO3ZKijJiA==
X-Received: by 2002:a17:902:ce8f:b0:20b:68ec:6026 with SMTP id d9443c01a7336-20bc5a1940amr61634635ad.34.1727960669997;
        Thu, 03 Oct 2024 06:04:29 -0700 (PDT)
Received: from google.com (1.243.198.35.bc.googleusercontent.com. [35.198.243.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca3020sm8685475ad.84.2024.10.03.06.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:04:29 -0700 (PDT)
Date: Thu, 3 Oct 2024 18:34:19 +0530
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
Subject: Re: [PATCH] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <Zv6WU9CwbF9d34b3@google.com>
References: <20241001133519.2743673-1-ajayagarwal@google.com>
 <20241002181223.GA231923@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002181223.GA231923@bhelgaas>

On Wed, Oct 02, 2024 at 01:12:23PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 01, 2024 at 07:05:18PM +0530, Ajay Agarwal wrote:
> > The current sequence in the driver for L1ss update is as follows.
> > 
> > Disable L1ss
> > Disable L1
> > Enable L1ss as required
> > Enable L1 if required
> > 
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
> 
> This seems reasonable to me.  If you have seen a failure that is fixed
> by this change, please include some details here.
>
The failure is seen when the RC CPU attempts to clear the RC L1ss
register after clearing the EP L1ss register. We do not clearly
understand the state machine on the RC side which leads to this
behavior, but it looks like RC attempts to enter L1ss again and at the
same time, access to RC L1ss register fails because aux clk is still not
active. I will add some details in the next version.

> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 22 ++++++++--------------
> >  1 file changed, 8 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index cee2365e54b8..d37f66f9e9c8 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -848,16 +848,14 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
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
> >  	 * Here are the rules specified in the PCIe spec for enabling L1SS:
> >  	 * - When enabling L1.x, enable bit at parent first, then at child
> >  	 * - When disabling L1.x, disable bit at child first, then at parent
> > -	 * - When enabling ASPM L1.x, need to disable L1
> > +	 * - When enabling/disabling ASPM L1.x, need to disable L1
> >  	 *   (at child followed by parent).
> >  	 * - The ASPM/PCIPM L1.2 must be disabled while programming timing
> >  	 *   parameters
> 
> Since you're updating this comment already, can you add the spec
> citation here, e.g., "PCIe r6.2, sec 5.5.4"?
>
Added in the next version.

> > @@ -866,21 +864,17 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
> >  	 * what is needed.
> >  	 */
> >  
> > +	/* Disable L1, and it gets enabled later in pcie_config_aspm_link() */
> > +	pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
> > +				   PCI_EXP_LNKCTL_ASPM_L1);
> > +	pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
> > +				   PCI_EXP_LNKCTL_ASPM_L1);
> 
> I think it would be nice to have the disable and enable in the same
> place.  Could we move this to pcie_config_aspm_link()?  I'm not sure
> the pcie_config_aspm_dev() wrapper adds a lot of value, but we could
> at least do both ends using the same wrapper.
> 
Added in the next version.

> pcie_config_aspm_link() configures all children; here we only do one
> child.  I suspect we should do disable L1 for all of them here, and
> doing both in pcie_config_aspm_link() would make that clearer.
> 
> pcie_config_aspm_link() has a comment ("Spec 2.0 ...") about the
> configuration order, but I'd like to update that, add a section
> reference, and make sure we do the disable in the right order.
> 
Fixed in the next version.

> >  	/* Disable all L1 substates */
> >  	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
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
> > -- 
> > 2.46.1.824.gd892dcdcdd-goog
> > 

