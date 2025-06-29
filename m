Return-Path: <linux-pci+bounces-31021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E35EAECB8A
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 09:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A639C1895558
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 07:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4E1DE88C;
	Sun, 29 Jun 2025 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="inxUrbOa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B618CC1C
	for <linux-pci@vger.kernel.org>; Sun, 29 Jun 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751181264; cv=none; b=UTAa4PQpI8zN7WlafQErgsPOwk1/1eXRZEU9n2yLqtiXLrXfTzuEA7H3hRkDJKMYbymjz5jkzXzAf42Q4IPdaPqbas+KU3rsPFKNllEeObGFMqjn2plm99dZB/E09HH1WKc2QYsNpzonfbX39wBovmLBfo7kXoUVS7cXN4V+6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751181264; c=relaxed/simple;
	bh=J8GQT2trkTb01E7MlkDuPeYC87iUXGHHCqRIpxpFgDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+igYuOkiJsVfypSMJ7wuRM28iOgsFKhRoHxD5lLP/gexMbfNUu0toyCGxLno6Gg8gOOGF+hbyRBz3Max0PO6WFJ6YPHqafZ5WPTKU7iRucaN9Ckd4L8nvFGx9BTdeRhYuJUFPnhy4TUQOqkjznoyhu1i6Ca4+FEHtXOlOOd0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=inxUrbOa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747ef5996edso1075803b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 29 Jun 2025 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1751181261; x=1751786061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozDbBML7YtdYOzaZLTQmITakoUDWV09n9sOABaWE4oA=;
        b=inxUrbOast7zN6/ywUy4/VkpGV5kQFrciMOk/LygGtvXQDhlLoE4iMLtDNxcKyYskb
         ianQX7IsrIE7uucCOTNucOYrRvu/awz9faQXJGoQY6HGE/S2os3cQ4HcPlOfZ251a+LJ
         ILzU3Oo3GMGPxD2hLRlto4tybJIjVJb3c3j1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751181261; x=1751786061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozDbBML7YtdYOzaZLTQmITakoUDWV09n9sOABaWE4oA=;
        b=Nzqj1o6nYvTRKXW6buAC+qNbQ5b+KqMk5ug6o+6Jtz6LJGI5a7v5pogR+ZN+WDY1W0
         whOWUtXwdGVcF8FpwQJ6Wz9+5tZslkh7d0RYMpoeZuvRFBqDlxTocFp2US1yhrESTeXk
         aPkO7eDDPSWKIc0eYxQUVBT8kPOgRfjLNMrJn/+/s/mOXVLj/3sew5/0eMLm4MMLheYY
         WpkpR3ew5OS782qEphkZpkQYbJqRUKan0qV7f/XZZudGCTuWAIXhg2SrhJdxdC0Ml2MB
         j+fc/wlR7ge02J+T+05NG548MdJzIyYwxwfI1KiimJEIJawSAtbmig+Frj4b7h8VDpOW
         PkDg==
X-Forwarded-Encrypted: i=1; AJvYcCUvSedFk/t76+/XDCpRvxWTC2zm8t5l8lT8pefWvHSazrW3wySWA4X23C56vt+/pryWc/dWGWW35HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyti4vuwbbQ90QhcullMzTws/TQ/RHE3GTlxx1vgPpJZWpoO+Sp
	SK3arSVjA+2ToNFXbiKxAK+4B07TtbLZybqthSEqSOeMafgIMCIvHilJtOPsOjkrHsD83SU73Dj
	81k48PLAJ
X-Gm-Gg: ASbGnctd3+pzR87B7Dq9fQUg6oiW7CmfnhX/nMZ83fmTEaIrhVzIdMGciZTb6aD5ylu
	SdcL+NJW/SsPNt+f70+KEhF1/Now7667UVONjL7oGHZdHO4RsC3xIQ0ARhMny3X9llWrStpH7kU
	vBwdJf5w9M8ztDg3qSQlwHmGpsFAVFmQm2O+0J4e19lcl9C4jgWjBbHuHSNAGPVgOpp43svLJnL
	/nY8P+b6pAAZSXdLrG8LdHk4JJ3ukMAtEqGSjjWwScLcUxd4hydENP0PlrHTFLmD2yqQIrOCMtg
	ANKWoKy5EM6dIw3NrD3fSPAxB+4tkEoRb3ESPCiktLDeZoZ63gDLJTEq684La3Eg5RoxoqQ9GLF
	n9ErxTXkEFnshUkp4QgD6p1kUVWA2MPGkMqs=
X-Google-Smtp-Source: AGHT+IHtG/45BDZt70yMwwuz4Y6ZIXl1jatRRQgkfDIMJeFfDl5ARXbNOyDtGoGrQYqRCFHKlnXo9w==
X-Received: by 2002:a05:6a00:9094:b0:748:ed51:1300 with SMTP id d2e1a72fcca58-74af6e61c70mr11839656b3a.9.1751181261080;
        Sun, 29 Jun 2025 00:14:21 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56cffccsm6282694b3a.130.2025.06.29.00.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 00:14:20 -0700 (PDT)
Message-ID: <954c0915-25d9-4bc3-ac82-452650902a3c@penguintechs.org>
Date: Sun, 29 Jun 2025 00:14:18 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: pci: fix documentation related to Device instances
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
References: <20250629055729.94204-2-sergeantsagara@protonmail.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <20250629055729.94204-2-sergeantsagara@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/25 10:57 PM, Rahul Rameshbabu wrote:
> Device instances in the pci crate represent a valid struct pci_dev, not a struct
> device.
> 
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
> ---
> 
> Notes:
>      Notes:
>      
>      I noticed this while working on my HID abstraction work and figured it would be
>      a small fixup I could send afterwards.
>      
>      Link: https://lore.kernel.org/rust-for-linux/20250629045031.92358-2-sergeantsagara@protonmail.com/
> 
>   rust/kernel/pci.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 6b94fd7a3ce9..af25a3fe92e5 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -254,7 +254,7 @@ pub trait Driver: Send {
>   ///
>   /// # Invariants
>   ///
> -/// A [`Device`] instance represents a valid `struct device` created by the C portion of the kernel.
> +/// A [`Device`] instance represents a valid `struct pci_dev` created by the C portion of the kernel.

Should this not just be a "a valid pci device" and let the type in the 
function definition speak for the type instead of duplicating the type 
name in the  doc comment?

>   #[repr(transparent)]
>   pub struct Device<Ctx: device::DeviceContext = device::Normal>(
>       Opaque<bindings::pci_dev>,

-- 
You're more amazing than you think!


