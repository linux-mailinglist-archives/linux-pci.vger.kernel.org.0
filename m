Return-Path: <linux-pci+bounces-7695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA018CA500
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 01:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300201F217BC
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 23:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F92487B0;
	Mon, 20 May 2024 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpD+Y3cl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925E4502D;
	Mon, 20 May 2024 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247658; cv=none; b=Nqz7gqhQkNbCCXI3I/0BhZkyqtuxkrD8JmeKmBfxKC8oMr1GLroB6kkQeG0QXrx80y4Wi52K/ETl1D4Jrdyse7DUKZDafTAcUqVa2rhvkOTNJE8t75ji4WiHLiJCM1V9/e+nARdfwuYSKwt4FBeph/celTodv3xPpS2vMfh8mVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247658; c=relaxed/simple;
	bh=8QqgZxVf0288aHf9DZD/0Jyi87hO0+ha9iYcdXrU1lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf2iufG0H/r5P0i739xmBuyE2viK1lumNP6OC83jJ/q6enE09tHeKkIykXf3L/OxGJu3Y2URXKSjl0+9GJFaSLKKZtDIEL+2pKoDzPBwYaxecfNaccE8zR+n2a+cLflf9Rna4piTi0TCQoVe6OWcTR6DX+7ueNT/LGEDS8PWjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpD+Y3cl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ee12baa01cso98294615ad.0;
        Mon, 20 May 2024 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716247656; x=1716852456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XXQ+fW79Tox5jnZShvFqsN/aIVjF4mLnyQ2RqxwCuE=;
        b=FpD+Y3clwm0+wmaQ6zzG1pvW+qC05Uc5e+1aGYr5+wiazeJWTQ2K3T7NER04LrTXpR
         BxFpMkceuPWF/O1VNUtaAiQQKJedbgq22mnfO7grO4+rqJFy6g5IOMpGknWhl1mQf1KT
         bqLvQvB4l+tB8p2DufnhcRaUmmm8WKoTj5hjstpWg9YdQaT7shHj7GLUJw9KzXi6BKxP
         XDqfa8nDme6EPPQo2BwxNYU4eO9BYJeh6ZzhztexJ0dZCwTrCbq2e+t/pjgBuMsML3Ya
         1jB8Xpd7vXVmd6v5fSdiwE6p+4bUO+wz2cjskm4EsLB0O3Ku/l6fVAR+W2SUFuFlJiWL
         DtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716247656; x=1716852456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XXQ+fW79Tox5jnZShvFqsN/aIVjF4mLnyQ2RqxwCuE=;
        b=WgzocNp/ol4zGCyckaM2VhFWg/w5e2eo58Ys4vcfzVfKjmRuFGqO/9z5qO0Tp0ruG8
         +PVUWHTho8vDTF54abdokifm+OAA8O6hu2mPhGk+f7BlUprjNj1j/AtBXbDpeLeAbZQ1
         UAkfewVgqFjMFK4SdeNX88nhDDoA6k+ebZDAWsSQCVDwnAUWGU75GZP5kcbzER6UkSCX
         gAZJ8bGP2eOVGSCVREWD8haR0BrYT1PL+dvbiSse74Vvfl59StO6S7TM2xyrFl9SLLw6
         yj+euvms6kUgV+JctG5cqi9ma4Ax0Nmy+sMrUgr+Dr/ulIVnaRaaL+Ide55tRsfeIoh2
         r3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCCEqRpZU8cHxhQEBOZMEtXWSFYhHFAYbKpfVkNmfW5Qf+II+GZrX6kKb8hEO5KNnlLL1/c4xRpm6yjGxn05dKrUMY7e/6j/YdO3M99TV8J3gOA31XdxBTJj6F4IlonSTqVdbYiIlKeDPzpzzPUVaM0oxSsRwcwKYFYr8eHNNQ7lu5jy305NU=
X-Gm-Message-State: AOJu0YyOsH0kIxEsMwy50MsQGhICVJWQfDXj7athLEztx6wlT1DCxoG9
	4wNmuXjyfu3QC8+X2Lyfy8s4kAPRM94pSs17LTETrCfZjYEQnuY2oHJMOTEIUNVtnlxzaRaEFIk
	t5qLNTry4fw09wyIUC4OG0T29FLg=
