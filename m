Return-Path: <linux-pci+bounces-18739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E459B9F711F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7CB162E7C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF861FC0F2;
	Wed, 18 Dec 2024 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jh4OJuji"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FA189BBC
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565612; cv=none; b=AkYRPf33BZA8MvmO1aDU4CZOUM7Hxjg07lhazaH0szuPxxsaSZAmt8rnn+Yr5N5rBxcCy3wjHm6pOxEekpt1dVcbTYxZsAQNUaiE0ROHkebAcQKaFvVRhjclHVR0WfyoJuiyLZAhtsUWH3p7HWtYG23uGhukspPQ7HTPUSGJaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565612; c=relaxed/simple;
	bh=hHRydfUkl3vQlQdd77DMOcJmJEVI5aSlq9psSrcIL18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWqj5b9Apxbu+AGeLRm9Hlt0EYFyu8v8BQKMckFqezWLe1pzUQhIMVGMPUlp/C3fFveHT6UO7UOP2Ac0DeTotC2flURs3an/lTxLg/22k4xSpzz28SChcJzXYSuiJ43P8hfAnYELo8U/DkQUriKZnwjOc/WXzh3K60ezYRRI0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jh4OJuji; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43621d27adeso1365445e9.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 15:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734565608; x=1735170408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EtgKondHMyCR2GKtuPU0Jr6vHmmyanEzhmvLMFwiJk=;
        b=Jh4OJujiMogI1WTI8zUWKghRb4UNXStjHB7pt/2Rpq0kRwaFVJPeFJNlgTYT4ukcyA
         iDIMz2tzNZjr5Cf4mKghn6NgFEDC4sxrRyOpWULOSq6K148t+qkb7Ygkyle78ebtrMdh
         CgQJvRgPxX5bmGcXXVbxCGR9Pkp817tWHSbOxNjKxm7+DFGGc5ZLfHj1Xu7NPNtyDOtk
         6QI7Y/BFvmdGQgKcN1fVe7YKj6qWDtlA6mL6bssQeIXpQwPj+AWdnAFHcIhatSuDcP31
         w14PQUL0ZjOsyIgvUKUfZLM2YLd+klk6TeiO3YA10ZDAul+2tsNB1Xxoj/TsC/4/y4mu
         eIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734565608; x=1735170408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EtgKondHMyCR2GKtuPU0Jr6vHmmyanEzhmvLMFwiJk=;
        b=ddCyf/DaFm+Tve8nYasZcRspq9WQa51hPPropZ9BuxRlfUjk0tprrfeQoR4DhkCTv9
         jCv2MJsL+cijgORFw30XnixZJO3Nn3OPlYBG9vF5r2cc0LzEXsMk8weRXc6yLucnPisQ
         Q0Yh9ko5HrD7Sr5qCnXMlhZhZPJ2+ca8zCWQaidocK5eJCO8BPeT5UfDDOHcFsJbo4YM
         RYOfIWL0CpoUvNrswFh+MbAYyFJC8cOpSQJepQe+43phxRRuoKlu0a/pNv6i4iwePOvO
         yXZ1Kc65Dwb3l2/u/LyePIMmHfvx+zA4JKG6jAgpWxEOK4ylaLNim6eFaWXyznDbv1Le
         xy7w==
X-Forwarded-Encrypted: i=1; AJvYcCV1els8+ASAA2AR2G921IsQFwGFBEuc+jjLZ8UZJqU6MZaACJYmgdGomH3qCX+oYpJhWlz/pTgTt/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMhllVbyulfkq7iosEIjNAEUGVvXzBpxcb/TaE0rPmPQRkclY
	CDMo4EPNJeexSyqVt8wJrHaLgLwnt8+Oo5bri1ROAK+X8DRlZRd1kXdP3GawNJWKJHORZRqJxT6
	Z75Q2XjByRAGlp7wi66iOgj9BbEiU6fM2a2fmwA==
X-Gm-Gg: ASbGncuHHkuttbmJd7wEXeLxQ24rXbWMggdNPRvhqTxNQQeeN5OpgvdBhMjV5Zz6b7D
	O1+kRNCpJV4liFJUdfQWR8YCvUlqgmQfOvJeYx6gSKIg6o/KtvL7hk8p4k/l5QCI2NevPtQ==
