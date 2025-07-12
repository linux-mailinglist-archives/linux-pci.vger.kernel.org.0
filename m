Return-Path: <linux-pci+bounces-31992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81846B02A4A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988AD1BC2354
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 09:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7933274669;
	Sat, 12 Jul 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge0qYzln"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048332C85;
	Sat, 12 Jul 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312938; cv=none; b=OhPca0DV1GN2rDQYoLKgd8mEcCb7BzTH08OuYwhY5VtlwHHpINxadv3zYf50/FbpOn/6TYmp8tlgt3hMYAjbcTKnxHezBv94nhDCSdDLB5ZzV419j/2pfb588nvQQLCrm05j83EWMBFDeoZodXCaxGe3w4tNVlV53FYEp+J9l3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312938; c=relaxed/simple;
	bh=s7cj6oQ/BwxZRbAJNXkKJ5U3lAZkjlVFoTQUXhnxDU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftllAb80POgVgUtM28H197KhQt2AGhjIGVO0wC2vxTrRkvUF+1HxG+1NP2iGhythf8EhkdOc+LedbziE882RtLW0JnpEHHVtiQgC4i3URO2AmDK3iSwBB3o7MMh21WxIsjpKcgcDh1w1d63S9UrQvPqNJWGirCfpQ3P61iRvEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge0qYzln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCDFC4CEEF;
	Sat, 12 Jul 2025 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752312938;
	bh=s7cj6oQ/BwxZRbAJNXkKJ5U3lAZkjlVFoTQUXhnxDU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge0qYzlnIYod4rhihkSfZD4ko+Zfwd285rO3xx6MFDFopsXEmAzxZk4y8kUb7p5bz
	 NoH3sJU09ss7eDPcX0nI/XutJaWC5u2uzHholnqK20XB64GB/AuwkMmqbGT50z/3ET
	 weq8vk33lsZdhItHh6IEgA6Brae0ppGkQ+/w/NDyRuJFYNDRh9wm+/WvEGZx/XRkzi
	 xEdusyZDWLymZabqIHnCjCBR2bIU5cNrDIwuvtLdRM36e4yr4NuqIFKIs1hWymlieF
	 Js97lk0OQzyOHYVmLLPukwlqvCm40w/OxWDENmp5MVJNqObf54eVY8A9HwLt9h23PU
	 sPYGY1BBZTjiw==
Date: Sat, 12 Jul 2025 15:05:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Message-ID: <qay63njqf7z7mchizt5sm66i67rvxxxicikxmfuvllmmxfy7ek@mulnjvde5q7w>
References: <604ffae3-1bfc-0922-b001-f3338880eb21@linux.intel.com>
 <20250711230013.GA2309106@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711230013.GA2309106@bhelgaas>

On Fri, Jul 11, 2025 at 06:00:13PM GMT, Bjorn Helgaas wrote:
> On Fri, Jul 11, 2025 at 04:38:48PM +0300, Ilpo Järvinen wrote:
> 
> > +++ b/include/linux/pci.h
> > @@ -1826,8 +1826,8 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
> >  #ifdef CONFIG_PCIEASPM
> >  int pci_disable_link_state(struct pci_dev *pdev, int state);
> >  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> > -int pci_enable_link_state(struct pci_dev *pdev, int state);
> 
> AFAICT there's no caller of this at all.  Why do we keep it?
> 

I'm just working on a series to convert the ath{10/11/12}k drivers to use this
API instead of modifying LNKCTL register directly:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath12k/pci.c#n961

> > -int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
> 
> We only have two callers of this (pcie-qcom.c and vmd.c, both in
> drivers/pci/), so it's not clear to me that it needs to be in
> include/linux/pci.h.
> 
> I'm a little dubious about it in the first place since I don't think
> drivers should be enabling ASPM states on their own, but pcie-qcom.c
> and vmd.c are PCIe controller drivers, not PCI device drivers, so I
> guess we can live with them for now.
> 
> IMO the "someday" goal should be that we get rid of aspm_policy and
> enable all the available power saving states by default.  We have
> sysfs knobs that administrators can use if necessary, and drivers or
> quirks can disable states if they need to work around hardware
> defects.
> 

Yeah, I think the default should be powersave and let the users disable it for
performance if they want.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

