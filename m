Return-Path: <linux-pci+bounces-27606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E35CBAB4909
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 04:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C097146403E
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E139619992D;
	Tue, 13 May 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPRFafg7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428F1991CA;
	Tue, 13 May 2025 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101600; cv=none; b=eP4bLaOWlaxCkiqjn7VFS4Kwx97unsisyLVutCnS1MD/GkwTIaPYO5e1qFz0YsUo+mfjn8FpEa/pInPPi4c+V6BUP2FtEov5IAAwpKADjlnlcqU58mYZvzOC9Kfeb6vbNM9uff6HqieH4LLHBQWbWCKHX8Qo/tWKXELicYO8o2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101600; c=relaxed/simple;
	bh=WcrSmSlSjmHVcZ3HD2/qTAxVlXG+sQlwOjuClfwPBi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/ZFWza9DDQRhoi7bsnNBW/bbCB6w47v2k9Ck//LkYne2lvgc4OXIJNt00yUAvIEjJOIZecDipO7eFhueyg3W1ZrSPPb5DFTNZ1jKQR63vNYnvSnvJlDqSIyJt+wq4xpzqE8i4tAA9BbJV94NGKHieMRSqZBS8Zea/uGsWH4q/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPRFafg7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747101599; x=1778637599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WcrSmSlSjmHVcZ3HD2/qTAxVlXG+sQlwOjuClfwPBi8=;
  b=OPRFafg7X9QfFyMNCR/cMp1wNjGOlF+TXz2w/jYJP7RTbzQADgq9CW1U
   erX/3WIuj+hkG+8Buv+Gz4a0SbtMVx+YahTFKJDHxhxpbPTENcj9WN7T4
   sM+vlyckBNC+v3CgGT1SsVnGjiBNFHMbPzMmYuEijCuq8b3pmU2CrlOLM
   aqEx0ckPIcrVTwCVILO0JIs7g17Tn4k2KMNraJugtGVPLiMEzeGIoQikZ
   IJAXOOMwOQT6CF+QG9kj7B4jMO1yWqcZl/+82bhUKx2t91NwhMKMlpUWS
   rIPra+Kmwl8sGKwNdPfQZPOSADW3O3OB/5luxxza3wY2HVRFJFgoDB3iZ
   Q==;
X-CSE-ConnectionGUID: Kk6CNmTiR767ZoqMOxK7gQ==
X-CSE-MsgGUID: Z4Sbq9EWSnilxdkAUBDcWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59928337"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59928337"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 18:59:58 -0700
X-CSE-ConnectionGUID: mzr8htMGRjaIDmb/NxuA0w==
X-CSE-MsgGUID: apClmqaPSfix6Pw7S7DIcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="137957128"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 May 2025 18:59:51 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEevt-000FaB-00;
	Tue, 13 May 2025 01:59:49 +0000
Date: Tue, 13 May 2025 09:59:13 +0800
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
Subject: Re: [PATCH 01/11] rust: helpers: io: use macro to generate io
 accessor functions
Message-ID: <202505130821.z5LcD77G-lkp@intel.com>
References: <20250509031524.2604087-2-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509031524.2604087-2-andrewjballance@gmail.com>

Hi Andrew,

kernel test robot noticed the following build errors:

[auto build test ERROR on 92a09c47464d040866cf2b4cd052bc60555185fb]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Ballance/rust-helpers-io-use-macro-to-generate-io-accessor-functions/20250509-111818
base:   92a09c47464d040866cf2b4cd052bc60555185fb
patch link:    https://lore.kernel.org/r/20250509031524.2604087-2-andrewjballance%40gmail.com
patch subject: [PATCH 01/11] rust: helpers: io: use macro to generate io accessor functions
config: x86_64-randconfig-073-20250512 (https://download.01.org/0day-ci/archive/20250513/202505130821.z5LcD77G-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250513/202505130821.z5LcD77G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505130821.z5LcD77G-lkp@intel.com/

All errors (new ones prefixed by >>):

   ***
   *** Rust bindings generator 'bindgen' < 0.69.5 together with libclang >= 19.1
   *** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),
   *** unless patched (like Debian's).
   ***   Your bindgen version:  0.65.1
   ***   Your libclang version: 20.1.2
   ***
   ***
   *** Please see Documentation/rust/quick-start.rst for details
   *** on how to set up the Rust support.
   ***
>> error[E0425]: cannot find function `readb` in crate `bindings`
   --> rust/kernel/io.rs:221:36
   |
   221 |     define_read!(read8, try_read8, readb -> u8);
   |                                    ^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `readw` in crate `bindings`
   --> rust/kernel/io.rs:222:38
   |
   222 |     define_read!(read16, try_read16, readw -> u16);
   |                                      ^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `writel` in crate `bindings`
   --> rust/kernel/io.rs:243:41
   |
   243 |     define_write!(write32, try_write32, writel <- u32);
   |                                         ^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `writeq` in crate `bindings`
   --> rust/kernel/io.rs:248:9
   |
   248 |         writeq <- u64
   |         ^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `writeb_relaxed` in crate `bindings`
   --> rust/kernel/io.rs:251:55
   |
   251 |     define_write!(write8_relaxed, try_write8_relaxed, writeb_relaxed <- u8);
   |                                                       ^^^^^^^^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `writew_relaxed` in crate `bindings`
   --> rust/kernel/io.rs:252:57
   |
   252 |     define_write!(write16_relaxed, try_write16_relaxed, writew_relaxed <- u16);
   |                                                         ^^^^^^^^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `writel_relaxed` in crate `bindings`
   --> rust/kernel/io.rs:253:57
   |
   253 |     define_write!(write32_relaxed, try_write32_relaxed, writel_relaxed <- u32);
   |                                                         ^^^^^^^^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `writeq_relaxed` in crate `bindings`
   --> rust/kernel/io.rs:258:9
   |
   258 |         writeq_relaxed <- u64
   |         ^^^^^^^^^^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `readl` in crate `bindings`
   --> rust/kernel/io.rs:223:38
   |
   223 |     define_read!(read32, try_read32, readl -> u32);
   |                                      ^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `readq` in crate `bindings`
   --> rust/kernel/io.rs:228:9
   |
   228 |         readq -> u64
   |         ^^^^^ not found in `bindings`
--
>> error[E0425]: cannot find function `readb_relaxed` in crate `bindings`
   --> rust/kernel/io.rs:231:52
   |
   231 |     define_read!(read8_relaxed, try_read8_relaxed, readb_relaxed -> u8);
   |                                                    ^^^^^^^^^^^^^ not found in `bindings`
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

