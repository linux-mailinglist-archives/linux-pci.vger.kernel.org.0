Return-Path: <linux-pci+bounces-21339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B6A33CE8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 11:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1587A1598
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105B7212D7A;
	Thu, 13 Feb 2025 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBVNwmSf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9E211A06;
	Thu, 13 Feb 2025 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443333; cv=none; b=YMK9oNpkYYXeONHrYq1MyHlyw4mMoM7ug5Pw7uXJwBm3l4hdRpQo4Uz3TDuGUMXNv46k88dlgKzqntEL6jCSOhLMlGC0WJpibj8f8PRUzfOWTExi0wUtComAl6K9FjWf9b3bvFUcmFczKf0d2ZrlI/UmwlTNoruqXBwoCL+WpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443333; c=relaxed/simple;
	bh=JhUzn/oXMehFtshzcjfm48DfNmsq9f9fSX1uzKk6Z4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V32lIT7dPGybW8vVeAkZK7x6MX41lbL46TckHiOq3K7yaVNNGH/dRBR5mSNNDvnQlP0FuNRlNDr9S+b4apZI6lDEiTQcnpzVVNCjTnba6+jnNehVye8/NgIioyx0NeG2zAHurxbdMczohsjGNDCbv1CblO7lXGPDKV+vodPaN64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBVNwmSf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f7f03d7c0so12270115ad.3;
        Thu, 13 Feb 2025 02:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739443331; x=1740048131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZPJ7w8CWX3al1cRya7Ec0kd5qmpYeD7VrjjmpjQXU8=;
        b=iBVNwmSfKPFEU+Fa67jdz58qBjCC1aL4W7iXnHR7Pt0iA95NdmmKqrzwdUFd8difng
         +4bOfV8gfvlBTUZBmgaOjUIXvNtOb8qR4Bl6eyAPkfHsy6DZ9N81cMOYkwxBoSq25hR7
         1zGoHVBCKcxMSb7Jzot6bzICBJcHD440fxs3C3xWAlqtM+1jGZS6bz1h5Zitk1G/Rafx
         Ffvf0qT0T/5QkrGTtvWBgYeXF8iopvQrjSlNPRB2/5YGZSg2FP4/qcsovTp7SPlEaFfV
         WkIyC0+pb+JcSEFS4RTcijRoUQNC9qccZKVKxYFWaBWVWV8qqStNOkV1AUpoeDtPWBV7
         +F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739443331; x=1740048131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZPJ7w8CWX3al1cRya7Ec0kd5qmpYeD7VrjjmpjQXU8=;
        b=LqtqeZHjLn2jxCmFS5BKwkiVH2PH2r1ksDl6QQDQfFJg3HNcGqfjlWk8VzhNpaB4Xu
         wtxWFeKgqR762mj0fpzQH8NQ/9WVE83kG439PR2KZ8PJwbXVPdrqKdn3uAB0WecMmCxg
         NiP+CXlUkmc9pzxAdd/xVO/dlmHrUUdDn/5B6odNo5IoVF7fvCnq+bwmJxBCmbyJmTXm
         PwwZewOx8F20p03v/vpI4faHYEh1S8mFqh6Fy/wFr0ljI7vYxsO+I6bvgkNPqy9CNEKB
         v2FHCPTBLjmFl7yWL/b/xIngYAu2O3h0UK6VJTwAmlCTB1h4uHf7lsAHJ9gMFydNuUpN
         vTNw==
X-Forwarded-Encrypted: i=1; AJvYcCXL9kKIqL0bt2F9KFFyBo/C4hoG0y4fFj0odywCD12pTJMtpRDOO5Vzhyu9CWxZ5Z2QgHdR10AJWD5AMJw=@vger.kernel.org, AJvYcCXQ8+0EF6jXh/0tiKeJ1CAxehG0/2emNVFMVhrZadMtubQguvsrZoZ7XNP6SbhbWIo1/7KdlHx2/3W1@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRHV7yuwleffKraMsDeYavePloTG6det20N8+pQTfSdJfFhVb
	XYvWTTIOa5D4tma/oe7l1gWZ491hSdvIj6J0K6OoK2l7qBMkbdW4
