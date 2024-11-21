Return-Path: <linux-pci+bounces-17162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA29D4D3F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 13:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82DE28193B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26BA1D79B0;
	Thu, 21 Nov 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Muf4CKR7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2C1D319B;
	Thu, 21 Nov 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193764; cv=none; b=NGgOVjJ7s+XrdliB8aSniyDDauxKoKeL621jiVT8FiEreptol/ShrCBe47ic+zI+8MwSnYPPhm5y+8eYs9vK0vChd7w22Z3YTBPtWZ7EEcDxFQ/vJ4EBqIqvtxcYlVpjHHhyRTbZXDxV6tMUQA8Qcozb9vK+bG57jOq8FDqa5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193764; c=relaxed/simple;
	bh=OJ7jpXptzMvUw5SQvMFqKJ9P9BuHEp7aI5omam+VfLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7uD5RJXXtyOhnMEWgxZN0p1pOwbAK1OcoSShGLrQO5OzLZu/NqaBXh4NYfefHJsveoF+3xORUbjsYeQTXHagUNlZsqrEUcdjb9hYNydi4ATizEGHIgLqhZOfhwCjPKr/L4eIB90SloDAOal2Y1R3s1ByE0RsordEQx1r/FDMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Muf4CKR7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732193763; x=1763729763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OJ7jpXptzMvUw5SQvMFqKJ9P9BuHEp7aI5omam+VfLQ=;
  b=Muf4CKR7ceAVLH5s00znc0aaXIKyK/JAxmFSXk8jjPkEQuTvwDW3KCin
   trL9f5MngK/R4qFoXPqyxM+YOkod9rQf9z9e6aZPkWjrh4YN9q3iZeMh3
   3pNDdMvLmmYSDnOkLtUgwH+bfh41coY83Gsd+q8eRmw298LjAwnnsW0+m
   rKSeKeLKygLDkRCEyjvvyRTxyfq8ix5/JST9Bn8lR5/naUC2MsMu5H3il
   +C80W/2emVoz1PMb2/sndW10+CBkjkZpeoPBu9Pkyiq2GQnC3+0ehChuc
   J2CeMMI6BIqP56j7hQFGXxqK7wxulDkzt4kmOiwMOg7wThvW5e3DmSBK9
   Q==;
X-CSE-ConnectionGUID: N3UMfb7VR3ij1iO4iG54Ew==
X-CSE-MsgGUID: OH7FnKr/SWq3WbShzVnyNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32154257"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="32154257"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 04:56:03 -0800
X-CSE-ConnectionGUID: yej0/1NpRA2rwMa2tT724Q==
X-CSE-MsgGUID: GykF+9oBRGCCLEWmxWYMyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="95046739"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Nov 2024 04:55:57 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tE6iw-0002zb-3A;
	Thu, 21 Nov 2024 12:55:54 +0000
Date: Thu, 21 Nov 2024 20:55:43 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?unknown-8bit?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	mmareddy@quicinc.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH 2/3] PCI: dwc: Add ECAM support with iATU configuration
Message-ID: <202411212032.CbThzjSv-lkp@intel.com>
References: <20241117-ecam-v1-2-6059faf38d07@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117-ecam-v1-2-6059faf38d07@quicinc.com>

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/arm64-dts-qcom-sc7280-Increase-config-size-to-256MB-for-ECAM-feature/20241121-095614
base:   2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
patch link:    https://lore.kernel.org/r/20241117-ecam-v1-2-6059faf38d07%40quicinc.com
patch subject: [PATCH 2/3] PCI: dwc: Add ECAM support with iATU configuration
config: i386-buildonly-randconfig-005-20241121 (https://download.01.org/0day-ci/archive/20241121/202411212032.CbThzjSv-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241121/202411212032.CbThzjSv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411212032.CbThzjSv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pci_generic_ecam_ops
   >>> referenced by pcie-designware-host.c
   >>>               drivers/pci/controller/dwc/pcie-designware-host.o:(dw_pcie_host_init) in archive vmlinux.a
   >>> referenced by pcie-designware-host.c
   >>>               drivers/pci/controller/dwc/pcie-designware-host.o:(dw_pcie_host_init) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: pci_ecam_create
   >>> referenced by pcie-designware-host.c
   >>>               drivers/pci/controller/dwc/pcie-designware-host.o:(dw_pcie_host_init) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: pci_ecam_free
   >>> referenced by pcie-designware-host.c
   >>>               drivers/pci/controller/dwc/pcie-designware-host.o:(dw_pcie_host_init) in archive vmlinux.a
   >>> referenced by pcie-designware-host.c
   >>>               drivers/pci/controller/dwc/pcie-designware-host.o:(dw_pcie_host_deinit) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

