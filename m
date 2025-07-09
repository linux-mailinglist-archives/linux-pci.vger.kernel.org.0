Return-Path: <linux-pci+bounces-31777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C99BAFEBCF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 16:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE1A188780C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E92E267A;
	Wed,  9 Jul 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAXtNAZ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404DB2DFA39
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070801; cv=none; b=D3qjZK+l/LMGn6nHZAHhyoSFQ5nc4hWXhTXlzIpXfVBP0Db7lhe3dsU9dvAykKkUS6FGADc1cakSO5upvRfZ+ddli9ZmXSBPVioNNQtuhUxqbxR099ol4Jv0WvjleBQkt5LhsI2l/AfeXTO59QoyngxPub95umK3QUE9NMoFX8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070801; c=relaxed/simple;
	bh=onxQyqbXg2+8eNUdjRi8yLtGmLMnVsEDz+kKPNPRjAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jkf0zJ21eUTLgXbqp1G/hJXbdiCpPzj0LtQfPrhy2kYduNXn/y6ujr1AxTFAsANcxTj9PVRNcoOP+Wp1sELrsd3EbXs7m+iss7q80OJkdhTcx/MuyopH+cetz8k1U5n4f/yqn68eV2G17ydesJ9GIjnllUEG8wZcBjVmEs5QFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rAXtNAZ1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so4684156f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752070797; x=1752675597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onxQyqbXg2+8eNUdjRi8yLtGmLMnVsEDz+kKPNPRjAo=;
        b=rAXtNAZ1g38J888WZ3JPtxhSSjvhtdzBT1x84EFomAUxBE5XsMEuj5EzF1YBe0YK3R
         eRGUZdXOC6gmvdSzsmcuVT9w4YyX/YcmvUwbs2uSJ10DZA6UFZtVH45NGFbFOdNlizYo
         Na6SszQyri6aH4k0JkhSo7t69kDtPMvKDHtCUnOkB0oMJkdeCB4iv7jTrt31DSzDBSyB
         jAGmJ4jCVn8KXtonYHCJZRooTAhJ4bV3fq9ocZRwR62QuLAycEuOOb7I02DF0O1dYiUw
         uz7+9WjQObcbcMoPoXaEQr3U/ama0oJ4aHrqU1juD2cdJOVpbMwy4roMg6j5Qs8w5P1B
         iPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070797; x=1752675597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onxQyqbXg2+8eNUdjRi8yLtGmLMnVsEDz+kKPNPRjAo=;
        b=CelMbGR2bGS+MDOhKA+sx7AaKC25xrAJKZBS1ZxIdBzJVwRaLh3tBYOd6KdlHoBjP3
         9t700CYRxOJCKF5yxnrnz33zY486vnEZr//pPjeFDpH4BG1vPIT0MKfcK4UOAJhNEnNq
         vdNtTsoOR2nqTrvWRCQi309zvzBLII9PHj+Wn2eVI2ZHWOb/PRovUCgjavnuR1JAieFS
         hbI9DyCiE8EW6NtSB3gqUVVNFkMqVbiK/T2z3ZrXPGtGbLkhWXGoHefiukFh53wLy6p6
         +5C90TH+vsvqRvgELmHN6YDuSoBHwM1w7Mhu4ovyFjDYInKn/gTHfzJD4NuorGgAqeub
         sQlw==
X-Forwarded-Encrypted: i=1; AJvYcCXiWEj35KsB3fGTuQFCoMdkZh7zob8wiKnalq/vMQFDpauKuIQ3znlf5j+HaWdfiMT1rlVTGMrwzpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHW4K7CZDOE2i5Jhb02QQ1Kt2XlEQBPh+RSScHmI43/LaxW6EF
	KSyDXZwlU+hvcVXfYAU7PoTUjWIzqpnurEFXuxM2rnapFW4zFS2zLG+mCh7vSyY8awZ85qTiW3f
	WMbLjBkQX7tnBzrJE8fIHL8Pe6deKl488ZciYCTMq
X-Gm-Gg: ASbGncvMTAoS5neLz35kqRZrVUUUX+L58fMZlKogM87TQ+tpoEkZwwhiWP/Csphpk3J
	FCiWfO5Ub9CKKRFi/nXh9wJVRhFavYaiueCone+pFJNA7h37fx+xfxYoDEYSsfdsA5QEuQRBAMJ
	chG9LfsT5qrkhp/+BKdGHLREq7QudQ1aeqrj65DKALVSatSOJlTi6dduAEASrajNFvgDb0F9uxf
	w==
X-Google-Smtp-Source: AGHT+IHymgYqf5Be4dPgTGavXNkdAqtCHlNw8IloAmJ/sAoTV++LmztnNSzx86sJhSRZfMqHeXmmwb/R6uZnNJhr5Ts=
X-Received: by 2002:a05:6000:4712:b0:3b4:9721:2b13 with SMTP id
 ffacd0b85a97d-3b5e450988cmr2292725f8f.14.1752070796982; Wed, 09 Jul 2025
 07:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-device-as-ref-v1-1-ebf7059ffa9c@google.com> <DB7KZXKOP5F0.1RMMCBJNR43KO@kernel.org>
In-Reply-To: <DB7KZXKOP5F0.1RMMCBJNR43KO@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 9 Jul 2025 16:19:45 +0200
X-Gm-Features: Ac12FXzkjhW6iD-XDuQYdQEQJTvTDaPwURvqNJ0qQ1PU5t7-VlkiVmA2ozb6b7I
Message-ID: <CAH5fLghf1zwmR_hLVAxYU0khmeTGEejTL8qE_BaF3d-Ncg3HAg@mail.gmail.com>
Subject: Re: [PATCH] drm: rust: rename Device::as_ref() to Device::from_raw()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:07=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Wed Jul 9, 2025 at 3:53 PM CEST, Alice Ryhl wrote:
> > The prefix as_* should not be used for a constructor. Constructors
> > usually use the prefix from_* instead.
> >
> > Some prior art in the stdlib: Box::from_raw, CString::from_raw,
> > Rc::from_raw, Arc::from_raw, Waker::from_raw, File::from_raw_fd.
> >
> > There is also prior art in the kernel crate: cpufreq::Policy::from_raw,
> > fs::File::from_raw_file, Kuid::from_raw, ARef::from_raw,
> > SeqFile::from_raw, VmaNew::from_raw, Io::from_raw.
> >
> > Link: https://lore.kernel.org/r/aCZYcs6Aj-cz81qs@pollux
>
> I think the link you actually wanted to refer to is probably [1]. :)
>
> [1] https://lore.kernel.org/all/aCd8D5IA0RXZvtcv@pollux/

I can update.

> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Can you please split this patch up in one for the DRM renames, i.e. drm::=
Device,
> gem::Object and drm::File, and one for device::Device?

Sure I will split into two patches.

Alice

