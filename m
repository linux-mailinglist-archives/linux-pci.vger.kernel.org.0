Return-Path: <linux-pci+bounces-4225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BA286C282
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 08:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E002E2837F9
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B8939AF9;
	Thu, 29 Feb 2024 07:30:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483B45BE0
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191814; cv=none; b=kf3qi2VyQYciCaeFtNkB9yytlzddbz1sXIeu1B+EbS5+tNULCYFLBAsT0U0LjRcZ3PNsJkThwsK6qmWGTFWTDmLen5cQaJVTQZEhO/JZc2teKv2+aZjE9vYhm8qaeSK4KSwmamu30xY3vex26z4KOZWyTQWAa+a8oKcr/nrDF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191814; c=relaxed/simple;
	bh=rjKQsLKBAzqSr4dtcHw0J7MTGh8WjlmBAOHPzrDr92M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvRWh5/URUz9HLj2t55mHokztw6vNnrAxF/dwWSBURHPvRAPGoZckuoK967LkbP/axlTpOQewU1U9VeNENVBMQV1Vm9u5UObh+sS9/YQ16hB1d2LWeIFzs2YeL8h9YMRAF9cCjUnoUP+TYsJLtImSh64vIdXNYatgsPgllTGFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rfarW-0000Gw-9K; Thu, 29 Feb 2024 08:29:50 +0100
Message-ID: <0d03e5d4-12d0-4cc5-b17c-692471ee3c2d@pengutronix.de>
Date: Thu, 29 Feb 2024 08:29:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] PCI: imx6: Rename pci-imx6.c and PCI_IMX6 config
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 imx@lists.linux.dev, Richard Zhu <hongxing.zhu@nxp.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, bpf@vger.kernel.org,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
References: <20240227-pci2_upstream-v1-2-b952f8333606@nxp.com>
 <20240228230520.GA314710@bhelgaas>
 <Zd/DlibuoSxvjPW5@lizhi-Precision-Tower-5810>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <Zd/DlibuoSxvjPW5@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

Hello Frank,

On 29.02.24 00:36, Frank Li wrote:
> On Wed, Feb 28, 2024 at 05:05:20PM -0600, Bjorn Helgaas wrote:
>> On Tue, Feb 27, 2024 at 04:47:09PM -0500, Frank Li wrote:
>>> -config PCI_IMX6
>>> +config PCI_IMX
>>
>> What does this look like to users who carry an old .config file
>> forward?
> 
> I don't think people will use old .config when update to new kernel. I can
> keep PCI_IMX6 for config if have to.

I'd argue it's the complete opposite. Most users don't use the in-tree defconfig,
but use olddefconfig on their customized .config, either explicitly or
implicitly via menuconfig and saving.

This would result in non-functional PCI after an update. I don't mind renaming
the file, but please leave the Kconfig symbol as-is.

Thanks,
Ahmad

> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


