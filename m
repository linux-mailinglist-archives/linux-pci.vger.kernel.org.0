Return-Path: <linux-pci+bounces-45031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFBD2FCF0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 11:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B993007FF8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 10:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845B35CB95;
	Fri, 16 Jan 2026 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npVRRZMb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAECB36167D
	for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560293; cv=none; b=BtWGGIe1jqIQAr3NkilRB6WGluuwd1w6wrOL7chJ2QyloUmLjMLz9oVY+xQzqqD4PyzrmKqdrI+K/WEewYx/kLeCe2Tsm+Q7QGJFB2QfGdckyZfHxTZdWIsGmCAFNy8BaFXRlbMnP/+ovwIVbGsjOP0p31PmYxxbUvpTGW5X9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560293; c=relaxed/simple;
	bh=b7fb2kg9k9dh+/1ZB4RW0gIF9ob0dRm04urz98QiGjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UoRasm9dpSr2P3RmrfgVW+5SHLlIx0s93RlFRUeWbe5ujX1+wYLwwrsz+RZlRzf4+sauDp1KoSu6IT7EB+5JCeAm9MpGPDV1IYxUIALkn+ZBesUJT+Jn2YZBXwuFf8mkXcGJ5aSBCLSvjdRfEWvxiEij82HmapsoVrqRT28cAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npVRRZMb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4801ad6e51cso12594945e9.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 02:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768560290; x=1769165090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUX7IRgIyUPb4V4ApOigl/qbJl9m0SFY99Aj6A7demw=;
        b=npVRRZMb1dp8pb4o5o1xfiNBcJfCavVVdZmQBJ8rvljYhOMRDl/VI5txkcmO4pBZ3I
         /KVSF9or2D4DhzYq9sIEHwG0UyMy/8rEuTg6Cq1vWUOMeFNuWk4onwEJC6Cyg31siZmC
         lkEqijfwO2WYaiARXRyN4eYrKVfSo3KUX0T60gdnmkh7w38ByzeOzCnTFn27yhMOrsIg
         HzJaYT0fFq/r1XNy+1RSDgZFGrZWv9uevLPV31blKloPeWEsDbpc3XzRa7npuep1Cf9e
         BejEez2DCN4LWOmXxSg8oRJFJbVAruLQH0itn99PPdlKowcScGojok4LrH2dS+7PFaod
         gLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768560290; x=1769165090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUX7IRgIyUPb4V4ApOigl/qbJl9m0SFY99Aj6A7demw=;
        b=HA9ecHysReTGyTRnkKx+QkbuPeUF5VahAeFQJaYoVTsBB5inmdKLr1UVAtetfCfJVr
         E6tGHVyGWf2eUpk0jpLu7LWW1kcaxoB4RLC7ojpb7gudlkf66mNxhyGzQ/LfcxgOnD8b
         SQnpzCXbU3rht7LY4jXTG0Y/4QmR1UMQluhlE1w3MV800jPfz8qtu+wm+lqiBv25G2DM
         QvuQJ2sqLcOmKcjnnL8G1tZBRHedAOSrq36u3Ucr2Q7PK4mzFPkhvoeRJgtPUjGCIfUl
         1jF0WRmcnEMpr5iDaZRhjBcLWWY17xEK4nGfLRNDWFL8paokp4/eD5Qistir6qzts1M3
         HO5A==
X-Forwarded-Encrypted: i=1; AJvYcCWzhdBM3ZbTcNnmys7li3976JSH3A+vm11lZGbicQDY4uqYTp3EtqOmrCR0re8xxxfy8a/Vj3oNKeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrosCEzW99BYbZfMLTxKMdgA6++jFikGWBFAO4qMzVtnj/e1jl
	g9MrpNa3QaQThiRftAzJbQgomVVVRJPhl18B3/2rzI1d2jQPLgTJhoZ1Zoz76x7ZAp9pc3AEeVC
	0YNpXI+Kj7E70/VKRVQ==
X-Received: from wmaq10.prod.google.com ([2002:a05:600c:6c8a:b0:47e:d9ed:20f0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c16a:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-4801e33c332mr30124455e9.25.1768560290048;
 Fri, 16 Jan 2026 02:44:50 -0800 (PST)
Date: Fri, 16 Jan 2026 10:44:46 +0000
In-Reply-To: <20260115212657.399231-3-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115212657.399231-1-zhiw@nvidia.com> <20260115212657.399231-3-zhiw@nvidia.com>
Message-ID: <aWoWntMxyhBc9Unx@google.com>
Subject: Re: [PATCH v9 2/5] rust: io: factor common I/O helpers into Io trait
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
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="utf-8"

On Thu, Jan 15, 2026 at 11:26:46PM +0200, Zhi Wang wrote:
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

> +pub trait IoBase {
> +pub trait IoKnownSize: IoBase {
> +pub trait Io: IoBase {
> +pub trait IoKnownSize64: IoKnownSize {
> +pub trait Io64: Io {

The following combinations are possible:

1. IoBase
2. IoBase + Io
3. IoBase + IoKnownSize
4. IoBase + Io + IoKnownSize
5. IoBase + Io + Io64
6. IoBase + Io + Io64 + IoKnownSize
7. IoBase + IoKnownSize + IoKnownSize64
8. IoBase + Io + IoKnownSize + IoKnownSize64
9. IoBase + Io + IoKnownSize + Io64 + IoKnownSize64

I'm not sure all of them make sense. I can't see a scenario where I
would pick 1, 3, 6, 7, or 8.

How about this trait hierachy? I believe I suggested something along
these lines before.

pub trait Io {
pub trait Io64: Io {
pub trait IoKnownSize: Io {

With these traits, these scenarios are possible:

1. Io
2. Io + Io64
3. Io + IoKnownSize
4. Io + Io64 + IoKnownSize

which seems to be the actual set of cases we care about.

Note that IoKnownSize can have methods that only apply when Io64 is
implemented:

trait IoKnownSize: Io {
    /// Infallible 8-bit read with compile-time bounds check.
    fn read8(&self, offset: usize) -> u8;

    /// Infallible 64-bit read with compile-time bounds check.
    fn read64(&self, offset: usize) -> u64
    where
    	Self: Io64;
}

Alice

