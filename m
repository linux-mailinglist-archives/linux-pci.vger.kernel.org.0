Return-Path: <linux-pci+bounces-43960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD7CF0224
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 16:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F6C330037B1
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jan 2026 15:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5362E276051;
	Sat,  3 Jan 2026 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me7GF99J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4A1E832A
	for <linux-pci@vger.kernel.org>; Sat,  3 Jan 2026 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767454721; cv=none; b=FkXdy4+mhz1Xm7kNzLfSsxTKB2kL4uSHAdAgeMH5WBPU+LhDfySQxMI6d+bgz7tF4Nz3I+X8BEZoDR4zw6PvncyUOGdgaKXyiqkDFmE87D4aPJAIqG9I4ma6IaXUCDg0TaZBiDWBYdd9R6FoxiPqvjR+2BCg19cMSIzkTXDIgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767454721; c=relaxed/simple;
	bh=Cq3k1/fXBP/fel0pjPIO4KMDsjM8pwucAIhaVZQ4XBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/NjT5dPKel50HwpT+bzLH8iAx+dak3wX1ihcmlYN2KeMECcMCIaTaS5ikWOcW0U+amQOT2jjjxaVTGJ1XV6k24pdwzV7J/Ng29KVgJboPNmvYxXrlNj9ruDiopqzPZGfPbudkzY3NAFbxuCdD9jq5QGHXfKrlCfH6e6WUgqv+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me7GF99J; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b725ead5800so1814878566b.1
        for <linux-pci@vger.kernel.org>; Sat, 03 Jan 2026 07:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767454718; x=1768059518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hs0EhRoobDLxoEH08l0zC5fr9dWFdN5yFIFiuBMlNQ=;
        b=me7GF99JAULmF/6ay0IJjFgsGXTTukgbeEgebbP8q/Z4bsdZ4vL3NvJsWK/PCrrn0t
         TLw6gDPXD6DidR8zBY8BLlNs4IwmmYAdXHNdn9ETipEo9Zs2GPneXyINpnhyovBMsRGh
         09qOy8YCggXhCMfKoLG9NV+EIvET66VXDeh91/0iufIhlqQO6luxHzdfsgXQAq+Dw5ey
         QFF+vSU8P/4sw8zI3XdcLImEXTzZOW569LgcX0VXHJ9DHiNoWAPcl1+N+Mc9SFHnrDWT
         CUa+rXF/pg+uaSjLO8MxwlZh5BBqpfXHf/Q96drNdzNI6KqVbj0NVEyqmw92luN6tGqD
         6m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767454718; x=1768059518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hs0EhRoobDLxoEH08l0zC5fr9dWFdN5yFIFiuBMlNQ=;
        b=xM6xYWULITaO5EcfYG3fNmuiZ6ApwuNrAsAUZ4l8fk0fGMwFpFLZ/WKd4PeNL1VpEG
         qYRDqXLf2TEuovvdGpdASHHSnoUW31eAzkuR+cAkv/8D3ySRkIZU4VosspeW48wrF/Bc
         irjQbuUHrLNuQUdqlpntgEHlKZfrELlT5+snMJOJza12N1b+yWXac+SrcLxuz4vSszXz
         4UksmH6LFN9zWtxiMWrcpMs3JWOn/u6TOQxA8tC41qjurB5/wOG+WQmEF9QDdeoom4lW
         QkYB6AFNfpO5OSL/n/96EkohUBqhdieSrxKWhfatRQfAM3gtcA8LYoKoM5FekR/+Cge5
         7rpg==
X-Forwarded-Encrypted: i=1; AJvYcCUhLFUFWTDeyGnZntvtcO+bElOhwHIzxGe/VyYZHWqGYd0iQ+DDmIF0jiyT+fFe694nz8v6d9gDrc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmS2ic9ZJqw+y8TfaQjItyAWaUPhJLBpvTs+64PpTw6m1Lgx3u
	1YwN/IuYL0qVDib/pLYNUP78Aaybd1M21IAdyR0q7J2hRQzR5LaCmkmF
