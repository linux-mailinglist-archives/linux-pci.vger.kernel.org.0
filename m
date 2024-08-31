Return-Path: <linux-pci+bounces-12553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EA99671A9
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 15:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636DD1F228F5
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4A1D130D;
	Sat, 31 Aug 2024 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="oS8vZfbE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5541D130C;
	Sat, 31 Aug 2024 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725109237; cv=none; b=pDRWOknfpeWUDuYf2ZjG5ULcm6alEr7UeZEenBCjDbncTfhs99PbXCZ+depIMtqAU+vcu2WOGEq9AUoWbUB4Q0nOxbij+mvPk1qsqBX24GQPnmWVPsdztHYLIB6QbVxNkWhdW+DgvisW3aSGjfDhWGozTmyiO9JRmLofzAa1sJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725109237; c=relaxed/simple;
	bh=w659f6kqV/OR/UzNObajOpqSV64/Bzt1TYyuLmls+Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvCOE984xVrQqC5y8dmMZOXnfAo0Cfwf1ALQwOIQ7+Cm7GDZM+MpGCki/v3SFdGpYx1Xv/guA3am8YKTllWYUAezDo2jA1FhmD5d2qLqyFCjeS68Mjz2B8yAkc73qYIzvN1yRcrZMloZw/GR7MxwgfYIyl9Q5dtNb/6uJbLun0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=oS8vZfbE; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=W6rrmx0uL0jY6lwJcH1ACK0U7bPTNm0fVoJtP29xGVY=;
	b=oS8vZfbE6wByklYv2ot0QHTG/nuEASjtIh2GSbnF7yNLt8WI+6ZuHK7XWRHZ5C
	3STD1i0939IhFRgKuGtS8FMmuES2ZrVAFDbVsEnRVKLsDZxXtPGjy2VtdToEGd3S
	ST9jlSBhTOYcYrdMdjxk95DJ2lEweuhZa57Dz1xBCJj6E=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3X0nJE9NmJYk7AA--.10321S3;
	Sat, 31 Aug 2024 20:59:55 +0800 (CST)
Date: Sat, 31 Aug 2024 20:59:53 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <ZtMTybL79ui5ocPM@dragon>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>
 <172356674865.1170023.6976932909595509588.robh@kernel.org>
 <AS8PR04MB86767916B0539B339120C2218C872@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB86767916B0539B339120C2218C872@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-CM-TRANSID:Ms8vCgD3X0nJE9NmJYk7AA--.10321S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWrXrWrWF4rtF1UKr4kJFb_yoWxtFg_Kr
	4Iy3s7Ar45Xay8tanYyFZ8ZrZ7uF4q93y5Zw1UGr1a93s8JF95XF95Gr4kK3WjgrWDWF15
	trnxXr1jgr1aqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8z6wtUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxdMZWbS-EksMAAAso

On Wed, Aug 14, 2024 at 01:49:30AM +0000, Hongxing Zhu wrote:
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> > 
> > If a tag was not added on purpose, please state why and what changed.
> > 
> > Missing tags:
> > 
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Hi Rob:
> Oops, I'm really sorry about that I missing this reviewed-by tag in v5 by
>  my mistake.
> Thank you very much for your notice and kindly help.
> 
> Hi Shawn:
> Can you help to pick-up Rob's reviewed-by tag?
> Thanks in advanced.

Hmm, this one should go via PCI tree.

Shawn


