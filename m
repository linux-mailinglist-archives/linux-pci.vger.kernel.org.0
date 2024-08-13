Return-Path: <linux-pci+bounces-11612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22194FBFC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 04:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3B2283114
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 02:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF808467;
	Tue, 13 Aug 2024 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Dt3XS+W9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B0018EAB;
	Tue, 13 Aug 2024 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517476; cv=none; b=U1CZDhrom+/ySY5zGapYURHVErQ7ch5cEmHIE1vK/X8xg9trX9N0xsv93OAt6UovFrV5cbH7BdKIOD263SssEIk0ZPwUo286vQdHFtLTEQl0yY06iWeEctr3jRhhcOa9AoTICPIqwb6cifj9HhQsLYRj8CuGH2liTKsPL/m+kJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517476; c=relaxed/simple;
	bh=mrLd9Xn+sldxCRSn8L5qGWjjQhKmZ9P1zL2JPSrATNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQlU1l9ZSZTjX7Kr3d+LCN+//vMQlK/ePCvF0cfkDPMYqTNP6sahlh3eORgOR9Vhz21D302oFy4k/+rUgitGxMgryRuCK03oQfPkgkK73qeUEuuot8x1UJ8pxt40Ti2HCmgtA/PM7I9b0wvaxAS84oDvPxhL9DMiq6mFD3ysJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Dt3XS+W9; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=uuCHQ6dD39y247gfbV6xTF9L0a98i010s7PSy/g9X/0=;
	b=Dt3XS+W9C2f6Bo60qLMlch09JlDKo+7uTi2nViU23WKzVcXiDWJivPc3CoMn0N
	upz1CYnuE15F6MwYT6CPWb10Y8l6O7nFBrAcofAb8FrGfX90ZbIYuqzB+Oh/E0xM
	AuLWugfw7vhlVKv1/MhxouW2wW74/8or0ECxue0QP4Qxw=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBnryz2ybpmE0pSAg--.46098S3;
	Tue, 13 Aug 2024 10:50:32 +0800 (CST)
Date: Tue, 13 Aug 2024 10:50:30 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v4 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for
 i.MX8MQ PCIe EP
Message-ID: <ZrrJ9hfs2ycJgq8W@dragon>
References: <1722218205-10683-1-git-send-email-hongxing.zhu@nxp.com>
 <1722218205-10683-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722218205-10683-3-git-send-email-hongxing.zhu@nxp.com>
X-CM-TRANSID:Mc8vCgBnryz2ybpmE0pSAg--.46098S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1xXw45AF1rJFWxtr47Arb_yoW3trb_u3
	y8Ja40gw1FkF17K343JF4S9FWjk34q9Fy5Xrn8t39ay3yxJayjkFykt3s5Ar1UKa9rWFsr
	CFW7Xa40vrWfujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0CfO7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAo6ZWa6wscd1AAAsB

On Mon, Jul 29, 2024 at 09:56:43AM +0800, Richard Zhu wrote:
> Add dbi2 and iatu reg for i.MX8MQ PCIe EP.
> 
> For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the
> driver. This method is not good.
> 
> In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
> Frank suggests to fetch the dbi2 and atu from DT directly. This commit is
> preparation to do that for i.MX8MQ PCIe EP.
> 
> These changes wouldn't break driver function. When "dbi2" and "atu"
> properties are present, i.MX PCIe driver would fetch the according base
> addresses from DT directly. If only two reg properties are provided, i.MX
> PCIe driver would fall back to the old method.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

"arm64: dts: ..." for subject prefix.

Shawn


