Return-Path: <linux-pci+bounces-24436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A780FA6C8F0
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 11:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFE11899259
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8A1E3DD0;
	Sat, 22 Mar 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="As+i6puU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561B1EBFE4;
	Sat, 22 Mar 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638150; cv=none; b=rN9+mkeCJ1DLfJujsDWGfW5K+ovLlLARxGynYpAgN6ZBvB/BpM+goVB5o9y0va6t/zaTJRT1qNgQbRWGFfGMrJ1RvSBu0Fl+QtPCv7K/2IePSq6e70l7TUtqd/cE3BHRVgCOwHXdQ5LujcG0qSI11kLqmKNLYbh0e2V+G2Bo3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638150; c=relaxed/simple;
	bh=Hdv42PI+SQv5JUjnRTSo8idtKkWDywJe2XkqlGKHXbk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1z8UkmyJhPqzjsfZn2JuCkdbyXbuZJfrxEVB2JmHC7F9q0tK5IH90y+2FzhljjzfAt3aJUTlVYi5H8NS9iB9vgGVb/Ap7lfMOBmEdPapgznWNc067MjIN8KsZsMyrTuqiN4v45pFg+qoOEY9Fv5wrAQVkT9Li7aAeii9aJ2M6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=As+i6puU; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742638138; x=1742897338;
	bh=ZFFKz10EMacfDB3xAKr3jPI1Qcnx3CwnTAUEEkeCMJo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=As+i6puUOChqNYwjfuQbipHqiHnACG+UwFrA+edTl42+0UFiXWTzD4tcgdaGwMqLU
	 8cu8mBWPDyKg4fu5zvg8aLH9COXNyWd7D2vEiQU5hr0UKwsuFq9qAjD1z8N1sUvZ6p
	 sRYKDRiub1ZX2qHx1VV7djzTwPKnP1N8Ha6VtRrOMJ9PUiapxHj/T/tqxr04TRPBfk
	 MJZt0KwVBayBmwVaQCOuqnh1ZTGu5+gzqYjSi/3dj/+jto6XCYlfFAw+CkNg4fqrfT
	 44rcKBAZomTosmwdCDQhkwJXCf0iOK8jidYdlPUkFKq76bnI9PmW2LRcHX7dxTHuRe
	 V5zRzmShxw5+g==
Date: Sat, 22 Mar 2025 10:08:53 +0000
To: kernel test robot <lkp@intel.com>, Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <D8MPNRAYNZIS.T7U3XLKHN523@proton.me>
In-Reply-To: <202503220040.TDePlxma-lkp@intel.com>
References: <20250320222823.16509-4-dakr@kernel.org> <202503220040.TDePlxma-lkp@intel.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dfc469007ca1960c05e3b75300ee8c8b99f6f5a4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 21, 2025 at 5:56 PM CET, kernel test robot wrote:
> Hi Danilo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 51d0de7596a458096756c895cfed6bc4a7ecac10]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/r=
ust-device-implement-Device-parent/20250321-063101
> base:   51d0de7596a458096756c895cfed6bc4a7ecac10
> patch link:    https://lore.kernel.org/r/20250320222823.16509-4-dakr%40ke=
rnel.org
> patch subject: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::=
Device
> config: x86_64-buildonly-randconfig-005-20250321 (https://download.01.org=
/0day-ci/archive/20250322/202503220040.TDePlxma-lkp@intel.com/config)
> compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c=
2d9b7e4de40d0804dd374721e6411c27d1d1)
> rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250322/202503220040.TDePlxma-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503220040.TDePlxma-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    ***
>    *** Rust bindings generator 'bindgen' < 0.69.5 together with libclang =
>=3D 19.1
>    *** may not work due to a bug (https://github.com/rust-lang/rust-bindg=
en/pull/2824),
>    *** unless patched (like Debian's).
>    ***   Your bindgen version:  0.65.1
>    ***   Your libclang version: 20.1.1
>    ***
>    ***
>    *** Please see Documentation/rust/quick-start.rst for details
>    *** on how to set up the Rust support.
>    ***
>>> error[E0133]: use of extern static is unsafe and requires unsafe block
>    --> rust/kernel/pci.rs:473:43
>    |
>    473 |         if dev.bus_type_raw() !=3D addr_of!(bindings::pci_bus_ty=
pe) {
>    |                                           ^^^^^^^^^^^^^^^^^^^^^^ use=
 of extern static
>    |
>    =3D note: extern statics are not controlled by the Rust type system: i=
nvalid data, aliasing violations or data races will cause undefined behavio=
r

This is just a minor annoyance with these error reports, but I would
very much like the error to have the correct indentation:

>> error[E0133]: use of extern static is unsafe and requires unsafe block
    --> rust/kernel/pci.rs:473:43
        |
    473 |         if dev.bus_type_raw() !=3D addr_of!(bindings::pci_bus_typ=
e) {
        |                                           ^^^^^^^^^^^^^^^^^^^^^^ =
use of extern static
        |

Would that be possible to fix? That way the `^^^^` align with the item
they are referencing.

Otherwise they are very helpful!

---
Cheers,
Benno


