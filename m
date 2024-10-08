Return-Path: <linux-pci+bounces-13992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD609942EB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23C01F28357
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8D314A0B8;
	Tue,  8 Oct 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="FSGgDrOz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198062566;
	Tue,  8 Oct 2024 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376893; cv=none; b=dODOVTFmpcO3DuBhy4+EOrN9MZbNlzdZp81qtr9O6+GuTIPWgancr+9yKZiNbXEwA/KnrxCW5Q13BDvLn0qQF6MWcFgQbgp4+WXUiovK07J7dYQwaL3BYLKfahWQQURKfjuSBSMuA4Ve1284ABJaJDMDH42JtRSVvqvxofmLwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376893; c=relaxed/simple;
	bh=LT6tVZ5fR1YC44235qgb8Y+HXZK+9cZRuJKZf/Mf89E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EURn+ZGWuKmW0g95muyepKJqxKC0nqg8c24RE+f9dvxQIjGuewmTW4Z89yggTSf4crUZiyuV+OyR1WMFTTEcME+XtGoEsME6TmC9P6uzjY7DH5DcfXh6QszmDCot1ZhrHDrxM4q9nzrRbldEbdJsKBz5OWmwXz92vI+qHbu2deQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=FSGgDrOz; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=LT6tVZ5fR1YC44235qgb8Y+HXZK+9cZRuJKZf/Mf89E=;
	b=FSGgDrOzQjsOKQ3S/p2OxVRngsgTQzfOgR2sVWaRBAR6NT0Nkdq8hxRVPRLnGh
	euKyVg5Yp5P0w91CRNs9QeH2zY4HheoxnvWDeO6v45MjBxR/Nh8cRW6aAut8rmXN
	vFLFabYf5S6lIIg8Lc02WUbFMWuFWVBnYVTRdSB0Mx9c0=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnf9eW7QRnyJzcAQ--.40279S3;
	Tue, 08 Oct 2024 16:30:16 +0800 (CST)
Date: Tue, 8 Oct 2024 16:30:14 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v5 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Message-ID: <ZwTtlmUWD/b1Jzi6@dragon>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <ZtMUbpBJscWlgkhW@dragon>
 <ZtgqmCbkD1ruZr4U@dragon>
 <DU2PR04MB86771BA534FF1A8C0AE5B8618C692@DU2PR04MB8677.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR04MB86771BA534FF1A8C0AE5B8618C692@DU2PR04MB8677.eurprd04.prod.outlook.com>
X-CM-TRANSID:Ms8vCgDnf9eW7QRnyJzcAQ--.40279S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVxR6UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgRyZWcErZHI0AAAsG

On Wed, Sep 25, 2024 at 04:03:03AM +0000, Hongxing Zhu wrote:
> Hi Shawn:
> The dts bindings change had been merged on Sep 06.
> Can you help to merge the others?

Applied, thanks!


