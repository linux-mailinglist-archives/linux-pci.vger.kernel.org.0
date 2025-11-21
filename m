Return-Path: <linux-pci+bounces-41842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71877C771B4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 04:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E47AF356490
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 03:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F82DEA77;
	Fri, 21 Nov 2025 03:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UT5nWW/X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D223ABA0;
	Fri, 21 Nov 2025 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763694071; cv=none; b=O45nH0vKjjbGV3R6QgRn6IbCuY4b3xl4BMV04xZ1chEQ+l6w6n3M2prZz6CPG9imDkE4ar0EHtMcdsWmb3RLT2ohxLUv4OjEPu2wuqTTlFXfOQUFV0KWrTqn2fod+F7t/teawHlmpAbituK09XVKpiQlcX3lkqARnJ/90D6TmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763694071; c=relaxed/simple;
	bh=FVL7q02Hpy/Av8OCyCSpHvCN7UDMdCrsi9RsabkaWH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecyzoEgTI5Plmyof/Tu7noNV+m/RpOEsHYrSnetcoZivpg+inU9j/aNdwWIjbidMIpRV0CGUPZxyjSDD2AAlLjKh+ddBOKMCTUMgtMfkUgo54FiNwMbfcHg6AY4fye1Vt/DLrLFWC16xckvnetKzuADrXC3yDD1Evsh/fMcBpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UT5nWW/X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763694067; x=1795230067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FVL7q02Hpy/Av8OCyCSpHvCN7UDMdCrsi9RsabkaWH0=;
  b=UT5nWW/XhV0k/03xp12qcnlcQRJV68HXDsy5F8awlqylTvzC9eOOv4Ke
   R8R7aMsMWZlaylmtD6VAnrRFvKU5hymDQr5TVY7XG/Byk5p5buO5NGFEk
   I2fsf7C0gpF8nDss7ZLD4j0iJN8hqN1gq7OJzvW5Qvhz5z0hMSV7U7IIa
   yC86QmFj2VV6GRq4fzgJeKoe3rCn+uCLsg0Xbdzb+2vTHShRHEtdYgft8
   fwv+96pzRrpaOPeMmHTq8LofDm2R5oT7+0kh8p06qOB/TsPZk59dWNesq
   45fDKBqBoXBhWls1S380sr6NgGoB/hWaaSHzQ9y1q+0C3opPXm0yG9POw
   w==;
X-CSE-ConnectionGUID: iTyIGvSDTB+9gGZOPNw23w==
X-CSE-MsgGUID: t7RVNVp1S6G36t6Vcuv7Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="68387428"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="68387428"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 19:01:05 -0800
X-CSE-ConnectionGUID: yid6KJQSR2WsDJcpM4e0/g==
X-CSE-MsgGUID: AjA8/8NURZi/0NhunpN+oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="195714715"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 20 Nov 2025 19:00:58 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMHOK-0004sR-06;
	Fri, 21 Nov 2025 03:00:56 +0000
Date: Fri, 21 Nov 2025 11:00:32 +0800
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
Subject: Re: [PATCH 1/8] rust: pci: add is_virtfn(), to check for VFs
Message-ID: <202511211008.jgLuTcrQ-lkp@intel.com>
References: <20251119-rust-pci-sriov-v1-1-883a94599a97@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-rust-pci-sriov-v1-1-883a94599a97@redhat.com>

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Colberg/rust-pci-add-is_virtfn-to-check-for-VFs/20251120-062302
base:   e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
patch link:    https://lore.kernel.org/r/20251119-rust-pci-sriov-v1-1-883a94599a97%40redhat.com
patch subject: [PATCH 1/8] rust: pci: add is_virtfn(), to check for VFs
config: um-randconfig-001-20251121 (https://download.01.org/0day-ci/archive/20251121/202511211008.jgLuTcrQ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511211008.jgLuTcrQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511211008.jgLuTcrQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0599]: no method named `is_virtfn` found for struct `bindings::pci_dev` in the current scope
   --> rust/kernel/pci.rs:415:35
   |
   415 |         unsafe { (*self.as_raw()).is_virtfn() != 0 }
   |                                   ^^^^^^^^^ method not found in `pci_dev`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

