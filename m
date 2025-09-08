Return-Path: <linux-pci+bounces-35687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3FB49A0F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078227AE1E6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 19:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB012BDC29;
	Mon,  8 Sep 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bByI+k/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDED27CCE2;
	Mon,  8 Sep 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360131; cv=none; b=suko23I+tN7jVhTdzmeAUDTuYNDC5hPQ5EkbYIQA43Sr4wCQdVwp/EujSM7AkfOriYImxgPXGaYEH5oDN69bOj0ELhgV+RsdexzclY4f99WrzMmOBWww8k6QjudissRg39BdtYudv0tl4My31g3N0wvP9QL436wy1YPTZQh5oK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360131; c=relaxed/simple;
	bh=TfAsCRSpW8EOD10f2rELOMrobwLS5VOMi2GmYF+/5S4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AJxdTOsSysGgxMx+2Fk+ZygcCPr9cRzPXOpQzMFf1Bo4XWFmtJw4ElDdwGG9yfutoKS5/1aAsnsYZITYnkMa5mTeFHTN8sQfnC0ztIuvHt49XmcXaU1VMWA9DW6hd3YnasRwBIV544wVpaMDOSG6dNZ2RFEMkbJwaddP/WWl32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bByI+k/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50ABC4CEF1;
	Mon,  8 Sep 2025 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757360130;
	bh=TfAsCRSpW8EOD10f2rELOMrobwLS5VOMi2GmYF+/5S4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bByI+k/oHDUFhlceIdJGTBC/ovihppEHdbfTmAVkxDiK5krpoUjC7iNxvuUB6YY0g
	 t3nVguveEICmcoYfEyVNRGCpiYZ6nlWHZbix1dyK66pAiYJ8qTbf3MF6ypER4++rrm
	 DkWzw0hw1kJkntf9P57CsKdMeTvgawXGW8QSEjazrTJcftfH54KI5K+xi7ZmJOdh5G
	 GoidFlkyaTfE+sktGb3i9TOKfVtdsKNT0T2tmG+aZjyjvBC3YtRGiROmVzYF6jzk8A
	 Gk8tNP/LSDqx49k9Owp+tRTA/iwpBCD2i8fB7DrUWnAo90dKuDYS3MLkIay8/F38WV
	 EUDplRfIOMy8A==
Date: Mon, 8 Sep 2025 14:35:29 -0500
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
Subject: Re: [PATCH v2 3/5] PCI/pwrctrl: Add support for toggling PERST#
Message-ID: <20250908193529.GA1439341@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-pci-pwrctrl-perst-v2-3-2d461ed0e061@oss.qualcomm.com>

On Wed, Sep 03, 2025 at 12:43:25PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> As per PCIe spec r6.0, sec 6.6.1, PERST# is an auxiliary signal provided by
> the system to a component as a Fundamental Reset. This signal if available,
> should conform to the rules defined by the electromechanical form factor
> specifications like PCIe CEM spec r4.0, sec 2.2.
> 
> Since pwrctrl driver is meant to control the power supplies, it should also
> control the PERST# signal if available.

Why?  Probably obvious to hardware folks, but a sentence about the
necessary connection between power supply and reset would help me.

> But traditionally, the host bridge
> (controller) drivers are the ones parsing and controlling the PERST#
> signal. They also sometimes need to assert PERST# during their own hardware
> initialization. So it is not possible to move the PERST# control away from
> the controller drivers and it must be shared logically.
> 
> Hence, add a new callback 'pci_host_bridge::toggle_perst', that allows the
> pwrctrl core to toggle PERST# with the help of the controller drivers. But
> care must be taken care by the controller drivers to not deassert the
> PERST# signal if this callback is populated.
> 
> This callback if available, will be called by the pwrctrl core during the
> device power up and power down scenarios. Controller drivers should
> identify the device using the 'struct device_node' passed during the
> callback and toggle PERST# accordingly.

"Toggle" isn't my favorite description because it implies that you
don't need to supply the new state; you're just switching from the
current state to the other state, and you wouldn't need to pass a
state.  Maybe something like "set_perst" or "set_perst_state" like we
do for set_cpu_online(), *_set_power_state(), etc?

> +static void pci_pwrctrl_perst_deassert(struct pci_pwrctrl *pwrctrl)
> +{
> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(pwrctrl->dev->parent);
> +	struct device_node *np = dev_of_node(pwrctrl->dev);
> +
> +	if (!host_bridge->toggle_perst)
> +		return;
> +
> +	host_bridge->toggle_perst(host_bridge, np, false);
> +}
> +
> +static void pci_pwrctrl_perst_assert(struct pci_pwrctrl *pwrctrl)
> +{
> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(pwrctrl->dev->parent);
> +	struct device_node *np = dev_of_node(pwrctrl->dev);
> +
> +	if (!host_bridge->toggle_perst)
> +		return;
> +
> +	host_bridge->toggle_perst(host_bridge, np, true);
> +}

