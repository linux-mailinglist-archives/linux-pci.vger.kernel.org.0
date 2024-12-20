Return-Path: <linux-pci+bounces-18861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CC39F8D45
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 08:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3048B1887B1E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51D51A2545;
	Fri, 20 Dec 2024 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Vc3PaSZS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F1313C914;
	Fri, 20 Dec 2024 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679721; cv=none; b=XXQzTwFVcwIPsU/Sle/QspkXgnR+3qbSyG8GpcO7mxrOqsSp1I6Lzj1U9GaSeJx4t5rK2BMmCDKqO9zQgngApiPr4XT1tTJFPppup8LV4hv2WetZ6vqn0vkjkqxSCVf6jO16vHGgULJqbd315MkkG6Qa7wsf4MA1vglS8Fro6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679721; c=relaxed/simple;
	bh=sGx77ozUw7yN+iK8p6McR/9h4IK0oq9FjKGckw92b6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqY0W1rCP/xAWAvWneAsEVgs0eIhmi0tqbcPH+OJuuePAkGzAoy5XHJOlPWKNbEgzVGvyPB+dUJIQkbha3sPMv+7fgyhNBkQETs4ZWbSdtsyic0Wpv2cckNpxqKBxromovMDj0RgkhiWSTLhniLBpVRrQkr6HRpHnl+O9OCPx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Vc3PaSZS; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=okOoYFhEwwQVF2Nxxig28MGVcd0XbeC5HipyHISGhms=;
	b=Vc3PaSZSMpEKKnZrU7kgySOzyp2DVOyQX2vD7UagaFE/tTHqiUGrS1e6I6YPkw
	6BWAfvvENDNZGumPO9XplSGQaLAxuImffPgVr7sWA5GEyx7WPRFOPvRnw8uholYA
	HCM24ECdTp2AMujcj0khbNP/Q6uJpWNxjoUiC8DrkWMSY=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDX_8BbHGVnT2C4AQ--.274S2;
	Fri, 20 Dec 2024 15:27:27 +0800 (CST)
Message-ID: <44c74561-a4db-4550-a07e-67f51556dd03@163.com>
Date: Fri, 20 Dec 2024 15:27:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return
 value.
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20241219081452.32035-1-18255117159@163.com>
 <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
 <999ad91d-9b61-b939-a043-4ab3f07c72a1@163.com>
 <v623jkaz4u4dpzlr5dtnjfolc5nk7az24aqhjth4lpjffen4ct@ypjekbr4o54q>
 <f2c8be62-7ff6-f0d0-f34a-ddb6915df0a4@163.com>
 <20241219094906.wzn7ripjxrvbmwbh@thinkpad>
 <c16dc225-4116-c966-7278-cc645f16c8a4@163.com>
 <20241219112051.pjr3a4evtftlpxau@thinkpad>
 <3bbb298a-6f84-6be7-69c6-eaeaa088cc0e@163.com>
 <20241219133545.jiyqdzbkpwfu2rcv@thinkpad>
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20241219133545.jiyqdzbkpwfu2rcv@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDX_8BbHGVnT2C4AQ--.274S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1DGF4Utr15AFyDurWUtwb_yoW3ZFb_Cr
	1F9FZxAw48ZrWxX3Z0kFs2v34ag3y3ta9rt3W0qF1fuFyfAw1UXr1DKrWYv3WfJwnxGrZF
	qa4YyF4jk3sIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0-18DUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwW7o2dk4Zi9AAABsU



On 12/19/24 08:35, Manivannan Sadhasivam wrote:

>> We have 5 PCIe controllers, and if a few of them are not connected to the
>> device. And it will affect the boot time.
>>
> 
> Why are you enabling all controllers? Can't you just enable the ones you know
> the endpoints are going to be connected? I'm just trying to see if we can avoid
> having a quirk.

Our SOC has a PC product situation, and there may be PCIe slots on the 
PCB, but the device may not be plugged in. So we need to enable all ports.

> If you do not know, then you need to introduce a quirk for your platform.
> But that requires your controller driver to be upstreamed. We cannot provide
> hooks for downstream drivers in upstream.

Our controller driver currently has no plans for upstream and needs to 
wait for notification from the boss.


Regards
Hans


