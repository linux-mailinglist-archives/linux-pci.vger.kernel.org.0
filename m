Return-Path: <linux-pci+bounces-31022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D073AECB8B
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990343B71CC
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 07:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0036D1A7AE3;
	Sun, 29 Jun 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="cyMTcqSD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792BE1F92A
	for <linux-pci@vger.kernel.org>; Sun, 29 Jun 2025 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751181322; cv=none; b=KMV/zAT1zM8U+q30fF+qiGpgXR8JbnrjB3GkFAH2CGHoYrAZyBOjt3qCStHYTb0pXeh75VZ40VuTdl9hH1tgFwv5eKAvZNFmkPNISbfS5zLFN5Mkt9hWCLvVtoXN5PaZlMqtNGk7NGW+TgCbZbfvjGtca5aUEUPnTdjyROikIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751181322; c=relaxed/simple;
	bh=J8GQT2trkTb01E7MlkDuPeYC87iUXGHHCqRIpxpFgDU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NCs3cKWj/f0vGTfu522Bpu7Jb2WQVDyGlaFKreNfM0EfDzy2rQORhKGenEpScuJ7q9+LYFij5mk4LVJF2s7bgZCHKo8rD31VipDonlZNWrqFyrZo6sPmLPC/AgHY/xwMtsfr/MxTbkXp6FoEFZbqEKTORWj6cDYOP3Fqg74A3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=cyMTcqSD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so3294745a12.0
        for <linux-pci@vger.kernel.org>; Sun, 29 Jun 2025 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1751181321; x=1751786121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ozDbBML7YtdYOzaZLTQmITakoUDWV09n9sOABaWE4oA=;
        b=cyMTcqSD8aP4sVTpeA3QXO+6/RsCJKcgGUdQX0YD738nfmVjIes7jVHfkG3lEKaaOq
         cadeSffi0XuHmUUMPHZOnNr6fF5VwP8KYxriSHxRaBTHqyBNsDL7qti0Ad9IamAqlESs
         ZkKvz9j/+TdjmkXDatF6cHu5NMR2pmPAOyDTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751181321; x=1751786121;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozDbBML7YtdYOzaZLTQmITakoUDWV09n9sOABaWE4oA=;
        b=CO3DQJsZJqr72GvgEKSurcyWA53/PwXjKtetpiagOTSyNsZ2L35punMsVKLq77QL7t
         HEC/Q7A5EDCtwDhfRNOMEOzwnnLOVn0Frw1/0AVNdNUV4HQ2zfyy0tReBs7hCfPgG/s1
         SjDUjhaL7jnShkrTiGwkFCEdLYxDyX+4b3sCxvREJKfWzA5xU42lUPSjV8wPSX2IURZc
         liZL3LXN4XWrcYAMO7MTExLOg1qvZk453QE1uyxOu/nWvJyCSwhObDwbwI0AUbvSE8fl
         0QIxQgQ9rZTqEFJe1AZpsuOj9EdmxiGTcOB9FKhJ6U0bzUbdHqhf9V1A47/vFG1qTwrS
         2qww==
X-Forwarded-Encrypted: i=1; AJvYcCUVAsiMBkAxytemqVlpOUFWUvtZd8CW4UirB1y/aSPvv/ttdAsKR6SOyiNsYGho3oqHiX1rPQsEE5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoah8eE6Nasgc2REoO66pHlEqdfCPTXVD16NK4voRU+Rozr6W
	m4ha+mpG5VTqPTLj4ZuWktjWw6gYXHCaZ4Tr7KWXC03Tvp0Q1bj4/tDJ7bIzRV6gKdI/o7t+fRY
	aXml4c4+K
X-Gm-Gg: ASbGncu1yJv3LqfDBL22Y7imq6zQuK1/eeQKmgcixKduSj5kkCSrk3RdCfCdBo/ZG2K
	3da39YkJRLaWpQrk6w4nZnfXntklsaMzAS/aQDS9SOFjoi2CcjYg+6WdLa1f3Il4s58UC2Phn3v
	fkqY/EQX81R6dmbaqQtSxGLlibqIjSHvXOBPNGf3VI/a8cYful6n4rlmZB8pYJa4DiCP+DpWQtc
	t/ANMI/tpeEYpOGXI6RDDHOW0XMkId2QzWcIzyXYl3J2FXnX9zrEG5pqt2XvXy6+5Kfj3I0Z9jx
	LmUcyPdUXHnx+BNfE1Cwz/X8ZLm9Uf4wv56dAkbkReoEzGlnyyCxqoPcsJxIMK0hCkH49ALx6tw
	Ax3knAhPn5yASb8xb8PpjqM9bBkmuImf2uUg=
X-Google-Smtp-Source: AGHT+IGiaTFsmWeXVJkTv2VaiKMWkITWTwekLu0wrtx94GI2QuT+/ZY1FtfDIbmXjtj0P9P/jEY5Vw==
X-Received: by 2002:a17:90b:58ed:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-318c8eb9aa8mr14409504a91.2.1751181320729;
        Sun, 29 Jun 2025 00:15:20 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13a3a26sm6342594a91.19.2025.06.29.00.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 00:15:20 -0700 (PDT)
Message-ID: <ee8636ef-ecf5-4e1b-a304-9a96df1ae4ba@penguintechs.org>
Date: Sun, 29 Jun 2025 00:15:19 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wren Turkal <wt@penguintechs.org>
Subject: Re: [PATCH] rust: pci: fix documentation related to Device instances
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
References: <20250629055729.94204-2-sergeantsagara@protonmail.com>
Content-Language: en-US
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


