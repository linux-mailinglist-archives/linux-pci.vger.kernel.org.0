Return-Path: <linux-pci+bounces-21484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C93AA363B0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDDD16FDE3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4FF26773B;
	Fri, 14 Feb 2025 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QInND93q"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D1267707;
	Fri, 14 Feb 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552055; cv=none; b=q9HaaZADpnMhT6gfzzEVMvbPkim2em+KvdZb12gflXqV71UBpd//NbCAgtQOQzxpIw0FC+hW0q+dOOQcjy2mNoORgdlrtaWVT0G2bKkqCB8+hiIlALvJ4SaMjjJEHNmXh93SGByPztxTixWANrGmpOdowivcURTfGAFwgcxDYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552055; c=relaxed/simple;
	bh=IFEiXrrJb8KjuBXvYRhIgd9nrcRAceAIp9pxdMOs/uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDGII4h6mi2tWbp0G1nM3152BNhIyCVmOre6BeJdbGocOphIiVQ4FVtcIlsJIFVUVRJDvZCiSmTBaSJpngmpSwPGdNnPgxfk9Rvzyw402a0L4RyN5HnARb+3ba42eWGs5ZlWLH98PWUTs1CvX87dsFR3Lssn0Cei//uM1OUNZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QInND93q; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=iHCZRKQOV/t8wh4QfIKn5R7J3aMaa1mmCvAkxwGVn1k=;
	b=QInND93qA0Ww0L01d0UIruACfP7sdCgMwcj84uGApfrq6Z5J0vPINYNdTev2Em
	8fmSsa3fqDx+MFoA6rAIoBvOuOjNWxDnilGBWiCHGrGdwmPWsz58lLs5VxBATvGH
	7QQNt+Y0S/rIUP+zXqT3ChW/edZTXwrhM8VyAlm0zmvtY=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnsQoQda9neAOaMA--.50023S2;
	Sat, 15 Feb 2025 00:53:37 +0800 (CST)
Message-ID: <f7e51e84-721c-4177-9a00-94ca466c145b@163.com>
Date: Sat, 15 Feb 2025 00:53:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 bwawrzyn@cisco.com, cassel@kernel.org,
 wojciech.jasko-EXT@continental-corporation.com, a-verma1@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250207103923.32190-1-18255117159@163.com>
 <20250214073030.4vckeq2hf6wbb4ez@thinkpad>
 <7eb9fedc-67c9-4886-9470-d747273f136c@163.com>
 <20250214132115.fpiqq65tqtowl2wa@thinkpad>
 <332ec463-ebd9-477c-8b10-157887343225@163.com>
 <20250214153103.4cjlawksw4xobc2l@thinkpad>
 <3d3d8772-08ba-4e5a-bf1f-71821cf056e7@163.com>
 <20250214155725.jpkd4vtcycav4yrc@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250214155725.jpkd4vtcycav4yrc@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnsQoQda9neAOaMA--.50023S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUFq2MUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxDzo2evaI6xnAAAsY



On 2025/2/14 23:57, Manivannan Sadhasivam wrote:
> On Fri, Feb 14, 2025 at 11:48:16PM +0800, Hans Zhang wrote:
>>> If so, it is fine. But is there a way we could detect those first generation IPs
>>> and flag it to users about broken MSG TLP support? Atleast, that would make the
>>> users aware of broken hw.
>>
>> I don't know how to do it, but here are the questions that were actually
>> tested.
>>
> 
> Not related to this patch, but please check if it is possible to detect those
> controllers.

If possible, I'll try to find an opportunity to check it out.

Best regards
Hans


