Return-Path: <linux-pci+bounces-29520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E44AD678B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 07:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF54417AA70
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 05:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6071E503C;
	Thu, 12 Jun 2025 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKo4Kmwu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6501CD208;
	Thu, 12 Jun 2025 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749707884; cv=none; b=subuOFNPCRNLe5eUxkwAuq2ysmOyxIaNN+W7C54U1S6a+WUVWHgrGrAFwYSYgXiC9ybErdFBZa1fx09miXaJgo4RyfKuo9sszln4QXh/J6oFNvg/0itrPm2oTveR7+fNCEIf1XvGI6VLQvyYJxO8uovOhAErQUiaKMF+snOuFPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749707884; c=relaxed/simple;
	bh=t9DFAXafbBpQoxbSD83zR7atzKmCC3qmxfog0a69E0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDNLpeDRb383L12ALda4yLZXb8jLJxvTt39OfVCzI58F/AT40pDNeS+Eor2csp6ujrFji6kNQCY+N8lcPhgsES8PRp+YCPGVHfYAii+6/v8YvVVi6gSVG2KJHA9dHBiL2BHotZ+Per+omolp2vNqsvvC3+zdFnArh8MPzyZyCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKo4Kmwu; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e79de9da3fso152927137.1;
        Wed, 11 Jun 2025 22:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749707881; x=1750312681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dib0fsbbn+uZXprI82x5KfkaUX4XukaqcnHt4XTNnyM=;
        b=kKo4KmwukSM4Ze9WZJMQHH8r1AtSJ10xNAC9AdFs9fh5y4hHFQiiV0DsSp4u0hrGb0
         yHxMxnAK4y9rZF/+TQSvfqjKcEVwW+qA+M6hMAxxO4PZ0d61gApOCWqg5OoYWcliklIz
         4wnVffV3HrekT8dKFd/QJNhw8l1zZoNIqbf7OcFUforQLod6w0+QifcClJ9ZiyVW29pM
         s1klnTfzb9j3o04IHqXSXat1b6sRTZF3Gzm13N7+QSBFmcG4Q3mdWv09VCkZ0/09HUcm
         SMySaXS2lxpenntV55Cvv11iJhO9B/o7g7dqvPpqyLpdXnDUBzJwS6ry4MTKGxMjGjXq
         6ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749707881; x=1750312681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dib0fsbbn+uZXprI82x5KfkaUX4XukaqcnHt4XTNnyM=;
        b=sh8JQaiKql+2l8ggVeL24IIlzba+uyPxd2fzKCvB0LHR5mi0t7tX+zrB4O1zTp5H2u
         rWcrFU5vXraCuanGeo4tve5zamopSnIieKd0caLFUks+zUkzdKD7oSCPu/WQy+J2UH0g
         K4B+nc85WENA9GaQP1rW2zMy9Hyhk+ucYnXFN72aoCHWGm5Zs6GG/yT4irGYXmtfzvYD
         koGdFvk3DUtHvoGODG6Brgj/FCf0cGVTfSQAd06J2+Hgt3THN47f0rJcBc5xEEHmDfpD
         3OG3rXduCAUurihoc6vxAmAbiHYPAp5TlAAcbHNWcmM6wmPEYamFTIeYFXCb2uFFas/K
         Uuww==
X-Forwarded-Encrypted: i=1; AJvYcCX2OHEF7C2osQwJo0XvKtoGBxgekVq6zPCcSu2i5uWRpQ+vYPeeusiY6JJ8G+MtKaETVafMhGdBJ4JL6kX+@vger.kernel.org, AJvYcCXPL3WsjmlXnj7XQXsWsUZgYNPGyqX2VCPuf75TrlgV3PGJIkgTsHAHzAckNVcDNQ+oQTNzkxrgLpjhz7XA/8M=@vger.kernel.org, AJvYcCXX7njLMwthuVHUAZ4P0ixVKgdp9ptnZXXvcn1kslk1Zm4wVIUkqUe+Q8nsLHwCnd98CocXaEEB5C9P@vger.kernel.org, AJvYcCXd8KymPMPPAEmLJt+m7UjmasVhvoo0TQ5BNAyS0suS08HzmPVB4ZPIzF99ENvWlDP8iHiKHRB89jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGR+T1AMpwuTmD1xaJ6SX1qBbrklYXVxEeEWUweMxXu+60JAMA
	2ByWEUy5jZVT9FHsxUpeQsWXufK3bXkNUUu1WtFy8cF40ohKcszHnEl0gqQSKQt0eetnhUWBHAw
	BBpob8TNR9qVGH5YNOF8lQJ8Ycz+9lnkXbA==
X-Gm-Gg: ASbGnct91msfw5fo2YQB5g/+UlXWL5kdnmaBHmYweN06N8D41vVsznCny5StCNyV5vk
	tgb6L/QupkmE7CgIX4VfGcFSDlLqwRDkPteKz2zH4QBW0H9WbIfO1uxhzSy7Ko5In1vIbQMU2IZ
	arlN88oqcZC/g1OcwbFMjO0nm1TeKFmY8E6fUmr+qVN+t+6yrAiCHmki40tExwWwg7rdJuUqoeS
	9gOjzKLK1PL
