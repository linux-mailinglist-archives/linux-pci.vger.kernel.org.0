Return-Path: <linux-pci+bounces-24215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE7BA6A181
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DBC465462
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD72E215F49;
	Thu, 20 Mar 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKJ1iucM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5820B7F9
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459768; cv=none; b=O264S7WOcTXtpjHKeJZyaKVr1TQlrXrvc7qWj7SIspz9z1pevRp/dv7B8tCn+pgsBvaF0EmRDFDyM0iRBWHmufcDXHfVAYfQvz+NPgVJwbkJfquJwijX+TUxbVZnfCo3LR3qRjzs4OhB5rmVhUSoxfs5EuJkOF8g1MFbVRJKvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459768; c=relaxed/simple;
	bh=KNJnFdpohVmIa9lQL3tDOPD+TWPXmNHbRtdDIF7XKFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BAGE6rwIVqCGCdpEV7pRYw50RjsAFU8DFRnaVF1WxSRIUdMm5UFKQ/cnhoUIOx1zVNypGAFMpUPiLZ/KsX9XlSyxBcOj+tDZh0kVlQSAueZI6Kx0KsW9EkhdUnlXE8XZJIuBVVYOjL+suDMg/1HDzMbhDW9MEH6cdMeEnCr8eKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKJ1iucM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43947979ce8so2126425e9.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459764; x=1743064564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F//KPN2uLlDC+J9SdRcv9HHuEvs+T8Y6Iwqb4VpEjaQ=;
        b=nKJ1iucMm4+Ft7xY7dWQjBzS9hYTpOAaS0HrvwhD4WKQglGeji44zIKnRc5a0tC40U
         wIzQ5R42sHRNnC8jJUrfnQ5PTnUYUt6IGwuKT+isj56g+xZuK3bF6oy4e4Y5xHXyJPgy
         oQXDIqJNlz7w5sgdcqSdg0hj02IzXurvJzEKGhwDiskbA2b24KBJ1KAEzmlZkumWcCZd
         KFgsufXXs2LwyrwzqjfduLjOLWrmtil1671KKqXeBx+TsfAQpy3YSybba/7D3GoknfWF
         mflNIdQpmLDbIo5vH5Q5pjVi3/rmjRqOcMExqFVSzJ+wUC7+Dz9VlRUAISePfLsv2Zit
         U9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459764; x=1743064564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F//KPN2uLlDC+J9SdRcv9HHuEvs+T8Y6Iwqb4VpEjaQ=;
        b=nm2g6yxWOOHabqA+UMnOUMy9EGW9ML2FA6DjzkV6uZQajm6DJm9ZRkKX8xc9tb7QwK
         yn0D3UDR3VHc0skt08PsFC0AsIp9u+8fckVWFWszeV6yG5hQaXGvPZX0d9qSHUBjU9Rc
         iUnUSxiJAy1fWgpTM9lvnCxPLkI8XvsVnMo2E6Id8Wy14vbLas/jJdQjYNfbmE4tGjaR
         Z8CL8oQiiRblS3vlQvh2R+kA2YQHgHw302Z7gU2AXj/6anmqO0ipiFFJtbNcSHEdjCLP
         4gPwB8PlUV/RZud0xJi65QRGdfAshpZM/JaVPGd79bmcfexTVaNMpUQLk753kuiRZF1s
         38hw==
X-Forwarded-Encrypted: i=1; AJvYcCWUVTVlT4Bu2SQpzQDol7cGl9xYvNB3ojuLcu96+6r6xedTkKt7ffZTk4/IMWeULsFFSQsVWBRITXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycr2ikovwsXO8z3FeDA+/7xZ9x8BFsqaOAifNhCaQSbiPC4jcY
	EthHT1kdLDT5xaPZPWAyfh+IeIk6GaNhhkZKwWSJnJg7c00aAwW6iBosxxseKb7FZ98hl1Plhwm
	p01AvPO08FiUQhg==
X-Google-Smtp-Source: AGHT+IGae8DQmm0qB5K/T2yS0Ts18/juxqQiCR0uNBRGxkWQTVlUWPIuqtVDcfSLOrlM8VzPf2m3TStxTVObcuM=
X-Received: from wmby10.prod.google.com ([2002:a05:600c:c04a:b0:43d:1f4c:ccf2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f86:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-43d4378b1bbmr48923425e9.8.1742459764068;
 Thu, 20 Mar 2025 01:36:04 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:36:02 +0000
In-Reply-To: <20250319203112.131959-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-3-dakr@kernel.org>
Message-ID: <Z9vTctFR7QAOa4tn@google.com>
Subject: Re: [PATCH 2/4] rust: device: implement bus_type_raw()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 09:30:26PM +0100, Danilo Krummrich wrote:
> Implement bus_type_raw(), which returns a raw pointer to the device'
> struct bus_type.
> 
> This is useful for bus devices, to implement the following trait.
> 
> 	impl TryFrom<&Device> for &pci::Device
> 
> With this a caller can try to get the bus specific device from a generic
> device in a safe way. try_from() will only succeed if the generic
> device' bus type pointer matches the pointer of the bus' type.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 76b341441f3f..e2de0efd4a27 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -78,6 +78,13 @@ pub fn parent<'a>(&self) -> Option<&'a Self> {
>          }
>      }
>  
> +    /// Returns a raw pointer to the device' bus type.
> +    #[expect(unused)]
> +    pub(crate) fn bus_type_raw(&self) -> *const bindings::bus_type {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.

Is this field immutable?

> +        unsafe { (*self.as_raw()).bus }
> +    }
> +
>      /// Convert a raw C `struct device` pointer to a `&'a Device`.
>      ///
>      /// # Safety
> -- 
> 2.48.1
> 

