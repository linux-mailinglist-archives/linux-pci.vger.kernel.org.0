Return-Path: <linux-pci+bounces-26346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC8A95C0A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 04:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88513AE10D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 02:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FFB1A0BD0;
	Tue, 22 Apr 2025 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="RKukL9Iz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E6E1A071C;
	Tue, 22 Apr 2025 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288382; cv=none; b=e2CMF1jlIrVPkTEkksb/SOA0fR556CzJFCpmBinZ2VoYdVgsaHon2vxVEC/uoTgdkeh2FCk8vdS3V+4/DOlp8oWEHgqDzI3l7vunU2sbQUjbN0ehhyxxrWxkb8T9gVz97vAg4AyS5hv7y9FYx8jG4keSnRPc5cdLPe3LsdYFbPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288382; c=relaxed/simple;
	bh=kGFnUpUTsJMisKdKVeE9j+sNCS0a1HmuE29YmJa3HAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+KxuuVYUGgFQAG0xv2f8gosEDBjQek0yJqxcb03rB15rArcSQ2HII37sGPC443VIGadik3dadCtcdFq8cVGAaAYXLhcm4kbKVti/U8LhaZyNTRrYO77Pv1Cx4f22azJWNU3A8J0A/csvpPpHH8drXtjE5puZqW8Md2JEoWjRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=RKukL9Iz; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=RRd/Mv2IK7FoRUzYMao2nZ0bIVcFKFyPzLBcuxvr7as=;
	b=RKukL9IzXolSfcWHT/VQNZX015mSZ/RCEj3z9FuKbM9pvStmSTiHp2VHmSMMDW
	NBL1zvflI5/YchYfQ0JmCG1P997+lf8Ys5YzjccWS0Bkg/7XtLw0CiZaC/k/Ladi
	szDdIskegADB/l71A4fbymWtrtXR/asSeh5R78DG4CjEQ=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDnptJK9QZoN72iAw--.10140S3;
	Tue, 22 Apr 2025 09:47:56 +0800 (CST)
Date: Tue, 22 Apr 2025 09:47:54 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	s.hauer@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] arm64: dts: imx8mq: Add linux,pci-domain into
 pcie-ep node
Message-ID: <aAb1SlxBsADlglrh@dragon>
References: <20250226024256.1678103-1-hongxing.zhu@nxp.com>
 <20250226024256.1678103-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226024256.1678103-2-hongxing.zhu@nxp.com>
X-CM-TRANSID:M88vCgDnptJK9QZoN72iAw--.10140S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVf-BDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRI3ZWgGsHT8JwABs5

On Wed, Feb 26, 2025 at 10:42:55AM +0800, Richard Zhu wrote:
> Add linux,pci-domain into pcie-ep node of i.MX8MQ.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Applied, thanks!


