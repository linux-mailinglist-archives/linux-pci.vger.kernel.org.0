Return-Path: <linux-pci+bounces-28865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D94ACCA41
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE231893934
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2087723C512;
	Tue,  3 Jun 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YTiSAETJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AF81537DA;
	Tue,  3 Jun 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964744; cv=none; b=Mgppa724eIALZFrxw3TP6Cdc/u+JIYnyQGiI4gPWa8qauPX8BO7ml27jrm9OeDbA/JfeWkhgydfqwT3Wbrseeuh8ILGovmvf5LLq4EQo/MFgSPxPLqYrzhoVtGmVQYFzFXFsl38c96L+gNBGXDzEwNBzM8ZDsNf2/NWedffvgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964744; c=relaxed/simple;
	bh=n2G3L/1cppZUNXCPoJuyAcelWsbwiVmnTyGSvW/NvHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTss5P3dMJAJj39BfUpaodSvSeqAssIJ9U/uFR18fCq9ZnaAYuzxxyjzPJOdGoN5KjUsTBYQHG+/hWE3b7lo4pY4+beLjm7l8rY3ov8gxupXXXShsW0x8LE1TJQcLu2No5I3KKoXlqX5ay5tHeFs3eudeFDVPU1Zo+cJ8ibnV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YTiSAETJ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=hURbiKG9dQjvo1z7louEbs80FaEACCtaK1pYxGcQybk=;
	b=YTiSAETJcwDb5JB6n2x1gSB0GLykGqtbhOEyae8cLdqkA3sCPvL7QaXjpuDEQl
	kpk3oeA4NJkUluZLUKGArxRxtpMoUiMWb4YIYi1zPGu8U7MTbhqGjZg1ul3RbmQG
	Ghgxpc/Z8EaMQkPiblSJH+EYw4RcCkz8ufRo3XpWcQRCE=
Received: from [192.168.71.94] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnxyxTFT9oBzsNBw--.483S2;
	Tue, 03 Jun 2025 23:31:32 +0800 (CST)
Message-ID: <7191e865-4aa1-4de3-aa50-f32ea2786b5f@163.com>
Date: Tue, 3 Jun 2025 23:31:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: Add PCIE_SPEED2LNKCTL2_TLS_ENC conversion macro
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org, jingoohan1@gmail.com,
 robh@kernel.org, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250519163156.217567-1-18255117159@163.com>
 <20250519163156.217567-2-18255117159@163.com>
 <9bc475b4-4924-1b0f-af3e-ec4fa8140765@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <9bc475b4-4924-1b0f-af3e-ec4fa8140765@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnxyxTFT9oBzsNBw--.483S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyfuF1rGFWfCF1UAr4rAFb_yoW8CrW3pa
	43CFy5AFW8Ww13Cas0gas2qa4FqFs3WF4UuF47Wr98XFyft3Z5Gr12yFWUKr9rZr4vkrW0
	va17trWUCF12kFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRAsqXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwRho2g-AT4TzgABs9



On 2025/6/3 17:08, Ilpo Järvinen wrote:
> On Tue, 20 May 2025, Hans Zhang wrote:
> 
>> Introduce PCIE_SPEED2LNKCTL2_TLS_ENC macro to standardize the conversion
> 
> Use () parenthesis like you'd use them in C so functions and macros in
> changelog should have them appended.
> 

Dear Ilpo,

Thank you very much for your reply and reminder. Will change.

>> between PCIe speed enumerations and LNKCTL2_TLS register values. This
>> centralizes speed-to-register mapping logic, eliminating duplicated
>> conversion code across multiple drivers.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/pci.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index f92928dadc6a..b7e2d08825c6 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -415,6 +415,15 @@ void pci_bus_put(struct pci_bus *bus);
>>   	 (lnkctl2) == PCI_EXP_LNKCTL2_TLS_2_5GT ? PCIE_SPEED_2_5GT : \
>>   	 PCI_SPEED_UNKNOWN)
>>   
>> +#define PCIE_SPEED2LNKCTL2_TLS_ENC(speed) \
> 
> I'm not a big fan of including that _ENC there, it just makes the long
> name even longer and doesn't really provide added value, IMO.
> 

Will delete _ENC.

Best regards,
Hans

> Other than those, this change logs fine.
> 
>> +	((speed) == PCIE_SPEED_2_5GT ? PCI_EXP_LNKCTL2_TLS_2_5GT : \
>> +	 (speed) == PCIE_SPEED_5_0GT ? PCI_EXP_LNKCTL2_TLS_5_0GT : \
>> +	 (speed) == PCIE_SPEED_8_0GT ? PCI_EXP_LNKCTL2_TLS_8_0GT : \
>> +	 (speed) == PCIE_SPEED_16_0GT ? PCI_EXP_LNKCTL2_TLS_16_0GT : \
>> +	 (speed) == PCIE_SPEED_32_0GT ? PCI_EXP_LNKCTL2_TLS_32_0GT : \
>> +	 (speed) == PCIE_SPEED_64_0GT ? PCI_EXP_LNKCTL2_TLS_64_0GT : \
>> +	 0)
>> +
>>   /* PCIe speed to Mb/s reduced by encoding overhead */
>>   #define PCIE_SPEED2MBS_ENC(speed) \
>>   	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
>>
> 