X-Google-Smtp-Source: AGHT+IFdSRWS6hABEc0ngQXZkSTeaXUeFQin7xzEsoJY+YvCrNqTdEjMrPR7JYZTNaSfEHdQKpp4JYpxLPweGurGvW0=
X-Received: by 2002:a05:6000:1448:b0:386:41bd:53a3 with SMTP id
 ffacd0b85a97d-38a19b48ed1mr1069707f8f.50.1734565608190; Wed, 18 Dec 2024
 15:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212163357.35934-1-dakr@kernel.org>
In-Reply-To: <20241212163357.35934-1-dakr@kernel.org>
From: Fabien Parent <fabien.parent@linaro.org>
Date: Wed, 18 Dec 2024 15:46:37 -0800
Message-ID: <CAPFo5VKDsqR48OAjUSCKNZM2_28Upi0qH9f0gP5_472JBBBLPg@mail.gmail.com>
Subject: Re: [PATCH v6 00/16] Device / Driver PCI / Platform Rust abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, chrisi.schrefl@gmail.com, paulmck@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 8:34=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> This patch series implements the necessary Rust abstractions to implement
> device drivers in Rust.
>
> This includes some basic generalizations for driver registration, handlin=
g of ID
> tables, MMIO operations and device resource handling.
>
> Those generalizations are used to implement device driver support for two
> busses, the PCI and platform bus (with OF IDs) in order to provide some e=
vidence
> that the generalizations work as intended.
>
> The patch series also includes two patches adding two driver samples, one=
 PCI
> driver and one platform driver.
>
> The PCI bits are motivated by the Nova driver project [1], but are used b=
y at
> least one more OOT driver (rnvme [2]).
>
> The platform bits, besides adding some more evidence to the base abstract=
ions,
> are required by a few more OOT drivers aiming at going upstream, i.e. rvk=
ms [3],
> cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].
>
> The patches of this series can also be [7], [8] and [9].
>
> Changes in v6:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Module:
>   - remove patch to pass the module name in `Module::init`
>   - add a patch adding the `ModuleMetadata` trait to retreive the module =
name
>
> - Driver:
>   - generate module structure within `module_driver!`, such that we get a=
 unique
>     module type for which `ModuleMetadata` can be implemented to retreive=
 the
