Return-Path: <linux-pci+bounces-36304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73723B5A372
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 22:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B1B1B27115
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB0727C84E;
	Tue, 16 Sep 2025 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5r05xWm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DEB278156;
	Tue, 16 Sep 2025 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055693; cv=none; b=eSczvmpZpRZnM6k/UZrZDZ6VTPzcIvzGRQuEwBZgbI7RERt0maA0Mu0uRJLAahLP5HtwseFplEngq/WjqzlEK+MKpQh4w28SwS0jzwSc5vbwjzvWkUPJAe1+NYGpNHTusWz1qdFOGzpkGqwQErEHYZ3LrympZOnKnvNfX/hSR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055693; c=relaxed/simple;
	bh=Y1IqRfSmlcIgYAclgwowutMBZed1+nhjdRTcYcMbupo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MLBVMQAb67jfS+UIbuXIiaxwEIGWqZvSyHp6pKEeJZ5XAHJX8kvi7mJ3mxl4yemFjX197iixkFOkvCYA+K5HVxBR9/xAFmobnbngBAgS/RmbXeeIg/jivH6cK5tCX6vrEVqDSIOLGImIRNffojqOGfLIbBUOmO8GWkrYN52NpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5r05xWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52273C4CEEB;
	Tue, 16 Sep 2025 20:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758055692;
	bh=Y1IqRfSmlcIgYAclgwowutMBZed1+nhjdRTcYcMbupo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A5r05xWmYvjRRzvE92m3mH2/SmzKfmpjZuLwjCsCDgkybVbpSojkwZKz7L4frT/Rb
	 PFFZM2QFsby8HiInnpUv4UwGzS02ekBSEuSEXajuzPhoqgHOvaqCBQOmvwO5RT7Eid
	 s0zI9vRyZeJSmj1LYOL6HZEdDn82HExVNPCvgrMdnBzKbNisSvS/Xj5iDFpm4Pix5x
	 yFu6APZisS6AYcgAVeFP7KUp8AO0xxLrR6io9vUZIuC6yqSiRvt5Xz81ODSCBN2TM2
	 J6+XawPw3xi8uaY56TfHIyX4+yaDwaP2I9e242ffc9QDZcsQTR7WOscNFlDeAx4kfU
	 U6G/IW1hDA9rw==
Date: Tue, 16 Sep 2025 15:48:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 4/4] PCI: qcom: Allow pwrctrl core to control PERST#
 if 'reset-gpios' property is available
Message-ID: <20250916204810.GA1814032@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-pci-pwrctrl-perst-v3-4-3c0ac62b032c@oss.qualcomm.com>

On Fri, Sep 12, 2025 at 02:05:04PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> For historic reasons, the pcie-qcom driver was controlling the power supply
> and PERST# GPIO of the PCIe slot.

> This turned out to be an issue as the power supply requirements
> differ between components. For instance, some of the WLAN chipsets
> used in Qualcomm systems were connected to the Root Port in a
> non-standard way using their own connectors.

This is kind of hand-wavy.  I don't know what a non-standard connector
has to do with this.  I assume there's still a PCIe link from Root
Port to WLAN, and there's still a PERST# signal to the WLAN device and
a Root Port GPIO that asserts/deasserts it.

> This requires specific power sequencing mechanisms for controlling
> the WLAN chipsets. So the pwrctrl framework (CONFIG_PWRCTRL) was
> introduced to handle these custom and complex power supply
> requirements for components.
> 
> Sooner, we realized that it would be best to let the pwrctrl driver control
> the supplies to the PCIe slots also. As it will allow us to consolidate all
> the power supply handling in one place instead of doing it in two. So the
> CONFIG_PWRCTRL_SLOT driver was introduced, that just parses the Root Port
> nodes representing slots and controls the standard power supplies like
> 3.3v, 3.3VAux etc...
> 
> However, the control of the PERST# GPIOs was still within the controller
> drivers like pcie-qcom. So the controller drivers continued to assert/
> deassert PERST# GPIOs independent of the power supplies to the components.
> This mostly went unnoticed as the components tolerated this non-standard
> PERST# assertion/deassertion. But this behavior completely goes against the
> PCIe Electromechanical specs like CEM, M.2, as these specs enforce strict
> control of PERST# signal together with the power supplies.
> 
> So conform to these specs, allow the pwrctrl core to control PERST# for the
> slots if the 'reset-gpios' property is specified in the DT bridge nodes.
> This is achieved by populating the 'pci_host_bridge::perst_assert' callback
> with qcom_pcie_perst_assert() function, so that the pwrctrl core can
> control PERST# through this callback.
> 
> qcom_pcie_perst_assert() will find the PERST# GPIO descriptor associated
> with the supplied 'device_node' of the component and asserts/deasserts
> PERST# as requested by the 'assert' parameter. If PERST# is not found in
> the supplied node of the component, the function will look for PERST# in
> the parent node as a fallback. This is needed since PERST# won't be
> available in the endpoint node as per the DT binding.
> 
> Note that the driver still asserts PERST# during the controller
> initialization as it is needed as per the hardware documentation.
> 
> For preserving the backward compatibility with older DTs that still
> specifies the Root Port resources in the host bridge DT node, the
> controller driver still controls power supplies and PERST# for them. For
> those cases, the 'qcom_pcie::legacy_binding' flag will be set and the
> driver will continue to control PERST# exclusively. If this flag is not
> set, then the pwrctrl driver will control PERST# through the callback.

