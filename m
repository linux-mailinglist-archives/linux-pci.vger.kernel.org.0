Return-Path: <linux-pci+bounces-41851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12134C77C62
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 08:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9CE64E8F9A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABBE3396FA;
	Fri, 21 Nov 2025 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVWES19G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F3433970F;
	Fri, 21 Nov 2025 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711918; cv=none; b=HyQ7YPKFKBcMdPqTItKN4WHzEIppWw0oR+SIV+51sI1f51nzaQ3VVqhtG3qavZF+Lb4Om29QB4YL1DLsdRUX6HR2y6O+i7vqdN78yYOT6UvA/8+RqivVbarnWrMqhMCEfEAtm6q0UTJZhE4/2m5nqXm4o4K3NF6ONNqwBozec9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711918; c=relaxed/simple;
	bh=AB2Q4F7MHO42MsOSJmeXRb7cAV7Fu3VrcSzA4mqdjBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZsNhrTBj2Y/hXlI36gie7I/b21NPAESIEQfaOP5TXhelfpy20ThpZt0P+XPF8APxWRwAp7gPVcYylkwVsOPr20+zyjP1MColQVsFfWSBf6FfbM1QpV/8J+NNUjVwBVpHQeG7QZ8VdcNVCTuZUJuIgjRbHxogRFG+akbc4rmizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVWES19G; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763711916; x=1795247916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AB2Q4F7MHO42MsOSJmeXRb7cAV7Fu3VrcSzA4mqdjBw=;
  b=cVWES19GiRBLcP71zEu7sKZl3fanMSkrQVlMvhVQ3ahEsD3WBRglMjw7
   KXFiwzfdsi+RkKXPKmiuOpBzH31t5XPHDDRjVxulTRmvU9FmxDhAGzIlA
   KpjfxF3geUh0YaHiJ3uB1Cli2vggDkKLH1qIAYsJueOcpZNCIw/hneXq3
   6BMSw2fbvM9MbGwbvWp93IqGRfRULZgemsZ2PrHAp/PZaruYw74WK+Nc8
   xoLnWme8+3PLeeS/zvqgy5ldFgWHpgNz5P9plyIeMXn/3yVemnvC7OliN
   3e8uCY6oOpQ9rWt+PcHNh0EwD/SCmw7FNva/0jYWS4EGtOxKpmOk4DHTG
   Q==;
X-CSE-ConnectionGUID: pXpqSlrwS5+DwCwhRhhOfw==
X-CSE-MsgGUID: uPW1Q7MSRRSKUkIwGFdGNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69413042"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="69413042"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 23:58:36 -0800
X-CSE-ConnectionGUID: 1cJQW2g6Q86m1an8yc7BDw==
X-CSE-MsgGUID: hj7cxYB9SGuQ64Wp2Q/e3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="190913439"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Nov 2025 23:58:29 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMM2E-00055v-1T;
	Fri, 21 Nov 2025 07:58:26 +0000
Date: Fri, 21 Nov 2025 15:57:45 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Colberg <pcolberg@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Peter Colberg <pcolberg@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF
 device
Message-ID: <202511211511.hUcSTiSF-lkp@intel.com>
References: <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Colberg/rust-pci-add-is_virtfn-to-check-for-VFs/20251120-062302
base:   e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
patch link:    https://lore.kernel.org/r/20251119-rust-pci-sriov-v1-7-883a94599a97%40redhat.com
patch subject: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF device
config: um-randconfig-001-20251121 (https://download.01.org/0day-ci/archive/20251121/202511211511.hUcSTiSF-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511211511.hUcSTiSF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511211511.hUcSTiSF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0609]: no field `__bindgen_anon_1` on type `bindings::pci_dev`
   --> rust/kernel/pci.rs:546:40
   |
   546 |         Ok(unsafe { &*(*self.as_raw()).__bindgen_anon_1.physfn.cast() })
   |                                        ^^^^^^^^^^^^^^^^ unknown field
   |
   = note: available field is: `_address`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

