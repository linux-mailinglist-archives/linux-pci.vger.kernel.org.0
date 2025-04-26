Return-Path: <linux-pci+bounces-26815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF36A9DC48
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4391F1710DF
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA33D1C36;
	Sat, 26 Apr 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifFoVU8m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D82BD04;
	Sat, 26 Apr 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745685848; cv=none; b=lS/G26d7nRCkg8hOSGev26mKOV0JNAldynViBnNBbqu01jXYKfVkHhr8Pa1Vd6kCTZTwk/MRuaMDF1G3ELeNXuu4Wg4yh1ah39yucsGhLBhkgHDWwtCU2+bk1zoMpwVRsRPEsTbgXHqmNaHS9lIIY/403ztcPD/u2wFdL2Ubp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745685848; c=relaxed/simple;
	bh=1QIf3vMg7h2Se24IFtWQFTIkzSSKq7hNsQj63B/P/zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVE+VJoeEoqVw8b3hG4YUlaHXahE9H6Uq1VFqNphs0B+XJlua3yDFfhBFMFEe5SjRl3oCIy7ibwuQqZnq3/zOFEzxewlvx2qgn+Md3SlCTAf3SZxp4ubrL021FInAlCZFB2X5CS0YvbYeZw0B5gEEFrHV3dT5L+cy9mfAFyOBio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifFoVU8m; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c30d9085aso2319989f8f.1;
        Sat, 26 Apr 2025 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745685845; x=1746290645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mcf7vr1GZNpwiHE/ZlzHYRIvYccGMAJfanDR9q7K3k0=;
        b=ifFoVU8mC46MYYRV43nUKejqS6PfY4qSGJdPJEV4+Oge0gobsHajFMGQfw/d2Xvfxe
         JkbGR0iEpr5kHCXvgce8uETEMmTIQGXdXja7QYaSjjNH91Jff108Z+N7r4BfR9uwGSOm
         LizyUOazhxdiJf7MiD0QUcUkf17ub12iBHFSm6AmjM7DrKEURNYhqHdplxrU0ZihsG9H
         BcLkvu5Au7nJf9OpoGNUBItRmHDM4WK+PFiCMdf7HdAC8cNQPylIB7QT76tulRC9btg+
         WqsKXhweYeVtx3GR5arOZQH93KCasY0iH9CVWNnQqgrPy9M5KoQw3Kz9eQxIt5qnQ5cV
         aeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745685845; x=1746290645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mcf7vr1GZNpwiHE/ZlzHYRIvYccGMAJfanDR9q7K3k0=;
        b=PW61hJtXw1a+7s6jWFIlW2aomaJHDKk+dsR0DjMIYtLc6xnz/56kXnHhyZxTf4o2Cg
         piGuu55JRoX7+qEzgewaBQOiN5fT4UjXBOecaliASwOnD8wpw8IoYYpkc0f+XTTYdf5O
         lWF7t8uf2Whgv9d+kBI1lAtNcBbPJlP9GLAwlupZxd/91DwSWlIr2nPxp3UgyRVhFfyA
         FW/UDaqSb7ec5PjbklpwEjDoiDsE+/KWf7wodPS7J4aP9tnH9ShuMRDN9cJlK8xH10PB
         M/LBt3CAUV8lxwNl804YFWUkTqHi91Vy7PL8k5g+AxY9s3DSsBWIqC+SE46JOcgfqFXB
         5BTA==
X-Forwarded-Encrypted: i=1; AJvYcCUQsl1wzrE5sVaHAFiS/T05xIJ/AYQutnWf7CaIETjRouLyj9eMMnk+jV7+jXQ4AzRajnyhdkwM3vUvdU/RQYI=@vger.kernel.org, AJvYcCVBcjW/90Yr0BNinSIaGGL/6Pt8CNeyv7VsslHeo0n9B1Wyrt/xjdheN3+YF+5AntBmLKFGHnCwZINsNSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNkC/qGptVf9/DYWRpHWPTaymZBnZr+3K7wCQG14spB9Psqot6
	MA/3tSxdsf/7QHvFb96MM0bWtQS19R9Jn/6Kr1USKW3Qar4HCkRD
X-Gm-Gg: ASbGncszs23XB2hCLAn/Ki1Cwtu7iHZcrJ1LVv8hKKLs6pYlyuqB2X2SABFJXINb8gl
	cBXKGSBX3HfLL4J/VVc9iQoL5eIyMvSz/dQLC2dobOqZPVE6ouak2DoPoM88mjzK2CA3GiJACX7
	rYyoD0nPrblQXiDSWmG2kt2Qwkiipj7qNQxgaw0MeBgmNHLA25P6P5nLa8OnaZLtUpkqPj1RQcC
	8O5JFlaP/IsqhJpnNd1lz6bm5CWHcwrKmrONgjRXpF2bt/e+Fc0e8rnundaONDOOEh0zJf5HBqm
	aCciNyLI+xsjdRSXStKy6NdfF6at+7fIL1K/7bdHzVG8eY5XrL1jcA==
X-Google-Smtp-Source: AGHT+IHTERUWnVlXEuFFkkKj0MykFQU5mHktIF7PX7bZDPluUMPIceU1QbKxM4XwLSfz0u1fCNh/bg==
X-Received: by 2002:adf:f541:0:b0:390:fbba:e64b with SMTP id ffacd0b85a97d-3a07aa6c9bemr2271155f8f.31.1745685844792;
        Sat, 26 Apr 2025 09:44:04 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e4641csm5969768f8f.80.2025.04.26.09.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 09:44:04 -0700 (PDT)
Message-ID: <aa747122-fc78-45db-a410-ceb53b4df65e@gmail.com>
Date: Sat, 26 Apr 2025 18:44:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
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
 <20250426133254.61383-2-dakr@kernel.org>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250426133254.61383-2-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.04.25 3:30 PM, Danilo Krummrich wrote:
> Implement an unsafe direct accessor for the data stored within the
> Revocable.
> 
> This is useful for cases where we can proof that the data stored within
> the Revocable is not and cannot be revoked for the duration of the
> lifetime of the returned reference.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> The explicit lifetimes in access() probably don't serve a practical
> purpose, but I found them to be useful for documentation purposes.
> --->  rust/kernel/revocable.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> index 971d0dc38d83..33535de141ce 100644
> --- a/rust/kernel/revocable.rs
> +++ b/rust/kernel/revocable.rs
> @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
>          self.try_access().map(|t| f(&*t))
>      }
>  
> +    /// Directly access the revocable wrapped object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure this [`Revocable`] instance hasn't been revoked and won't be revoked
> +    /// for the duration of `'a`.
> +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
I'm not sure if the `'s` lifetime really carries much meaning here.
I find just (explicit) `'a` on both parameter and return value is clearer to me,
but I'm not sure what others (particularly those not very familiar with rust)
think of this.

Either way:

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

> +        // SAFETY: By the safety requirement of this function it is guaranteed that
> +        // `self.data.get()` is a valid pointer to an instance of `T`.
> +        unsafe { &*self.data.get() }
> +    }
> +
>      /// # Safety
>      ///
>      /// Callers must ensure that there are no more concurrent users of the revocable object.


