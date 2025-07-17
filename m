Return-Path: <linux-pci+bounces-32410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3129DB09197
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A29E164449
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643C32FC3D7;
	Thu, 17 Jul 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GYV33WQV"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862572FC019;
	Thu, 17 Jul 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769283; cv=pass; b=l2ess61jVePFyFjKhuryHshLPFcYLJV9K1L2lzJF/0KaJJIvOLbDxtcrNCsZytDHhyiPL9JWPGlr3ZROUwSukrh6Qq+O4dFQUT/iUXcXmbNBPnDzRJZUaFw544VZYLQw/Ao1n1tpbr6P8ivPRmWtfPQX/vTR5K+rLX/1ISQSyLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769283; c=relaxed/simple;
	bh=xxLi7VZ6XfF9oiVfbnH3WcSEfX/GBfKqxLKORZPRKCE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gf78NDq6ePSII3k0sSYmf7+Ae6AbpFUjtAxvdQPBqCGkq3uM0F+YQD+NhS1euvfKIrauUjSbra/grzoZ5X5AsUEjr75MWaGi4MO/Zvegea5z23zGSdk5KgRce+p6+WiA8+mWclzs3CM1W8y2PgHA8tppuf8Z3uKrLOIFoZiHfVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GYV33WQV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752769242; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hqHJaKVpcklVJ5ujh9TyZ1C2RwXLMFcCZzuhcZDDHBJI468tyUwj269ewOZWBRbKgJKTHuyiP0P56hXruY64UjCiVMmDnqKEbNISs6hrDCXNEF8RfvKvlNDojtg3IlnW9CF8p64u5rigVKZW2UH3uM4AqMwC1lkAsWgj4H+blvU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752769242; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cT2kqEKsp8nlH01nlREn5zAQtGgkfbFDvedreAfAxps=; 
	b=Hd9LoJa7pXFft2ocoaDzl+jGNFnH2nOsFCiMpfr0i3pPP1fddApqggMjKEvx3CMuqFl5Pd/6Qu1mjpiWTpycdCqx1T0sj6XQLJjgzMtKL9WUrZfH+rjFoXL+iNp+nVWv1AbNNGnFCC3LvOePt0VuwGb2jcMHyhjBa2CDLhUt5cY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752769242;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=cT2kqEKsp8nlH01nlREn5zAQtGgkfbFDvedreAfAxps=;
	b=GYV33WQVtsv9ltqXLJYvexwmlcFEEFES7LzghTw2Qe6DI6JTfqNJOh4u1XQ9rqXt
	igXxKt1gbYFWE/y9YrtYREOmmnqPRD/RzNuaBOkT+RyHpMArOrEJMkEi4qiZZllOXAL
	SVmiU4w0ZVjJ3OwK+eSEc7iVQz8r7vBgmxJMvwCQ=
Received: by mx.zohomail.com with SMTPS id 1752769238879669.4169784081596;
	Thu, 17 Jul 2025 09:20:38 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <202507170718.AVqYqRan-lkp@intel.com>
Date: Thu, 17 Jul 2025 13:20:20 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <helgaas@kernel.org>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9834736F-F70F-4290-9DE8-755A6D0D5EB8@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <202507170718.AVqYqRan-lkp@intel.com>
To: kernel test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 16 Jul 2025, at 20:45, kernel test robot <lkp@intel.com> wrote:
>=20
> Hi Daniel,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on 3964d07dd821efe9680e90c51c86661a98e60a0f]
>=20
> url:    =
https://github.com/intel-lab-lkp/linux/commits/Daniel-Almeida/rust-irq-add=
-irq-module/20250715-232121
> base:   3964d07dd821efe9680e90c51c86661a98e60a0f
> patch link:    =
https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-3-d469c0f37c=
07%40collabora.com
> patch subject: [PATCH v7 3/6] rust: irq: add support for non-threaded =
IRQs and handlers
> config: x86_64-rhel-9.4-rust =
(https://download.01.org/0day-ci/archive/20250717/202507170718.AVqYqRan-lk=
p@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project =
87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=3D1 build): =
(https://download.01.org/0day-ci/archive/20250717/202507170718.AVqYqRan-lk=
p@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: =
https://lore.kernel.org/oe-kbuild-all/202507170718.AVqYqRan-lkp@intel.com/=

>=20
> All errors (new ones prefixed by >>):
>=20
>>> error[E0425]: cannot find value `SHARED` in module `flags`
>   --> rust/doctests_kernel_generated.rs:4790:58
>   |
>   4790 |     let registration =3D Registration::new(request, =
flags::SHARED, c_str!("my_device"), handler);
>   |                                                          ^^^^^^ =
not found in `flags`
>   |
>   help: consider importing this constant
>   |
>   3    + use kernel::mm::virt::flags::SHARED;
>   |
>   help: if you import `SHARED`, refer to it directly
>   |
>   4790 -     let registration =3D Registration::new(request, =
flags::SHARED, c_str!("my_device"), handler);
>   4790 +     let registration =3D Registration::new(request, SHARED, =
c_str!("my_device"), handler);
>   |
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20

This is a single character fix, so I am waiting for the discussion on =
the cover
letter [0] to advance before sending a new version.

[0] https://lore.kernel.org/all/DBCQKJIBVGGM.1R0QNKO3TE4N0@kernel.org/#t=

