Return-Path: <linux-pci+bounces-31895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA671B01196
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 05:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0571CA366D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 03:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E83A199237;
	Fri, 11 Jul 2025 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZCc37bH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4CB2AD04;
	Fri, 11 Jul 2025 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752203848; cv=none; b=ClGdUU7tV7+7welEATt/q1GsUrGLuqxg5B8YRqu8QCfEzPijxslkptopttFb5Z9DxKBbOXwA9Tl8b2qZLS+wLzh1bX0quUmUbzU5ut4r+imZe1NNnPCdSMnrJKs3DrWAVYWUKTHjLzf96VAwc76nwtOTcvetb/zY+UdGpZCfwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752203848; c=relaxed/simple;
	bh=69YdCXy9T56JPgHNs8/RIXf2FrN1J97HQke+qeHG+pI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=idejyAf81MV++FTHuLrsdvsbaHqamXyQCfyJPDUcpg6akvvfSX1QQ+Gm2bQymnPF4iwUraC16/RoPNeHETqK2gNmIf9WQTmCCXveOzzHk4YFcEbw9hlhGRclqXg6nn/amrbLu+e18avk18VFWWUPxL6ae0qpUkweh4G1+npJYLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZCc37bH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7490702fc7cso1062539b3a.1;
        Thu, 10 Jul 2025 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752203846; x=1752808646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFDoR8SfLXsLl/O3jRzI2BKgXb2tqvysIMV0NNbufCM=;
        b=IZCc37bHNdws5NoGnCc6UAfjgIYuQvyVbwZdPk+02HDRGjxIDMJeOeQQq6DBnJUbLN
         JDIn0JC7BUsdE9MtyRhOBGTMvdnHzbz9iS+IYWLHNe1uzXxIOyYzLCT4fYEddfNHfMu1
         FdpgIMCKu+AhSTc7LlUJIes/hyfQ1rTDt06lqJ7zgaByCVT3kaXI6xEz9FeB3XDBDj4y
         xkX8DOF2re3JEcybNE+WiZrjivEyLrh5eoz0H988bT8gXkEt3Xf2/AjoLYLlJ/J9c3S9
         S4HcCnI9O/U8v19d2iEg5uM8LheA+IEns3Pe/NoylLG3qzmLa29+IFpWY7kqbg5GNxmL
         nYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752203846; x=1752808646;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DFDoR8SfLXsLl/O3jRzI2BKgXb2tqvysIMV0NNbufCM=;
        b=PsmWFymUy+ZLCm1MkHmWia3T5dM2gm8y1yCRZrUxQVvHd8lePPYPb3zClOPNNWbemN
         9h5vBUxNRTk8oVO1AfTJWc9jX4pj1GKxJr1FxnT2KkJ+bi0W1rEj01/H7U8myCMoM3Ih
         DcbjX5yntpjDCFUwg4zFLGMTjHEFb+hcHuKvzT7SZZvF8Gvo4mdqzUFI0gIKKfPUNpF5
         EEVLhIHYLC8WtV1uGxGiEzKMmOi+jTj9jtyZLxA4HcEUl6MJYMZQIvJmEFNPdjJyMUKY
         QqqN0ySTezw5dHEHtScX/YPkaBD4Uu1bVn7QVchJmcrOPoO4bb66WUDau7DlaZwpIGyz
         UB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKO+5MbS/gu2BOLFD9BubQHgSj5MoLnZLoZK6fFdjDycEFAxMxbOHN5Ezn7npXT198QDdIjIms@vger.kernel.org, AJvYcCVbWlKJfEHqU3Nof8usKmeex+WVR3EdZzT24Ss+Fr4RERBM1AnfAxgjlQzv1PH+5k51rnVQDZJak7Sj@vger.kernel.org, AJvYcCWFylok41yh+aGzq6QkfD5HfEVI1NXlqxQbVWDxtK7lBVH6Y76yp51VjPzPx/THXpTxgVWzFBfTh8IEhcD7@vger.kernel.org, AJvYcCWgs2IXxBGDRZ52hAIdlWPSYnCVnvdCJGnwn7aiZbi9HuiUZxqqMTeKe67KZukfA12C6ihBZqJvThsEg+fAH1A=@vger.kernel.org, AJvYcCWv1+XtpUe0JQOpqlaugQV815sahexnkxtZkJz3fSBaFiZQLMUrQ2ffsm/3V3vKr8Q6UxaZb2skOUs9@vger.kernel.org
X-Gm-Message-State: AOJu0YwvaZvFja16LE7zN18NMdX8DJxZHYflIzHXa+AOZgqQosTOXcRS
	CIehhyxQ0/OlIc4ROOaQxC7yWlKbTrZhmAAYAY5RayiHePRH0k7Gatt+