X-Gm-Gg: AY/fxX4U7rYaUDCbpz/iT7cbQQOyd/jchgJfQ7pSFTWqYGUy8A3rkTAlosDlHKj1nUr
	sfhqWEFr0prxBS3Xi2eXhPqHplAmoicqDo+lHSarCAyq+DgrVdt3tPSGGLAA34rwsv8XOYKPVjp
	HwDto/DeE3icFTnH+pcxoFOeQkqUFd39Z6fsrXL+wfu9XRprz+gCvjanI1pa+gDFPWjDG2EA/6W
	MOHwZoNqF9fYquK9CoojYSMAvwDXbS2g0otS2lzE6KyNpGHHV26W150NruT/0emt9/1JFexTWMx
	1AIkfAGfX4HMGXmADbI6rdE5ZhugObnMnWSZUDpOa2BaPoCHFc7yMOhqYSBdopTiyTL9cL7vsZH
	4V6L90pchYYkg54+JaSvTkn9tN0gGANeCZ7RUcBrAM6OZshvtwhZ78pnrkAsJmex1TTAEowlrsA
	JhO0Vy8hlbI/jdDS/QJDGaWVBvOoUVgOqPwOfzzn0xr2erufxClCGtjV5pRzpW4g6OIz9DMhoYz
	WOh+wfwXsyeYNdW1alHjFNFyRtT5AoeYnzAnyu/0nvSBA==
X-Google-Smtp-Source: AGHT+IHX3y0FmDy1TKEc3tmnS+B1SrOgQ3j6ATmu3whCYNr8VYjGOlmbeI9SRs33adJYXlB3knoEvw==
X-Received: by 2002:a17:907:7638:b0:b80:6ddc:7dcd with SMTP id a640c23a62f3a-b806ddc842amr3076213466b.31.1767454717880;
        Sat, 03 Jan 2026 07:38:37 -0800 (PST)
Received: from ?IPV6:2003:df:bf2d:e300:a75f:8613:8605:1c8b? (p200300dfbf2de300a75f861386051c8b.dip0.t-ipconnect.de. [2003:df:bf2d:e300:a75f:8613:8605:1c8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad83dasm5150694466b.25.2026.01.03.07.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jan 2026 07:38:37 -0800 (PST)
Message-ID: <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>
Date: Sat, 3 Jan 2026 16:38:36 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
To: Danilo Krummrich <dakr@kernel.org>, Marko Turk <mt@markoturk.info>
Cc: dirk.behme@de.bosch.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20260103143119.96095-1-mt@markoturk.info>
 <20260103143119.96095-2-mt@markoturk.info>
 <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03.01.26 16:24, Danilo Krummrich wrote:
> On Sat Jan 3, 2026 at 3:31 PM CET, Marko Turk wrote:
>> inststance -> instance
> 
> It's trivial in this case, but we usually write at least something along the
> lines of "Fix a typo in the doc-comment of the Bar structure: 'inststance ->
> instance'."
> 
> Please also add a corresponding Fixes: tag.

While looking at this some days ago as well I came up with

Fixes: 3c2e31d717ac ("rust: pci: move I/O infrastructure to separate
file")

But that just moves the pre-existing typo from rust/kernel/pci.rs to
rust/kernel/pci/io.rs. So I'm unsure if that move-only commit should
be mentioned in Fixes:? Or if we should go back more to search for the
commit introducing this typo?

Best regards

Dirk

Btw: While we are at this file, do we want to add an 'is' in line 57
as well?

// `pdev` valid by the invariants of `Device`. => ... is valid ...


>> Signed-off-by: Marko Turk <mt@markoturk.info>
>> ---
>>  rust/kernel/pci/io.rs | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
>> index 0d55c3139b6f..fba746c4dc5d 100644
>> --- a/rust/kernel/pci/io.rs
>> +++ b/rust/kernel/pci/io.rs
>> @@ -20,7 +20,7 @@
>>  ///
>>  /// # Invariants
>>  ///
>> -/// `Bar` always holds an `IoRaw` inststance that holds a valid pointer to the start of the I/O
>> +/// `Bar` always holds an `IoRaw` instance that holds a valid pointer to the start of the I/O
>>  /// memory mapped PCI BAR and its size.
>>  pub struct Bar<const SIZE: usize = 0> {
>>      pdev: ARef<Device>,
>> -- 
>> 2.51.0
> 
> 


