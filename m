Return-Path: <linux-pci+bounces-23399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FDEA5B6EB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 03:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52601189569E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 02:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EBC1DE892;
	Tue, 11 Mar 2025 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="RMCb81w2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676417741;
	Tue, 11 Mar 2025 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741661195; cv=none; b=LQjVw2zTWhr8gz63ysnprqOw2BEq+NVlfJ1SsdLpdJSoaYaOurvyq6lClCqOJqv4BnjeRffhRJo83Ut5FTxST+86FBsGQPir+MJqzzatjpwzBnohyeiqTRj/NsxTLea/CgAc7/HJ3QZsVUYg6as5DA3uX+7Bxo81o5yzCcLRCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741661195; c=relaxed/simple;
	bh=r5C5UHC/MEvYiNybKnqxQY5J2VLFO/BGtRfgQh/kKSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1nscenFRQfbtOe2whxY9VdPQqseQQS58EbG1vzu3qq7tNZIxMt+DtDz28Jbf2wmxoU04ddmA03eEdZ2DPg665bNV2VXmkZzbIz995++L7Z3fkhUZqa1nYw3yAWk3fdf7A/fnsE7HDCW5EaOyold2UlME23pK4cjSC5Hnowzy7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=RMCb81w2; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=HOnuc6V7iZj1VHst/LjUygWq87lYaT/N7rhOGEcupU8=;
	b=RMCb81w28Z95GMpjzit9coBp5ZegdbVkG1EVgach9vpYzvBpRGVMgsMA8bORSm
	tVDKkMtP0t5q4tbhb+QnW+z/J0Xx0DtfqcBydniCVqEc4m93HeXjXYsQ1g87Gpdf
	JQk2FYnhnJ6CaLJhpsas+dMsHTvRbiIUhtCs+qtM8D3SY=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgA3xq+Xo89n92ivAA--.43267S3;
	Tue, 11 Mar 2025 10:44:41 +0800 (CST)
Date: Tue, 11 Mar 2025 10:44:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 0/3] imx8qxp: PCIe fixes
Message-ID: <Z8+jl+QWCwStEitG@dragon>
References: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:M88vCgA3xq+Xo89n92ivAA--.43267S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUV75rUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAh4NZWfPWknoJAAAsD

On Tue, Feb 25, 2025 at 11:27:20AM +0100, Alexander Stein wrote:
> Alexander Stein (3):
>   dt-bindings: PCI: fsl,imx6q-pcie: Add optional DMA interrupt
>   arm64: dts: imx8qm-ss-hsio: Wire up DMA IRQ for PCIe
>   arm64: dts: mba8xx: Remove invalid propert

s/propert/property as Bjorn suggested, then applied both DTS changes.

Shawn


