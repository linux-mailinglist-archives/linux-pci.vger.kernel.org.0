Return-Path: <linux-pci+bounces-44195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 801F2CFE625
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 15:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0833300A535
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70984343D62;
	Wed,  7 Jan 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJGp+/42"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1845233D6E1;
	Wed,  7 Jan 2026 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796599; cv=none; b=q2r4KccmGj9SxpzQ9biDIHe23gxthBRMejwxtMPMlKA0pa/pUrn+dCPWijobSI9HMejDZY5y0JIIbWohpSfWs2Ac+sUD58yszLPu6Tj3Qyu2HwEE9bi8fABfhuHcNviDAWlA9LqU53SWka/tEW8E10sDYeb/MX2rJex6fPoN4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796599; c=relaxed/simple;
	bh=XwWSLB55x1rNencsXn/TLrmA6eEpbslMnGuzUkhuAZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAwHG5a3nVXvD5GuiPubA+3U32GsGXflxURdM2vdixcJEDDN5hv7eSQ4LTtcmytO67ohPDpvZMXLNhlW5oxvcuupMADB2n/2Tmjx3TqFXS+Ds9eMp05lPyJwhzN7Y1OIy+HK65zHJrc+NcwSRd5uf6yrum4N3rJRZuLgL3CKnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJGp+/42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A703C4CEF7;
	Wed,  7 Jan 2026 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767796598;
	bh=XwWSLB55x1rNencsXn/TLrmA6eEpbslMnGuzUkhuAZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJGp+/42xRifMjAf5rrJuTTUE42Vv6ojPGiVs3rklIv2y8HD+hCl1URycRStDpbiY
	 Y5mhpDNIk9SCsBSZTSCxeBdqmHSy6CwFDiwhfTXYqbG5z8+42tSEcB0xQJgj/cAJx1
	 7gLokOWP7SpUejdKujEOKG8LLOcc6FBd7mcc0QkD02TadGtPWF8s9nxU5wvrgGyNJo
	 k9D1+7EjoU39UtwWs1JL/VbFq8ysrmYqsMMVnRqy2aZ1vzyy2uYE8JHyTrNDvA70Na
	 jf6BAzdP3w0dwvzGzoVi7COcmoN7A/NW4+Le/t+VbOqbJYZyFhtL23E8/SJSwh3a+X
	 7QRER6Vk8KsOg==
Date: Wed, 7 Jan 2026 15:36:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Damien Le Moal <dlemoal@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 0/5] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Message-ID: <aV5vb1VlQYeWNcv1@ryzen>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>

On Wed, Jan 07, 2026 at 07:41:22PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series is an initial attempt to support the PCIe M.2 connectors in the
> kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
> Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
> in PCs). On the ACPI platforms, power to these connectors are mostly handled by
> the firmware/BIOS and the kernel never bothered to directly power manage them as
> like other PCIe connectors. But on the devicetree platforms, the kernel needs to
> power manage these connectors with the help of the devicetree description. But
> so far, there is no proper representation of the M.2 connectors in devicetree
> binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
> and fixed regulators in devicetree.
> 
> So to properly support the M.2 connectors in devicetree platforms, this series
> introduces the devicetree binding for Mechanical Key M connector as an example
> and also the corresponding pwrseq driver and PCI changes in kernel to driver the
> connector.
> 
> The Mechanical Key M connector is used to connect SSDs to the host machine over
> PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
> support for driving the PCIe interface of the connector in the kernel.
> 
> Also, the optional interfaces supported by the Key M connectors are not
> supported in the driver and left for the future enhancements.

For me, it is not clear if there is a dependency or conflict with your
"major pwrctrl rework series":
[PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl devices with controller drivers

Does one need to go before the other, or are they completely unrelated
and can be merged in any order without conflicts?


Kind regards,
Niklas

