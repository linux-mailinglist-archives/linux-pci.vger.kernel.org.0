Return-Path: <linux-pci+bounces-26008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A7CA9078C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F563BD802
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869DD2080F1;
	Wed, 16 Apr 2025 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9BqaHyO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE5207DE5;
	Wed, 16 Apr 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816813; cv=none; b=j90SZMAOjgJ5hHAEr7BV3yGTOviHdQBhaqCjc1gKR6uPMVwjkk7uQ76++kkONu/To9KggdqSENbu6F9DcesrQ8E76zliSn8LNASa4EKOCDqof4DwBRzKt7b9ZSkcxLjsKVF7jnbnxDN6RJhLNlrkNjbYYdtCjgcRAZPS/WgXJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816813; c=relaxed/simple;
	bh=kCVbfLAZNndH71VOtNN3t9SCRn2ApxZIB93dUmK6lcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iw95HSxgUk+2IreBPdXiRmSc7HK1a1Py+SHwIBgJZmT1NyNfsFETxO7gbd7oQpXUADo9tl/VwRbOs0UiovMMRDiqdEB2AjWX8YNwFSRpEHAHL6aEiAdWRxw4uzcc9v5lhFe911La3VBCXHmlccT0ozpd0jF4p6RUzqyG/IPLCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9BqaHyO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso1539468a12.0;
        Wed, 16 Apr 2025 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744816810; x=1745421610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sWTeW5JPNog8u98+gGPIwRpNW08sbRO3hBcyyJAqaM=;
        b=k9BqaHyOTTlYgsru79+pOu6ck4QpqQHXfWjmEZRkKKNGfvtJNTq2Y1Svrqc/hQQo0T
         +d2VMEd2n0HmltUaLs1Rf85qAZSwbSuLSHXFxiCneUe56UjklrerfoYqG8FE2mJNVxwb
         9NgZR0kYAX9f24Wlivo+8ATpU8v7z7d78xOnQF1FoON25y8CSMIuTi0kjN7Z4WdOZ2EP
         4ssmql9ryTNnRUecYcz9NaWl4mzonFaD9VZIVGvpzL/14bMKmb2bWIzLy03ysKMkn1B+
         T2GlBBUB86NGJKVjpCXBxPBR6QWG/mwktTEcM3bjM7ed+uNDXzPjghUWk51U7OIE4Y1L
         ydMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744816810; x=1745421610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sWTeW5JPNog8u98+gGPIwRpNW08sbRO3hBcyyJAqaM=;
        b=YGeaja/DeCHAXbNWUKhXPQzignBA2T4uRUdV/55y2Z7iJrwvsf7ORLFHVEYk7ucqg0
         0MIgbNohXkpzYmt8/fjQxqI9OGf6cyLNyOnRqBwRvGPvrjk6CCR86PM/uLQ/VYnjcbyF
         Xi6gC9F4ORVMe7rmZI4VsT5noeDe9JV6GwuMT5qIsYKO4l5KmPulmPl472n57lsQIYta
         nFeBdAQUeZh4odpJ0yet+rG4ObmTtVEJQ38pbFOVqU4YBiXg6OAP8WkUYCQp0BNiHizo
         Tvbe8/+1f3U1gZX58BdgBy2DCbHtqFQNaMJFYnfftSWh6OC34PdnduqFUQhH4sJPrm6T
         YSkg==
X-Forwarded-Encrypted: i=1; AJvYcCUF2Z0GvZFfHnD0J1oDMhLTGr1j5v2FChaFIMeMfRBFGzTPviEkbwzqhebyXa2S8MVBU2f9gwi64ypTAZM=@vger.kernel.org, AJvYcCWexeirObRRPWBH14IveM3Tc89b5hKNaNydDlnEyx7OGBFgXGrqYfebvLy+Cd+SdfZvstZP47ZCfW3B@vger.kernel.org
X-Gm-Message-State: AOJu0YyrvZudaFUZ7MxEsB9KGqbnuI3qU71E/t8QaKNkgI9ZF9BurmqH
	DS8wlwACTIa0H9R6aqVkpFrojBF8q5sAHaQNfqHjagLdWR/fIb0v
X-Gm-Gg: ASbGncsmYL4W0aCs3+Hd6R2UDHNLo48sh7AE3n6qEzpclXQnSXeK7gnsgHKrdvMWh1J
	moz+gLLsYYL9HP/unXtdp8w4EkSMqtd5X6LsEa8sSjBFPez/cLtYjFCAp9KnDFA2joEGiiUYoVR
	aYaI1k+E1xRljTF+L0ViHHLuKmIyvwDJypcpXiUGUVjdstCXt8iD+7uy2bedwnESy5G8J2JHtBe
	2s5xzWqdKycrNFnYGEPudC1V6P4rnvY/+lPT4x+/UEgBlQ4FNgXVUfl/cwTaWVowci3pIY0OW10
	rbXI1RmWXwz+N/tLEy8U9k5s3TZvnq5nOaAgGgf0c6Yk7dv9BZaxqg==
X-Google-Smtp-Source: AGHT+IFxR6UYUgOKHVLVg6n4w6RHWVoUkZFCxPoGbNXih5IwBs66f7bVUwUF0n9FeKTWUdtV+a8y9g==
X-Received: by 2002:a05:6402:5cb:b0:5f4:9015:a6d0 with SMTP id 4fb4d7f45d1cf-5f4b87537cemr2061930a12.12.1744816809732;
        Wed, 16 Apr 2025 08:20:09 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f507687sm8723710a12.56.2025.04.16.08.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:20:09 -0700 (PDT)
Message-ID: <45eacf4b-be34-47de-93bf-69601e394aef@gmail.com>
Date: Wed, 16 Apr 2025 17:20:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] rust: list: use consistent self parameter name
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com>
 <20250409-list-no-offset-v2-3-0bab7e3c9fd8@gmail.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250409-list-no-offset-v2-3-0bab7e3c9fd8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.04.25 4:51 PM, Tamir Duberstein wrote:
> Refer to the self parameter of `impl_list_item!` by the same name used
> in `impl_has_list_links{,_self_ptr}!`.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

