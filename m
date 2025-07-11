Return-Path: <linux-pci+bounces-31896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E592B011A8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 05:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284AE1CA4D07
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 03:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541A119DF4D;
	Fri, 11 Jul 2025 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7ktKKn6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7216F265;
	Fri, 11 Jul 2025 03:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752205104; cv=none; b=lVg/8Lv0rWCfeYk2EAT6Gp/0dqIiAVLLLIqK0w5kJlryni2Pi50sTEUhdWK/GgGp7dW2ens1lW5mphPEf4k9dnQzRipHUoVkx53O/lprAF8eLPFaXu8u2v6l4j/Kwyka122vOX+/ZQoo28BsOORtX7PJ+ubX6aG9wWUx3aGkK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752205104; c=relaxed/simple;
	bh=H0Hm8kyQZ6n/N/KRsdcxE9qHNEhDDCeTojZ8XUtvPZc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BMGltRBT+QqTbON4oEo4Mrt0ZYGxpJ5Kw7G1UtyX4JWFV4Wuw4EorrNhQIlnWSqXok5g5QxvM6qw7s7aoDPrY07qjiVDEw3uHLSInOrFNUHFI3AODUZ2K+ig5CqHyh7hHgm3vj3S8ra43eG0u/IkzKzwqDZJvIeabsJ42H+Axl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7ktKKn6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2349f096605so21517815ad.3;
        Thu, 10 Jul 2025 20:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752205102; x=1752809902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/Qj70+Qw1ZA0kyE48WMaDv1mNZmCeBb3mdlEQxC1dk=;
        b=h7ktKKn6yo5z7tz1eZ773Oq5HAjS/gAyGJnQi7QOml8Sa3vuWQi8iHsK+ueRcQe5x/
         aeJjSdzgGIBf/wassO+Vhh0y7r5BR/2mFSBIVuJ9cX8Iv4NgHrQ8erpbYKayedp749ph
         ZKsdaUAYtGl+3k7ulfGarIIGzUHWwr4B58jeq7cT1oNJYEcXA77T851SL7c8ssI8/glC
         /xLrjff88jF6KJCzoz1iFdTLytthGinGonLjE7PC8LRC5IgW3hAgHFXYBwJWNU/GzlhU
         SANmzSJHVA1GJ24BHX0G/MvHgnPc/crmSI5PZmWEIdi1Fu6eyqlgGrSCwcQcfiiWmonG
         J5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752205102; x=1752809902;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q/Qj70+Qw1ZA0kyE48WMaDv1mNZmCeBb3mdlEQxC1dk=;
        b=Q1eh68n4gUIvOxvOPg2VBJEEcbyMFrw+oJxoaq7qPHs4lDE0Z8371iEmlkkwcy7iGv
         3YRpERHmCSYHH2JrHG4xUSEzUYu+vSJ8GkuYzxTwB4i/aFc2jwpLKp9jI1cKB32H69Dc
         3grepaOpYQCSfXDfrkBR+eGwb4gX506dFvOTyQ/TpfnrxjvEqkAcB8eIcgUeubtl4dgb
         6uqsTEZsHBK7Xnjt4YChmlT2vYRv3cpH0PYwNc192KW49mQd2WkN9bUKvVYmGeJBeQf2
         x9KH2IU1d79/HCqeXTdwDf+5seQ7KZ86n5kyMpiMvi5RUdubcJtcGvXVhMxyQTq0dRWp
         Wnxw==
X-Forwarded-Encrypted: i=1; AJvYcCURFaw0LwptBj4NL2nXFgxThFZ5oBdiBFMWyUhnRWXJ0durIKvYb/ica22DcpYzSNgHX8Sj2sCw1yge1Iy4@vger.kernel.org, AJvYcCVbcWH8OYh06npX/bp00MB8YOsKB7+/lBPNeW7SRDNLzoarvfUy4awRwWuQnENODk9OUE5jf8YI@vger.kernel.org, AJvYcCWXE0rJ2TMS6E56moHRx6j2JDR4XKOGeOeyjXIAML2taFAUlc1SetGZGvWjiwmrYWm1QEnXIDMZyBik@vger.kernel.org, AJvYcCXrayQ/KLgpKfIN8FBuR7Go4Qrq9dFVJWEW7zQ1n1gNnFIZyNuHS8+hUvGnY9Oig5LBH0rTDPVT5VAYjsqYoTw=@vger.kernel.org, AJvYcCXvSfl2fRbcWQBiNfzsvz/NLU9wrQP/8Ph9a+WlLnHG3n1oMm/y8dxcOfOR2DJ9+1+IXuj8oGX1zIwf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy232ZctqxEcDoAcvoJzz2fHsKh1yGr3U3T8BU1FSUc45qtWlnI
	rCnnMEBkTwE6abfVXv/AwktO6m17nfbVlMhOoKSjjXw/6Ln72C9HQn52
