Return-Path: <linux-pci+bounces-35880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FAFB52B42
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 10:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F8B18955C4
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F92D7DE3;
	Thu, 11 Sep 2025 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eLLw0LoR"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBB2D6E6A;
	Thu, 11 Sep 2025 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578255; cv=none; b=dyNW/cfDx+tHy8knHszxulzr1v0SCesIa/7twmPseQpofe/jaDwb/1zcghDf8/B39DQ/yopDrmSXKkK9Oz1p9Rfo91otLELwCI7s7V1vXD99PGvzWD5ZFRbEOamX3Iz43+RQ9E4HgDZ0GtvpHTcCol+3qT1cqdW6D7UdHQefOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578255; c=relaxed/simple;
	bh=ZbLh3w9qgdKNzwXJqgp2abe1gQ9CIj5mTrQV0DwHZoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk5vR4rRj1CG2bm/qW5uYGjal2lQZkbN5B/x1zzGgG9foJ4Q8+S8Gh9ysJpvfaBhzgU76k3fe1xKX09REtCWGEzp9VFCbfU/d6Gc7+QwytO+sajA5SpJ1VmFf/FX+8Cg6F90eFcCJvsNSvrrCgjAQDg88YBPorOr4LJfg2M24v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eLLw0LoR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 51E5C22E3E;
	Thu, 11 Sep 2025 10:10:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TEID8B6EKtIt; Thu, 11 Sep 2025 10:10:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757578251; bh=ZbLh3w9qgdKNzwXJqgp2abe1gQ9CIj5mTrQV0DwHZoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eLLw0LoRhdiW6rBw7ZButYxIty7OAQjCZnW82Ezd46anyExxpeN+SJMO01aeYBDJP
	 enjvSwjZGuATAM6nFZtd846Hr4WFfs1HG26px4Fr1a6fiAjVbD3KmMF8ikf1sppeaj
	 aVN99nSXPl4gTUNCgfmHIWk+b2nwhxBjZ4ly3RgvOaCVo+ZYYe1cIpAlwjxLC82U5b
	 /pd4D9V1ekwXrS1/AH1EfsVHtUhxn9QJUYhPHYmhpLf8q91Mj33x/a/Q73uu0mzue6
	 DWy7d5Zr5hy3Zt8CrE+xjnMOqY++2u0udyrvZf9SVslDNEFuGaVxyBhEB1PgyXkywU
	 0qzbHeAiVk22w==
Date: Thu, 11 Sep 2025 08:10:36 +0000
From: Yao Zi <ziyao@disroot.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	heiko@sntech.de, jonas@kwiboo.se, krzk+dt@kernel.org,
	kwilczynski@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Enable PCIe controller on
 Radxa E20C
Message-ID: <aMKD_LhjdFNNu62B@pie>
References: <20250906135246.19398-4-ziyao@disroot.org>
 <20250909130009.2555706-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909130009.2555706-1-amadeus@jmu.edu.cn>

On Tue, Sep 09, 2025 at 09:00:09PM +0800, Chukun Pan wrote:
> Hi,
> 
> > +&pcie {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pciem1_pins>, <&pcie_reset_g>;
> 
> The pciem1_pins contains PCIE20_PERSTn_M1 (GPIO1_A2)
> This will cause conflicts, "pinctrl-0 = <&pciem1_pins>" is enough.
> 
> [    0.115608] rockchip-pinctrl pinctrl: not freeing pin 34 (gpio1-2) as part of deactivating group pciem1-pins - it is already used for some other setting
> [    0.191042] rockchip-pinctrl pinctrl: pin gpio1-2 already requeste by pll_gpll; cannot claim for 140000000.pcie
> [    0.191949] rockchip-pinctrl pinctrl: error -EINVAL: pin-34 (140000000.pcie)
> [    0.192570] rockchip-pinctrl pinctrl: error -EINVAL: could not request pin 34 (gpio1-2) from group pciem1-pins on device rockchip-pinctrl
> 
> > +	reset-gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
> 
> Missing supply: "vpcie3v3-supply = <&vcc_3v3>;"
> 
> > +	status = "okay";
> > +};
> > +

Will fix them in v2, thanks.

> Thanks,
> Chukun

Best regards,
Yao Zi

