Return-Path: <linux-pci+bounces-25521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AEEA81A95
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 03:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32223B164E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 01:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFD07D07D;
	Wed,  9 Apr 2025 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lPCYIr2x"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F50250EC;
	Wed,  9 Apr 2025 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744162719; cv=none; b=ienAtXzlD3TBMG36YceYfPqcCtwnpGEPYaKi9IqApC5jb6X43d0ThhiJI5FEVev7q4ZAQwxxFtVUoRax9RfNUfB/7MprZVvPRTsHADL4jdrKJsch0RL1eRd/fwJ9kZEfooNVDThZYKhDqviLdE4sWNP9QXnOICD3/7LxoqNNSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744162719; c=relaxed/simple;
	bh=/Aqhjl5oClsTu1nqE+4odId5RVqnkUfrHVKtJCSZwMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMNfyH5pma40Vyeo/LIOeLCI7Yd8sRdaxzqUrsUnixmgaP5Woq/Kx9usW5d+tAdCPKdfP6cORp2NwUrE2qfbEb5zxqp/j3d0x4wIqExwYDHucfPyOSFmtto1PHc5Ycsk71Dei1OfelVi+mxkxFtSkPAuOG4CrKofI3aiHChjpUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lPCYIr2x; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=c3z3dr7lgCFWhzF4uE+NiRcEM2IRJ/mxV0Clz0l0eIg=;
	b=lPCYIr2xPYp0mI+Bylyk7TGs4qKH2qxyv+9MNdMV1yG0A1seS/tMaV/NAo3YLt
	U5LyMq+5lAThv82osy/J0uHt5GtSMKPWCwKtEnB2kBVITMo+7AFioivjKdfK88sT
	fOj7sKgjsjsW/hFdER/S8TNe8Xuo2Op7rzubd3q9EPNxs=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBXH3NXz_VnptM4FA--.59992S2;
	Wed, 09 Apr 2025 09:37:29 +0800 (CST)
Message-ID: <1731bcdd-22ad-4c71-a94e-b3576c1e7dc2@163.com>
Date: Wed, 9 Apr 2025 09:37:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250402042020.48681-1-18255117159@163.com>
 <20250402042020.48681-3-18255117159@163.com>
 <8b693bfc-73e0-2956-2ba3-1bfd639660b6@linux.intel.com>
 <c6706073-86b0-445a-b39f-993ac9b054fa@163.com>
 <bf6f0acb-9c48-05de-6d6d-efb0236e2d30@linux.intel.com>
 <f77f60a0-72d2-4a9c-864e-bd8c4ea8a514@163.com>
 <ef0237d9-f5da-44d7-ab45-2be037cf0f25@163.com>
 <3689b121-1ff2-f0f6-59f4-293cda8ea6a8@linux.intel.com>
 <ef311715-3e61-4bf5-bdae-58fd87a3d5e7@163.com>
 <e4db2248-ed8b-d270-d417-9efdca947e8e@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <e4db2248-ed8b-d270-d417-9efdca947e8e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXH3NXz_VnptM4FA--.59992S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr15Xw47JFykGF43AFy5Jwb_yoWDJrXE93
	929as29w1I9Fs7Aw4fKrs8urZ0g3yUWryYq3sYqrZ8GFn5AayDAr4vk3s2v34xGa4Yyrsx
	Kr4Yqr42y34IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUboqcUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwUpo2f1RouuSgABsu



On 2025/4/9 00:18, Ilpo Järvinen wrote:
>> Move the Capability search logic into a header-based macro that accepts a
>> config space accessor function as an argument.  This enables controller
>> drivers to perform Capability discovery using their early access mechanisms
>> prior to full device initialization while maintaining the original search
>> behavior.
> 
> ... while maintaining ... ->
> 
> ... while sharing the Capability search code.
> 

Dear Ilpo,

Thank you very much for your reply. Will change.

>>
>> Convert the existing PCI core Capability search implementation to use this new
>> macro
> 
> I think the rest of this paragraph after this are unnecessary.
> 

Will delete.

>> , eliminating code duplication. The refactoring preserves the original
>> functionality without behavioral changes, while allowing both the core and
>> drivers to share common Capability discovery logic.
> 
> Other than that, it seemed good enough for me.
> 


Best regards,
Hans


