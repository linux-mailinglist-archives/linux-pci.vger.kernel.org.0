Return-Path: <linux-pci+bounces-26816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E15A9DC51
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 18:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D2B17606E
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658D2185BD;
	Sat, 26 Apr 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2DbS05K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEBBA94A;
	Sat, 26 Apr 2025 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745686395; cv=none; b=DBouns0RqMFAArURUlaPthZFrp/j7SsBvJIOyiaZIGmV1AGx+G4vNLpcA2QEgLlf7pX85CZ9emGubSZDmseY7MC/Elg0IWm/LcPPlFxRj7WKasDDyyyBeKMMZ+mH9xRnUnm749LlZHn4TlOLXyO8eN7CmbAPHe+hMjTq3kOwrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745686395; c=relaxed/simple;
	bh=X7xnq85wY/gWSKsD9DoU5wnwThXnb5KlA/HmxiKJRH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHgAgrjGLhVc3g7rjVVo+GhGCWxZ6wrVS/DTEuREgnrA0IZq2iKdOW0Jaq8tLH1KOSk5tr5wA/44iPBcVRlyDTb6heDJx+gVkYIb+bjLpCe0NlpDU+KsawowQbIuxGEpKq2j210OrH2Ntvnmx8UgbBGdvUfrkecLY2X7O3WzNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2DbS05K; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf680d351so25693855e9.0;
        Sat, 26 Apr 2025 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745686392; x=1746291192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUZaXRHqtJVgnkyUE9q17Wetw9kYAHMgInznaRd/Y54=;
        b=e2DbS05Kg3CnwCQ03DImysy8AhG3Ow5+9rr59hIbV7IRiLlMBjYZTG4eA2Zz79ejwC
         H5RmklsaEjtovOby2AcA7ULIMXFLdcZR5N0cZEr83+yrmREtpnWcRRzWL7LC/Aa18kPS
         UuD2jRbVY8wDgAioOuYaUL4SDDm8n2QsxAzzs58pFZ7grvm9HIQpnA2Wcr80Ykn/wo5L
         bN3Y7KAUCkWX0VjewFbM4qR1Jw2A7eWvRdfJ86cT5BWrncJL7zTsjStiGS9xPZvm5FiE
         WjIuPZducGlOyVpmEx8CLmJiw7QMdgv+EnGFgDiN5MlCOzE2UXrrgf5DNZuW7ldyhHBK
         3quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745686392; x=1746291192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUZaXRHqtJVgnkyUE9q17Wetw9kYAHMgInznaRd/Y54=;
        b=xEPMGOjQfUkWvsAqJIgjVCghkWckl+W0H2A1ZXGN28n5dqQY/b5fCbamEWmKiWUSyt
         p7loXNiPRotIADZ8AkwJKObtd16MrbhG51//CTYYHWajc3d+ZWqYqkk3nULHcMPKT09p
         y8D/UyL4ECJsvl5wE734+3nEpP4qsN+kFwX95Bs8JhTRp6PqWj6QzjGoHYTbafSkuam9
         tiza4C9bvggQMOG7TV5aX6LN/tyrywjrPNWy9h/lkCEYsD4WlIJVH4109rdXeLHpwoy0
         1SqcZZTQmtYNdo+eoF7M+F4lMKuuRbhufAemlqrRwspAVQZlcTx4UqoaucY/du8OE8Ie
         3Oug==
X-Forwarded-Encrypted: i=1; AJvYcCVTy3jTTxLZZfXw5oVFv8j1hGUuclm++Aea1Y6ox/3ZqPDRZY3/rD+n/OBdNAGXLB2wrCf5nsxYDMZf2UFsruo=@vger.kernel.org, AJvYcCVuLGt5Nxg9/mdDy1LEMVAzXu87/A2Szjg3pR3156q/rrb/McNqThiHyMVCdusV03ove49YepW2+59qmts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDF+teNfJehG/8RPSXIbNoh72X0JLgCPF8ezExqhftnkzUm37
	lNZjVT3PwdC//BQRX8ITFtCGDHvBT6YrazXHiqBYf+n7UxHp7NU7
