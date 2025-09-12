Return-Path: <linux-pci+bounces-35980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591A8B54316
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 08:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DB11C82650
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 06:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A62848A9;
	Fri, 12 Sep 2025 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="af6vTfth"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B62750F2;
	Fri, 12 Sep 2025 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659329; cv=none; b=ELPSc1m6sX6UedQHZ+A91+SzkHgiABGHSPNCQx6rvsx2yWrztA6PSdAzhYWBoxMDr0lAFFZh2EpcW10AYiKRUK/t4n6R57vNu+Vu4ODNwBkB+4/NtT3nbOs42GNlb5bWcPVHqTBZedoBKozXow1hhWTithusKhh1ph1ldj5X9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659329; c=relaxed/simple;
	bh=XARN275NSX7547scBYEyJ8UtV2onKi9DOJyaZQNGPoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts63DJGy8goVf9fsMoI/EKcSGgSQ8nmXIs3ZHTu3a3eJKEDJxHrak15c5A/ry+SbPTF2yoY7zsXJcAbJh2s7MlcVUexglYVPq0SrXIdITyry9nUlWkPqTBRWxrXb6VPauV0tWemy4u6EKCgshkDK+hO3jc2+IKXbqcaS9O+5WVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=af6vTfth; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757659328; x=1789195328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XARN275NSX7547scBYEyJ8UtV2onKi9DOJyaZQNGPoE=;
  b=af6vTfth1ahq9GC4xpomf6CcABAYw/8VNRDsosLaNYWG8IYuo/bNW6jk
   Ry/K80vUE1pOLWRynzihpyVPY0bm2rod4RLUnD8AfFdfmZ57o4QCaoU3N
   5A7DObR0CMpqA9pECcnb+DsjXSB/RWDVdPROiy/qSlokyjaY2+F7i6Sme
   XFCz9Z+ZvRfCBmLMC7/6o+UivuGsHJLsb9weHkoEeakomBsD8SKeqokef
   cmXyR5r8zzuhmzj9w18HEcpU6cqFdCXyuUuB9fkV0hXNc6Hm4TbQyptdX
   N47OX1IJAqH7Q+9z8agifZ6dvi8N82WHreMILddnWDq3MtojuDrHF4A2r
   w==;
X-CSE-ConnectionGUID: IIIqWRUCSPKK2r2DIiLVTg==
X-CSE-MsgGUID: CdpeU/M3RNaCjRBmLia/rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="63825762"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="63825762"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 23:42:07 -0700
X-CSE-ConnectionGUID: Oxn9V5DzSJCdg0k03flx9Q==
X-CSE-MsgGUID: r2bIIqZXTWCxU6X5CjMrtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="177927638"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 11 Sep 2025 23:42:00 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwxTp-0000t2-2p;
	Fri, 12 Sep 2025 06:41:57 +0000
Date: Fri, 12 Sep 2025 14:41:49 +0800
From: kernel test robot <lkp@intel.com>
To: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	dakr@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	acourbot@nvidia.com, Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	John Hubbard <jhubbard@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, joel@joelfernandes.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH] rust: pci: add PCI interrupt allocation and management
 support
Message-ID: <202509121404.668X5Vy6-lkp@intel.com>
References: <20250910035415.381753-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910035415.381753-1-joelagnelf@nvidia.com>

Hi Joel,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.17-rc5]
[cannot apply to next-20250911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes/rust-pci-add-PCI-interrupt-allocation-and-management-support/20250910-115528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250910035415.381753-1-joelagnelf%40nvidia.com
patch subject: [PATCH] rust: pci: add PCI interrupt allocation and management support
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250912/202509121404.668X5Vy6-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250912/202509121404.668X5Vy6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509121404.668X5Vy6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0425]: cannot find value `dev` in this scope
   --> rust/doctests_kernel_generated.rs:6968:13
   |
   6968 | let nvecs = dev.alloc_irq_vectors(1, 32, IrqTypes::all())?;
   |             ^^^ not found in this scope
--
>> error[E0433]: failed to resolve: use of undeclared type `IrqTypes`
   --> rust/doctests_kernel_generated.rs:6968:42
   |
   6968 | let nvecs = dev.alloc_irq_vectors(1, 32, IrqTypes::all())?;
   |                                          ^^^^^^^^ use of undeclared type `IrqTypes`
   |
   help: consider importing this struct
   |
   3    + use kernel::pci::IrqTypes;
   |
--
>> error[E0433]: failed to resolve: use of undeclared type `IrqTypes`
   --> rust/doctests_kernel_generated.rs:6971:16
   |
   6971 | let msi_only = IrqTypes::default()
   |                ^^^^^^^^ use of undeclared type `IrqTypes`
   |
   help: consider importing this struct
   |
   3    + use kernel::pci::IrqTypes;
   |
--
>> error[E0433]: failed to resolve: use of undeclared type `IrqType`
   --> rust/doctests_kernel_generated.rs:6972:11
   |
   6972 |     .with(IrqType::Msi)
   |           ^^^^^^^ use of undeclared type `IrqType`
   |
   help: consider importing this enum
   |
   3    + use kernel::pci::IrqType;
   |
--
>> error[E0433]: failed to resolve: use of undeclared type `IrqType`
   --> rust/doctests_kernel_generated.rs:6973:11
   |
   6973 |     .with(IrqType::MsiX);
   |           ^^^^^^^ use of undeclared type `IrqType`
   |
   help: consider importing this enum
   |
   3    + use kernel::pci::IrqType;
   |
--
>> error[E0425]: cannot find value `dev` in this scope
   --> rust/doctests_kernel_generated.rs:6974:13
   |
   6974 | let nvecs = dev.alloc_irq_vectors(4, 16, msi_only)?;
   |             ^^^ not found in this scope
--
>> error[E0433]: failed to resolve: use of undeclared type `IrqTypes`
   --> rust/doctests_kernel_generated.rs:7025:16
   |
   7025 | let msi_only = IrqTypes::default()
   |                ^^^^^^^^ use of undeclared type `IrqTypes`
   |
   help: consider importing this struct
   |
   3    + use kernel::pci::IrqTypes;
   |
--
>> error[E0433]: failed to resolve: use of undeclared type `IrqType`
   --> rust/doctests_kernel_generated.rs:7026:11
   |
   7026 |     .with(IrqType::Msi)
   |           ^^^^^^^ use of undeclared type `IrqType`
   |
   help: consider importing this enum
   |
   3    + use kernel::pci::IrqType;
   |
--
>> error[E0433]: failed to resolve: use of undeclared type `IrqType`
   --> rust/doctests_kernel_generated.rs:7027:11
   |
   7027 |     .with(IrqType::MsiX);
   |           ^^^^^^^ use of undeclared type `IrqType`
   |
   help: consider importing this enum
   |
   3    + use kernel::pci::IrqType;
   |

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

