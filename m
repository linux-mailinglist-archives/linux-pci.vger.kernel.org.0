Return-Path: <linux-pci+bounces-38469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94007BE8B85
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FE054F5FFC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B730331A4F;
	Fri, 17 Oct 2025 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9heAzin"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E3331A43
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706297; cv=none; b=E4liODHsQ9Ue9Yvxm/yLYJrg4d315HVzapZNf/q0wZIVz50AwnJYCxo4ln7B4KFZNhuNK5LOCQvLUceTmbZj5wLOl/JZzm/oPJPGnMsWl+KCNEV7E3nkPqqD5SsOJ3xuAlapE/4PnV1ja0ZdK20TLyGWZuaDg+t8lBx1U4BLYI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706297; c=relaxed/simple;
	bh=45mXk3vW1QoAnyjK4Nd0ASLRTO5e22FNrn8YEgJAgCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hyvkoPHWllfAMBPblvFF6/01n2VAMyGqVA/5o3iSeTX5XNfOQwMkMzv5d63+U5irvphZoeo8KE2YEVX//meKn+5KlF+RzDcxBzpjbecTs8baM6z/afQC+6r/7tgvlKIS0GBhQ8UYcGHbrKU0cujeV27lGU0n4yuAo9jjyVYATvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9heAzin; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so2520335f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760706294; x=1761311094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QsGulBtXOolWogbv37P9kOPn3EPzZ7HWeVFTvLjVVtA=;
        b=M9heAzinbWs6Rws/XraRiYASpesShCyWMFYu3Ulftwtmb8EKhO1Cg3XmpkqIluR/1E
         0A2rNY/+AhKaiXftu0BmP2ymAuKimHzsi/H4teFi91493IWupZSZZ62fc92UgtPWDccI
         UzzPUz8dEjWv4I+sbnuF+vpbs76iOXmq8SXWo/dpVbu3IE14neNkx+/D6O60EEdRf6hc
         srW5cprOSSsWHget1JX8jbm+8SMNnfQjoOR3J0jCFFKK4D61zovbTG8nTtEHYgPjUXfX
         HqYtShRJsQo4MfxYrjxFYmTw0uweC7OrwWC5+dNs+Kis/eI1tFQfDEPtnnsc86E2oHyj
         expA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706294; x=1761311094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsGulBtXOolWogbv37P9kOPn3EPzZ7HWeVFTvLjVVtA=;
        b=qbR8APvwJhk06m6EH+Xz0DK8UVKlLh3lg4WhStaNppUoPGx+b711SrfIzOm/44Ik57
         pS7pXuJibQzADd9obo4vl4T8WotG3KHP/Mi24tbK8WsuxPKFOkM2QNu0FyAb2fqEmckv
         QV8PcShA1c+1tLog+QnWlAO3/AOOV4LE65y8aXCfoYZQOwyQTysYXy17kdiUclXMk6oY
         1+aLV9K1en/wclI7jtL5DsbTRXXf8YL2vfWb9xE2LHlqlueghuL/PO8hNmi0ZVG1Smuv
         EWbwDa7AXALrHcLoVn4gbQ2oolhfYj+zzxIB0M0zzgzV/VOrlHNuVJGJnnxOXXamoyN0
         u5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnaGxPtIzpT6wBahnm4Y84ai9iybaYfz1AwebEKHDDrbsJ6Te/3Gub5WpyKz6Bgzb+FL/iyO2FPEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MDaQeNL50S6OyC5/7xSRJYxYANlfgQyBkI8f6W9ceZtjhc8J
	KUSdOiJ063fCtETdQwmg2DL6uiWoYkXG18naCleM9DVN95t/XDObgae0DPGANi4HlU3LQRAiLPN
	/tMgNCZo2rYFPRcHenA==
X-Google-Smtp-Source: AGHT+IHmxuUy/higL8bMvF0u1RF+TfLvGKbJRuFXq91cThOSrZ5KPNHsS9I5kFewP7afvF/ZcVPnLKvl0oA6dKw=
X-Received: from wmbgx4.prod.google.com ([2002:a05:600c:8584:b0:46e:1fc1:6636])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40ce:b0:427:6a8:532a with SMTP id ffacd0b85a97d-42706a8535dmr1784522f8f.31.1760706293678;
 Fri, 17 Oct 2025 06:04:53 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:04:52 +0000
In-Reply-To: <20251016125544.15559-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016125544.15559-1-dakr@kernel.org>
Message-ID: <aPI-9GoI7ZsNCpQr@google.com>
Subject: Re: [PATCH] rust: driver: let probe() return impl PinInit<Self, Error>
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	acourbot@nvidia.com, ira.weiny@intel.com, leon@kernel.org, 
	daniel.almeida@collabora.com, bhelgaas@google.com, kwilczynski@kernel.org, 
	abdiel.janulgue@gmail.com, robin.murphy@arm.com, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 16, 2025 at 02:55:28PM +0200, Danilo Krummrich wrote:
> The driver model defines the lifetime of the private data stored in (and
> owned by) a bus device to be valid from when the driver is bound to a
> device (i.e. from successful probe()) until the driver is unbound from
> the device.
> 
> This is already taken care of by the Rust implementation of the driver
> model. However, we still ask drivers to return a Result<Pin<KBox<Self>>>
> from probe().
> 
> Unlike in C, where we do not have the concept of initializers, but
> rather deal with uninitialized memory, drivers can just return an
> impl PinInit<Self, Error> instead.
> 
> This contributed to more clarity to the fact that a driver returns it's
> device private data in probe() and the Rust driver model owns the data,
> manages the lifetime and - considering the lifetime - provides (safe)
> accessors for the driver.
> 
> Hence, let probe() functions return an impl PinInit<Self, Error> instead
> of Result<Pin<KBox<Self>>>.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> Depends on a minor pin-init patch [1] (Benno will send it to the list
> soon). A branch with this patch and the pin-init dependency is available
> in [2].
> 
> [1] https://github.com/Rust-for-Linux/pin-init/pull/86/commits
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=probe_return

Overall LGTM.
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  impl Device<CoreInternal> {
>      /// Store a pointer to the bound driver's private data.
> -    pub fn set_drvdata(&self, data: impl ForeignOwnable) {
> +    pub fn set_drvdata<T: 'static>(&self, data: impl PinInit<T, Error>) -> Result {
> +        let data = KBox::pin_init(data, GFP_KERNEL)?;

Perhaps the gfp flags should be an argument set_drvdata?

Alice

