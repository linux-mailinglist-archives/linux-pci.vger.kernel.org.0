Return-Path: <linux-pci+bounces-31997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05905B02C11
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 19:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342911C421AA
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658F1FBEBD;
	Sat, 12 Jul 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7WoWwRF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0A2BAF4;
	Sat, 12 Jul 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752339732; cv=none; b=DAB5PRgyyRi62Snwb7EoVOb8q58xbz0vhOhz/XhFiOyFuLYZJAKL9bZ2diBEcBfyix8nsZMaP4e427yDhVKZ8Drxn2WHc/Az+KeQv43gHnXxaHI06RlROaZLBzZcC8AQtT5FwpOVwbrxaS4XhnjB9LAXCgjcCDPgWQF53R3+wG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752339732; c=relaxed/simple;
	bh=1HY8c3/LmGoUrP3tyoScTxQmlAqVeoVJ3c1Lyp1DEdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i50NcipwR1m48DF2E/0CBQMHfmGcDy8WSrX80/cIcduEWPB4wEA5lhHTUSBbA3jq1HvPp7x6T5knwBRuP3JCR9yETCIigJuW0t1g1PhgzViceYnBrlw4ZAm5Enb/v+O2y+YNenB1KYe/iPEe6m8yFR0us/JRdPdSoIetP8yWPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7WoWwRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A062C4CEEF;
	Sat, 12 Jul 2025 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752339731;
	bh=1HY8c3/LmGoUrP3tyoScTxQmlAqVeoVJ3c1Lyp1DEdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7WoWwRFokdz7QDOrKE4h+u1d9Au7oDqmNWsM7XwvnxyFATLfVzrItCT2DRABwlx0
	 dp6wwxre5pFpYhOdC1JO+wdM+Ur78vjS9j89kcIpiLNW3Tv0VSaoFC5j2LQRqrBWZD
	 FvhcPFcLlEAbnpVWzJ8vjUD1Qkh3K3TKKruZJhHMsAhyXPLK7p8SswM9jOiE6chpg+
	 /ITIuLkKAsoovWme8T4v7+OCNRTfSAilLKSemsKZ3zVVyYQDjvk/iQqJG7zJfSdU4P
	 Dg+PNXJifWB+6dgtlcskTrw1DMVElBintfFo20ICsXELHarEFSxfG9lak4caOCnqnZ
	 POAbVYyLtBqEw==
Date: Sat, 12 Jul 2025 22:32:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Message-ID: <drj7qm65bfu7irnfyy2cfhzkqlrkvd2tuvlxrlpxyohhpjbs3x@ecgooujjynmx>
References: <604ffae3-1bfc-0922-b001-f3338880eb21@linux.intel.com>
 <20250711230013.GA2309106@bhelgaas>
 <qay63njqf7z7mchizt5sm66i67rvxxxicikxmfuvllmmxfy7ek@mulnjvde5q7w>
 <470742a6-861e-498e-9da4-1fa213969c7e@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <470742a6-861e-498e-9da4-1fa213969c7e@163.com>

On Sun, Jul 13, 2025 at 12:05:18AM GMT, Hans Zhang wrote:
> 
> 
> On 2025/7/12 17:35, Manivannan Sadhasivam wrote:
> > > We only have two callers of this (pcie-qcom.c and vmd.c, both in
> > > drivers/pci/), so it's not clear to me that it needs to be in
> > > include/linux/pci.h.
> > > 
> > > I'm a little dubious about it in the first place since I don't think
> > > drivers should be enabling ASPM states on their own, but pcie-qcom.c
> > > and vmd.c are PCIe controller drivers, not PCI device drivers, so I
> > > guess we can live with them for now.
> > > 
> > > IMO the "someday" goal should be that we get rid of aspm_policy and
> > > enable all the available power saving states by default.  We have
> > > sysfs knobs that administrators can use if necessary, and drivers or
> > > quirks can disable states if they need to work around hardware
> > > defects.
> > > 
> > 
> > Yeah, I think the default should be powersave and let the users disable it for
> > performance if they want.
> > 
> 
> Dear Bjorn and Mani,
> 
> Perhaps I don't think so. At present, our company's testing team has tested
> quite a few NVMe SSDS. As far as I can remember, the SSDS from two companies
> have encountered problems and will hang directly when turned on. We have set
> CONFIG_PCIEASPM_POWERSAVE=y by default. When encountering SSDS from these
> two companies, we had to add "pcie_aspm.policy=default" in the cmdline, and
> then the boot worked normally. Currently, we do not have a PCIe protocol
> analyzer to analyze such issues. The current approach is to modify the
> cmdline. So I can't prove whether it's a problem with the Root Port of our
> SOC or the SSD device.
> 
> Here I agree with Bjorn's statement that sometimes the EP is not necessarily
> very standard and there are no hardware issues. Personally, I think the
> default is default or performance. When users need to save power, they
> should then decide whether to configure it as powersave or powersupersave.
> Sometimes, if the EP device connected by the customer is perfect, they can
> turn it on to save power. But if the EP is not perfect, at least they will
> immediately know what caused the problem.
> 

We all agree that not all endpoints are standards compliant. So if they have any
issues with ASPM, then ASPM for those devices should be disabled in the quirks
or in the device driver.

That said, the change that Bjorn proposed is not going to happen in the
immediate future.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

