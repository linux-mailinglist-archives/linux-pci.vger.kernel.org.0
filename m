Return-Path: <linux-pci+bounces-12554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DEF9671AD
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 15:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D33DB219D6
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 13:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D98B4A3C;
	Sat, 31 Aug 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="S6PTxzUl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF112C9A;
	Sat, 31 Aug 2024 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725109410; cv=none; b=VdvaCZfu9CIAsPFXFq0v+IuodV7mNePaQAYOKMSd/nrzCrb+2EwXxWJmAdzwJLdav5x4EqXHE08HCbyl+3NaT8YU898bBYomagtAFhI3EGmipT8j6VCwDo/5KL53Dhy6opUuClltEVyWFajmz3RM14UC7fUSIPTucs33Ux1FBOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725109410; c=relaxed/simple;
	bh=FvhXiPh2zeXzTeRJgyzV63N2jWYC9mSuDAQuNFB7lW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtbeIqpp7P8jXGbbO9J0R2XHmjOIyBew44UsvrNUCGkSWR8X3EEEl2sKKRJisF7KGIs4wpqz9YyTBpajw0T4Uocjii8PsUh1zxERtbmihkkyo+7gSDzTfVggsFT//CLkRhZWHL9XcgMG3mWVppMRqbsZaHjsAE7WIOmbIu2DCh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=S6PTxzUl; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ogS1093DYNfHdi/kXr74mgK5XoOfm1WU8YZW02sTJ/g=;
	b=S6PTxzUldpxTJgqdY3tBVH3woW5ltXkGSXvaDpCR1zSzSgFyEObaWTUzIDStB6
	MQjNk3RabBxi3NB0W8jiXjdGkI7R6daAklbDxuZojA8kBMdQ/5wPsaY47jZtw3yC
	n9r8tYz9IyoNB6Ix0Df81tvsCzDP6EujpicRJ5oAxwpoU=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHLzxuFNNm6Y47AA--.10675S3;
	Sat, 31 Aug 2024 21:02:40 +0800 (CST)
Date: Sat, 31 Aug 2024 21:02:38 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v5 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Message-ID: <ZtMUbpBJscWlgkhW@dragon>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
X-CM-TRANSID:Ms8vCgDHLzxuFNNm6Y47AA--.10675S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWfWF47Gw1kuF4xtr48tFb_yoW3XFbE9a
	yUJa4UWw45Ca10k3Wakrna9FW7A347AFW5ZryFgr93Xr4xXF95uFZ7t3s5Gw1Ut3ZIqF1q
	9F9rZa4UXw47WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8ZmRUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAVMZWbS+PA0YQAAsB

On Tue, Aug 13, 2024 at 03:42:19PM +0800, Richard Zhu wrote:
> v5 changes:
> - Correct subject prefix.
> 
> v4 changes:
> - Add Frank's reviewed tag, and re-format the commit message.
> 
> v3 changes:
> - Refine the commit descriptions.
> 
> v2 changes:
> Thanks for Conor's comments.
> - Place the new added properties at the end.
> 
> Ideally, dbi2 and atu base addresses should be fetched from DT.
> Add dbi2 and atu base addresses for i.MX8M PCIe EP here.
> 
> [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and "atu"
> [PATCH v5 2/4] arm64: dts: imx8mq: Add dbi2 and atu reg for i.MX8MQ
> [PATCH v5 3/4] arm64: dts: imx8mp: Add dbi2 and atu reg for i.MX8MP
> [PATCH v5 4/4] arm64: dts: imx8mm: Add dbi2 and atu reg for i.MX8MM

Applied 3 DTS patches, thanks!