X-Google-Smtp-Source: AGHT+IGEMavk70qt3RuGIQr9WWZqlaa9jeDDSPgh/mflwaCkoGhyuwH7XuQ9rwMUz29WMtYJkcGpnIdZhJ5FDM5VvC0=
X-Received: by 2002:a05:6102:54a9:b0:4e6:d784:3f7 with SMTP id
 ada2fe7eead31-4e7ce8ef245mr1335838137.15.1749707881321; Wed, 11 Jun 2025
 22:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me> <20250611143737.00005e21@huawei.com>
In-Reply-To: <20250611143737.00005e21@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Jun 2025 15:57:35 +1000
X-Gm-Features: AX0GCFsV5zkqcbRQLFy6YRBBC2YdwkRh-jAXFTHtjbwkFiyZkLQYm_5yhcXUlIo
Message-ID: <CAKmqyKNpqUp8zBSKzmUVaeVnLkWi3VK7_UBqvgrF7Yp2ZYs6MA@mail.gmail.com>
Subject: Re: [RFC v2 00/20] lib: Rust implementation of SPDM
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alistair Francis <alistair@alistair23.me>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, ojeda@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, gary@garyguo.net, 
	alex.gaynor@gmail.com, benno.lossin@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:56=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 27 Feb 2025 13:09:32 +1000
> Alistair Francis <alistair@alistair23.me> wrote:
>
> > Security Protocols and Data Models (SPDM) [1] is used for authenticatio=
n,
> > attestation and key exchange. SPDM is generally used over a range of
> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >
> > From the kernels perspective SPDM is used to authenticate and attest de=
vices.
> > In this threat model a device is considered untrusted until it can be v=
erified
> > by the kernel and userspace using SPDM. As such SPDM data is untrusted =
data
> > that can be mallicious.
> >
> > The SPDM specification is also complex, with the 1.2.1 spec being almos=
t 200
> > pages and the 1.3.0 spec being almost 250 pages long.
> >
> > As such we have the kernel parsing untrusted responses from a complex
> > specification, which sounds like a possible exploit vector. This is the=
 type
> > of place where Rust excels!
> >
> > This series implements a SPDM requester in Rust.
> >
> > This is very similar to Lukas' implementation [2]. This series includes=
 patches
> > and files from Lukas' C SPDM implementation, which isn't in mainline.
> >
> > This is a standalone series and doesn't depend on Lukas' implementation=
, although
> > we do still rely on Lukas' crypto preperation patches, not all of which=
 are
> > upstream yet.
> >
> > To help with maintaining compatibility it's designed in a way to match =
Lukas'
> > design and the state struct stores the same information, although in a =
Rust
> > struct instead of the original C one.
> >
> > This series doesn't expose the data to userspace (except for a single s=
ysfs
> > bool) to avoid the debate about how to do that. I'm planning to do that=
 in