X-Gm-Gg: ASbGncvxjZ2BTE0TScbDjklOAfqEgaJx69vGp3Mjj5XnpKn6x8ybVcJO6XzdwL0Xwyx
	fQjrTebfh7KfYMzz+tT3bcl9J/ftyjO76lGb8Y1/LAB6kPXTrbhTNy9/j6P/+G86Ch3WeSyoy+h
	6RBKOJCSupKm8oUo5MzufuOlrZsCrB/rbrTH32L5CpecsEpOCpFEgDUf1izyXbpQWwWpR+Zkt3h
	opzpUiLtY3GWXsN6+3rIlGuDiUWET6aCR5FHAY0/y8v31HNAMmPTmEQPtJlCgmPMka8Hk2x2I6A
	5dmbyJec984/wshrbHwJT+G9uR2X4aACVyOZ6xhCKhuE5C7EPfKktg==
X-Google-Smtp-Source: AGHT+IFKmZ7mhB8aR8Dx52u/NjMaXf8xS2ko9r/BSAYOwgrhNBxKW8vD1hGM9SPWLpQyrQwyvCYBIw==
X-Received: by 2002:a05:600c:3b21:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-4409c454190mr108298515e9.3.1745686391644;
        Sat, 26 Apr 2025 09:53:11 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2e00e3sm101061305e9.34.2025.04.26.09.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 09:53:11 -0700 (PDT)
Message-ID: <ce224b78-5c26-46d9-9b69-6bceb1bda62d@gmail.com>
Date: Sat, 26 Apr 2025 18:53:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com,
 acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com,
 acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-3-dakr@kernel.org>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250426133254.61383-3-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.04.25 3:30 PM, Danilo Krummrich wrote:
> Implement a direct accessor for the data stored within the Devres for
> cases where we can proof that we own a reference to a Device<Bound>
> (i.e. a bound device) of the same device that was used to create the
> corresponding Devres container.
> 
> Usually, when accessing the data stored within a Devres container, it is
> not clear whether the data has been revoked already due to the device
> being unbound and, hence, we have to try whether the access is possible
> and subsequently keep holding the RCU read lock for the duration of the
> access.
> 
> However, when we can proof that we hold a reference to Device<Bound>
> matching the device the Devres container has been created with, we can
> guarantee that the device is not unbound for the duration of the
> lifetime of the Device<Bound> reference and, hence, it is not possible
> for the data within the Devres container to be revoked.
> 
> Therefore, in this case, we can bypass the atomic check and the RCU read
> lock, which is a great optimization and simplification for drivers.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/devres.rs | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 1e58f5d22044..ec2cd9cdda8b 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -181,6 +181,41 @@ pub fn new_foreign_owned(dev: &Device<Bound>, data: T, flags: Flags) -> Result {
>  
>          Ok(())
>      }
> +
> +    /// Obtain `&'a T`, bypassing the [`Revocable`].
> +    ///
> +    /// This method allows to directly obtain a `&'a T`, bypassing the [`Revocable`], by presenting
> +    /// a `&'a Device<Bound>` of the same [`Device`] this [`Devres`] instance has been created with.
> +    ///
> +    /// An error is returned if `dev` does not match the same [`Device`] this [`Devres`] instance
> +    /// has been created with.

I would prefer this as a `# Errors` section.

Also are there any cases where this is actually wanted as an error?
I'm not very familiar with the `Revocable` infrastructure,
but I would assume a mismatch here to be a bug in almost every case,
so a panic here might be reasonable.
(I would be fine with a reason for using an error here in the 
commit message or documentation/comments)

With that:

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

> +    ///
> +    /// # Example
> +    ///
> +    /// ```no_run
> +    /// # use kernel::{device::Core, devres::Devres, pci};
> +    ///
> +    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result<()> {
> +    ///     let bar = devres.access_with(dev.as_ref())?;
> +    ///
> +    ///     let _ = bar.read32(0x0);
> +    ///
> +    ///     // might_sleep()
> +    ///
> +    ///     bar.write32(0x42, 0x0);
> +    ///
> +    ///     Ok(())
> +    /// }
> +    pub fn access_with<'s, 'd: 's>(&'s self, dev: &'d Device<Bound>) -> Result<&'s T> {
> +        if self.0.dev.as_raw() != dev.as_raw() {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: `dev` being the same device as the device this `Devres` has been created for
> +        // proofes that `self.0.data` hasn't been revoked and is guaranteed to not be revoked as
> +        // long as `dev` lives; `dev` lives at least as long as `self`.
> +        Ok(unsafe { self.deref().access() })
> +    }
>  }
>  
>  impl<T> Deref for Devres<T> {



