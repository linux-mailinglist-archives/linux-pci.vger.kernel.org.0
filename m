Return-Path: <linux-pci+bounces-6843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9816C8B6CE9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93F51C22978
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317F1272D9;
	Tue, 30 Apr 2024 08:38:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05D1272C6;
	Tue, 30 Apr 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466310; cv=none; b=GCnyC7Tz+uhVj2HLLwlg8UHsfGPpBaw9KiJ+HEcuxzEx/0KVIpySwDNWIEZwjRkCLKNtScYrMFXdmLH8QTh3OYnvKuLl81/pHLqahj9HQ6fHJ2bm23EuQCABocCA05DKdJcWSfali5ggGz0J90Vyb8M5kGlz3Q5lPnk2Vv2K/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466310; c=relaxed/simple;
	bh=JPAY6hy0dx2EEWypghWseKBA28SpgSG3Jr5Y4Fm3M/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buchR4VSuKhXFGNVdV7+J0FottTPJNci3NQUaWlTPMj+RasA9JztDkpp0Cx6jBjH+jj/3v1vmmFl3VjE9jnwl25ofTCguuX37IbyzOiVS+duwAh0YGbZ+Q6YKJWenbRcggPVzQnJ34NB2Z2ti4Oq/CJQQ839J1AIIwj5pfeLFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b01.versanet.de ([83.135.91.1] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s1j06-0007i9-Ie; Tue, 30 Apr 2024 10:38:10 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Simon Xue <xxm@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 stable@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dw-rockchip: Fix initial PERST# GPIO value
Date: Tue, 30 Apr 2024 10:38:09 +0200
Message-ID: <2493811.Mh6RI2rZIc@diego>
In-Reply-To: <20240417164227.398901-1-cassel@kernel.org>
References: <20240417164227.398901-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 17. April 2024, 18:42:26 CEST schrieb Niklas Cassel:
> PERST# is active low according to the PCIe specification.
> 
> However, the existing pcie-dw-rockchip.c driver does:
> gpiod_set_value(..., 0); msleep(100); gpiod_set_value(..., 1);
> When asserting + deasserting PERST#.
> 
> This is of course wrong, but because all the device trees for this
> compatible string have also incorrectly marked this GPIO as ACTIVE_HIGH:
> $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3568*
> $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3588*
> 
> The actual toggling of PERST# is correct.
> (And we cannot change it anyway, since that would break device tree
> compatibility.)
> 
> However, this driver does request the GPIO to be initialized as
> GPIOD_OUT_HIGH, which does cause a silly sequence where PERST# gets
> toggled back and forth for no good reason.
> 
> Fix this by requesting the GPIO to be initialized as GPIOD_OUT_LOW
> (which for this driver means PERST# asserted).
> 
> This will avoid an unnecessary signal change where PERST# gets deasserted
> (by devm_gpiod_get_optional()) and then gets asserted
> (by rockchip_pcie_start_link()) just a few instructions later.
> 
> Before patch, debug prints on EP side, when booting RC:
> [  845.606810] pci: PERST# asserted by host!
> [  852.483985] pci: PERST# de-asserted by host!
> [  852.503041] pci: PERST# asserted by host!
> [  852.610318] pci: PERST# de-asserted by host!
> 
> After patch, debug prints on EP side, when booting RC:
> [  125.107921] pci: PERST# asserted by host!
> [  132.111429] pci: PERST# de-asserted by host!
> 
> This extra, very short, PERST# assertion + deassertion has been reported
> to cause issues with certain WLAN controllers, e.g. RTL8822CE.
> 
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: stable@vger.kernel.org	# 5.15+

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

it also matches what the vendor kernel does.



