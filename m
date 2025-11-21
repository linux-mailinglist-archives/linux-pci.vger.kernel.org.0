Return-Path: <linux-pci+bounces-41869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3129C7A25B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 15:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E9634F0363
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FABC346A07;
	Fri, 21 Nov 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxkENGpF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E6340D9A
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734818; cv=none; b=LApTWgRd/iZIxMoqSlidPUYP05G5BC/I4toqHU0iKxQORhWMgpHpUssUqkvwGJQ76KFleQel6l6WV47q3GDIkvTk0ZfukyE6vCJV55tnC5FR+gXAU4LqHqgSXnndMNmm/4iFSYYmiPWelcd3vUPdM1xyZ+NQ1GKNEeCvk/gwZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734818; c=relaxed/simple;
	bh=S44K+7M87mUDWzitlSfBz3IfX5X78T+NM19oZFlPoqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TjAbOCPxmSrUHJU9TT9SMTAJcJEg5f5tZj5WvPUbWFJOuBjSjjVX/ITD9ZvLshpCy66dZuBYwLqXb5prMCLyNkQr2BCM3gcJ/IxRbQge3uyuN9Jwy7Ch5GDpP7yyRRACj9Mf6AFkCETIJxtHE8WTBrNUBE4nFryaEij24zv93QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxkENGpF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779da35d27so26426115e9.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 06:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763734815; x=1764339615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bF0yy4kYcfJc00YYadClwGA4hfPDk8gPIn3KVtCTX2w=;
        b=uxkENGpF8ZQjmeaXr+DKREpMM+ezNZkAI6STgEy1X4iHLpJPBPY0DH7T+VX77oQQ1Q
         eBYwbBr7GMrLkJzKQMVxsoHfUWrgLsJ3+9Xi/mFM0kgVUeqOLbel2aAKCDVQs3YJFV3+
         puyExb23baqWC8H+Rgyz1wdvKy48QSa2IbDzzHFzXPIPZ/UWcScmFNb4KSJZ1xWaoavL
         aOE3lDzIa16Z17p2UepKsAPOzfHYbsMtVXb0HBr0fHrm/2CVcz5+NEhL02HF6a65jfvp
         cTCpDpIUtgFlDazdnPPNq/OWJGSVimv/c0be8CngImX635MsbmmEc6FJc/32o4nk9b1c
         yPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734815; x=1764339615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF0yy4kYcfJc00YYadClwGA4hfPDk8gPIn3KVtCTX2w=;
        b=eDCO5kRy+TcQYLKpkx0ObDv98L6BSmwUxMkcN6lm1BOlwKrEf+Tm1/PXQure1IubZ7
         b6qb2mOecdj0QXUzM+5dcG5p2AJVtElfzKh9t2iFRDcNcQpgPdL3g+wmy5Z8vIjha/v5
         fNvhfpTpieZw43gzuE1G1dxxrBoskuf48bPPXA8W9ph+kn2kQL5PxUBqT61lov30HGAP
         MDyq8fPMGg60Jo5xvN1WBqi/n9v69GpqGrYeW7jD1fITLwc+B7CldtXuHkxP/E18flz2
         nTloxuhKuhS6LVORvahhqWT6sLoTlZli7cXgN16pBm9tVUF6sCr2/n9EoQ+XVJmK5bSx
         s4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXWSXkkSpaC6/bK5/QYteDJqFEg0Vxs42xaQwQIDjmaYkyURtN2twDCsx6zVoNz/KESDpktBWOMuCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw8Spc6zv3m5JyJBRjGahGyznhD3kr8XIJewV3/44Eiemq48wp
	HKPvyVHWhSOt5DPFno1HJhXkO0wt4Rxo6KWC9CXWG5xU+XG7+6nyGdziB4U8LrFinl8NzfoY3LO
	YIF7S/4Fgh7VJN+q9Hw==
X-Google-Smtp-Source: AGHT+IHOOD4afO0MnsA4eFPhPWH6RGRFOOAgl0BEECmhcT6Gsttx5iYqEIkR92guCVGiooSMWjvF6Y8EbIyZtwQ=
X-Received: from wmbes8.prod.google.com ([2002:a05:600c:8108:b0:477:165e:7e2a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c15:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-477c01f5487mr36508565e9.30.1763734814799;
 Fri, 21 Nov 2025 06:20:14 -0800 (PST)
Date: Fri, 21 Nov 2025 14:20:13 +0000
In-Reply-To: <20251119112117.116979-4-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119112117.116979-1-zhiw@nvidia.com> <20251119112117.116979-4-zhiw@nvidia.com>
Message-ID: <aSB1Hcqr6W7EEjjK@google.com>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io trait
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

On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct.
> 
> To establish a cleaner layering between the I/O interface and its concrete
> backends, paving the way for supporting additional I/O mechanisms in the
> future, Io<SIZE> need to be factored.
> 
> Factor the common helpers into new {Io, Io64} traits, and move the
> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing that
> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implementations
> to use MmioRaw.
> 
> No functional change intended.
> 
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

I said this on a previous version, but I still don't buy the split
into IoFallible and IoInfallible.

For one, we're never going to have a method that can accept any Io - we
will always want to accept either IoInfallible or IoFallible, so the
base Io trait serves no purpose.

For another, the docs explain that the distinction between them is
whether the bounds check is done at compile-time or runtime. That is not
the kind of capability one normally uses different traits to distinguish
between. It makes sense to have additional traits to distinguish
between e.g.:

* Whether IO ops can fail for reasons *other* than bounds checks.
* Whether 64-bit IO ops are possible.

Well ... I guess one could distinguish between whether it's possible to
check bounds at compile-time at all. But if you can check them at
compile-time, it should always be possible to check at runtime too, so
one should be a sub-trait of the other if you want to distinguish
them. (And then a trait name of KnownSizeIo would be more idiomatic.)

And I'm not really convinced that the current compile-time checked
traits are a good idea at all. See:
https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/

If we want to have a compile-time checked trait, then the idiomatic way
to do that in Rust would be to have a new integer type that's guaranteed
to only contain integers <= the size. For example, the Bounded integer
being added elsewhere.

Alice

