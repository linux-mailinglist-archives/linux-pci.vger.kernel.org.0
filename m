Return-Path: <linux-pci+bounces-24214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A7A6A16F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5ED4645D1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE81E9B39;
	Thu, 20 Mar 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSFGm9SN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837C135A53
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459669; cv=none; b=N9uPM/cXWsH3j3zOxGhu2yQB59RRy6LhO56R9dkihqxD1mCPu1mDLIrVaelD4N/rRKsWf25ra4aXL0szkO5pgjiZVGn+zWVX6ayHh7K9uQ2EbCAIz/w3iN4CWrx4luEyPklD+rYvJDAWG6JQaL052VpsarUlMoUqwX4Q74+2OVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459669; c=relaxed/simple;
	bh=l3VwoIVwLUP27LDC5NTNwQF3pDkwJD3vZbcEVWf8GZA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NXZHLikkU2FLn6gERLBNRWIORIcDcqj2JjxsXXxhTLSzEPLk88Gz3aV+wbb0KQEkte86MpfiDECPW6XbOMH+yntfEblPxyQePQUj/zCi+8YsQJv0bvXFxvo3wvMK7g1Wn/unQ9xiCd2niBUfQxdtWpqJCayGhfBQs2bsyE8TVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSFGm9SN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so2945875e9.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459666; x=1743064466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFns9AG268hK1rHV5ZYPNSTIs8c0QR41lOuUEuj/IrY=;
        b=lSFGm9SNHHHdmvdG01URJ6pJnyPceQkbsIun2aVR0n0t3LSHayO8yYRE7lsLjVKm9M
         NdbG1Dk2M7stb1dqd1Sf9eNVmjTxXUbDBTl0j5DNec275nW4IB4dfcle4jz0jnD9XDCK
         eNVkR7C12zq+WJ5P7hXAP9s/uhtmchHr5fm9QZCS6zsMIeCMVZk8Rnm/sywtqOCqtq3W
         RILWOnQJtkpJO08rkP+9YHJPha+qlJz5yesYrLX+nOXHpecXhkM7EMl5/tuQ3ethjtAQ
         whkSKRNpGVEfNk4S8iDEiXCm+O0ZxZiLCusd4neqfr1Nl4NTY9J/Ub6hlUivIus8Ge/w
         j5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459666; x=1743064466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFns9AG268hK1rHV5ZYPNSTIs8c0QR41lOuUEuj/IrY=;
        b=jeUo7aUna4WedoG5TcemXPlLVZTXafFa0Va5/EjaOJjLpsl8TJY39wPRQlCe9lbxFT
         7FYwRBowOajDBEqd15Hs1yYOlimk2D9ZrU44sZQxa7O12cglIN+Joy32TUhNZJJWiHRw
         CN+OsjHHlYKjmqWzhS4654HGUq5YYx5R/NHjUXB88A7P3q6mxRxcg8WaUJGf9m/7jmGB
         /9JBFGVHqNZplKX2NeoAByGxYtUpT2e3p46hD6duQeiqHCVVUmkJxZxsjTQ9KNZ+b3GJ
         cOu5hH1LAWsKe/+mGi3RQhglBTzK2D/w5WyTtMRISpDmjH2zHMtiWI3oC69eUIhKIg+c
         SR0g==
X-Forwarded-Encrypted: i=1; AJvYcCVY7O1FOYZhSCgT2uB8OC24B10ObxbOhyqaOwla6ktALkZ8oXTnsdVM5P8rk3TyjFfMjUDODbNSfUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigEdTw0SHAtFChJmH2s8s7UdZ5UeD0d7mouyQ/KA4+Cp6Nf/7
	/+9q4emVoOdz+aL4xA0iMNaju4nu3ZSoZTVtg9bQp7McY9AoaMfHrfrTBXg693XzDxysAcU4Ows
	JZCXrRl0CJJrKWg==
X-Google-Smtp-Source: AGHT+IHugWNIf0NTcJ1BqVmz9bIucegvlBQBCECxMHN4Jb5Pzy5PsgyGHPknwC9dbNhN2W5DuUZR8ZPXN7RoR94=
X-Received: from wmbbe3.prod.google.com ([2002:a05:600c:1e83:b0:43b:c914:a2d9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3d97:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-43d437c32bcmr62405395e9.16.1742459665813;
 Thu, 20 Mar 2025 01:34:25 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:34:21 +0000
In-Reply-To: <20250319203112.131959-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-2-dakr@kernel.org>
Message-ID: <Z9vTDUnr-G4vmUqS@google.com>
Subject: Re: [PATCH 1/4] rust: device: implement Device::parent()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 09:30:25PM +0100, Danilo Krummrich wrote:
> Device::parent() returns a reference to the device' parent device, if
> any.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 21b343a1dc4d..76b341441f3f 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -65,6 +65,19 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
>          self.0.get()
>      }
>  
> +    /// Returns a reference to the parent device, if any.
> +    pub fn parent<'a>(&self) -> Option<&'a Self> {
> +        // SAFETY: By the type invariant `self.as_raw()` is always valid.
> +        let parent = unsafe { *self.as_raw() }.parent;

This means:
1. Copy the entire `struct device` onto the stack.
2. Read the `parent` field of the copy.

Please write this instead to only read the `parent` field:
let parent = unsafe { *self.as_raw().parent };

> +        if parent.is_null() {
> +            None
> +        } else {
> +            // SAFETY: Since `parent` is not NULL, it must be a valid pointer to a `struct device`.
> +            Some(unsafe { Self::as_ref(parent) })
> +        }
> +    }
> +
>      /// Convert a raw C `struct device` pointer to a `&'a Device`.
>      ///
>      /// # Safety
> -- 
> 2.48.1
> 