X-Gm-Gg: ASbGnctZ9GcnRo5SJUhEd5zoHUcEB/AyiMR/koRKP/TSTEEPqqXPZiBKJe7cYZDJuhs
	TGpnCCSex85HA27Ci431U3blPTDYQlYHHrUR4+ZCijLtmfvkfD+N9wRH1P6sFowYltwGuUH4It+
	DvcLj7FaeAQWLoCkKSAlicAUOPGuSx1DCzgDtAbtRNA7wbwfVQVyYQbmOuK+1vzGTg1oyTHw91q
	56LGR9jfgihEhzu/+dqAdWfmH1AhgXwTK3Uq8wcB/Wg+ETv6vZHRmJtktNVkjefnWbtvAdqBovy
	JOImHybjOFmI69c1RPCF55w2OdA2Q/k9P1/FhUVCfdgZdzNno1eyVhN2Yfwj40ogIyKJBknI7bN
	ymh3lPH/tAOSf3vdre2xJ/MMYY2bFQ+vPwdg530ln6g5ViPjn5iUnAVvlp1Kal3ehy8+ydj7zAe
	5qfImOH8MkvKc=
X-Google-Smtp-Source: AGHT+IFbi/G/K3dsTgG+PrTxboWCsavDU00apeau7wJJn4YJz0wFVUIjBVHaMM+adNeGlqGczuEsEQ==
X-Received: by 2002:a17:902:ce06:b0:234:e7aa:5d9b with SMTP id d9443c01a7336-23dee1ae93amr18370575ad.23.1752205101907;
        Thu, 10 Jul 2025 20:38:21 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43318e5sm41033895ad.147.2025.07.10.20.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:38:21 -0700 (PDT)
Date: Fri, 11 Jul 2025 12:38:05 +0900 (JST)
Message-Id: <20250711.123805.1564352128148532368.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com, dakr@kernel.org,
 gregkh@linuxfoundation.org, ojeda@kernel.org, rafael@kernel.org,
 robh@kernel.org, saravanak@google.com, a.hindborg@kernel.org,
 aliceryhl@google.com, bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, david.m.ertman@intel.com,
 devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com,
 kwilczynski@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 2/3] rust: net::phy represent DeviceId as
 transparent wrapper over mdio_device_id
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <DB77AQ53YOFK.VBSAP1H7FFB9@umich.edu>
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
	<20250704041003.734033-3-fujita.tomonori@gmail.com>
	<DB77AQ53YOFK.VBSAP1H7FFB9@umich.edu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 08 Jul 2025 23:23:20 -0400
"Trevor Gross" <tmgross@umich.edu> wrote:

> On Fri Jul 4, 2025 at 12:10 AM EDT, FUJITA Tomonori wrote:
>> Refactor the DeviceId struct to be a #[repr(transparent)] wrapper
>> around the C struct bindings::mdio_device_id.
>>
>> This refactoring is a preparation for enabling the PHY abstractions to
>> use device_id trait.
> 
> Should this say "the `DeviceId` trait" (different case)?

Ah, I changed it to the RawDeviceId trait.

>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  rust/kernel/net/phy.rs | 53 +++++++++++++++++++++---------------------
>>  1 file changed, 27 insertions(+), 26 deletions(-)
>>
>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>> index 65ac4d59ad77..940972ffadae 100644
>> --- a/rust/kernel/net/phy.rs
>> +++ b/rust/kernel/net/phy.rs
>> [...]
>> @@ -734,18 +733,20 @@ pub const fn new_with_driver<T: Driver>() -> Self {
>>          T::PHY_DEVICE_ID
>>      }
>>  
>> +    /// Get a `phy_id` as u32.
>> +    pub const fn id(&self) -> u32 {
>> +        self.0.phy_id
>> +    }
> 
> For the docs maybe just:
> 
>     /// Get the MDIO device's phy ID.
> 
> Since `as u32` is slightly redundant (it's in the return type, and that
> is how it is stored anyway).

Yeah, fixed. I used "PHY" for consistency with other comments.

>>      /// Get a `mask` as u32.
>>      pub const fn mask_as_int(&self) -> u32 {
>> -        self.mask.as_int()
>> +        self.0.phy_id_mask
>>      }

I also updated the above comment

/// Get the MDIO device's match mask.

> One optional nit then:
> 
> Reviewed-by: Trevor Gross <tmgross@umich.edu>

Thanks!

