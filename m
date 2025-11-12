Return-Path: <linux-pci+bounces-40945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A79CC503E3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 02:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7883E4E2AA5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 01:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3428A1D5;
	Wed, 12 Nov 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="NqdefhQy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F07262F;
	Wed, 12 Nov 2025 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912398; cv=none; b=oce6On8NkQZvvtLn4mvZmgGwKTgLJLwUW4nOAvkthL8es8UKVIePKNkyLKejSJo46UtaD55xEsAmsCx+U1AYSW3MmaZ8/DA3KdiabLwWWpt1VpxwgDpS+CHhDaDrlRDJDdIULUvR5xRmOGvpN0mYj5iGOQllIEaSwjN/BhES+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912398; c=relaxed/simple;
	bh=C9neEnQq3thnjzjGOw8nSCkjTdV9aE9g14bGC4lf5vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0lTXC/IPakSOS+EFloiEAM4xNjxe8AkMpNdQzXVhRApUbW87i8xCXZS0wierOwdjvgwL53USGdBIequefAJZAouXcr5Qp03SVixJ0NdIPv1DRdL3K55a6r1OIKexBMT18b0gZn3yPXCj4+uqN5xsEyMX2Wa0QPE1DDnJDNfOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=NqdefhQy; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=C9neEnQq3thnjzjGOw8nSCkjTdV9aE9g14bGC4lf5vE=;
	b=NqdefhQyq+sZoVxWznWBYZ2OWBn2H2NOGNh/Os3l7rkNzBdk2i26nmATH0wU4P
	4q0YgG+IWidcwRRI6NciXc1/zWQefvi7CKHaEs1D2zFXHaLtglQ7lvHI8/NTmeeZ
	nx7ued2u44pRu9fIGoz21fG+CByCpz55MYqHXBgoBwAa8=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAXXYde6BNpLQ7yAA--.5484S3;
	Wed, 12 Nov 2025 09:52:32 +0800 (CST)
Date: Wed, 12 Nov 2025 09:52:30 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/11] PCI: imx6: Add a method to handle CLKREQ#
 override
Message-ID: <aRPoXvIeooNhLpfn@dragon>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
X-CM-TRANSID:Mc8vCgAXXYde6BNpLQ7yAA--.5484S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUo1v3UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNwBx1mkT6GC+PAAA3g

On Wed, Oct 15, 2025 at 11:04:17AM +0800, Richard Zhu wrote:
> [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add supports-clkreq
> [PATCH v6 02/11] arm64: dts: imx95-19x19-evk: Add supports-clkreq
> [PATCH v6 03/11] arm64: dts: imx8mm-evk: Add supports-clkreq property
> [PATCH v6 04/11] arm64: dts: imx8mp-evk: Add supports-clkreq property
> [PATCH v6 05/11] arm64: dts: imx8mq-evk: Add supports-clkreq property
> [PATCH v6 06/11] arm64: dts: imx8qm-mek: Add supports-clkreq property
> [PATCH v6 07/11] arm64: dts: imx8qxp-mek: Add supports-clkreq

Applied these, thanks!