X-Google-Smtp-Source: AGHT+IHHIgAAdRine/mHLO7k00sK/oImuclvCKPExA5xMVPtP+YugBCGaRo4B3DZZlCCYxf9oBS8H6lz+9iXaduvCeM=
X-Received: by 2002:a17:90a:c401:b0:2ac:40c8:1f00 with SMTP id
 98e67ed59e1d1-2b6cc566d69mr25208745a91.4.1716247655910; Mon, 20 May 2024
 16:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520172554.182094-1-dakr@redhat.com> <20240520172554.182094-12-dakr@redhat.com>
In-Reply-To: <20240520172554.182094-12-dakr@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 May 2024 01:27:23 +0200
Message-ID: <CANiq72kObXP7-YtcXnWQXJpEQ=N+RtcSeM6A+scBK00VkFj5JA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/11] rust: PCI: add BAR request and ioremap
To: pstanner@redhat.com, Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	ajanulgu@redhat.com, lyude@redhat.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

A few quick nits I noticed for this one...

On Mon, May 20, 2024 at 7:27=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> +/// A PCI BAR to perform IO-Operations on.

Some more documentation, examples, and/or references would be nice.

> +pub struct Bar {
> +    pdev: Device,
> +    iomem: IoMem,
> +    num: u8,
> +}
> +
> +impl Bar {
> +    fn new(pdev: Device, num: u8, name: &CStr) -> Result<Self> {
> +        let barnr =3D num as i32;

Would it make sense to use newtypes for `num`/`barnr`, perhaps?

> +        let barlen =3D pdev.resource_len(num)?;
> +        if barlen =3D=3D 0 {
> +            return Err(ENOMEM);
> +        }
> +
> +        // SAFETY:
> +        // `pdev` is always valid.

Please explain why it is always valid -- the point of a `SAFETY`
comment is not to say something is OK, but why it is so.

> +        // `barnr` is checked for validity at the top of the function.

Where was it checked? I may be missing something, but I only see a
widening cast.

> +        // SAFETY:
> +        // `pdev` is always valid.
> +        // `barnr` is checked for validity at the top of the function.
> +        // `name` is always valid.

Please use the convention we have elsewhere for this kind of lists,
i.e. use a list with the `-` bullet list marker.

> +        let ioptr: usize =3D unsafe { bindings::pci_iomap(pdev.as_raw(),=
 barnr, 0) } as usize;

Is the type needed, since there is an explicit cast?

> +        if ioptr =3D=3D 0 {
> +            // SAFETY:
> +            // `pdev` is always valid.
> +            // `barnr` is checked for validity at the top of the functio=
n.
> +            unsafe { bindings::pci_release_region(pdev.as_raw(), barnr) =
};
> +            return Err(ENOMEM);
> +        }

Should the region be managed in a RAII type instead?

> +    fn index_is_valid(i: u8) -> bool {
> +        // A pci_dev on the C side owns an array of resources with at mo=
st
> +        // PCI_NUM_RESOURCES entries.

Missing Markdown. There are other instances as well.

> +        if i as i32 >=3D bindings::PCI_NUM_RESOURCES as i32 {
> +            return false;
> +        }
> +
> +        true

The body of the function could just be `... < ...`, i.e. no `if` needed.

> +    // SAFETY: The caller should ensure that `ioptr` is valid.
> +    unsafe fn do_release(pdev: &Device, ioptr: usize, num: u8) {

This should not be a comment but documentation, and it should be a `#
Safety` section, not a `// SAFETY:` comment.

> +    /// Returns the size of the given PCI bar resource.
> +    pub fn resource_len(&self, bar: u8) -> Result<bindings::resource_siz=
e_t> {

Sometimes `bindings::` in signatures of public methods may be
justified -- is it the case here? Or should a newtype or similar be
provided instead? I only see this function being called inside the
module, anyway.

> +    /// Mapps an entire PCI-BAR after performing a region-request on it.

Typo.

Cheers,
Miguel

