Return-Path: <linux-pci+bounces-41846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D98CC777E9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 07:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BF5E4E1009
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 06:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A859D26A1AB;
	Fri, 21 Nov 2025 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cA0fhmCf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA92586CE;
	Fri, 21 Nov 2025 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763704885; cv=none; b=iOiOZfqKLQfxQs4MVxukwF1AaeKsJdUwRVxzdnwxnm91GxeotFkHqNqKJAv+8DKlAyYUQDu1T2Qq8En3u+z6cvJulSLRNgp5KJyjhtNf/qn6cYHlbGPJbBnCsawM2TakCK03cU3naoV0VPMuleNhbIgzn57X1Op+jNUR6mfmvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763704885; c=relaxed/simple;
	bh=VxJUVnrel4GrYcjD7+FVaUwXq4Hddg0oQdzEZbbT1x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In1vu256MwmdcU2k0jLyoYnNYm/xJtpNyZUAJ39pHF7wNSTyxKuGtH5MTU0V5yAF1DddO0dixH68fQnAU8Lup59t9T8jwt18DR6avXjUHeOb6f43yOamJ/Wv8vcLY+eDf/oZQfq2wJuB3PzTJdefiAooqQ2YmDYkX9DK1FyrJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cA0fhmCf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763704884; x=1795240884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VxJUVnrel4GrYcjD7+FVaUwXq4Hddg0oQdzEZbbT1x4=;
  b=cA0fhmCfA92P13y349Hdud2Cvr1RcoWkbikJy/uIg+mUuDsFbihru8b9
   PxH1I0fMKsRhrZmpmi2NHzWjsX0F8GDQLTzta1VRZd5YeBERhqkm5hKhU
   vqph9pCGZlRm3HZY8uFOG6A/MB8bj3hKKVO6FLaD565Bl9hwi5HkwO7b9
   I0KE4TdUqe/bKzbb/iIfLCBJ5QV5pZ1RE1PxLitg6WIsEpry34HKxXX5x
   W0YQUiuISXHRUpZgWxnga/REM33uO69uGTKmY5rzsttYXHxpSrimqsCA3
   mVnxliH+MRoauU88VRnbesV7J4XvCQN2RmInsYSJKprM2wuwodPWtW30y
   w==;
X-CSE-ConnectionGUID: w04q/ukPQ9CdJNgo+uqt1w==
X-CSE-MsgGUID: Ji3+ZLvfRWSDLj6zcaT4Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="88442594"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="88442594"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 22:01:23 -0800
X-CSE-ConnectionGUID: mg0w5TNUSa+iEJ1jHHJkmw==
X-CSE-MsgGUID: lYGsrtOCT9iCOVAefWA4oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="196738488"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Nov 2025 22:01:17 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMKCo-00051X-1Q;
	Fri, 21 Nov 2025 06:01:14 +0000
Date: Fri, 21 Nov 2025 14:00:18 +0800
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
Subject: Re: [PATCH 6/8] rust: pci: add bus callback sriov_configure(), to
 control SR-IOV from sysfs
Message-ID: <202511211317.FkJsCIc0-lkp@intel.com>
References: <20251119-rust-pci-sriov-v1-6-883a94599a97@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-rust-pci-sriov-v1-6-883a94599a97@redhat.com>

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Colberg/rust-pci-add-is_virtfn-to-check-for-VFs/20251120-062302
base:   e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
patch link:    https://lore.kernel.org/r/20251119-rust-pci-sriov-v1-6-883a94599a97%40redhat.com
patch subject: [PATCH 6/8] rust: pci: add bus callback sriov_configure(), to control SR-IOV from sysfs
config: um-randconfig-001-20251121 (https://download.01.org/0day-ci/archive/20251121/202511211317.FkJsCIc0-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511211317.FkJsCIc0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511211317.FkJsCIc0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0609]: no field `sriov_configure` on type `pci_driver`
   --> rust/kernel/pci.rs:71:31
   |
   71 |                 (*pdrv.get()).sriov_configure = Some(Self::sriov_configure_callback);
   |                               ^^^^^^^^^^^^^^^ unknown field
   |
   = note: available field is: `_address`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

