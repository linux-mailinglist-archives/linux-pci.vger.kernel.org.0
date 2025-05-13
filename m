Return-Path: <linux-pci+bounces-27609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38621AB4BAF
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 08:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE9316FCE0
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909F51E8324;
	Tue, 13 May 2025 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqMxZau9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3421E5729;
	Tue, 13 May 2025 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116563; cv=none; b=PpzZj2os+g0v7JEgEuJ0BPwee5eN5Bw1q3Dlhy7MTL3O4zZGBIpm27UcWB8LwFxgF8lfMBJBclk0jHNQwX5oVlldZxmzXCKHtJhQdDRUuBOumGXbJahoWYUlV+793FYZtm/H5hC3QZGvv70H0g9KF9NotFQKJtF7LaUGEtCFPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116563; c=relaxed/simple;
	bh=Hmx8otWf9AOsg//ZAqhxQIypiCudbdqpzPydYKjqlA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFN8EbFxQIA81A+FJ2u8Gprjcaq/DV6udh3d3XwoOqSdSVMRz6MXBADEHFGumDblbjkF5Rc/W7xzYxzQovltwfqnmW9VnC/JVzd0BRNyrX8sNp0NYy4vhQUuEEotNdckhJ+f1XA2Z7lW0wwzK21clQWOo+oziiAHvF4K5G2ev1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqMxZau9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747116562; x=1778652562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hmx8otWf9AOsg//ZAqhxQIypiCudbdqpzPydYKjqlA0=;
  b=bqMxZau9tIuMibrb2giVUHqw5Gt9HAiXyKH4pZmeLL+ZrsSfpI3hy0RZ
   AMLQpyv93Vdq92uBeOpQQafxgjwlS+lUIduHUti4XFV8eD+dJxEn3ds/c
   NqMknPStn0/EXZEPheOcwFTTBmyOZdpVZs7MS+Lnp69ZuOw8WMeyVNays
   G2chYwbW3bZ/LZzGBDKPPtW3+ez5e/Bo+fD3yrF/ItJezKHOtHYhBakLd
   oUoe61gmrZ0XuqiaJu+KVT89mRsXHjHmRURkfTyWC3V1ibMTsXJFqMmeM
   CbHGa9yDmQBJ2GZEdsO5Dw33JB+INCiNDgE4GuukhzMpa5f8gLxqMXa+4
   A==;
X-CSE-ConnectionGUID: YEvoeCuvQoitCnKzIFCkjQ==
X-CSE-MsgGUID: sgErWSuDTcitBc8CzePCew==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59946159"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59946159"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 23:09:21 -0700
X-CSE-ConnectionGUID: D2SUU/18SAukkO4owmYMcw==
X-CSE-MsgGUID: tdkg41Z3QSqlZ0e3f8ip+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="160866821"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 May 2025 23:09:14 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEipE-000FlH-1H;
	Tue, 13 May 2025 06:09:12 +0000
Date: Tue, 13 May 2025 14:09:11 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Ballance <andrewjballance@gmail.com>, dakr@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, akpm@linux-foundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, raag.jadav@intel.com,
	andriy.shevchenko@linux.intel.com, arnd@arndb.de, me@kloenk.dev,
	fujita.tomonori@gmail.com, daniel.almeida@collabora.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 04/11] rust: io: add PortIo
Message-ID: <202505131314.ozIwFdR4-lkp@intel.com>
References: <20250509031524.2604087-5-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509031524.2604087-5-andrewjballance@gmail.com>

Hi Andrew,

kernel test robot noticed the following build errors:

[auto build test ERROR on 92a09c47464d040866cf2b4cd052bc60555185fb]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Ballance/rust-helpers-io-use-macro-to-generate-io-accessor-functions/20250509-111818
base:   92a09c47464d040866cf2b4cd052bc60555185fb
patch link:    https://lore.kernel.org/r/20250509031524.2604087-5-andrewjballance%40gmail.com
patch subject: [PATCH 04/11] rust: io: add PortIo
config: x86_64-randconfig-073-20250512 (https://download.01.org/0day-ci/archive/20250513/202505131314.ozIwFdR4-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505131314.ozIwFdR4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505131314.ozIwFdR4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find function `inb` in crate `bindings`
   --> rust/kernel/io.rs:481:26
   |
   481 |         read8_unchecked, inb, write8_unchecked, outb, u8;
   |                          ^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `outb` in crate `bindings`
   --> rust/kernel/io.rs:481:49
   |
   481 |         read8_unchecked, inb, write8_unchecked, outb, u8;
   |                                                 ^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `inw` in crate `bindings`
   --> rust/kernel/io.rs:482:27
   |
   482 |         read16_unchecked, inw, write16_unchecked, outw, u16;
   |                           ^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `outw` in crate `bindings`
   --> rust/kernel/io.rs:482:51
   |
   482 |         read16_unchecked, inw, write16_unchecked, outw, u16;
   |                                                   ^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `inl` in crate `bindings`
   --> rust/kernel/io.rs:483:27
   |
   483 |         read32_unchecked, inl, write32_unchecked, outl, u32;
   |                           ^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `outl` in crate `bindings`
   --> rust/kernel/io.rs:483:51
   |
   483 |         read32_unchecked, inl, write32_unchecked, outl, u32;
   |                                                   ^^^^ not found in `bindings`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

