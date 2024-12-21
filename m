Return-Path: <linux-pci+bounces-18932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203569FA131
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 15:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93767A04A8
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855E41F2C36;
	Sat, 21 Dec 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Df2B7RiH"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C481F2C59;
	Sat, 21 Dec 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792556; cv=none; b=HF7oVJyFdy3B5J3gNOHg/NHuJ+VWfjZ6EJLW62SHt2oEUMBu4CQ8Vhb7oHqI+ij2qfcIaCGri/2Aerj7uMftUoxgxgygG5ddxvWFl+RW4k3B5p+9IKw43eTdp3BqkNFiVL/fYso9QnTvagyjw6LX9RUuSCJzBGn3CJLrUFkUXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792556; c=relaxed/simple;
	bh=tAQkr1bL8Vf/NvA9zabtC82RDVInjdMk/JhPMaaCjS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBOrazmt7wPxV/XOo9ZVUbpzt5O1nQTLtewZcPVQg+tF0DgSqb4X3hnbQbJFmv9grZb2dZyp7XSjKladkk2wM/VFxz27r5FPit3y+q+xoPsQzsiZA4pejBkmtn0RUOCTEEpvfgSUmGXmREHSf6KDbt9xCCHFsedtAsF/SrjVa9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Df2B7RiH; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=JLjXSeT4ASAxskBE5NoXYk7PA3S09CaNlCxHsyGGnZQ=;
	b=Df2B7RiH2CmWqlhACWTFQkclyykl9j4rKzD3JMlanHx7irzpZQdl3Q+wNgpFNg
	PY42qaYsQ7P6v//LRYELXlmfHdZsAsUS2W1lLtnMy4GxemqthF3rmPfs//5OHVnn
	phjS1dCfxh9HqYa3/KCEllube9lqas1ZcEPSTZR2rSxM8=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wB3n2Ig1WZnXt7XAg--.13948S2;
	Sat, 21 Dec 2024 22:48:00 +0800 (CST)
Message-ID: <3056bc64-7fc3-421c-a469-d233f5de6b40@163.com>
Date: Sat, 21 Dec 2024 22:47:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return
 value.
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
 <999ad91d-9b61-b939-a043-4ab3f07c72a1@163.com>
 <v623jkaz4u4dpzlr5dtnjfolc5nk7az24aqhjth4lpjffen4ct@ypjekbr4o54q>
 <f2c8be62-7ff6-f0d0-f34a-ddb6915df0a4@163.com>
 <20241219094906.wzn7ripjxrvbmwbh@thinkpad>
 <c16dc225-4116-c966-7278-cc645f16c8a4@163.com>
 <20241219112051.pjr3a4evtftlpxau@thinkpad>
 <3bbb298a-6f84-6be7-69c6-eaeaa088cc0e@163.com>
 <20241219133545.jiyqdzbkpwfu2rcv@thinkpad>
 <44c74561-a4db-4550-a07e-67f51556dd03@163.com>
 <20241220123216.za6kzma4q2kyfhln@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20241220123216.za6kzma4q2kyfhln@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wB3n2Ig1WZnXt7XAg--.13948S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxQ6pUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwe8o2dm06AovAAAsx



On 2024/12/20 20:32, Manivannan Sadhasivam wrote:

> 
> Then the quirk patch has to wait until your driver is submitted upstream.
> 

Thank you Mani.

Regards
Hans


