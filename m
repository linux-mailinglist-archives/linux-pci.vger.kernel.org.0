Return-Path: <linux-pci+bounces-42738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFBCAB2DF
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 09:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90ED330562FF
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 08:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3FE260566;
	Sun,  7 Dec 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAt6HoPI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035124886A
	for <linux-pci@vger.kernel.org>; Sun,  7 Dec 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765097448; cv=none; b=ZG0vSwvXJhFMM9+HRY2vJTuHxeVt5iMfyLtFLErdqWpMP+hw43XREq+DTk8C4OX+fQm2aTGqIFPJYnFatZfv45PZQ1Z6z1O0/c/ojdD2suM/pRa+HQb9+i/G4kmsJitMFWSUT4ZMrGrOkA5nTxdevZIET3spk4JVutI7J9EYXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765097448; c=relaxed/simple;
	bh=XMqJYBYTtu4XRIcQoWEA3xfw1GeilePurf/OYgdwnSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tcta24BZsUR/qxup7gYDn+501oirz2lflIGUxbPcqU2PsVX+B+WDbCt9/TehnbNtfGSMSVrEfbWfePa38gHit0RxMwqG5xmG/snkrF5xrKDIwoQ6dF+teUHNmz3wZqxdTlxIymA2bIkgG4vHXmm6y1fY7TCDBFfvPhCMJgSKW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAt6HoPI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37b495ce059so26852411fa.0
        for <linux-pci@vger.kernel.org>; Sun, 07 Dec 2025 00:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765097445; x=1765702245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5b12hRnRWv6onGjF90Cte/QEE3Sc5Ju08UGYaWm18PI=;
        b=hAt6HoPIuqFSnHI1Gxy3lBFFlUZn7H/OMluppNnoan6Ypz549W72h9xythoW5AhZAQ
         6WVLAh37yDStYH83Ncee7eYUYGeGuLXRHBzlsTgcY7TLp2s8fdZW5ph6oB0zSVVjxnkO
         CnILHG4Avk4wEtiLtRQPl/IH6dhQquEcmh0+LKu0zZ5Cvrog36Nj5K758xpfPAIO8AQl
         OqFhDHuxOvV0plCCW/mToZL24rU2l7wMN6xKbfju+rBLkfKLjvR0QZOlSKvktvH+8Y68
         nK5LvUmG5X2ab7JpvZMj2ai+7HJOD9FsDulY9TBWJENrcq+tx7TztSCokeKhDL0dHJy0
         m2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765097445; x=1765702245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5b12hRnRWv6onGjF90Cte/QEE3Sc5Ju08UGYaWm18PI=;
        b=cH0XDaSVhkOuglZEA8BoqiXbFlIkcGb5S1LSphF6jDRPLk0vL10EaSXhNczfo6gkjF
         dd3bvsb5gjVksl/6DcyZ77hM7Y69HUdyzrwH4HfBRoNzNXPtXL+3klEYZf0ircAUHOky
         wQuh9g0zO4fSQ6jQyjTkas8cmrnvS9WkhHwdUMfB8cAJyV6up3bVkdUDVE+FkT58LCcP
         Q+8YYcEjPjZRimDPhACgGu2HDxQPdCakzafO5yz7gcz215a25qopxEfmx74WlhLnzWnH
         WWsKcZpesTfe5ZiWVbG38E9gXRJ68ZSD/cIQpTwS1C8Ck3gtxNvwuHo2kOIaC6Pwgyb6
         uXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzncVApePo4faQVfHQocY9lUY50qcDehKdd+rSnwSXkWjfG9Z0bJg4NUg445ZCB7SqwarAiX5Lg2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7PdQJD47FGBQXPQSoJW0zSpk/27SYL6UYZtWjYCCoxtgHSvv
	88mA1EIGaAixQrBhIJuY1CMZsPxdNvpnO8a8oh/Wv72V2YvL63yxNyp6d9Mzyw==
