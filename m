Return-Path: <linux-pci+bounces-24379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A36A6C0BC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327573AE8E8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7F22D4D1;
	Fri, 21 Mar 2025 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+rnIrBT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B133F6;
	Fri, 21 Mar 2025 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576262; cv=none; b=mIcYBP6E+sJb4ZYumuZ0gXubf/KgUazuy5oyASijgRkKbIyC8bDEn76DA4qnywrJ7lOUJzb7WS85uoB286/sazqvyhBPKaMw2BVJnO3FiwUoIaimHJCc6AZxJTATYOOnWIVE4Og/2pYVeAar21zrXJeb4+56rrkr0PyjCfpfF0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576262; c=relaxed/simple;
	bh=TI8QswTMwvsvAErK9ByhmOgqwM19DkY5k0TsQ8B24Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz9jkx9DNBvAR54iaz2BVBq2jXX/GxZxpeNRVTH98y2z2Vogej7EN9tBYBfKXDsuUN28mNQ3hG+qXPPqacqySLnqqU4rbw3iBIj50dB5ZMOmU90z4MF/5m+p1pKr1HQtp8u8ZptBWIMRyGCSeEp/0mljS5cgEY1LXtH+v/dfbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+rnIrBT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742576260; x=1774112260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TI8QswTMwvsvAErK9ByhmOgqwM19DkY5k0TsQ8B24Uc=;
  b=m+rnIrBTLgWMf8plFwRr+3xDP4UJButh7LjzzS40CpxSWxf9rkWDJh5I
   Z3vLVeFs371H6CtC73ng6eW9tbeuCwYnQoqoPN06Og0rnmznzS/EVWjhc
   5yBnkPQM5+dRqhbqhtQBsgVoNU4USKkSZXlFxhDwIE+tzIkmjx/y6nG8t
   g5FL41xam/Vq6RQMYXFphQyLfhZyKifR+YxH8G75sfUys1IsFqn4w6/PC
   7FUrUBesS6alW9L6IUVl1Xc6f9uG3dp9iFFT7v1oQKixLGC6jBLnQNXKX
   +BWROXKw23dDKns0PtEQfEKTirvgO0x6LT2Vt9sFO6HLd5XyCq8TT8ExC
   w==;
X-CSE-ConnectionGUID: 0i2rznayRgCFGD1EFarIdg==
X-CSE-MsgGUID: 0Bv7zjvyS6+/vbrGlRXdnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="31439953"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="31439953"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:57:39 -0700
X-CSE-ConnectionGUID: QLURwVkwRgCf9s9H6tFF6Q==
X-CSE-MsgGUID: IjjcQovXTG+DsaKdJVeKVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="128130989"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 21 Mar 2025 09:57:35 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvfgV-0001WD-0g;
	Fri, 21 Mar 2025 16:57:29 +0000
Date: Sat, 22 Mar 2025 00:56:58 +0800
From: kernel test robot <lkp@intel.com>
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <202503220040.TDePlxma-lkp@intel.com>
References: <20250320222823.16509-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320222823.16509-4-dakr@kernel.org>

Hi Danilo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 51d0de7596a458096756c895cfed6bc4a7ecac10]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/rust-device-implement-Device-parent/20250321-063101
base:   51d0de7596a458096756c895cfed6bc4a7ecac10
patch link:    https://lore.kernel.org/r/20250320222823.16509-4-dakr%40kernel.org
patch subject: [PATCH v2 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
config: x86_64-buildonly-randconfig-005-20250321 (https://download.01.org/0day-ci/archive/20250322/202503220040.TDePlxma-lkp@intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b7e4de40d0804dd374721e6411c27d1d1)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250322/202503220040.TDePlxma-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503220040.TDePlxma-lkp@intel.com/

All errors (new ones prefixed by >>):

   ***
   *** Rust bindings generator 'bindgen' < 0.69.5 together with libclang >= 19.1
   *** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),
   *** unless patched (like Debian's).
   ***   Your bindgen version:  0.65.1
   ***   Your libclang version: 20.1.1
   ***
   ***
   *** Please see Documentation/rust/quick-start.rst for details
   *** on how to set up the Rust support.
   ***
>> error[E0133]: use of extern static is unsafe and requires unsafe block
   --> rust/kernel/pci.rs:473:43
   |
   473 |         if dev.bus_type_raw() != addr_of!(bindings::pci_bus_type) {
   |                                           ^^^^^^^^^^^^^^^^^^^^^^ use of extern static
   |
   = note: extern statics are not controlled by the Rust type system: invalid data, aliasing violations or data races will cause undefined behavior

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

