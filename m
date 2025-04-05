Return-Path: <linux-pci+bounces-25322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED1A7C71E
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 02:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C103B8FD1
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 00:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40482F36;
	Sat,  5 Apr 2025 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd7MLgxn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FA4C62;
	Sat,  5 Apr 2025 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743813388; cv=none; b=ifx/4t3E9incxAvlqaaLFhMy1jNNSE33I31NzPfyV9xGna89hvjHexaYxr6efDLVYc0CkgLE3QAq/pKE2BRKUUs+vOT+4tdg1z8TT1MDeOb60NFwf0dpcevJ2HEIUQasKton5nxq8vqCR2eZDMLe5vuIj3ctNloLqLEsc4VXf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743813388; c=relaxed/simple;
	bh=D04GQjJVTbdj0EI/o3qCLXYgkzKbBu3RBBIdJTEG6Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQGdBiFerUdSSEAaUFt/p8MNxnhODi18zkNKG6lAE1L0jiAQFSN3hgKNMMUVH4/wmRp/gR1XjiKbkMm26ZDcmIi1y5VPbVjY5r+A6GvEVlsLbqlaUvKBPTGi3ex3/tKxaOEB3loCydLs7onNF82ax7nkJYcwaAK1MYQ70T7LSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd7MLgxn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743813386; x=1775349386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D04GQjJVTbdj0EI/o3qCLXYgkzKbBu3RBBIdJTEG6Dg=;
  b=Cd7MLgxn7uFUaxrrH3YCCuyNqSSDYWaMKtH0MuNO8B01xqrhTo0yXr0F
   lSvfoqvT1bvJZs4UOnOTCGWBeErbXe/C7ds4iQuTfzQ+OIy1l6qQVwLHZ
   em2JvQMvSrlDSWiEOr7tcIIDQgftQJ/9Rtz08naXvd0Usqud3Z3PmnpCa
   qyhAmBlWDrBGV88Tz/m3X/tKuJ9Ht3SwOLbWuF6VtJvV1BqJ8tJ+cE3Mv
   hyBf7e6Z41iyXEjPN4PjMPqGIKvBzg7exxjT1B/vxlKnxFNprn8eQGLzq
   ME6BuzHv3KO1N06tcU4FaKgwy1tMbVBTh8ZesplFmJEOPEknxfVCGlwlY
   w==;
X-CSE-ConnectionGUID: SailAoeyS5qlSAf/RVx3Bg==
X-CSE-MsgGUID: 8NyNoBeQQ0eIlhHL2aJ7Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="55901698"
X-IronPort-AV: E=Sophos;i="6.15,189,1739865600"; 
   d="scan'208";a="55901698"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 17:36:25 -0700
X-CSE-ConnectionGUID: 5BF7QoSpT1CL0i0rilUFFA==
X-CSE-MsgGUID: R95ij1hERPy+PpOJt1Ockg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,189,1739865600"; 
   d="scan'208";a="131593006"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 Apr 2025 17:36:21 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0rWF-0001hT-0p;
	Sat, 05 Apr 2025 00:36:19 +0000
Date: Sat, 5 Apr 2025 08:36:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, Frank Li <Frank.li@nxp.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Remove obsolete .txt docs
Message-ID: <202504050824.95rb99r8-lkp@intel.com>
References: <20250404221559.552201-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404221559.552201-1-robh@kernel.org>

Hi Rob,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.14 next-20250404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring-Arm/dt-bindings-PCI-Remove-obsolete-txt-docs/20250405-061754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250404221559.552201-1-robh%40kernel.org
patch subject: [PATCH] dt-bindings: PCI: Remove obsolete .txt docs
reproduce: (https://download.01.org/0day-ci/archive/20250405/202504050824.95rb99r8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504050824.95rb99r8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt_link<../../networking/netlink_spec/rt_link>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>> Warning: Documentation/devicetree/bindings/virtio/pci-iommu.yaml references a file that doesn't exist: Documentation/devicetree/bindings/pci/pci.txt
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
   Warning: Documentation/translations/ja_JP/process/submit-checklist.rst references a file that doesn't exist: Documentation/translations/ja_JP/SubmitChecklist
   Warning: Documentation/translations/zh_CN/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

