Return-Path: <linux-pci+bounces-32152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 478DDB05A4F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 14:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D8E17F2C7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD02DEA84;
	Tue, 15 Jul 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSvGlIdR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F63274670
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582808; cv=none; b=U/UOnsu24Q1tVBXBeKX1pn1UyMVG2F7ebkhaOmdKADn4jIUNVGEhu9Wbbd4JOkUzK0BCClMxxjQ2qgETGSW7QD5nNbVpCXKxfbZBfOiwPPSfGAAYgQptKgGY7hRKJuEuhTmxoz5MajtPdKsHKXh48O2DBfPybQo/qVpdLpGbHVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582808; c=relaxed/simple;
	bh=I6i/EyKtu9kTeHVvimXGCXVSzCMMytdEC5VDydgz9wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMbDfmdNhlYiU2LzcLJUkRsS/Ad4ZQ4RU9MRHBrRNr5VLqpTb38HGEdvvzed8hfOcnMQ3Sf61F3KzObuyKexuRYVVixRwGkobhOKnsoSzXtMQZN6bi9z9IKZ+dHD6Yei7veHdkEAWAM1ut0C0rbjVDgE/cSjIEB09lk3vQ8eFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSvGlIdR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d6ade159so39002215e9.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752582805; x=1753187605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxJvXzNAx/wxcXJMnx0rqVWrH9gKkRzFrMsFLcWu9f4=;
        b=YSvGlIdRCBGTQXYI7PX2O77nbnREyCrdJA5UZqHUDJICCufmUytBCPjNG39NEzMfwe
         PyTv8aKS4S80oBpns4XDobfg6QyL9cLVLZHbs0IvkK0cpBoF5Et+sDkIxKSicTMt/exK
         kleA8PHdJNCOdDGUM9Lyma6l2mtUVjXoNEpdyF9t0mIDxZlPjtxdQzKoRfms66NL3ghp
         ujzYoFHyxTUOL7k8yfzwShzbrUxou5pLXvmztWdqDf0B2FQoBSqerGboIqXxSUpdpqf4
         Zv9c1wwKW31sfZQi5EhSmBl4XQbgY/ywnBG7GzFSuRkTc2wx0VY5Wd80/cqfLnLXpb5o
         yOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752582805; x=1753187605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxJvXzNAx/wxcXJMnx0rqVWrH9gKkRzFrMsFLcWu9f4=;
        b=jt7KcNIaPnMCDdQADP2uUA96hP9YYS+emKnlWr3LLzH4L4HQdM1sdf1cGk/bp2ZfYL
         5ZnW4NJ26s3GxvaSjBAEz9QuPmQyiKWUeFVd5x5NkWLI47e6ijdaa+sxhbcCq11GtzEJ
         0LVKxP1z+PHi08q1rNb5wS+HS0tfosSlUfuceZTNjIGNTUVaGb41+K8DP92Lcx1eT2U9
         5XhSKHRKyj3mW/M7BsV0ff0zNjxPnSSrzyPNo+l2v+C4GI5Ynb8+2MdEu8ihIn/ElXJH
         knixUEUJ352sw+0ILGDJ/NXbz2Lg9NstjRdAAUutmMC1fYTSj239joYglwJYqZZCXLBf
         2Rkg==
X-Forwarded-Encrypted: i=1; AJvYcCVxLot7HUCfxkGqPmNaYOeNTiFtWIrVJF7qj2iuukvqDeNl6KE2/gztZ9T9/38MELmR8pI5I7C5sCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbpv9nxKvniqGHTg4Tt5V8D+ZtPvFNrawSKE6HPvWFlIIXY/jv
	vRtmlLxn3Cu/B5c5XmbjRWKMab2+YLqwYtwWX56cnZRhJC8wRci4JCbL689X/zBH6xJkexQ85lS
	CNsjFgPbQhwWDUnSJZ4wgIuyAL2CR0Zf6q7B8pG9P
X-Gm-Gg: ASbGncu+izrCI53hQfxj92ykfeVCxiuiOWK9t3qvmYYsuvMM3fuYY2T1n6g/9bQiriS
	oGsV/Jcfku/ynIcWuae2GsiMIAHuSS+M2Xs7sgVxndEAB3HHu1wL6Km2aQrJNRZuTd/fa28oo7k
	ppwGvj7s/mNBYcsqc6javAp1zNqpxpLTL/6zu/KUphbVEpiwcFq5MeYJRofybZDHuMtilu9D0u5
	0/XkFM=
X-Google-Smtp-Source: AGHT+IHsSxt/ccfq3IS8RwrKiSzpaPPIWfXeSHZBLdgXWILdsWaDM5Ybin3kG0LyFIgWQPN/jFP74RS5jphBMvGLCBw=
X-Received: by 2002:a05:6000:1a86:b0:3a4:eda1:6c39 with SMTP id
 ffacd0b85a97d-3b5f2dc216dmr11909192f8f.13.1752582804862; Tue, 15 Jul 2025
 05:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
 <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org>
 <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
 <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <C72C6915-3BB2-431F-89ED-7743D8A62B7E@collabora.com>
In-Reply-To: <C72C6915-3BB2-431F-89ED-7743D8A62B7E@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Jul 2025 14:33:11 +0200
X-Gm-Features: Ac12FXzafqL5CgtuWo3knu-1K9vyMTCNfAik34wqBKJ35Mxv3Xe2G9Y-3oofZaA
Message-ID: <CAH5fLgibCtmgFpKNrC+jcSEqSUctyVMuYwEC0QSo+vzyDXK0zg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and handlers
To: Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 5:13=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi,
>
> >
> >>>
> >>>  (2) It is guaranteed that the device pointer is valid because (1) gu=
arantees
> >>>      it's even bound and because Devres<RegistrationInner> itself has=
 a
> >>>      reference count.
> >>
> >> Yeah but I would find it much more natural (and also useful in other
> >> circumstances) if `Devres<T>` would give you access to `Device` (at
> >> least the `Normal` type state).
> >
> > If we use container_of!() instead or just pass the address of Self (i.e=
.
> > Registration) to request_irq() instead,
>
>
> Boqun, Benno, are you ok with passing the address of Registration<T> as t=
he cookie?
>
> Recall that this was a change requested in v4, so I am checking whether w=
e are
> all on the same page before going back to that.
>
> See [0], i.e.:
> [0] https://lore.kernel.org/all/aFq3P_4XgP0dUrAS@Mac.home/

After discussing this, Daniel and I agreed that I will implement the
change adding a Device<Bound> argument to the callback. I will be
sending a patch adding it separately as a follow-up to Daniel's work.

Alice

