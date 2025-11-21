Return-Path: <linux-pci+bounces-41844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B5C77405
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 05:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8832F35EE49
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 04:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CD32D248C;
	Fri, 21 Nov 2025 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTUj+g0g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D922356A4;
	Fri, 21 Nov 2025 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763699778; cv=none; b=TXR0BlgK7HH0wrFa1irs69/sPkz1pcLLuO08vNpM8+qK9QHPYWdx4ZY5csS6lUGAiFpo4JzQzbEFvjC/s9GuHvGrj3likkzm2IkIp6syERQh1/dXWYPOLHaMluhQ3E4oHAnO52V5UPswTd/X0niQljs/lxnfDwvIGbRHh4zdMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763699778; c=relaxed/simple;
	bh=JlEEmEr94h6V/BNxgcdQnse4ygoRSgWZ+BGKgES2B84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr/tu+uTKBD73p34PCm+CXGpwAT55guP7Bw8sAm3vi9fSv065YSd9C6uo0yY5cGgsfitGhqS5RJCBmOyt7gYSdombq9QW3FrP8DZMVpBq1hIUenJXtYrILlrJxc4CIn3loZCYGN8tHO8dRgatJsqt0EAmLtuK1SxRB6I25aZC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTUj+g0g; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763699776; x=1795235776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JlEEmEr94h6V/BNxgcdQnse4ygoRSgWZ+BGKgES2B84=;
  b=iTUj+g0gBQ8dm8qOIVFZ2VeCr2DNkBRgm5QkuDhZidtzXvNKPWd6eiWl
   lkCwNYk03Ng/24+rceQXvrWQg4gNnENgV4zX/dvKNE71Ji46RT9tQJ0pW
   Lk8jC5y2Y7quG2ULtu1U1oIRVQXKDd5mL35QsEgQ0uoAPeQsn2pE2Ebdo
   dEvqdhev3lqfnI9igtFMvJpPJLRxJLDv6XmHcNQ49ln2iD9pgOpjZzYc5
   tRMVegtetPM2bGJ6+B0bYQMqvgDTogE8jqmimh6aSmglZgl66lC9AR4i3
   /7mFsag5Nh2FHyCRbenrW2QSP4f27IICz10CKYvBC3wlYIKA31ATpNlhE
   Q==;
X-CSE-ConnectionGUID: jjLkO1+iSDC9WdJmYPYmig==
X-CSE-MsgGUID: YX8/tJ/XScKuQyc0XPEHcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76470198"
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="76470198"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 20:36:15 -0800
X-CSE-ConnectionGUID: 3qUtCfdQTX+6ydmAnxfdOg==
X-CSE-MsgGUID: O05UoCfkRhygniuhs87ffA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,214,1758610800"; 
   d="scan'208";a="191449600"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Nov 2025 20:36:08 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMIsQ-0004xX-0Q;
	Fri, 21 Nov 2025 04:36:06 +0000
Date: Fri, 21 Nov 2025 12:35:30 +0800
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
Subject: Re: [PATCH 2/8] rust: pci: add is_physfn(), to check for PFs
Message-ID: <202511211257.8KOIldMM-lkp@intel.com>
References: <20251119-rust-pci-sriov-v1-2-883a94599a97@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-rust-pci-sriov-v1-2-883a94599a97@redhat.com>

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Colberg/rust-pci-add-is_virtfn-to-check-for-VFs/20251120-062302
base:   e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
patch link:    https://lore.kernel.org/r/20251119-rust-pci-sriov-v1-2-883a94599a97%40redhat.com
patch subject: [PATCH 2/8] rust: pci: add is_physfn(), to check for PFs
config: um-randconfig-001-20251121 (https://download.01.org/0day-ci/archive/20251121/202511211257.8KOIldMM-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511211257.8KOIldMM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511211257.8KOIldMM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0599]: no method named `is_physfn` found for struct `bindings::pci_dev` in the current scope
   --> rust/kernel/pci.rs:415:35
   |
   415 |         unsafe { (*self.as_raw()).is_physfn() != 0 }
   |                                   ^^^^^^^^^ method not found in `pci_dev`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

