Return-Path: <linux-pci+bounces-7436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82408C4A23
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 01:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF60284827
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 23:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0A85631;
	Mon, 13 May 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0uUs7jl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF614F211;
	Mon, 13 May 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715643665; cv=none; b=Omv9n/3nJwf680FSIxg6IiRS11XhHCVzvRrMdBtjsA2inFkFCwV2UD7ECvBcd9jIhhpehiqFH2o4rvGk0wqp96cQKcrqjfvui1HcQ0pK+8UnUp1e1JlmNWkZCNF7VtCXeAXcFfESZ1T3KrBwwnqUenwvuk6ou5uPXyU13UwAO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715643665; c=relaxed/simple;
	bh=TfWLdkwPYDBzWbv61MXZTfFH0gQ9dE/COO8Daqvh1sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls6PIZHhiM1ffJc17zYrfi68TgnlPclgKA+3zwRRYX0HHwPOcMMcUgbjQPSoQkBXTtKZm+9wsuJiW/Z+A1xk4gRXOIEMI2l/t8j+ceU/kk01WFhsiXdBrfhfj4X6bfvJBljuR7c5g8kMhZwWX6n4sVQ1P+L8U6sM+oIp8Ciah/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0uUs7jl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715643663; x=1747179663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TfWLdkwPYDBzWbv61MXZTfFH0gQ9dE/COO8Daqvh1sw=;
  b=K0uUs7jlikB/m3oiXfEvwOkKj94rfHoZSGtKORgnGFQ/Ub8UJ9W+Jlnf
   fP1r1L2I3PY4SZqWvk2lrJBxpmPMqVANV/4ars8sOA+ZZLde5FuBbxVJY
   /ayGbF/YJJIzOEcbH/gYOchTdT6LYs7rmakYzKn2Xmpoeqq/PFz06W4Pg
   xSXa5xbZUGfxuCUNyPB1nT5IA+Eb39is7mQfnlvKDvG3JsHcmaf2PeI2y
   46jvoMsbur3HT4KkkdOnVNZJ81RlniVpxluqMJUHsAFrHBkYwEb53bps7
   8eT2ttz9cuLD0r6qzUhNNQY7/51eXzGpfUjRYY6CQALNpphPr+kICnlIt
   g==;
X-CSE-ConnectionGUID: 7ivaU8XNQHqrKJZ/vEQrYA==
X-CSE-MsgGUID: E5lz4WXCR2KOk+fPfU/5Zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="34116208"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="34116208"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 16:41:03 -0700
X-CSE-ConnectionGUID: wHaTGeS2S0eETsrOHyK/3w==
X-CSE-MsgGUID: Q3sOCypySK6KFjm0/3utVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="53692072"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 May 2024 16:41:00 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6fHu-000Anf-0G;
	Mon, 13 May 2024 23:40:58 +0000
Date: Tue, 14 May 2024 07:40:08 +0800
From: kernel test robot <lkp@intel.com>
To: matthew.gerlach@linux.intel.com, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v5] dt-bindings: PCI: altera: Convert to YAML
Message-ID: <202405140709.5BmKZtT7-lkp@intel.com>
References: <20240513205913.313592-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513205913.313592-1-matthew.gerlach@linux.intel.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.9 next-20240513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/matthew-gerlach-linux-intel-com/dt-bindings-PCI-altera-Convert-to-YAML/20240514-050049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240513205913.313592-1-matthew.gerlach%40linux.intel.com
patch subject: [PATCH v5] dt-bindings: PCI: altera: Convert to YAML
reproduce: (https://download.01.org/0day-ci/archive/20240514/202405140709.5BmKZtT7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405140709.5BmKZtT7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/devicetree/bindings/sound/fsl-asoc-card.txt references a file that doesn't exist: Documentation/devicetree/bindings/sound/fsl,asrc.txt
   Warning: Documentation/gpu/amdgpu/display/display-contributing.rst references a file that doesn't exist: Documentation/GPU/amdgpu/display/mpo-overview.rst
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pci/altera-pcie.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