> > the future though.
> >
> > This series is based on the latest rust-next tree.
> >
> > This seris depends on the Untrusted abstraction work [4].
> >
> > This seris also depends on the recent bindgen support for static inline=
s  [5].
> >
> > The entire tree can be seen here: https://github.com/alistair23/linux/t=
ree/alistair/spdm-rust
> >
> > based-on: https://lore.kernel.org/rust-for-linux/20240925205244.873020-=
1-benno.lossin@proton.me/
> > based-on: https://lore.kernel.org/rust-for-linux/20250107035058.818539-=
1-alistair@alistair23.me/
>
> Hi Alastair,
>
> I've completely failed to find time to actually pick up enough rust to re=
view
> this :(  Also failed to find anyone else who has the rust skills and enou=
gh of
> the background.
>
> Ideally I'll get up to speed at some point, but in the meantime wanted to=
 revisit
> the question of whether we want to go this way from day 1 rather than try=
ing to
> deal with C version and later this?

My feeling is that if the C version is merged first, there is going to
be very little appetite to later replace it with a Rust version. So if
we do want a Rust version, then it should be merged soon-ish.

But, no one seems super excited by a Rust implementation. I didn't get
a resounding yes from anyone, including Rust devs, but I did get a few
no's.

So in the current environment I don't see this progressing.

>
> What's your current thoughts?  I know Lukas mentioned he was going to spi=
n a
> new version shortly (in one of the TSM threads) so are we waiting on that=
?

I saw that Lukas is working on a netlink version. That's great to see
and hopefully will address the comments from LPC last year. That
should also pave the way to getting SPDM support upstream.

I currently don't have time to convert the Rust version to use netlink
and I'm not convinced it's worth the effort as there appears to be
little enthusiasm for this at the moment.

Maybe in the future this is something that can be picked up

>
> For now I'm going to take this off my review queue. Sorry!

No worries! Thanks for letting me know

Alistair

>
> Jonathan
>
>
>
> >
> > 1: https://www.dmtf.org/standards/spdm
> > 2: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/
> > 3: https://github.com/l1k/linux/commits/spdm-future/
> > 4: https://lore.kernel.org/rust-for-linux/20240925205244.873020-1-benno=
.lossin@proton.me/
> > 5: https://lore.kernel.org/rust-for-linux/20250107035058.818539-1-alist=
air@alistair23.me/
> >
> > v2:
> >  - Drop support for Rust and C implementations
> >  - Include patches from Lukas to reduce series deps
> >  - Large code cleanups based on more testing
> >  - Support support for authentication
> >
> > Alistair Francis (12):
> >   lib: rspdm: Initial commit of Rust SPDM
> >   lib: rspdm: Support SPDM get_version
> >   lib: rspdm: Support SPDM get_capabilities
> >   lib: rspdm: Support SPDM negotiate_algorithms
> >   lib: rspdm: Support SPDM get_digests
> >   lib: rspdm: Support SPDM get_certificate
> >   crypto: asymmetric_keys - Load certificate parsing early in boot
> >   KEYS: Load keyring and certificates early in boot
> >   PCI/CMA: Support built in X.509 certificates
> >   lib: rspdm: Support SPDM certificate validation
> >   rust: allow extracting the buffer from a CString
> >   lib: rspdm: Support SPDM challenge
> >
> > Jonathan Cameron (1):
> >   PCI/CMA: Authenticate devices on enumeration
> >
> > Lukas Wunner (7):
> >   X.509: Make certificate parser public
> >   X.509: Parse Subject Alternative Name in certificates
> >   X.509: Move certificate length retrieval into new helper
> >   certs: Create blacklist keyring earlier
> >   PCI/CMA: Validate Subject Alternative Name in certificates
> >   PCI/CMA: Reauthenticate devices on reset and resume
> >   PCI/CMA: Expose in sysfs whether devices are authenticated
> >
> >  Documentation/ABI/testing/sysfs-devices-spdm |   31 +
> >  MAINTAINERS                                  |   14 +
> >  certs/blacklist.c                            |    4 +-
> >  certs/system_keyring.c                       |    4 +-
> >  crypto/asymmetric_keys/asymmetric_type.c     |    2 +-
> >  crypto/asymmetric_keys/x509_cert_parser.c    |    9 +
> >  crypto/asymmetric_keys/x509_loader.c         |   38 +-
> >  crypto/asymmetric_keys/x509_parser.h         |   40 +-
> >  crypto/asymmetric_keys/x509_public_key.c     |    2 +-
> >  drivers/pci/Kconfig                          |   13 +
> >  drivers/pci/Makefile                         |    4 +
> >  drivers/pci/cma.asn1                         |   41 +
> >  drivers/pci/cma.c                            |  272 +++++
> >  drivers/pci/doe.c                            |    5 +-
> >  drivers/pci/pci-driver.c                     |    1 +
> >  drivers/pci/pci-sysfs.c                      |    3 +
> >  drivers/pci/pci.c                            |   12 +-
> >  drivers/pci/pci.h                            |   15 +
> >  drivers/pci/pcie/err.c                       |    3 +
> >  drivers/pci/probe.c                          |    1 +
> >  drivers/pci/remove.c                         |    1 +
> >  include/keys/asymmetric-type.h               |    2 +
> >  include/keys/x509-parser.h                   |   55 +
> >  include/linux/oid_registry.h                 |    3 +
> >  include/linux/pci-doe.h                      |    4 +
> >  include/linux/pci.h                          |   16 +
> >  include/linux/spdm.h                         |   39 +
> >  lib/Kconfig                                  |   16 +
> >  lib/Makefile                                 |    2 +
> >  lib/rspdm/Makefile                           |   11 +
> >  lib/rspdm/consts.rs                          |  135 +++
> >  lib/rspdm/lib.rs                             |  180 +++
> >  lib/rspdm/req-sysfs.c                        |   97 ++
> >  lib/rspdm/state.rs                           | 1037 ++++++++++++++++++
> >  lib/rspdm/sysfs.rs                           |   28 +
> >  lib/rspdm/validator.rs                       |  489 +++++++++
> >  rust/bindgen_static_functions                |    5 +
> >  rust/bindings/bindings_helper.h              |    7 +
> >  rust/kernel/error.rs                         |    3 +
> >  rust/kernel/str.rs                           |    5 +
> >  40 files changed, 2587 insertions(+), 62 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
> >  create mode 100644 drivers/pci/cma.asn1
> >  create mode 100644 drivers/pci/cma.c
> >  create mode 100644 include/keys/x509-parser.h
> >  create mode 100644 include/linux/spdm.h
> >  create mode 100644 lib/rspdm/Makefile
> >  create mode 100644 lib/rspdm/consts.rs
> >  create mode 100644 lib/rspdm/lib.rs
> >  create mode 100644 lib/rspdm/req-sysfs.c
> >  create mode 100644 lib/rspdm/state.rs
> >  create mode 100644 lib/rspdm/sysfs.rs
> >  create mode 100644 lib/rspdm/validator.rs
> >
>

