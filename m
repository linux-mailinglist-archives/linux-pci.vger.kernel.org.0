Return-Path: <linux-pci+bounces-38718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FC6BF0322
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B51F84F321E
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BFB2EC57F;
	Mon, 20 Oct 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="f+td/ulG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B1C2F5A3F;
	Mon, 20 Oct 2025 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952793; cv=none; b=n9FqFV8HJfy0q6fRmfDpV323MmFfo/RSVJ92GxQY9cqC6S4UImsM9IALC1qW1GYpHuTAvGDfEEMZctomxCNqaJpTxzBu8bsvSQ1czKO7QiDE7Q5RgV9QyJtURJeUrdK7Fs9+LAF+vKrNxqrByD5mBMoNceeg5zgvtEagEti0hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952793; c=relaxed/simple;
	bh=kCoTnVBoPmj35rDTdc2u9eHaOcW/hIpTViF68Vm/4C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1+ay5FkVTMKIW9klESATmNBsc0Tt/MG9RLbquNuzCtBZJHwDEY7FOc0shUFizwgEvsdAU/nFuaHfgnJMWSElqAa6f9jNgqZnjQsIezmEdm3MvzkHOhdJmFBqPSt7HkKqJtRsMlHuND+BVz34IX1fkh+suNvXEUhxaUdBU5H2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=f+td/ulG; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=n/CPIzx5KaL4TyTuJmekW/24AWANlyqw3dcl3WFRWCE=;
	b=f+td/ulGtsPQnMf4UyE9j/iAeHqvY2m6HE3o3yyNzMK9d9OTLoJmJTOHjc25wj
	YJf6h4X9eVPS8jKXFSIktaRYEv+9nHu7dkShH6/qYgKai+seF6B5DFdOSge0elUr
	zOpjYkLOmANepEswQHnkajIgM/Z0ouimRwMktRf2qkcYU=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgB3zxWZAfZoV+ZTAA--.12317S3;
	Mon, 20 Oct 2025 17:32:11 +0800 (CST)
Date: Mon, 20 Oct 2025 17:32:09 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 3/3] arm64: dts: fsl-lx2160a: include rev2 chip's dts
Message-ID: <aPYBmXdpZyO0b62F@dragon>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
 <20240826-2160r2-v1-3-106340d538d6@nxp.com>
 <20250923111038.qluh2kjmc534ytig@skbuf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923111038.qluh2kjmc534ytig@skbuf>
X-CM-TRANSID:Ms8vCgB3zxWZAfZoV+ZTAA--.12317S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2puAUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNRw-pGj2AZwdHAAA3w

On Tue, Sep 23, 2025 at 02:10:38PM +0300, Vladimir Oltean wrote:
> Sorry for digging up an old thread, but I'm curious why you applied
> patch 2/3 but not this one? Currently,
> arch/arm64/boot/dts/freescale/fsl-lx2160a-rev2.dtsi has no user.

I'm not sure how I missed it :)  Thanks for asking.  Applied now.

Shawn


