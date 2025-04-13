Return-Path: <linux-pci+bounces-25760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C00A873AA
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 21:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C95D188D9B4
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B33E197A7A;
	Sun, 13 Apr 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvvWs2GQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428619E833;
	Sun, 13 Apr 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744573104; cv=none; b=MuZYG3FbkGbsMxFtUYJ6R++u/Ot2FizhTqlqxlRXAoCmFC9ATURWzX3sn29VE+LIdgvKBPNOcP/muw6WrlpN+MgGRUh8CA7q57vBCdn11Z3nLcnMDnTVajydEUktgL+HRqdV7snfoWQHVuVx/rwsdQzZKnMKqaDclcgKMW738o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744573104; c=relaxed/simple;
	bh=aLQiKfS+vZoV3A9YY0/xQ88DDJ7+HMvKNpHMPAC7uCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6c4gGUuy4zXmFB81cIOKGPR5HkzNtOGWVXY3j0FrVc44q4qVHKvpZclsDaweH3lKJxnyNxedUqpI8zI7bNNUKJsuHd5P8EW8/tTbis/3DbOq+TgM+PVtdw0YmGEDyR7mX8HQxehO8Nad4slj1RAEkRh5v3vEkhg4Esv2NG2zaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvvWs2GQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac289147833so730523466b.2;
        Sun, 13 Apr 2025 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744573100; x=1745177900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLKvDmY51PZRVjhgJoAOzzWE4gsPyBkxL4CKeqUI1+8=;
        b=jvvWs2GQOOWM1WbHM+CeQSfUoXa2FgYG/f9VFzjcUdNP5g4VpgohK6/1w7NEJhltV6
         vk/39t1xPrAD0leMAtN9Xo92g4MdPpIbFUAuydolu9slMz8GxE9H9xxSvjXCVX6RL8Jq
         nxMo2XYUEek6k0Kdl0/tavKhu23dgm1aL5sVcjb8gYhi9smAl4FlEm4KdwvKBOZ6Eaqc
         HaxkB2Fvta0CgSCQ14vFrlwUfPuI4r2N5776ypUaUmGMrp2GQ3aaYxytX5IcwKV8YDY+
         hrFnlKRNipWpkk+n2jh5pck2smUgpclClr9luBXvrk9Skz3NYOKyp/O/iqZSUCyw3L2S
         anLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744573100; x=1745177900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLKvDmY51PZRVjhgJoAOzzWE4gsPyBkxL4CKeqUI1+8=;
        b=PHXJvU1dmEcAD+/Qepgoqjh+Fcz5FBzTbLSY8ORH3vReydeiTgsb5MdA/Rqi0TG3js
         uYmzz28o6du/QqBuLtceh60px8Gh/DeWJjORaVMSmSSc0DgcvhxLDBjUGXxL1jffXCkt
         pl7pPACdnqPhx/64HJbmsemUj+g9bzwX28XDitsp1LkPbg4kmWxUtpqECE27cRyCf86R
         UZsJU14cVYrX1ynbbbjXMGFLVrBuMTuX62Rpf2zBFxMQA4ZAr5bFeOIgcutIl92qyQpg
         bnLyxLTPqXS34d74Rn2+ZNv5qFOCwI8Jf5EY9hpbclJk7PyxJZLd+td6H64TUsG4V0LC
         6KHg==
X-Forwarded-Encrypted: i=1; AJvYcCVGHrL0nTMgCyL8a8I+kAk+S7m9tDXo9kz5+0be5IpsSmpxrThnLVrV6Wm6zjP0dhAgcFmLR9GAd2tQNs/Yhq4=@vger.kernel.org, AJvYcCVuYzLIEiPsLo3JSUZW8hZICL0o0B23vZ53rQW+vzROeBuo1Sv1DpSVCSXxJXGKZ6RHwKUDZTrLAeGn@vger.kernel.org, AJvYcCXx25eVqWHnXSPz9Z++eznaSuY/ru5RSdzgkKBYdDIAXVpEDhNykDlDxgTRMesdH/sskYyJQB19wYY7QIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOua7bfFFQBJSwaz1clBNcMSRJyzSU1uQPT3DZHg+MjiG0SEHL
	WFQ2Wi/+oVBTIDwFis/sw+DgxfD3fkERsCcJ/C2tpMfY+DwPEa5G
X-Gm-Gg: ASbGncsnePZGzpe8nfrS8YLg/CFgBdXcEJ/6G4ZoTqtYD5cCp1y1l2yh1NyNE4KnjY2
	EnPWt4nF0ZN2kaoPGQJOJarmyIpOw6dOSaZ6rNgXS3QAMIu7KxQz2w5+jwGYD/siOVqWMlgiicq
	2z6XJCV7eExlC1zONx2RZYjclT1r+/bLxKNXZKiKCfHgHFzKCzS+V80yN2+3tjxFKO5VZ6KH3+i
	1GHqmV0sHWv4Vd6cFcUp5gAwSyLZchIJe1HdosvjOWawn5Ke7pn22+Dr6KrcaCS4YbsrxjLdlma
	u3soLp65dUDfUW+Iu8LQs+rBpU2Vd/3qjxHEfywcKg6q7ZmhRJs42A==
X-Google-Smtp-Source: AGHT+IHLw0nBq43BlMIbkMBJ5Biibfbk8ji1r33eLdFdVCE35F6cy4bjI3+/HPeiV2VTUGkgPitpwg==
X-Received: by 2002:a17:907:7ea5:b0:ac2:b1e2:4b85 with SMTP id a640c23a62f3a-acad3456e28mr907658466b.3.1744573100290;
        Sun, 13 Apr 2025 12:38:20 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd1cfsm784214566b.138.2025.04.13.12.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 12:38:20 -0700 (PDT)
Message-ID: <b983c624-399e-406c-9964-560ed5323d27@gmail.com>
Date: Sun, 13 Apr 2025 21:38:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] rust: device: implement impl_device_context_deref!
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com,
 kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
 abdiel.janulgue@gmail.com
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 daniel.almeida@collabora.com, robin.murphy@arm.com,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250413173758.12068-1-dakr@kernel.org>
 <20250413173758.12068-2-dakr@kernel.org>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250413173758.12068-2-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.04.25 7:36 PM, Danilo Krummrich wrote:
> The Deref hierarchy for device context generics is the same for every
> (bus specific) device.
> 
> Implement those with a generic macro to avoid duplicated boiler plate
> code and ensure the correct Deref hierarchy for every device
> implementation.
> 
> Co-developed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs   | 44 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/pci.rs      | 16 +++------------
>  rust/kernel/platform.rs | 17 +++-------------
>  3 files changed, 50 insertions(+), 27 deletions(-)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 21b343a1dc4d..7cb6f0fc005d 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -235,6 +235,50 @@ impl Sealed for super::Normal {}
>  impl DeviceContext for Core {}
>  impl DeviceContext for Normal {}
>  
> +/// # Safety
> +///
> +/// The type given as `$device` must be a transparent wrapper of a type that doesn't depend on the
> +/// generic argument of `$device`.
Maybe explicitly mention that the memory layout/representation 
therefore doesn't depend on the generic arguments.

Either way:

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

Cheers
Christian

