Return-Path: <linux-pci+bounces-37133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948AEBA5233
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8BA2A1FB5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF13228C84F;
	Fri, 26 Sep 2025 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4OhCUsG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A342615667D;
	Fri, 26 Sep 2025 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920034; cv=none; b=i1xfX1FvuLFfifHQnCT+AFkQ+E/EsyypByQusO4R9V4JCGjWstT9iinj4e0vwqzkZ6z2WQDFfOQ4zY4lRnGH5Y1RAWa95Kg63TcqUJQdJdnIK568R9mykLZnb4njIF8aUzlGvawRYgYf/nD5tbME23pOZZjyi8KzE077ZGiqZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920034; c=relaxed/simple;
	bh=i45xzC7yA1PYW8/tIOpUf6+frrJsG6ExocWAVAZkri8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bQ2fJXziscCiNLvPkt2VhHFZcOxIqV8DcX4NPCD/9FWiy1nIKa7ykDJdVW3uRvevCmbhl12r2wEQZQonysc+T2osLch3sBduwNpPe459pHMiB1bymj+vLeYxZvpQkX3RQWkUhlWwAAvKvH/rXZnrFNmrdFKLPjMLVtiTJc22vic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4OhCUsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A17C113CF;
	Fri, 26 Sep 2025 20:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758920034;
	bh=i45xzC7yA1PYW8/tIOpUf6+frrJsG6ExocWAVAZkri8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=E4OhCUsGZLnOGQzGap8V0RvGV/q7cB1oUFGaQK06dzU7yCeO7oKvIz7cbaJBoWqwf
	 s5HzYqQOTrZkFlnbxV5OcgfDzwuBygEod8Sd9rbUoMDWML7oAEOKeo3pCzB0ITsILt
	 iAY5aNmisBkcmfhgmFFL321klL/mXxPC0OhwHZoaNlBnKhgy7wCrd0PVQ3e4/nHuu+
	 cS5rR5TrEVd3jXBKEWLydBGnZwUeCYA/ATHIcCN62ogZm9fu+UsqONSGHWaNfwkKHa
	 lpo7Oa7O+OOkTXowrpk9C6G2+5G3kv5N14nRKnjm91yzlt2tn/sjo7o39/ndOhMLwd
	 wfIQGGj6g8XiA==
Date: Fri, 26 Sep 2025 15:53:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v3 1/4] ARM: dts: mediatek: drop wrong syscon hifsys
 compatible for MT2701/7623
Message-ID: <20250926205352.GA2266604@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925162332.9794-2-ansuelsmth@gmail.com>

On Thu, Sep 25, 2025 at 06:23:15PM +0200, Christian Marangi wrote:
> The syscon compatible for the hifsys node for Mediatek MT2701/MT7623 SoC
> was wrongly added following the pattern of other clock node but it's
> actually not needed as the register are not used by other device on the
> SoC.
> 
> On top of this it does against the schema for hifsys amnd cause
> dtbs_check warning.

s/does/<something else, not sure what you mean>/
s/amnd/and/ ?
s/cause/causes a/

> Drop the "syscon" compatible to mute the warning and reflect the
> compatible property described in the mediatek,mt2701-hifsys.yaml schema.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/mediatek/mt2701.dtsi | 2 +-
>  arch/arm/boot/dts/mediatek/mt7623.dtsi | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mediatek/mt2701.dtsi b/arch/arm/boot/dts/mediatek/mt2701.dtsi
> index ce6a4015fed5..128b87229f3d 100644
> --- a/arch/arm/boot/dts/mediatek/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mediatek/mt2701.dtsi
> @@ -597,7 +597,7 @@ larb1: larb@16010000 {
>  	};
>  
>  	hifsys: syscon@1a000000 {
> -		compatible = "mediatek,mt2701-hifsys", "syscon";
> +		compatible = "mediatek,mt2701-hifsys";
>  		reg = <0 0x1a000000 0 0x1000>;
>  		#clock-cells = <1>;
>  		#reset-cells = <1>;
> diff --git a/arch/arm/boot/dts/mediatek/mt7623.dtsi b/arch/arm/boot/dts/mediatek/mt7623.dtsi
> index fd7a89cc337d..4b1685b93989 100644
> --- a/arch/arm/boot/dts/mediatek/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mediatek/mt7623.dtsi
> @@ -744,8 +744,7 @@ vdecsys: syscon@16000000 {
>  
>  	hifsys: syscon@1a000000 {
>  		compatible = "mediatek,mt7623-hifsys",
> -			     "mediatek,mt2701-hifsys",
> -			     "syscon";
> +			     "mediatek,mt2701-hifsys";
>  		reg = <0 0x1a000000 0 0x1000>;
>  		#clock-cells = <1>;
>  		#reset-cells = <1>;
> -- 
> 2.51.0
> 

