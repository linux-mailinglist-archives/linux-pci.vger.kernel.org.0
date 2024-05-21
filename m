Return-Path: <linux-pci+bounces-7708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254748CAA97
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 11:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945631F2274D
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F755C29;
	Tue, 21 May 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsFmmGOE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D542EB1D;
	Tue, 21 May 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283099; cv=none; b=PZSKkf5WH/FnEamiU7oIR3IU9/xYo3FBOfwxWpH2BSh+R7PGNnyFw3z85HkpztU6m4bosZUbbPt/ay138L8wzABHJpVG9Yn1bSE5EY95IL/FuWEyNuZVFma5mROu42qPn62zPmQ2Zpmv29gVnqjRlId8cEyMWM7WCl+J5RcLMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283099; c=relaxed/simple;
	bh=evIKBeDjrjIyrHQrE6yLoAQSN9K9vIdfXRpSaiKjBgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lo24sDu/byA9YSvJsJwpM4vrhZCg64aaL9I8NFchZkQkCq99crRJjFtJLYCXNwJPSSUx3PM9M36/ScwfbJXT9yyN/ieVtmXpXZtjECnkSo8phj7i8Zl6BEdWbkAws9tcinlOdsRlI4SL5CFr01KAwPtzV7AyXpdxc2Mtt23qm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsFmmGOE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so106299215ad.1;
        Tue, 21 May 2024 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716283097; x=1716887897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evIKBeDjrjIyrHQrE6yLoAQSN9K9vIdfXRpSaiKjBgE=;
        b=FsFmmGOEC/VhY0UUXUWBNpzNjtvFmEfMl3npl973KK7v+92QY7xSWH8phaAOQeZd1r
         1o4m/wncg2yy6V1dBctSYohnyOBOMZGcoFIn3HmbfuZCz0UWQfrKaO1GtYBwtspe0ws7
         Q/aEPMM20YB58OffunAPcoVJjRnxIc2H5E9k4k8UND8dURoD0+4FcDBWB0nmA1DE9ZXS
         uzNfssLVprmuxh2tElgkRbYr/RrEZaDM63ArcEYsMT/tAMb0djl1EnlKXbh2Bprsnac4
         bEucmxJS9bR09XK0yfjEOcdOHVQxJ7fFTJhpK0wG8IBQvuVoSbKn1eQYk6aRlLuVYKz3
         sF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716283097; x=1716887897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evIKBeDjrjIyrHQrE6yLoAQSN9K9vIdfXRpSaiKjBgE=;
        b=AosQKbJ4XKolCiyW9z3X5/aulE+WV6E/4DOUHhtWgve0jsKdx/G+W7YfglRmqtmtSj
         ojrjq+ROZnyy2xiZQF+aiIYgRsId2lbrVZzFPciW8QBYMyi2cyscDMwTmEGhkndPeL4R
         HxknI6dBEvWDjSvib8wzmEmbu41oe0HNj/UKsnD6/f7sC5nS5SXm837Hz6zEAOGDxVj9
         7ijh+lUM9OoCZCTfFS5APAaHe7+o9ZEpSOqxDGXX3FMUUfduCNfFi4trRJ+l/cn6sF70
         sY2dHB8/OJdOack7YqXp9Uz3qFqrP6OnsT6kQKh59T9VjCpNWFqLcmJKbV7895xEGb2C
         4UAg==
X-Forwarded-Encrypted: i=1; AJvYcCUV5aVN8sUq6a/QOmkHHgPU+xNUZh2Yj9oPvdNY3bBj/hye+tDjZZgvl78fkoteMo3splLuB/mAlE+Maxj9ZFW+Qs/gF3Gx3AekBn5m08eqireICG/aeYjkNCve4MBePZgaB+krDbtTSBxA56c/cL17lPXVYbkwStDtsFjv8o2exRYSu61FgRk=
X-Gm-Message-State: AOJu0YxRdCn7E16TDRNIG1zem0kobVUI+Cogv+RDdq1G8oCAuNMurVgu
	jEKviECqyYFdZEW3uvWUT1E6CjgUEJUDuaChdf9M9Wm968397MbtMs1XcrxxJd5chUW9aXvQdIj
	YzamfY2vvnUYtY6haCyN2yoFSOis=
X-Google-Smtp-Source: AGHT+IFieXXoG+hRo4v8ZQFVy0FPx0LzOZqLI2NQxeJ8z3p0jf0pXavFZ5ZiMD9/R71xHVho3OeDGCXPVB6CXwJTom4=
X-Received: by 2002:a17:90b:100d:b0:2b6:2ef4:e2aa with SMTP id
 98e67ed59e1d1-2b6cc780466mr24891904a91.25.1716283097622; Tue, 21 May 2024
 02:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520172554.182094-1-dakr@redhat.com> <20240520172554.182094-11-dakr@redhat.com>
 <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com> <cf89c02d45545b67272aba933fbc8a8a0df83358.camel@redhat.com>
In-Reply-To: <cf89c02d45545b67272aba933fbc8a8a0df83358.camel@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 May 2024 11:18:04 +0200
Message-ID: <CANiq72k7H3Y0ksdquVsrAbRtj_5CqMCYfo79UrhSVcK5VwfG5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem operations
To: Philipp Stanner <pstanner@redhat.com>
Cc: Danilo Krummrich <dakr@redhat.com>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, 
	lina@asahilina.net, ajanulgu@redhat.com, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:36=E2=80=AFAM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> Justified questions =E2=80=93 it is public because the Drop implementatio=
n for
> pci::Bar requires the ioptr to pass it to pci_iounmap().
>
> The alternative would be to give pci::Bar a copy of ioptr (it's just an
> integer after all), but that would also not be exactly beautiful.

If by copy you mean keeping an actual copy elsewhere, then you could
provide an access method instead.

If you meant the access method, it may not be "beautiful" (Why? What
do you mean?), but it is way more important to be sound.

> The commit message states (btw this file would get more extensive
> comments soonish) that with this design its the subsystem that is
> responsible for creating IoMem validly, because the subsystem is the
> one who knows about the memory regions and lengths and stuff.
>
> The driver should only ever take an IoMem through a subsystem, so that
> would be safe.

The Rust safety boundary is normally the module -- you want that
subsystems cannot make mistakes either when using the `iomem` module,
not just drivers when using the subsystem APIs.

So you can't rely on a user, even if it is a subsystem, to "validly
create" objects and also hope that they do not modify the fields later
etc. If you need to ask subsystems for that, then you need to require
`unsafe` somewhere, e.g. the constructor (and make the field private,
and add an invariant to the type, and add `INVARIANT:` comments).

Think about it this way: if we were to write all the code like that
(e.g. with all structs using public fields), then essentially we would
be back at C, since we would be trusting everybody not to touch what
they shouldn't, and not to put values that could later lead something
else into UB, and we would not even have the documentation/invariants
to verify those either, etc.

> Yes, if the addition violates the capacity of a usize. But that would
> then be a bug we really want to notice, wouldn't we?

Definitely, but what I wanted is that you consider whether it is
reasonable to have the panic possibility there, since it depends on a
value that others control. For instance, would it make sense to make
it a fallible operation instead? Should the panic be documented
otherwise? Could it be prevented somehow? etc.

Please check Wedson's `io_mem` in the old `rust` branch for some ideas too.

Cheers,
Miguel

