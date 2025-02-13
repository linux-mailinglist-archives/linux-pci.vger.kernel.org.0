Return-Path: <linux-pci+bounces-21338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998EA33CD8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 11:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C767A2890
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63A212F8F;
	Thu, 13 Feb 2025 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnsCqf8V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F08210F5B;
	Thu, 13 Feb 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443055; cv=none; b=AQtpPmeyH5W3wsTVNoKYcHiYWGtKBCM2fmbvkCkLIyNvET94IXhF4BwrMdcDcCZYYzn5bHgtEL7BnWdAz9Fce2bHZJ8ipcxXoMTaL89+VVzNFx4ldZ7sQ+RBq+fmywG8k8G0BfM7eyy8cpPBoHfBH/03Csdq4KFIwhKRisESGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443055; c=relaxed/simple;
	bh=x59ELff3Ko9XV3P4AzW9q22BeUT9x3Uw9yDPdDi/YBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyXE6+KEor5FuwzrmWE7o2PGGckZLpAQi+FRd7/QTepy9wLRbBKjrmFbfFHkEvKMnO4iTUHAQfiAva+aRvzbL2++0fWfcSbuz+xCH/EFjzuSkYuKkn5ZVJp2t/abuIT9Z3XwvuwqrQgyZvc2OOpXhpQrVH5oSYIbqnGhNgFvXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnsCqf8V; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa48404207so1600984a91.1;
        Thu, 13 Feb 2025 02:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739443051; x=1740047851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpTN9u4BUWo3INTZx8FXN6C9iuKB5h3rpN1TXdUrLeg=;
        b=UnsCqf8VYwHzFg4I+QSZhpV2eMZC6iyBV4SM9KsFFI4dPlsedfGayKORt6cVuD6L+q
         qCrx7rQHNs0kOrGniiMnykzAgnzgqcxwz2OJqneKDc9ks2SrFbXNS33iceEKHBcSdqh7
         QNvXkwTcJPc6ygVrOD4z2Rudoo/CmG00NnUKGPdLyq0ooZa7aTEb/7sZ2ZeqLBBObYNa
         r0mj1XeRWG+6jRGCiFcFHPwYNNWDEIh6rv8hn+rBAE478VqNxbUiCEm+0mz1w69Yu8qa
         l8SI6pu3/mBCaENNj8q0GJEHhPoer701g4J2sC8PCksEu27g2Lv1aQK1tw7ZQs2hfpIb
         6eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739443051; x=1740047851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpTN9u4BUWo3INTZx8FXN6C9iuKB5h3rpN1TXdUrLeg=;
        b=rIc1EtOIwsa8kyV5BfW+bTq3Q3/1FZwyGS2rUsWyC8CS8SI+CiUKKV2Drk+HumBdk9
         MiJnvtzoE/G/cTBw7oiSsRkjkPfzwwMpupmQF4OCeSEdwP76A+q+7qcI0S4qrZqPWpq3
         vtK47SGuSbgG172YJYkCfMLRR96OAdlilj9v1uqQ5rHsO+qEyTrrrJuv3AxspjwI7+v+
         Sa2AtAr/5/LrtTbV6pVf/44NmQBaGNs3bjBCZzOfxZ2jRhK8UdlH9Q2Hu/27fNrmzp9X
         i1TJ0aULpTYbz5fZonlFFNfs6pvafA2DEEdZ3FpgxJ92MUG38pR6tWnmMG2q0PPF6LId
         0OWA==
X-Forwarded-Encrypted: i=1; AJvYcCWl/mg741k/XjoPrm9RV1/R+rgrrBEw0P0Uhcgd/Z3Y0Sbto9p68iV2ojaKeBkMGvrcChyaJYgHDtJQ@vger.kernel.org, AJvYcCX9SG/tD8QMRQ+KcsXeuyoo+B42vMf1mEiA1IJCUE1kJhp5ufUOZcThednOslDgm/xQZt0dTttem3IhBMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5E/uOzLW2xRu+mcHB/oOHqo+w+1S5loQ8IZ0IY/SMe8eiohjb
	lcshXFPUAewTwfj0YzJSJbqKBVlsdeuseYHYsGEyZjfNXdZh0Gnz
