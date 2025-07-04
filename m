Return-Path: <linux-pci+bounces-31520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419FAF8EB0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 11:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979023B9705
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1092BEFE1;
	Fri,  4 Jul 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQHbbdf2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E42328AE4;
	Fri,  4 Jul 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621510; cv=none; b=ec7cDSLoTFgYej7fsgM7zAlk+2XcQY6QdVnPMS5m36hMZvIjXjq0G1yRiGGwIEXCTxg/vwcVJ+iPi9IiFv7PVn4HYglSmuEiQBxOhZGvmr0XzOqUS27RaMbC8VwFx3McruLm2MMbYIqpcWG/d5hA+DzJ5GKjPDK58BbMlHwhCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621510; c=relaxed/simple;
	bh=d/MO04WOV1NKnJM6X29x0Vs3JojE3h50l+YSvo1LTLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJNkAuSAgCemLXFtPfIS66SCSxrXOeW4/2yLQpENPCitgia/dc30+b0uLv+PIDSbBA7cS+q6Qyk8FKKJOcN79lAwuMXMcN000ZLGxx7XON43zZmn1PWGhUNZSjs7aC3gOYYrQAJVlsfY3VIF0dungsf73X7LisleYvnbu+j+ITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQHbbdf2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23c71b21f72so1274315ad.2;
        Fri, 04 Jul 2025 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751621508; x=1752226308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/MO04WOV1NKnJM6X29x0Vs3JojE3h50l+YSvo1LTLc=;
        b=BQHbbdf21W5hD4xFpH1NDVkR3OyReLHUNB37l07qwYd++s3lMVfWMlH1cxW9Tkh8Ok
         PEq/AEY8Q+ULQTAE/Kk5A1mQ+6RiQ3nq0nqGfaCPl7ZqBuap+8MOaD4C6f/x8irn7b89
         j6gi2YvCANj5n/x3CZEp9rA3nY//cKsFcYnpAfQA5XN6hMWRWitHREqoSsYKXv4gE76r
         6ZNAOshiYsnxCC4qyvwsmF6xEEC4IdEb/IqYEsse4Uqy/u6Pf5OUhEsUWnKpnW5NBtfa
         2rsyTDSlfUAoQJ/+0KH4v8oHNwYKnTr2bFx2/5fR45ih9b5aEjrcTZJHj0UkGEdclbn0
         BmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751621508; x=1752226308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/MO04WOV1NKnJM6X29x0Vs3JojE3h50l+YSvo1LTLc=;
        b=qvnbtYe+yfs/43nlqzHmkKk9/kP5rqCFZ7BztrJFzbYXxZ4qNlamdfQb/SbtEbxRZ7
         OF16rnEC0M9EutZCEErg935r59d3vLMIFtHm8auy6uWdeOGzpdjD2tsHTIobjhdEKdrh
         IJIx8houWIPm/rnWijOZFQQbalJFwWMndI29P2ut9PIVjYrtfcl+NR1+24juVap/xTgY
         tneLcryPe2rl28U+mHA8VxPIPctTAAtpcgm5vKoGKY4q5FblBLZugJXJklIeuKWyypMH
         De2r1n4DcuKJ30HAUHRc7EV1oFOHMP8JdpxQeWe1PzAJwfF+ht6ByxsikKEA4SDBB/Ps
         QSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7w7nEvWpPc19Sdk2s1wqCg5YUjwQYN2XYFSPwwyzkF1+rHXK+ce5uDyVfVV4MmihgY04NTVo4X7pq@vger.kernel.org, AJvYcCXnJwydPZq2LgrZvbpybcqAVslYAukPiRLfibxBg3YtTT8anTv2hlVhSi2x7o21a+AcnfCQM/DwU4S/4dK2xAM=@vger.kernel.org, AJvYcCXsOHVna8mFyW3NGULxKI3KgYgVbM00sNa0VipoLzECE2mkhIuY/DlZuhJc27QXmhfVagZdWTf4UF6w7n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNWyHg8rNk8VRlg8NIRRzLnn+9IjsQa3vHX5/xcAV+5u1nqAo
	i0FfoVM+5L3HvQMlbgJKWDi2Qh+jQ0SnKT5M6keW+Ba2JuCA2Tedl3Ct6kIeKldLpnMcdG+rxR8
	JEYBoM23uM1VuFZv3Drrv+2FkaqDDaE0=
X-Gm-Gg: ASbGncuHE3cRh4PqUq6mWNpjj7nICINoFfVMzv7fZ2sU0SCjZxuXGqgtHRbSEuq7kA/
	cNCKPXLSahaxi4w/cdi5fO6ZuQ4uzslMmqtqAo/bcTycx3KIe0xB4zskDGOp79ASxq4PRSj4YbX
	Q0kRzWiVA/2i1YVQjpTBiQBn8JkRUdg8Gm0i/4n6ibvdU=
X-Google-Smtp-Source: AGHT+IGZgZIOOC5V45OzgF9nVnkAkyYapdLuVvpdWtNopyjN8VdZsEMtsXDqfVWiZu81PQxveBrb5ac1J46HVQwP484=
X-Received: by 2002:a17:90b:17d0:b0:312:e9d:3fff with SMTP id
 98e67ed59e1d1-31aacb4118emr974079a91.1.1751621508473; Fri, 04 Jul 2025
 02:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-2-74103bdc7c52@collabora.com> <fcdae3ca-104d-4e8b-8588-2452783ed09a@sedlak.dev>
In-Reply-To: <fcdae3ca-104d-4e8b-8588-2452783ed09a@sedlak.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Jul 2025 11:31:34 +0200
X-Gm-Features: Ac12FXxOPwNdMLG_SDYv3paQWeciOf5zRBzImQn-zzRgaYYgawpcpeWIjIF2lJE
Message-ID: <CANiq72mA3c-gs5CZ5F2U6zkWU=X7kHcgWVsvXkHpvv9mXeoY2Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] rust: irq: add flags module
To: Daniel Sedlak <daniel@sedlak.dev>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 8:14=E2=80=AFAM Daniel Sedlak <daniel@sedlak.dev> wr=
ote:
>
> Why not Flags(u32)? You may get rid of all unnecessary casts later, plus
> save some extra bytes.

Yeah, avoiding the casts would be nice -- however it is done.

On the patch: it wouldn't hurt to add an example for each of the
operators too. Even better if it is a common use case of each (say,
for `|`, a common combination of these flags).

(By the way, the use of the `into_inner()` name here is another one we
will want to discuss for the new naming guidelines table.)

Thanks!

Cheers,
Miguel

