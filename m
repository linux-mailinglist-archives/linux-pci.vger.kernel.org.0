Return-Path: <linux-pci+bounces-1532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 432A581FCE3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 04:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D56A1C20973
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 03:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1EE17FA;
	Fri, 29 Dec 2023 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ah/aicGE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734B567C;
	Fri, 29 Dec 2023 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703821574; x=1735357574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vm6p9nuxloRluzYcX979ML+GT8QFdDfRTL49gEoXQn4=;
  b=Ah/aicGELwRB1UDR92/tVtkjEliD2YeJgdQDbaXjBdctPgzi1culLNtX
   2T+o2BGygwzY0sQOK0XSbm4wcHrmP3+esO5Xvm9A7CXR8kE/vRo0LtBTh
   h1G7m5tunRj+UAwDhYaTlgC1Hq3HENcTFxJ6IPnfUYjls0PwrERExeXJc
   bWYkOVu+FyXg1Nqr/p2E2xOpQjWTbeZYh4mhbky2K7MgKcmMpUEuhTLnn
   TlpjEK8Y1k3MIs3U+kDTHaLil7io1Sno8jzKRT44Q1C56Ap3wr6xZBlIy
   ABP8grqmDyheonJ2TCgqO5yw4/pppY0ndFCSTG0jIO4YF4LyjAWkSr0m6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="381591511"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="381591511"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 19:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="778711269"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="778711269"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Dec 2023 19:46:10 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJ3oz-000H4F-1U;
	Fri, 29 Dec 2023 03:46:06 +0000
Date: Fri, 29 Dec 2023 11:42:53 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Vinod Koul <vkoul@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 4/4] PCI: qcom: Implement RC shutdown/power up
Message-ID: <202312291155.8v6ZEtrf-lkp@intel.com>
References: <20231227-topic-8280_pcie-v1-4-095491baf9e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227-topic-8280_pcie-v1-4-095491baf9e4@linaro.org>

Hi Konrad,

kernel test robot noticed the following build errors:

[auto build test ERROR on 39676dfe52331dba909c617f213fdb21015c8d10]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/PCI-qcom-Reshuffle-reset-logic-in-2_7_0-init/20231228-062002
base:   39676dfe52331dba909c617f213fdb21015c8d10
patch link:    https://lore.kernel.org/r/20231227-topic-8280_pcie-v1-4-095491baf9e4%40linaro.org
patch subject: [PATCH 4/4] PCI: qcom: Implement RC shutdown/power up
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231229/202312291155.8v6ZEtrf-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 8a4266a626914765c0c69839e8a51be383013c1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231229/202312291155.8v6ZEtrf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312291155.8v6ZEtrf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: cmd_db_ready
   >>> referenced by pcie-qcom.c
   >>>               drivers/pci/controller/dwc/pcie-qcom.o:(qcom_pcie_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: crc8_populate_msb
   >>> referenced by pcie-qcom.c
   >>>               drivers/pci/controller/dwc/pcie-qcom.o:(qcom_pcie_config_sid_1_9_0) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: crc8
   >>> referenced by pcie-qcom.c
   >>>               drivers/pci/controller/dwc/pcie-qcom.o:(qcom_pcie_config_sid_1_9_0) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

