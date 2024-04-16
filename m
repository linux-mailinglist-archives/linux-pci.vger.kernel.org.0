Return-Path: <linux-pci+bounces-6307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE38A6452
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 08:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2CA1F229E1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 06:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557FD6E619;
	Tue, 16 Apr 2024 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzS40nkM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BD6BFCF;
	Tue, 16 Apr 2024 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250200; cv=none; b=o4IKgaCRu9yj8wH8CUNdNLyFccRYtngbd9a6uvX5jZIy57Tcf0ATAdBrmMj/ovch3PG+Kh8ExKv8cYRK/ZPV4V56+MBgHj8/AIQpUCv4ISjXNSGS1LMocTuxC6pkZUxHFNzv1qLkjmSORphrnMRoz8wKDvupJMjJ/PY9iJQ8HYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250200; c=relaxed/simple;
	bh=yfX5SuJiKsjZz5T4krQC0RPDEuHfvs/zvmFjAxx/zlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYD3iL1tB45ghxcYjZL5hZtApXqQsKcYvC/pOsP0wQTTRPs9OqUcsbC8S1u4U6Jqfqllyq6H8S9BC7UTKoAH+QHfSxc4DUPVDEbF/Nz07ncB1+Sd2UGYUnSUqdl5v5Ja/yclm5GxEyfBcM46CFftIMQgT8M429RY0ieWK509JIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzS40nkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD27C113CE;
	Tue, 16 Apr 2024 06:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713250199;
	bh=yfX5SuJiKsjZz5T4krQC0RPDEuHfvs/zvmFjAxx/zlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzS40nkMJsIBoNMyiBYU1dZiU1GtglSAeoOK9Wcywa3dOY58e3mqlh5jo9Uo3Wg2F
	 bgDK0tl59DTrBOygg0MimxmV2SmnnMK3sWaXBhFO/CJhjGPCxtnk5Ia76in1UYvUBK
	 vckfRAEjG0RHpNWyty6mmMfUa+d70IPhKPL2FQaHhubHznn8lySE+KogwTaJ59l1It
	 NTQM+YyatNBircIy0BD3jOigDDKO2b0E8+exBqLDcMGDsa4gWo9HVGWxSrZL8T2Vfr
	 2sQ0oHzwEEpUKvd/TIIKAKi7z/0bxlEuMynqeleZ7TqaBos8awEksUEIqjQ87iO0QI
	 DAkcQpckpO54w==
Date: Tue, 16 Apr 2024 08:49:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Brian Norris <briannorris@chromium.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, stable@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: Re: [PATCH] PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting
 ep_gpio
Message-ID: <Zh4fkbQTh0Z1GNGK@ryzen>
References: <20240416-pci-rockchip-perst-fix-v1-1-4800b1d4d954@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-pci-rockchip-perst-fix-v1-1-4800b1d4d954@linaro.org>

On Tue, Apr 16, 2024 at 11:12:35AM +0530, Manivannan Sadhasivam wrote:
> Rockchip platforms use 'GPIO_ACTIVE_HIGH' flag in the devicetree definition
> for ep_gpio. This means, whatever the logical value set by the driver for
> the ep_gpio, physical line will output the same logic level.
> 
> For instance,
> 
> 	gpiod_set_value_cansleep(rockchip->ep_gpio, 0); --> Level low
> 	gpiod_set_value_cansleep(rockchip->ep_gpio, 1); --> Level high
> 
> But while requesting the ep_gpio, GPIOD_OUT_HIGH flag is currently used.
> Now, this also causes the physical line to output 'high' creating trouble
> for endpoint devices during host reboot.
> 
> When host reboot happens, the ep_gpio will initially output 'low' due to
> the GPIO getting reset to its POR value. Then during host controller probe,
> it will output 'high' due to GPIOD_OUT_HIGH flag. Then during
> rockchip_pcie_host_init_port(), it will first output 'low' and then 'high'
> indicating the completion of controller initialization.
> 
> On the endpoint side, each output 'low' of ep_gpio is accounted for PERST#
> assert and 'high' for PERST# deassert. With the above mentioned flow during
> host reboot, endpoint will witness below state changes for PERST#:
> 
> 	(1) PERST# assert - GPIO POR state
> 	(2) PERST# deassert - GPIOD_OUT_HIGH while requesting GPIO
> 	(3) PERST# assert - rockchip_pcie_host_init_port()
> 	(4) PERST# deassert - rockchip_pcie_host_init_port()
> 
> Now the time interval between (2) and (3) is very short as both happen
> during the driver probe(), and this results in a race in the endpoint.
> Because, before completing the PERST# deassertion in (2), endpoint got
> another PERST# assert in (3).
> 
> A proper way to fix this issue is to change the GPIOD_OUT_HIGH flag in (2)
> to GPIOD_OUT_LOW. Because the usual convention is to request the GPIO with
> a state corresponding to its 'initial/default' value and let the driver
> change the state of the GPIO when required.
> 
> As per that, the ep_gpio should be requested with GPIOD_OUT_LOW as it
> corresponds to the POR value of '0' (PERST# assert in the endpoint). Then
> the driver can change the state of the ep_gpio later in
> rockchip_pcie_host_init_port() as per the initialization sequence.
> 
> This fixes the firmware crash issue in Qcom based modems connected to
> Rockpro64 based board.
> 
> Cc:  <stable@vger.kernel.org> # 4.9
> Reported-by: Slark Xiao <slark_xiao@163.com>
> Closes: https://lore.kernel.org/mhi/20240402045647.GG2933@thinkpad/
> Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>


I sent a similar fix for the DWC-based rockchip driver a few weeks ago:
https://lore.kernel.org/linux-pci/20240327152531.814392-1-cassel@kernel.org/

If your fix is picked up, it would be nice if mine got picked up as well,
such that both drivers get fixed.


Kind regards,
Niklas

