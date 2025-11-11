Return-Path: <linux-pci+bounces-40839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 878BBC4C270
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16D7F4F4D27
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1406332C328;
	Tue, 11 Nov 2025 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ODO/kGMq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78823C51D;
	Tue, 11 Nov 2025 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846976; cv=none; b=MbsYbmONEMh8y7/v7S+e+lsx/IIDnTZ/oT/VIKlAADxtIWjXnu9H027FKDELA0TkD+SGaC5BcwYzMPn3QfqbjEZgXYiClBq+c2gdfIGaHrZ8sz4SXyc8tgz42nE0n0GszOwGqUgsqsnNBxX1Ngyc18vrK35qByp9n85AakW+i/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846976; c=relaxed/simple;
	bh=8Ma8E6DFc1TdTBvoMfms9xPqoBsMOchLDJ+KmE8BDe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK0yEuU7/mM/wSvoJ8IhcmgTth19uekQLsJmH5Tpkl7BjV7GsQ4KUdhRjTnabqA35W1RUTfM8ioghFrEdcXcCf73Av0go6OT/7cWsE6EIYNLfzXSfoij54ewWtDoJ0wRAx6NtzPhEarDhlkvh4Xo2/f47xPzLCywmDQgmneNINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ODO/kGMq; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=nhDPWcHQwhbMDsBD0V/t6hKlH/MXgCs801GiP87Z/q0=;
	b=ODO/kGMqFbRqTC0v8r+qERLvSla7r6KNWJ77O80rPbP6codeYkA5nzwEg4h+O4
	gh5LhHWzo8deItXNDdhj4Nqr62RI+0yVSQEb/y1Hm34fRiLb0kURqkYZZC+BKkYR
	FcWKgs7vfgrFpVkC2XwQHSgRdbNtUezUJ3sSaFHwsJHxg=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBXvWOT4RJpfZLkAA--.5262S3;
	Tue, 11 Nov 2025 15:11:17 +0800 (CST)
Date: Tue, 11 Nov 2025 15:11:14 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add
 supports-clkreq property to PCIe M.2 port
Message-ID: <aRLhko0h1OZgvo2o@dragon>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-2-hongxing.zhu@nxp.com>
X-CM-TRANSID:Mc8vCgBXvWOT4RJpfZLkAA--.5262S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wr1kCFy3ur1DXFy8Cr4kWFg_yoW8Jr4rpa
	y8CFZ7Jr1xGF4fGanFqFyrKr98ta93JF4Uur1jgryUKrW5CF97tr48Crs3Wr4Y9w4fCw4f
	ZF10vwnaqrWYvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3EfrUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiOBV84WkS4ZUOIwAA3S

On Wed, Oct 15, 2025 at 11:04:18AM +0800, Richard Zhu wrote:
> According to PCIe r6.1, sec 5.5.1.
> 
> The following rules define how the L1.1 and L1.2 substates are entered:
> Both the Upstream and Downstream Ports must monitor the logical state of
> the CLKREQ# signal.
> 
> Typical implement is using open drain, which connect RC's clkreq# to
> EP's clkreq# together and pull up clkreq#.
> 
> imx95-15x15-evk matches this requirement, so add supports-clkreq to
> allow PCIe device enter ASPM L1 Sub-State.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> index 148243470dd4a..3ee032c154fa3 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> @@ -556,6 +556,7 @@ &pcie0 {
>  	pinctrl-names = "default";
>  	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
>  	vpcie-supply = <&reg_m2_pwr>;
> +	supports-clkreq;

Is binding updated for this property?

Shawn

>  	status = "okay";
>  };
>  
> -- 
> 2.37.1
> 


