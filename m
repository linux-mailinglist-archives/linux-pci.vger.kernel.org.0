Return-Path: <linux-pci+bounces-26007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96EAA90785
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3E0190686C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A0F206F19;
	Wed, 16 Apr 2025 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJKazprt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59491FAC34;
	Wed, 16 Apr 2025 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816730; cv=none; b=fGb/IISaC8rTEO4I317EP97EHVe8NSETB1gr8jyvNQaa+mBNV7osgE8v/4smzRwbM7FlB3/QcK88yIsPxDjckz+M81PLgBhnlqpPH2Tq+n6iFVjaxt4RJVUmO0/nDJT6G8NYtGkQ1nz6NHCU6v8Nc6+nX37YLRSwb4sc5eDZKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816730; c=relaxed/simple;
	bh=6C7b5ACUZiIoTFMKXIfTccrPKsvx/hrV2PGQgT+DTn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6yrPLCrt8QqX33qOuOp9pjprmXcGu3tGuNj3OD3yV1x5031V5MQqJ/lGk0cQCs7S1tMfnq3o3WL5eW+LJEW9JolDCsjIN+/hZLgSvyN6LPai9G9mQWkNEOUvpKHPFcOaE/wewYOyQtD/54XKYUxGkQmrmJhnqSzh9o/sdoIgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJKazprt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aca99fc253bso1078385366b.0;
        Wed, 16 Apr 2025 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744816727; x=1745421527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVstj4x0ZOBrjL3wG2i16/BbBDpIxTJzZQ+Ch9ET5uY=;
        b=WJKazprtllrGTjbxQVYvWIv0d7XQz1HVK5nANO9oQXgpHX5dh2myL4JKQokNucwWXr
         +aMV7QcwNcuoBiMlk1nmaA7LEBF60t/GCcrDjkxxSolU46eW7prAe4UgTQ+yw8x0tPhG
         JNnoaChGednPBfcixi5m0kuPFweYedVENDdV/MGZa2SVw9/MoHATvXeCK5Mdy1Mhds+K
         JbJyB6h1OL77OL5aqpkHhfCG3XVyvXhpfnRMbdYTICro7NDDgFJjGRNqhb1MVqc2ugZO
         vBi24p1z6oc8vVj1YyhUL2d443pc8irgI4GehXLGJjxMFz+cRY41o8XE9gd2g85QWzw3
         45WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744816727; x=1745421527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVstj4x0ZOBrjL3wG2i16/BbBDpIxTJzZQ+Ch9ET5uY=;
        b=Y8BVcqo9WoomSKOyIGpFcGjbjNmhpIhqtZzYy7A2Z4TMXbdJVkJhga44X8k/5QUuDH
         epSCUVoz/5E9th8mI0kyi/zIirbBZUA92vbLz0qZRSpRR29gmZgLIdLJMyXsvx/r0c++
         5CALOH0kbweD88jqr/nU0JHjZPz/hLCsgrqpU1FxawyPOgLbqt8RCZ6zIvCJ7GNem4KV
         VBjJbydeQFydnen6BDzH2GWgNHg2RMKEIjbiL7MbFIPO1RKcr9AjTln6C4PgxX/arm/7
         zyYkpFczfKC893P/XHtRdsAO3q6Fhmgr6Zmc62DbT8E9bwenYj5eKZmpnZdry5+WC5xC
         DVOg==
X-Forwarded-Encrypted: i=1; AJvYcCVtqRuP/VgfXneiGMAP4F/3Ne8m8F0vtzRRBf8qBWLw6bo+KICBscg+v5cvfsOu9w8pn/kpZes+hd8B@vger.kernel.org, AJvYcCXlMHGLAvrwl2wgU6pucv5UmNz0IYIQcfGWykKr3e3y8ziDYKc61xrYwQZoDuKEMSLeyCiAUkg7r9iQ6mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/Dv9Ie11Vnd1b4OlUGS+03WBHnlqW4g3+NYl5QxSsCm1a8Xg
	xLeFtOX2jF3+3y4nGQOIrpIhhk47WLARmIqte3vhZ3cnQg6dH+FJ
X-Gm-Gg: ASbGncuTc+E8nWlX71unwxNWQjb9666WxR17mLja5K0Tk36r9LVoJdyNWZTvvY4MIg1
	R1w9hE7Hzy6ckpu18pEG9C8BDaz1TVF/1qIc6yEhlY7BeTXzFTJYON7qlYhJmNtCWAAU6LEAoiO
	L0sZBaqX1kAJ4BXG03MUejNXgLXIB8lfd533KO880+esfWILtKmKSrXEKzoc3mGr8Pj8KVpID3j
	twejP0G1Tp5zRndPz9ZNzLO0HUNAbuxccZ6WAnYnAe0fu7yjJBEMQV9uwNjcLy34cFHyUNW6jXz
	59hOQF+60hrfGRnKUzUlthaz1IpDHsyrpe1FUCtz/FTtvI35ymNMlw==
X-Google-Smtp-Source: AGHT+IF3W0YsWOP3f1NrLdQIf+NO+rd5/vh7OwCAQPDINantGO4SyAPbbFuT4fgM4GCMyE5Owv6RWg==
X-Received: by 2002:a17:907:3fa6:b0:ab7:6606:a8b9 with SMTP id a640c23a62f3a-acb42b5717dmr191948466b.42.1744816726791;
        Wed, 16 Apr 2025 08:18:46 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3cd61f80sm142866466b.20.2025.04.16.08.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:18:46 -0700 (PDT)
Message-ID: <99dfba6a-d73d-4243-926d-c473868cbcaf@gmail.com>
Date: Wed, 16 Apr 2025 17:18:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] rust: list: use consistent type parameter style
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
 <20250409-list-no-offset-v2-2-0bab7e3c9fd8@gmail.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250409-list-no-offset-v2-2-0bab7e3c9fd8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.04.25 4:51 PM, Tamir Duberstein wrote:
> Refer to the type parameters of `impl_has_list_links{,_self_ptr}!` by
> the same name used in `impl_list_item!`. Capture type parameters of
> `impl_list_item!` as `tt` using `{}` to match the style of all other
> macros that work with generics.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

