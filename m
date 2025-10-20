Return-Path: <linux-pci+bounces-38826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC12BF4096
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 01:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE76818A7FF9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 23:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2892F90DE;
	Mon, 20 Oct 2025 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2r6yRWZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206CB2F362C;
	Mon, 20 Oct 2025 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761003511; cv=none; b=p0OZU20EwdfiUZSQewm/zlSSQf19RAvUER48P1yQItkDM5uPQSNdnBxSaY/L9zOGXH+z8FyWY7+8tssN053Xrk7O3HgFQn4mTjUEPe3Zhbz9E++rF3RrdnlojNhF4ROelPmwR89sD+jx2MFodO85v608Rrt6NyrovqoJ1QYSomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761003511; c=relaxed/simple;
	bh=SIJw5mfjVLuMIAkneKIDqYjtAB3HUgg7gTwbYwgB8XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRMm1YnB/5wtKb7qAst8bmOVWdSrrwISUPiQdXj7zZe++2fQPTD1QdrILdC4CevNl8dU7pKJslhXDpxVGCHoXVqKXsuuSXgT+F3l5r2itq1u/nq7RnXRELSNQkEYAitc+WpV46GX9Ru2lrOnJfV4HrffBLxMUx4swGbg6Eo2zIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2r6yRWZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761003510; x=1792539510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SIJw5mfjVLuMIAkneKIDqYjtAB3HUgg7gTwbYwgB8XU=;
  b=O2r6yRWZM/PHFvv9UwLdGN6lU+3l8Nf+PyK38bJR+Q2tVztEgYSFTQ+B
   eG9x3ZN807GMHetc3wk7GEmg7Xrd93QWp4uX4R/lMjUJsLztwQ7ADq397
   3HCFBPqxI9ttNfuNDRlIII1GS3OV/6WmJ0pYr1bK2LL9X9v8prviw/xFX
   Og0XHu+dKVXVw7R8Qcv7tcCPTak2ZOCNJ2GsgS+k3iplHgs5AGMpD2YnL
   FF/KEst9AWJz7cTT13mpI2dSw3cpDiqpuzlBhB5IwOIG0dIve8FU+4PyD
   YlNH+EppgmcN7MfKFiX9VYwQehFLyajsH8oqI70EindA88U8/CBlvRbMR
   A==;
X-CSE-ConnectionGUID: 6GpeLUB9Rjepn7V9HEyrxQ==
X-CSE-MsgGUID: xzgBo33tTymDHzQmKZ2MnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74246012"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="74246012"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 16:38:30 -0700
X-CSE-ConnectionGUID: umtj87M0Ty+vyL8Lk1WSVg==
X-CSE-MsgGUID: +bkf+DWfRrWIgkPT+R+5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="187715091"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 20 Oct 2025 16:38:22 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAzS8-000AFl-1H;
	Mon, 20 Oct 2025 23:38:16 +0000
Date: Tue, 21 Oct 2025 07:36:54 +0800
From: kernel test robot <lkp@intel.com>
To: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, dakr@kernel.org,
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, zhiw@nvidia.com, zhiwang@kernel.org,
	acourbot@nvidia.com, joelagnelf@nvidia.com, jhubbard@nvidia.com,
	markus.probst@posteo.de
Subject: Re: [PATCH v2 1/5] rust/io: factor common I/O helpers into Io trait
 and specialize Mmio<SIZE>
Message-ID: <202510210730.qW10Mhd0-lkp@intel.com>
References: <20251016210250.15932-2-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016210250.15932-2-zhiw@nvidia.com>

Hi Zhi,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.18-rc2 next-20251020]
[cannot apply to driver-core/driver-core-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhi-Wang/rust-io-factor-common-I-O-helpers-into-Io-trait-and-specialize-Mmio-SIZE/20251017-050553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251016210250.15932-2-zhiw%40nvidia.com
patch subject: [PATCH v2 1/5] rust/io: factor common I/O helpers into Io trait and specialize Mmio<SIZE>
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20251021/202510210730.qW10Mhd0-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251021/202510210730.qW10Mhd0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510210730.qW10Mhd0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0432]: unresolved import `kernel::io::IoRaw`
   --> rust/doctests_kernel_generated.rs:5047:74
   |
   5047 | use kernel::{bindings, device::{Bound, Device}, devres::Devres, io::{Io, IoRaw}};
   |                                                                          ^^^^^ no `IoRaw` in `io`
--
>> error[E0782]: expected a type, found a trait
   --> rust/doctests_kernel_generated.rs:7075:46
   |
   7075 | fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
   |                                              ^^^^^^^^
   |
   = note: `Io<SIZE>` is dyn-incompatible, otherwise a trait object could be used
   help: use a new generic type parameter, constrained by `Io<SIZE>`
   |
   7075 - fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
   7075 + fn wait_for_hardware<const SIZE: usize, T: Io<SIZE>>(io: &T) -> Result<()> {
   |
   help: you can also use an opaque type, but users won't be able to specify the type parameter when calling the `fn`, having to rely exclusively on type inference
   |
   7075 | fn wait_for_hardware<const SIZE: usize>(io: &impl Io<SIZE>) -> Result<()> {
   |                                              ++++
--
>> error[E0782]: expected a type, found a trait
   --> rust/doctests_kernel_generated.rs:5078:18
   |
   5078 |    type Target = Io<SIZE>;
   |                  ^^^^^^^^
--
>> error[E0782]: expected a type, found a trait
   --> rust/doctests_kernel_generated.rs:5082:18
   |
   5082 |         unsafe { Io::from_raw(&self.0) }
   |                  ^^
   |
   help: you can add the `dyn` keyword if you want a trait object
   |
   5082 |         unsafe { <dyn Io>::from_raw(&self.0) }
   |                  ++++   +

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