X-Gm-Gg: ASbGncvHJMTlNn6Mmmmyghh6cB4nSF24SUEGfYHxvFzwj324P/uf9v7/EoxNPfnBMSu
	+itCBBFrKK6HkMsbwDKd/L3KWsvezdJwBHdWeDOEYg0t5iNOHGNKghTWeUc4BA46MNSJ+rTkXiY
	v320ZP6kwpBITdahmX+iR9uRk4wPGKG3RmTGAjVaHollbtFt2eVIwRSdXxvaMC1Dmk/BKYUry2x
	prsFvW5cikAqlzZ9qkYJhV9tTtrPrcqNkgztEiE7t81XNTOjw3ounXiNzzwj9kZcbKPRpjzMF/z
	uFnC+XwU0gE3ZO3i3i8/VHLWfErcB6oi/druwxu4KZ6n7HeW8xS0F/HmGClbMzX1JPCpZdmgQ39
	FxCD+eM00/uFsV0sCCAwXhGERP8ea5EPHi1LiZlzGmJEeRMVhv5asPQogaGo9ovBno+0wKOIHrA
	141LFi68nwS8M=
X-Google-Smtp-Source: AGHT+IFRfTzksloXNib+hFDfwfLiSQOs2y199YIZ3gyqM86y6rWtFD151eKP2pMWqTE3hwJJGg6zPQ==
X-Received: by 2002:a05:6a00:ac8:b0:746:2ae9:fc42 with SMTP id d2e1a72fcca58-74f1ebce5d2mr1068525b3a.19.1752203846015;
        Thu, 10 Jul 2025 20:17:26 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f49502sm3387324b3a.115.2025.07.10.20.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:17:25 -0700 (PDT)
Date: Fri, 11 Jul 2025 12:17:09 +0900 (JST)
Message-Id: <20250711.121709.1360562848053380480.fujita.tomonori@gmail.com>
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
Subject: Re: [PATCH v3 1/3] rust: device_id: split out index support into a
 separate trait
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <DB7714QEA9EO.XB7BKFDO74JE@umich.edu>
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
	<20250704041003.734033-2-fujita.tomonori@gmail.com>
	<DB7714QEA9EO.XB7BKFDO74JE@umich.edu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 08 Jul 2025 23:10:48 -0400
"Trevor Gross" <tmgross@umich.edu> wrote:

> On Fri Jul 4, 2025 at 12:10 AM EDT, FUJITA Tomonori wrote:
>> Introduce a new trait `RawDeviceIdIndex`, which extends `RawDeviceId`
>> to provide support for device ID types that include an index or
>> context field (e.g., `driver_data`). This separates the concerns of
>> layout compatibility and index-based data embedding, and allows
>> `RawDeviceId` to be implemented for types that do not contain a
>> `driver_data` field. Several such structures are defined in
>> include/linux/mod_devicetable.h.
>>
>> Refactor `IdArray::new()` into a generic `build()` function, which
>> takes an optional offset. Based on the presence of `RawDeviceIdIndex`,
>> index writing is conditionally enabled. A new `new_without_index()`
>> constructor is also provided for use cases where no index should be
>> written.
>>
>> This refactoring is a preparation for enabling the PHY abstractions to
>> use device_id trait.
>>
>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  rust/kernel/auxiliary.rs | 11 ++---
>>  rust/kernel/device_id.rs | 91 ++++++++++++++++++++++++++++------------
>>  rust/kernel/of.rs        | 15 ++++---
>>  rust/kernel/pci.rs       | 11 ++---
>>  4 files changed, 87 insertions(+), 41 deletions(-)
> 
> Few small suggestions if you wind up spinning this again:
> 
>> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
>> [...]
>> @@ -68,7 +77,14 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
>>      /// Creates a new instance of the array.
>>      ///
>>      /// The contents are derived from the given identifiers and context information.
>> -    pub const fn new(ids: [(T, U); N]) -> Self {
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// If `offset` is `Some(offset)`, then:
>> +    /// - `offset` must be the correct offset (in bytes) to the context/data field
>> +    ///   (e.g., the `driver_data` field) within the raw device ID structure.
>> +    /// - The field at `offset` must be correctly sized to hold a `usize`.
>> +    const unsafe fn build(ids: [(T, U); N], offset: Option<usize>) -> Self {
> 
> Could you mention that calling with `offset` as `None` is always safe?

Indeed, added.

> Also calling the arg `data_offset` might be more clear.

Yeah, changed.

>> @@ -92,7 +111,6 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
>>              infos[i] = MaybeUninit::new(unsafe { core::ptr::read(&ids[i].1) });
>>              i += 1;
>>          }
>> -
>>          core::mem::forget(ids);
> 
> This removes the space between a block and an expression, possibly
> unintentional? :)

Oops, unintentional. Dropped the change.

>> @@ -109,12 +127,33 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
>>          }
>>      }
>>  
>> +    /// Creates a new instance of the array without writing index values.
>> +    ///
>> +    /// The contents are derived from the given identifiers and context information.
> 
> Maybe the docs here should crosslink:
> 
>     If the device implements [`RawDeviceIdIndex`], consider using
>     [`new`] instead.

Looks nice, added. [`new`] doesn't work so I use [`IdArray::new`].

>> +    pub const fn new_without_index(ids: [(T, U); N]) -> Self {
>> +        // SAFETY: Calling `Self::build` with `offset = None` is always safe,
>> +        // because no raw memory writes are performed in this case.
>> +        unsafe { Self::build(ids, None) }
>> +    }
>> +
> 
> With those changes, or as-is if there winds up not being another
> version:
> 
> Reviewed-by: Trevor Gross <tmgross@umich.edu>

Thanks!