>     module name
>   - let `Adapter::of_id_table` return `Option<of::IdTable<Self::IdInfo>>`
>
> - Platform:
>   - change type of `platform::Driver::OF_ID_TABLE` to `Option<of::IdTable=
>`
>
> - RCU:
>   - add RCU abstraction to MAINTAINERS file
>
> - MISC:
>   - pick up a couple of RBs
>
> Changes in v5:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Opaque:
>   - add `Opaque::pin_init`
>
> - Revocable:
>   - use const generic instead of bool in `revoke_internal`
>   - don't open code things with `Opaque::try_ffi_init`, use
>     `Opaque::pin_init` instead
>
> - Driver:
>   - fix `DriverOps` -> `RegistrationOps` in commit message
>   - fix signature of `register` and `unregister` to take an
>     `Opaque<T::RegType>` instead of a mutable reference
>   - implement generic `driver::Adapter`
>
> - ID table:
>   - fix `module_device_table!` macro, according to commit 054a9cd395a7
>    (modpost: rename alias symbol for MODULE_DEVICE_TABLE())
>
> - PCI:
>   - remove `pci::DeviceId` argument from probe()
>   - provide `vendor_id` and `device_id` accessor functions
>   - use `addr_of_mut!` for the device in probe()
>
> - OF:
>   - move OF `IdTable` type alias from platform.rs to of.rs
>
> - Platform:
>   - use `addr_of_mut!` for the device in probe()
>   - move generic OF code to `driver::Adapter`
>
> - MISC:
>   - rebase onto latest rust-next (-rc2)
>
> Changes in v4:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Revocable
>   - convert `Revocable::data` to `Opaque`
>   - introduce `revoke_nosync`, which does not wait for an RCU grace perio=
d
>   - fix minor typo
>
> - Device ID
>   - fix ID table export name to always be unique
>   - remove `#![allow(stable_features)]`
>   - move `#![allow(const_refs_to_cell)]` to the "stable in 1.83" list
>
> - I/O
>   - split `Io<SIZE>` in `IoRaw<SIZE>` and `Io<SIZE>`
>   - add rust helper for ioremap() and iounmap() (needed by doctests)
>
> - Devres
>   - optimze `drop` by using `revoke_nosync` (we're guaranteed there are n=
o more
>     concurrent users, hence no need to wait for a full grace period)
>
> - OF
>   - rename "Open Firmware" -> "Device Tree / Open Firmware" (Rob)
>   - remove unused C header reference
>   - add TODO comment to loop in `DeviceId::new`
>   - remove `DeviceId::compatible`; was only used in sample code
>   - add missing `#[repr(transparent)]`
>   - use #[cfg(CONFIG_OF)] for the relevant functions
>
> - PCI
>   - let Rust helper for pci_resource_len() return resource_size_t
>
> - PCI Sample
>   - remove unnecessary `from_le`
>
> - Platform
>   - fix example compatible string
>   - add example for `platform::Driver`
>   - rename `ID_TABLE` to `OF_ID_TABLE`
>   - don't allow public use of `of_match_table`; convert to `of_id_info` t=
o
>     retrieve the `of::DeviceId` to gather the corresponding `IdInfo`
>   - remove wrong example reference in the documentation of `platform::Dri=
ver`
>   - remove `as_dev`, as we already implement `AsRef` for `platform::Devic=
e`
>
> - Platform Sample
>   - fix compatible string; add corresponding entry to drivers/of/unittest=
-data/tests-platform.dtsi
>   - remove usage of `of_match_table`
>
> - MISC
>   - fix a few spelling mistakes
>   - rebase onto rust-next (v6.13-rc1)
>
> Changes in v3:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - add commits for `Opaque::try_ffi_init` and `InPlaceModule`
> - rename `DriverOps` to `RegistrationOps`
> - rework device ID abstractions to get rid of almost all macro magic (tha=
nks to
>   Gary Guo for working this out!)
>   - this is possible due to recently stabilized language features
> - add modpost alias generation for device ID tables
>   - unfortunately, this is the part that still requires some macro magic =
in the
>     device ID abstractions
> - PCI
>   - represent the driver private data with the driver specific `Driver` i=
nstance
>     and bind it's lifetime to the time of the driver being bound to a dev=
ice
>     - this allows us to handle class / subsystem registrations in a clean=
er way
>   - get rid of `Driver::remove`
>     - Rust drivers should bind cleanup code to the `Drop` implementation =
of the
>       corresponding structure instead and put it into their driver struct=
ure for
>       automatic cleanup
>   - add a sample PCI driver
> - add abstractions for `struct of_device_id`
> - add abstractions for the platform bus, including a sample driver
> - update the MAINTAINERS file accordingly
>   - currently this turns out a bit messy, but it should become better onc=
e the
>     build system supports a treewide distribution of the kernel crate
>   - I didn't add myself as maintainer, but (if requested) I'm willing to =
do so
>     and help with maintenance
>
> Changes in v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - statically initialize driver structures (Greg)
> - move base device ID abstractions to a separate source file (Greg)
> - remove `DeviceRemoval` trait in favor of using a `Devres` callback to
>   unregister drivers
> - remove `device::Data`, we don't need this abstraction anymore now that =
we
>   `Devres` to revoke resources and registrations
> - pass the module name to `Module::init` and `InPlaceModule::init` in a s=
eparate
>   patch
> - rework of `Io` including compile time boundary checks (Miguel, Wedson)
> - adjust PCI abstractions accordingly and implement a `module_pci_driver!=
` macro
> - rework `pci::Bar` to support a const SIZE
> - increase the total amount of Documentation, rephrase some safety commen=
ts and
>   commit messages for less ambiguity
> - fix compilation issues with some documentation examples
>
> [1] https://gitlab.freedesktop.org/drm/nova/-/tree/nova-next
> [2] https://github.com/metaspace/linux/tree/rnvme
> [3] https://lore.kernel.org/all/20240930233257.1189730-1-lyude@redhat.com=
/
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git/log=
/?h=3Drust/cpufreq-dt
> [5] https://github.com/AsahiLinux/linux
> [6] https://github.com/Fabo/linux/tree/fparent/rust-i2c
> [7] https://github.com/Rust-for-Linux/linux/tree/staging/rust-device
> [8] https://github.com/Rust-for-Linux/linux/tree/staging/rust-pci
> [9] https://github.com/Rust-for-Linux/linux/tree/staging/dev
>
> Danilo Krummrich (14):
>   rust: module: add trait `ModuleMetadata`
>   rust: implement generic driver registration
>   rust: implement `IdArray`, `IdTable` and `RawDeviceId`
>   rust: types: add `Opaque::pin_init`
>   rust: add `io::{Io, IoRaw}` base types
>   rust: add devres abstraction
>   rust: pci: add basic PCI device / driver abstractions
>   rust: pci: implement I/O mappable `pci::Bar`
>   samples: rust: add Rust PCI sample driver
>   rust: of: add `of::DeviceId` abstraction
>   rust: driver: implement `Adapter`
>   rust: platform: add basic platform device / driver abstractions
>   samples: rust: add Rust platform sample driver
>   MAINTAINERS: add Danilo to DRIVER CORE
>
> Wedson Almeida Filho (2):
>   rust: add rcu abstraction
>   rust: add `Revocable` type
>
>  MAINTAINERS                                  |  10 +
>  drivers/of/unittest-data/tests-platform.dtsi |   5 +
>  rust/bindings/bindings_helper.h              |   3 +
>  rust/helpers/device.c                        |  10 +
>  rust/helpers/helpers.c                       |   5 +
>  rust/helpers/io.c                            | 101 +++++
>  rust/helpers/pci.c                           |  18 +
>  rust/helpers/platform.c                      |  13 +
>  rust/helpers/rcu.c                           |  13 +
>  rust/kernel/device_id.rs                     | 165 +++++++
>  rust/kernel/devres.rs                        | 179 ++++++++
>  rust/kernel/driver.rs                        | 174 ++++++++
>  rust/kernel/io.rs                            | 260 +++++++++++
>  rust/kernel/lib.rs                           |  20 +
>  rust/kernel/of.rs                            |  60 +++
>  rust/kernel/pci.rs                           | 438 +++++++++++++++++++
>  rust/kernel/platform.rs                      | 198 +++++++++
>  rust/kernel/revocable.rs                     | 223 ++++++++++
>  rust/kernel/sync.rs                          |   1 +
>  rust/kernel/sync/rcu.rs                      |  47 ++
>  rust/kernel/types.rs                         |  11 +
>  rust/macros/module.rs                        |   4 +
>  samples/rust/Kconfig                         |  21 +
>  samples/rust/Makefile                        |   2 +
>  samples/rust/rust_driver_pci.rs              | 110 +++++
>  samples/rust/rust_driver_platform.rs         |  49 +++
>  26 files changed, 2140 insertions(+)
>  create mode 100644 rust/helpers/device.c
>  create mode 100644 rust/helpers/io.c
>  create mode 100644 rust/helpers/pci.c
>  create mode 100644 rust/helpers/platform.c
>  create mode 100644 rust/helpers/rcu.c
>  create mode 100644 rust/kernel/device_id.rs
>  create mode 100644 rust/kernel/devres.rs
>  create mode 100644 rust/kernel/driver.rs
>  create mode 100644 rust/kernel/io.rs
>  create mode 100644 rust/kernel/of.rs
>  create mode 100644 rust/kernel/pci.rs
>  create mode 100644 rust/kernel/platform.rs
>  create mode 100644 rust/kernel/revocable.rs
>  create mode 100644 rust/kernel/sync/rcu.rs
>  create mode 100644 samples/rust/rust_driver_pci.rs
>  create mode 100644 samples/rust/rust_driver_platform.rs
>
>
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> --
> 2.47.1
>

Tested on arm64 as dependency for my own series:
https://lkml.org/lkml/2024/12/18/1358

Tested-by: Fabien Parent <fabien.parent@linaro.org>

