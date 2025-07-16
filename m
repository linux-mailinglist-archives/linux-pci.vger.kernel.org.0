Return-Path: <linux-pci+bounces-32344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E36B08119
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 01:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CCD77AC307
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 23:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0D12C3276;
	Wed, 16 Jul 2025 23:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVp+G2pc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D4289E16;
	Wed, 16 Jul 2025 23:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752709559; cv=none; b=TVKLtZ/xczL5e/yIhL+5hd4vhBtt/jsqNxH/CJYA0VxHx+W7ZLO2BFacYuVYz12R78fmdM9lLI9XdIcVZPmfOSC9jXKfK/37MZ+oC+TGPE9I8klsc9fSTnSs1JH1TJyl9I1LcYzBkKPOBfJTsOorSllpepjR0BQnPnO1pSVI6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752709559; c=relaxed/simple;
	bh=J3UG5GnJ5BjYLTM0CP7GT2WZiod9LqwrORLiSgAOFFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwhxMXIKyM29NrJxN3vvUAxQlav3rGS6WrJhTbMcY2ROXDyJb38Gt4BgQTvY1Nrfx5lbKfH2dOQSuTIi14nIlAHXxyKdz/wAYXIBcnlQYP975cK6FvM4YhY44hrcvsr9j3QUL3XRinzIrMDoW1aiHqzgt/PdjBkOF4YU8m9qlOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVp+G2pc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752709558; x=1784245558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J3UG5GnJ5BjYLTM0CP7GT2WZiod9LqwrORLiSgAOFFE=;
  b=YVp+G2pcDDcGWQVucnhFCn6FavR1EdyisX/3G2ijnTX5Ok3UoDFjdoiT
   GQb0APfmGNOs53VgRhrvLN27zdwGHHzh/LytCBGIBPeP7zsm8Bo9RLdsU
   3ej2O7YoNKIrHFgvTcDOtnGO2TwSZXfQ0iq8y3gNPIaIlY2dc+zOjcwsU
   i2s/30ME0GWcRENlF70LTPua/X2aIXn9sjgNGq3aXJOwntB8DAc0XPWJV
   NCzBzltV0bLW8TIIdXV8gX6vAcGNI/KH7C7Xfg7hKO6TmfEYUB6iQJU8G
   9QgRQfRnE/UNBxntiD5ejaBBpYqayvav7vYl5KMxb9pzoZyfkJ7ZRdN5d
   A==;
X-CSE-ConnectionGUID: gGM90jKOT8ynNiIA+jQNFQ==
X-CSE-MsgGUID: 0k4WWt9zReigZShtvNfJ9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58780582"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="58780582"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 16:45:57 -0700
X-CSE-ConnectionGUID: wzgqLGgTT62ROBCL6R80XQ==
X-CSE-MsgGUID: O/jRKJFhSyq3YGSi9Gk1bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="157741471"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Jul 2025 16:45:52 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucBos-000Cxf-2v;
	Wed, 16 Jul 2025 23:45:50 +0000
Date: Thu, 17 Jul 2025 07:45:48 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Benno Lossin <lossin@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Message-ID: <202507170718.AVqYqRan-lkp@intel.com>
References: <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3964d07dd821efe9680e90c51c86661a98e60a0f]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Almeida/rust-irq-add-irq-module/20250715-232121
base:   3964d07dd821efe9680e90c51c86661a98e60a0f
patch link:    https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07%40collabora.com
patch subject: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and handlers
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250717/202507170718.AVqYqRan-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507170718.AVqYqRan-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507170718.AVqYqRan-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find value `SHARED` in module `flags`
   --> rust/doctests_kernel_generated.rs:4790:58
   |
   4790 |     let registration = Registration::new(request, flags::SHARED, c_str!("my_device"), handler);
   |                                                          ^^^^^^ not found in `flags`
   |
   help: consider importing this constant
   |
   3    + use kernel::mm::virt::flags::SHARED;
   |
   help: if you import `SHARED`, refer to it directly
   |
   4790 -     let registration = Registration::new(request, flags::SHARED, c_str!("my_device"), handler);
   4790 +     let registration = Registration::new(request, SHARED, c_str!("my_device"), handler);
   |

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