X-Gm-Gg: ASbGncvz0A0E6/NGXSaL2RLcst9nV5v2OA4rhL9ofv93ZbmrlS+t8h4Y3gMZcLI71cv
	eTsKtm8T1rALLhll8DAbh5h8kxcCqCtArIbdR+4nCcPj7WSSwrS9cGnBqluDLdqzlEZsQyqMkJQ
	3O9RNMohWSqTBluNH8AVk2GxwDVb+m0KvDVzIhWzKNGZT1A9rW3/2sLEWGt7lMmh9mWlNDSxzAE
	2CnQl+ljaZrGubA1rvOfxJyvmut4uAsoM+Wl7pI+vZ0w5anLEtcmC/qHGQI+Iokx42YDrc15BIC
	ShtYUwadzmP0ZV2st6CFVN9U95QZLW4NfIKbmlzNI60kfLs4MHugLhfL+MlXXrnNbfPZEsal7Ey
	20olBvdwN7Wy9R1VlWfz7yIFv+Z8LOxOolzpxswOY7l7JXe+c4X6uuTxnTHFnTSAmZs4MsMdORX
	rSZ4DTtjls6VSnkeFJVfyleQ1GjmNLI3auryyynPvb0tLBvf/bnEBEVsFqcaEWMUAkfdQjLoqbj
	DhaWLl5U657u1itZ7+ZQ+xgTnPN3BcD47XDQ2ZHpu8=
X-Google-Smtp-Source: AGHT+IHkpbBEjUpSSNR6c1N0xrVq9kG40VYKHC/sRRQKwimb+t89Kzoar8J3mhxBoq7JhZtP7BsBvQ==
X-Received: by 2002:a05:6000:430d:b0:42b:5448:7b08 with SMTP id ffacd0b85a97d-42f89f094b2mr4983612f8f.5.1765091533868;
        Sat, 06 Dec 2025 23:12:13 -0800 (PST)
Received: from ?IPV6:2003:df:bf22:3c00:1c42:64e:ef2a:93cd? (p200300dfbf223c001c42064eef2a93cd.dip0.t-ipconnect.de. [2003:df:bf22:3c00:1c42:64e:ef2a:93cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm18354202f8f.19.2025.12.06.23.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 23:12:13 -0800 (PST)
Message-ID: <ca549425-e10b-4d54-aebe-278d90c8cb92@gmail.com>
Date: Sun, 7 Dec 2025 08:12:10 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] rust: pci: expose sriov_get_totalvfs() helper
To: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: airlied@gmail.com, dakr@kernel.org, aliceryhl@google.com,
 bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
 cjia@nvidia.com, alex@shazbot.org, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 acourbot@nvidia.com, joelagnelf@nvidia.com, jhubbard@nvidia.com,
 zhiwang@kernel.org
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-2-zhiw@nvidia.com>
Content-Language: de-AT-frami, en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20251206124208.305963-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.12.25 13:42, Zhi Wang wrote:
> Add a wrapper for the `pci_sriov_get_totalvfs()` helper, allowing drivers
> to query the number of total SR-IOV virtual functions a PCI device
> supports.
> 
> This is useful for components that need to conditionally enable features
> based on SR-IOV capability.
> 
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 7fcc5f6022c1..9a82e83dfd30 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -514,6 +514,18 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
>          Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Returns total number of VFs, or `Err(ENODEV)` if none available.
> +    pub fn sriov_get_totalvfs(&self) -> Result<i32> {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_dev`.
> +        let vfs = unsafe { bindings::pci_sriov_get_totalvfs(self.as_raw()) };
> +
> +        if vfs != 0 {
> +            Ok(vfs)
> +        } else {
> +            Err(ENODEV)
> +        }

In the thread [1] there was some discussion about the `if {} else {}`
"style". From that discussion I "distilled" 6 options [2] which I
liked for having an overview :) Of course not all of these applied
there (const), neither will they here. And all have pros and cons. I
think in the end option #4 was selected.

What's about to do something similar here (and in the 2/7 patch as well)?

if vfs == 0 {
    return Err(ENODEV);
}

Ok(vfs)

Dirk

[1]
https://lore.kernel.org/rust-for-linux/CANiq72kiscT5euAUjcSzvxMzM9Hdj8aQGeUN_pVF-vHf3DhBuQ@mail.gmail.com/

[2] Options distilled from the thread [1]:

1.

if let Some(sum) = addr.checked_add(PAGE_SIZE - 1) {
    return Some(sum & PAGE_MASK);
}
None


2.

addr.checked_add(PAGE_SIZE - 1).map(|sum| sum & PAGE_MASK)


3.

if let Some(sum) = addr.checked_add(PAGE_SIZE - 1) {
   Some(sum & PAGE_MASK);
} else {
   None
}


4.

let Some(sum) = addr.checked_add(PAGE_SIZE - 1) else {
    return None;
};

Some(sum & PAGE_MASK)


5.

match addr.checked_add(PAGE_SIZE - 1) {
  Some(v) => Some(v & PAGE_MASK),
  None => None,
}

6.

Some(addr.checked_add(PAGE_SIZE - 1)? & PAGE_MASK)

