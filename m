Return-Path: <linux-pci+bounces-31023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E9AECB90
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 09:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7C11745B8
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F051A7AE3;
	Sun, 29 Jun 2025 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="a100A77s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBDE1CEAC2
	for <linux-pci@vger.kernel.org>; Sun, 29 Jun 2025 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751181630; cv=none; b=lJ8MgHLhUNM+/XpPNmOEm2yyhXagkqjRCo0cnJxL4q1A3Elqgc+ii9tEYU2HpuqWcISnh+3GBLl822H/g7JhSOug/yM8vMiBGiZim/S/JkAgprrCZ5GS2oU3k20RNCooVGOeUfi6AzZTksE1EP4jEbz2F6eQsm7sVeJ1/vydd1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751181630; c=relaxed/simple;
	bh=Cpp4cimSlX6/ZA+LS1tvkBe5d6uSGAhUqiVr+pmYzpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bVTBBH58nyXpTuwSx4K2yFFqQhcTu/97tVYs1swZeKVmg8NixU2kyWDSHwyXG5/VEjB5NNxKyZkLsPknLFAPL1bXhf3iVLEdpYWa5jC3c3cLahJg/YKV8btnU38SGy/1fyP1ELaBRHENmaQFPGlz3WuCIIIHgeYr5QUXn7Uinpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=a100A77s; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748d982e97cso1258654b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 29 Jun 2025 00:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1751181628; x=1751786428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3YbYWCMUijBwsfHEBbDnTMP57muDMHFrEOHCcbc1whE=;
        b=a100A77sxKk1gtNpMy/JCKtFz8t9QWsqyQS+qSjflKj7eUQUdE9UhpqxeJlJLrbql+
         y9rdPyzsYDsDU1NBTpPPb6vhwVh5mHzPZ2P6V0mIG+1caSWFu/EyJsyEMB75SuJ4XCqm
         vsZr2ueQsH0xmDKjA+7Nyt+MOD4cp+ODnODac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751181628; x=1751786428;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YbYWCMUijBwsfHEBbDnTMP57muDMHFrEOHCcbc1whE=;
        b=RY0bgl7UMGHjdypqVnZdhMD8t21DyQrBGMU2OV4oK4VYbuDWGN0HW09gCaSNhN4pCi
         2nrgXU4d1iAq4A2Wsq2V2varlj87lHzG4brkOTabosh9Udo0Rokw1jERhkX7x8YIq/SC
         4TkFOunAX2FCJ9854sf2UU4dlsumJ1oQ+sLaGAYbBKeQsMmFLgEIWhYxX0UE7neID7Og
         DefeMw0Yw7dxwCwS/zmcR+ubeBYxUOXmEjH6Hvkfi5orm7g3ARk2c32RkNel1uf9G49e
         sygxll1fyvTWzD3/pqLOYXmJ7urCqoCiXLqZX/zCriC56Is1JelQedUr1ai3M7GxFrGi
         XUcg==
X-Forwarded-Encrypted: i=1; AJvYcCXyz9EHDLMaK5ap+6oUPiHmbvyHnxYMNiRKASLEBpkwE5tFRJsZUR1RLUHh/P5L6fLwUZF5TN9e+f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZGpK1Pg024/3Tu655H7MG3gLa/T1DS2F+HFQapivLF6cRXlV
	62rOvnDlRjf0tusTH3ktH6KhSOfzaeDCsd3MlEBIG+t+E9j1bm9iyXG42boC/UzaQg==
X-Gm-Gg: ASbGncvqWyvGnOOvS6gJ5gd+ixoZzawPTUkO7FhCkMLbHaqovXlmdIq2W2assN0ROPA
	YlNXvEOzFNl8w21T//7lllB0MB7pQAjByS5l6aaUnA51p5xZjdDOBNfN297ynhRXhNUpFmmkg5z
	zOtuCpj/XJs6RxTOtiDnAIumpfSL5nKj1Tin6Ix9vtl1BEt3CtU3hpG1TwhlEo/+9lkdn28LpO5
	GBrlCAP5x6td9tV4hGtrQRc120gu8X0bO2fVgAtmQSTGFaYzzCwBMN9sILoCkW1N/jm9XElDFtt
	IIjGB8HQ+yN2f2SkZjxxj0RxB7vlvmSfiFt9IMPQKKdcfevLWVbrdeI9Lk20fGuMmH3C/TBMOpZ
	TjpZz5dGFN/OU4hJe0h5mqb3U/mDuf0rh9Jj5/LFKQYPzXg==
X-Google-Smtp-Source: AGHT+IEHkik0r8PJ7wgKd9VwE2NTDfBOTlJf0xKoCEuaiQe9ZnV5cbmTfkGbKhXrCLsrJpCbzOkIvw==
X-Received: by 2002:a05:6a00:1898:b0:748:eb38:8830 with SMTP id d2e1a72fcca58-74af6fcdd6amr11854659b3a.13.1751181628497;
        Sun, 29 Jun 2025 00:20:28 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ef308sm5885444b3a.157.2025.06.29.00.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 00:20:28 -0700 (PDT)
Message-ID: <a6b1b841-87b5-4b77-ac15-89364cc760ea@penguintechs.org>
Date: Sun, 29 Jun 2025 00:20:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: pci: fix documentation related to Device instances
From: Wren Turkal <wt@penguintechs.org>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
References: <20250629055729.94204-2-sergeantsagara@protonmail.com>
 <ee8636ef-ecf5-4e1b-a304-9a96df1ae4ba@penguintechs.org>
Content-Language: en-US
In-Reply-To: <ee8636ef-ecf5-4e1b-a304-9a96df1ae4ba@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Apologies on the double send. I thought the first didn't go through. 
Please ignore this message and reply to the other.

wt

On 6/29/25 12:15 AM, Wren Turkal wrote:
> On 6/28/25 10:57 PM, Rahul Rameshbabu wrote:
>> Device instances in the pci crate represent a valid struct pci_dev, 
>> not a struct
>> device.
>>
>> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
>> ---
>>
>> Notes:
>>      Notes:
>>      I noticed this while working on my HID abstraction work and 
>> figured it would be
>>      a small fixup I could send afterwards.
>>      Link: https://lore.kernel.org/rust-for- 
>> linux/20250629045031.92358-2-sergeantsagara@protonmail.com/
>>
>>   rust/kernel/pci.rs | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 6b94fd7a3ce9..af25a3fe92e5 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -254,7 +254,7 @@ pub trait Driver: Send {
>>   ///
>>   /// # Invariants
>>   ///
>> -/// A [`Device`] instance represents a valid `struct device` created 
>> by the C portion of the kernel.
>> +/// A [`Device`] instance represents a valid `struct pci_dev` created 
>> by the C portion of the kernel.
> 
> Should this not just be a "a valid pci device" and let the type in the 
> function definition speak for the type instead of duplicating the type 
> name in the  doc comment?
> 
>>   #[repr(transparent)]
>>   pub struct Device<Ctx: device::DeviceContext = device::Normal>(
>>       Opaque<bindings::pci_dev>,
> 

-- 
You're more amazing than you think!