X-Gm-Gg: ASbGncs4Mj66XDPwLvp1wluwC6pmgf885pMWbR2qREs1o6Hlu6/Ocoj+La7rMdOGZQs
	yNXAEAgZwSO4pqEghDYZtBEjVaWznXPmuixTGjLCub7oF54hQR4B/WS+X3xB94xz354lJgk7ayT
	QmbdJWzTp99mr4JZJbtTgf9wNjLT3TFrsZFDH1ae3M3cFcHGPA9fGlHW9brx1WO/zyqBID2Wzki
	D5fVxGFX4B6o1k1zXW4MYK0z/jfefOpdNRvOHjkxxm9s4aMDq19bFlksCem9BSI6/mfdEOnDk1K
	zIsZ6J3wueym+dRV40W6ZCgcsctLMQPhaoiVfZkaW3S2b8VJLNibipfVHq4=
X-Google-Smtp-Source: AGHT+IEI+FGQT0mJoCaWgpmVxSS8OQ1p7ri9u1bx9jiaRTK7695CdKt6XRKMDtKarhUvKOAGscSMMA==
X-Received: by 2002:a05:6a00:a90:b0:732:2850:b184 with SMTP id d2e1a72fcca58-7322c3f6c9dmr8920407b3a.18.1739443330706;
        Thu, 13 Feb 2025 02:42:10 -0800 (PST)
Received: from ?IPV6:2409:40c0:2e:ea4:cd5f:9fc:dd5e:c44e? ([2409:40c0:2e:ea4:cd5f:9fc:dd5e:c44e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242549d0csm985310b3a.21.2025.02.13.02.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:42:10 -0800 (PST)
Message-ID: <274de7be-86f4-489a-befe-475ae4c51826@gmail.com>
Date: Thu, 13 Feb 2025 16:12:03 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: pci: Fix flexible array usage
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250211210235.GA54524@bhelgaas>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250211210235.GA54524@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/25 02:32, Bjorn Helgaas wrote:
> On Mon, Feb 10, 2025 at 04:03:26PM -0700, Keith Busch wrote:
>> On Mon, Feb 10, 2025 at 06:57:40PM +0530, Purva Yeshi wrote:
>>> Fix warning detected by smatch tool:
>>> Array of flexible structure occurs in 'pci_saved_state' struct
>>>
>>> The warning occurs because struct pci_saved_state contains struct
>>> pci_cap_saved_data cap[], where cap[] has a flexible array member (data[]).
>>> Arrays of structures with flexible members are not allowed, leading to this
>>> warning.
>>>
>>> Replaced cap[] with a pointer (*cap), allowing dynamic memory allocation
>>> instead of embedding an invalid array of flexible structures.
>>>
>>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>>> ---
>>>   drivers/pci/pci.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 869d204a7..648a080ef 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -1929,7 +1929,7 @@ EXPORT_SYMBOL(pci_restore_state);
>>>   
>>>   struct pci_saved_state {
>>>   	u32 config_space[16];
>>> -	struct pci_cap_saved_data cap[];
>>> +	struct pci_cap_saved_data *cap;
>>>   };
>>
>> I don't think this is right. Previously the space for "cap" was
>> allocated at the end of the pci_saved_state, but now it's just an
>> uninitialized pointer.
> 
> Thanks, I think you're right.  Dropped pending fix or better
> explanation.
> 
> This is kind of a complicated data structure.  IIUC, a struct
> pci_saved_state is allocated only in pci_store_saved_state(), where
> the size is determined by the sum of the sizes of all the entries in
> the dev->saved_cap_space list.
> 
> The pci_saved_state is filled by copying from entries in the
> dev->saved_cap_space list.  The entries need not be all the same size
> because we copy each entry manually based on its size.
> 
> So cap[] is really just the base of this buffer of variable-sized
> entries.  Maybe "struct pci_cap_saved_data cap[]" is not the best
> representation of this, but *cap (a pointer) doesn't seem better.
> 
> Bjorn

Thanks for the explanation. The primary goal of the patch was to address 
the Smatch warning regarding the flexible array member inside 
'pci_cap_saved_data'. However, from the explanation, I now got that the 
current approach may not be ideal.


