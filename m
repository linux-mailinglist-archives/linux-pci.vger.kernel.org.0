Return-Path: <linux-pci+bounces-36340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA0FB7EA28
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B7716405F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF512E5405;
	Wed, 17 Sep 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCPYpQC/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C870224FA;
	Wed, 17 Sep 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104616; cv=none; b=BedAMLS62zRdgfcGW7S6Ov+yymXI/QVceJo0VG4Ka59jJRGOKk+2NNUgg3wx8had82/AKxgesuMvlSn1esxGGBzPv2WGsw3GeAhUO4XauQ7DTlp/JrxaeA5PhhcxYsoux9iLy18LqCD0eS84RxlguYx0aFqBn7go4EeEWFnDm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104616; c=relaxed/simple;
	bh=1sHt+GhISQCh7Dw+H0WwBAFkHIiCQ9IvxG+dQYuSAXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM3IbcsWod3w7BoVJKY9dcEmjOL/7jjf+NLC98Mcnk7se4Kgr6Krsn4vKjlapcdKyffr0cuDevpb2YP/2DXnX8n3QJdYYhjDkMvnFJSG+P9vJQK/flVEy+YFEoUVPp9FFEgbTx2kGOKPJmW3nPVvcMxT4PrA+JUgfiU8qLfPT/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCPYpQC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475B4C4CEF0;
	Wed, 17 Sep 2025 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104616;
	bh=1sHt+GhISQCh7Dw+H0WwBAFkHIiCQ9IvxG+dQYuSAXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCPYpQC/WAgfXA/i9a5VD06wTLnH+S/7nmo3AIo7KLuYWqTpEe3FJwk+FgyJhwobp
	 nTait17HSpCRwEAneDE1HstHfQ7K2FIwst+O7hgs8pleiGnNNvkYjnbJjLE8js3rwf
	 8TQh7K2+lsUal8wZP/6TtXJMN3svpxBCyVLKxFfOfjPS4wpneyVglZs27qxpf5brJW
	 7e5j1olsZm8Hay6Lk6r22zgD6Wx4atAvKRfKPhLpCiC0xZ3cynDbhlpZQ1jsLOXN8b
	 /6jeN4qO2yEOrZ+qYf/v4GfQcg7Q0LLZn7Y2srsjcdWQGT45e82mhIgSlZtWztKYZm
	 +GqqYMaClakNg==
Date: Wed, 17 Sep 2025 15:53:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 4/4] PCI: qcom: Allow pwrctrl core to control PERST#
 if 'reset-gpios' property is available
Message-ID: <gnaubphg6iyh23vtf2flsjxoot7psgla7cr2c5jpecaozh4vf3@mzcmg74g3ogk>
References: <20250912-pci-pwrctrl-perst-v3-4-3c0ac62b032c@oss.qualcomm.com>
 <20250916204810.GA1814032@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916204810.GA1814032@bhelgaas>

On Tue, Sep 16, 2025 at 03:48:10PM GMT, Bjorn Helgaas wrote:
> On Fri, Sep 12, 2025 at 02:05:04PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > For historic reasons, the pcie-qcom driver was controlling the power supply
> > and PERST# GPIO of the PCIe slot.
> 
> > This turned out to be an issue as the power supply requirements
> > differ between components. For instance, some of the WLAN chipsets
> > used in Qualcomm systems were connected to the Root Port in a
> > non-standard way using their own connectors.
> 
> This is kind of hand-wavy.  I don't know what a non-standard connector
> has to do with this.  I assume there's still a PCIe link from Root
> Port to WLAN, and there's still a PERST# signal to the WLAN device and
> a Root Port GPIO that asserts/deasserts it.
> 

If we have a non-standard connector, then the power supply requirements change.
There is no longer the standard 3.3v, 3.3Vaux, 1.8v supplies, but plenty more.
For instance, take a look at the WCN6855 WiFi/BT combo chip in the Lenovo X13s
laptop:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts#n414

These supplies directly go from the host PMIC to the WCN6855 chip integrated
in the PCB itself. And these supplies need to be turned on/off in a sequence
also, together with the EN/SWCTRL GPIOs, while sharing with the Bluetooth
driver.

To handle this complexity, pwrctrl framework was introduced.

- Mani

> > This requires specific power sequencing mechanisms for controlling
> > the WLAN chipsets. So the pwrctrl framework (CONFIG_PWRCTRL) was
> > introduced to handle these custom and complex power supply
> > requirements for components.
> > 
> > Sooner, we realized that it would be best to let the pwrctrl driver control
> > the supplies to the PCIe slots also. As it will allow us to consolidate all
> > the power supply handling in one place instead of doing it in two. So the
> > CONFIG_PWRCTRL_SLOT driver was introduced, that just parses the Root Port
> > nodes representing slots and controls the standard power supplies like
> > 3.3v, 3.3VAux etc...
> > 
> > However, the control of the PERST# GPIOs was still within the controller
> > drivers like pcie-qcom. So the controller drivers continued to assert/
> > deassert PERST# GPIOs independent of the power supplies to the components.
> > This mostly went unnoticed as the components tolerated this non-standard
> > PERST# assertion/deassertion. But this behavior completely goes against the
> > PCIe Electromechanical specs like CEM, M.2, as these specs enforce strict
> > control of PERST# signal together with the power supplies.
> > 
> > So conform to these specs, allow the pwrctrl core to control PERST# for the
> > slots if the 'reset-gpios' property is specified in the DT bridge nodes.
> > This is achieved by populating the 'pci_host_bridge::perst_assert' callback
> > with qcom_pcie_perst_assert() function, so that the pwrctrl core can
> > control PERST# through this callback.
> > 
> > qcom_pcie_perst_assert() will find the PERST# GPIO descriptor associated
> > with the supplied 'device_node' of the component and asserts/deasserts
> > PERST# as requested by the 'assert' parameter. If PERST# is not found in
> > the supplied node of the component, the function will look for PERST# in
> > the parent node as a fallback. This is needed since PERST# won't be
> > available in the endpoint node as per the DT binding.
> > 
> > Note that the driver still asserts PERST# during the controller
> > initialization as it is needed as per the hardware documentation.
> > 
> > For preserving the backward compatibility with older DTs that still
> > specifies the Root Port resources in the host bridge DT node, the
> > controller driver still controls power supplies and PERST# for them. For
> > those cases, the 'qcom_pcie::legacy_binding' flag will be set and the
> > driver will continue to control PERST# exclusively. If this flag is not
> > set, then the pwrctrl driver will control PERST# through the callback.

-- 
மணிவண்ணன் சதாசிவம்

