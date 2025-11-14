Return-Path: <linux-pci+bounces-41239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE77C5D357
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 14:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 799674E8342
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197EA2459CF;
	Fri, 14 Nov 2025 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJi1BqVk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D44244685
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125116; cv=none; b=Rk5Bcyl3QSmo59umfaWl678hbS4qgivmowQltur1tNfPRlcCUWlQFu58andcxaUtWf8/+OBc2bxOBXlTyxlcWRNMauinsGnE04xmZWD86OpkLdC+7GfoiW01rANPeFQ4rkoU//sUEskM+Q2TwYvG6LizmZjCXgXWGOJoGOuwaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125116; c=relaxed/simple;
	bh=iA0B3gs+fKlBWg5jSYfzc7MH5kde6ly60DrjWZEi2hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BqGu/A5yHW5Pc/8j0/erPYhuvaXyx7O6g80v/9eU7t45+t0/2aras7CWvo/tkFv27EHbzk/+2suvJkG6AdfhYKiuHT5nr/VAo5q/KpC+7m6CDZOfdVhQkZP1QDU1tobFmaA0EA1Z5JWHeSnjr9wDwoTC3cTzkDtG12oqvbTSkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJi1BqVk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477939321e6so2411715e9.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763125113; x=1763729913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fonN4XORu9kB4zZFGQ4ycucG5mwQsDuI6SHsKqHgqKc=;
        b=SJi1BqVk0WgK2qEzUmLRHZ575lQOoJUwQPMvfZwEv6tEP4t531qNhTmSOV3p78sbke
         wOEE0O/fOXLpAuH3okl9TikC6B/YGOA3D6Y3uZh8rFF7Gj2UFaUV1VDl5QAI8DYClVD+
         mbfyKtlsr2YreOguRdPF0Vja8Zp3MctEUOM6iP8vehpOlcng/oaGV1FaemQcvQi0fv5s
         SWaBxOewZP5mqpmAhoDL0lzeu+j5YnxJ3d/BULLzw54y2IARztLKLorq6n4IrcWCPLE8
         /dXvaReV01WK5wpFfMyTfm5lsoVQD1JLUSBX8cR4pgnRDH57lsv3sVogoYCiVww3Ov9v
         b5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763125113; x=1763729913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fonN4XORu9kB4zZFGQ4ycucG5mwQsDuI6SHsKqHgqKc=;
        b=VH43qFwYE6pBp4h32S5bnNsBL1j5vvEol3zGd474UT33wlZNstjXAWoIyJyRbf47AV
         19HncF/QBynARWix3lHmLRwnT5SI/xd0gy6hu5tQLjmFwU6kuaELmDYkPIwEKMwm6Ex2
         nU2790POkW2QmPwhtftwkkTH8jI2Zoq9Qqth3SbjtkD5IgkLxYiAhegeLS1bKaubY0Uh
         d4O6B04io2aOv2LH7WpMPYiD2nriX/oNs/Oxm0qYFWK/0Fj2TIw02PcvwA6Usy0sI0C4
         1gWLSlhLU4PCVovk0ua8n2LkGOQ9QaqokTjlJOqJUHkPobvMylXfIvbMMw9T2tF++jKM
         +2rw==
X-Forwarded-Encrypted: i=1; AJvYcCUsnSUbIJ171QOx1r/UJOBcTTtQ5IFmR814OoNgmjM/lPtoicTGTdZJCxGKUq8w0VrRFjZTW/eQvog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9O8I8YKucCGA/fa4Oe+SfVlQHx/BFHY7oqJiYk4e/Yq8N5Mpo
	t4M7kF+cz8AUpbe/LjyKNlV+fXnu2mvahN6sp6uflJTxevHHNrcm1fUmWnE5qSe3WXgpqvcof3g
	VNf/vkHw9dPD/FPONiQ==
X-Google-Smtp-Source: AGHT+IG2ECgXQJKqQsmQtOoG3o4r3rbEaGdM9qNWVQ/7abksmLYaocSL2QKZivyXJfCJ2v6fZgvJM/aIE1P9m6Y=
X-Received: from wmco18.prod.google.com ([2002:a05:600c:a312:b0:477:d21:4a92])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b5b:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-4778fe7cdccmr21897295e9.18.1763125112769;
 Fri, 14 Nov 2025 04:58:32 -0800 (PST)
Date: Fri, 14 Nov 2025 12:58:31 +0000
In-Reply-To: <20251110204119.18351-5-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110204119.18351-1-zhiw@nvidia.com> <20251110204119.18351-5-zhiw@nvidia.com>
Message-ID: <aRcnd_nSflxnALQ9@google.com>
Subject: Re: [PATCH v6 RESEND 4/7] rust: io: factor common I/O helpers into Io trait
From: Alice Ryhl <aliceryhl@google.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dakr@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	markus.probst@posteo.de, helgaas@kernel.org, cjia@nvidia.com, 
	smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com, 
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 10, 2025 at 10:41:16PM +0200, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct.
> 
> To establish a cleaner layering between the I/O interface and its concrete
> backends, paving the way for supporting additional I/O mechanisms in the
> future, Io<SIZE> need to be factored.
> 
> Factor the common helpers into a new Io trait, and move the MMIO-specific
> logic into a dedicated Mmio<SIZE> type implementing that trait. Rename the
> IoRaw to MmioRaw and update the bus MMIO implementations to use MmioRaw.
> 
> No functional change intended.
> 
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

This defines three traits:

* Io
* IoInfallible: Io
* IoFallible: Io

This particular split says that there are going to be cases where we
implement IoInfallible only, cases where we implement IoFallible only,
and maybe cases where we implement both.

And the distiction between them is whether the bounds check is runtime
or compile-time.

But this doesn't make much sense to me. Surely any Io resource that can
provide compile-time checked io can also provide runtime-checked io, so
maybe IoFallible should extend IoInfallible?

And why are these separate traits at all? Why not support both
compile-time and runtime-checked IO always?

I noticed also that the trait does not have methods for 64-bit writes,
and that these are left as inherent methods on Mmio.

The traits that would make sense to me are these:

* Io
* Io64: Io

where Io provides everything the three traits you have now provides, and
Io64 provides the 64-bit operations. That way, everything needs to
support operations of various sizes with both compile-time and
runtime-checked bounds, but types may opt-in to providing 64-bit ops.

Thoughts?

Alice