X-Gm-Gg: ASbGncvU5W+okUCaHfZl6qfyeCOmcTa7TOQeJdVt0moHDoi3x9FL2HfkMsSrZbWWyHR
	0MohwwSCnDtXXmpSfuTxNcWzBzbLEnt2ciz5VCdefRqGUaGDFCC150AB1AESMI8uxC1CESU9gzX
	QoFnyJ01YvxKijPmig7+fiNxuJ5j/Umh3+FGyqJnyJXtuoVcZdkzNidQj5X7RrV69KOaxo+hqkT
	ysfCAcNJfN3A3LnAJPhIf/wY2QH97gNRdCwW32ZvCTzf8CY6RXJUzbLDNtHUiifvW40zbic3cpD
	sWhfBWCSH+8W/AmnJruX6A+Kq6Kz5oUxu585lv5dXuxgWtkqMCAQ/far92bkb4G0
X-Google-Smtp-Source: AGHT+IFp9c4drkpPNFVMCkqQiOLv9O1FyLLSPt+myo1vKT8Z4QPUvCWKntfraEFXNe44f81QtBObXA==
X-Received: by 2002:a05:6a00:3403:b0:72a:8461:d172 with SMTP id d2e1a72fcca58-7323c1055a2mr4933229b3a.3.1739443051413;
        Thu, 13 Feb 2025 02:37:31 -0800 (PST)
Received: from ?IPV6:2409:40c0:2e:ea4:cd5f:9fc:dd5e:c44e? ([2409:40c0:2e:ea4:cd5f:9fc:dd5e:c44e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324276175fsm991569b3a.143.2025.02.13.02.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:37:30 -0800 (PST)
Message-ID: <93cb6da2-5bba-4574-88dc-1f3d03a9b8b9@gmail.com>
Date: Thu, 13 Feb 2025 16:07:22 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: pci: Fix flexible array usage
To: Keith Busch <kbusch@kernel.org>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250210132740.20068-1-purvayeshi550@gmail.com>
 <Z6qFvrf1gsZGSIGo@kbusch-mbp>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <Z6qFvrf1gsZGSIGo@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/25 04:33, Keith Busch wrote:
> On Mon, Feb 10, 2025 at 06:57:40PM +0530, Purva Yeshi wrote:
>> Fix warning detected by smatch tool:
>> Array of flexible structure occurs in 'pci_saved_state' struct
>>
>> The warning occurs because struct pci_saved_state contains struct
>> pci_cap_saved_data cap[], where cap[] has a flexible array member (data[]).
>> Arrays of structures with flexible members are not allowed, leading to this
>> warning.
>>
>> Replaced cap[] with a pointer (*cap), allowing dynamic memory allocation
>> instead of embedding an invalid array of flexible structures.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   drivers/pci/pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 869d204a7..648a080ef 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1929,7 +1929,7 @@ EXPORT_SYMBOL(pci_restore_state);
>>   
>>   struct pci_saved_state {
>>   	u32 config_space[16];
>> -	struct pci_cap_saved_data cap[];
>> +	struct pci_cap_saved_data *cap;
>>   };
> 
> I don't think this is right. Previously the space for "cap" was
> allocated at the end of the pci_saved_state, but now it's just an
> uninitialized pointer.

Thanks for your feedback. I understand your concern about the 
uninitialized pointer. To verify this, I tested the file using 
'~/smatch/smatch_scripts/kchecker drivers/pci/pci.c' smatch command, and 
it did not report any errors indicating that cap was uninitialized. 
Based on this, I initially believed the change to be safe.

