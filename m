Return-Path: <linux-pci+bounces-1504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128181F983
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 16:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3D81C2226E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CB8DDCE;
	Thu, 28 Dec 2023 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQx88cHf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5CDDB1;
	Thu, 28 Dec 2023 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703776350; x=1735312350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9joJ//r2WbPiqu6shWzXWoF/mATyTHXA55BcruPVTlE=;
  b=QQx88cHfuXYmBlykUFPEHpba+ZakbER268nDjVkGgKUg9ybm5F8wds+A
   Sv47NTPNW3cxemQMsj+zgo7td0OAmTPwHYH8ZkuCjUxpA7xBAKxGx3ovx
   3MOIFXxzj1Fh5/yb4N3lyNJfqB1wZyZ/m3PT+thqYq9/0NENIKxqtxjMm
   AM+4Fiq5NZdt32HDoWXAutm6ub7M2Pc0P3HMqIMDFrSbB9LHEd6wyq7yR
   T9YPoOBb5Ob46W+qbKz+AVAYAQ8mXEWRdJIJIQsi0Et1JrXn8ROS9HbpE
   FBf7ep1iTmV5IsJU2nklBEbV15W1UKp+Yc3x1MFX3N96afjMMpuguJrZb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="482733304"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="482733304"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 07:12:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="922117912"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="922117912"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Dec 2023 07:12:26 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIs3c-000GYX-07;
	Thu, 28 Dec 2023 15:12:24 +0000
Date: Thu, 28 Dec 2023 23:12:02 +0800
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
Cc: oe-kbuild-all@lists.linux.dev,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 4/4] PCI: qcom: Implement RC shutdown/power up
Message-ID: <202312282244.N6b5czwN-lkp@intel.com>
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
config: powerpc64-randconfig-002-20231228 (https://download.01.org/0day-ci/archive/20231228/202312282244.N6b5czwN-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312282244.N6b5czwN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312282244.N6b5czwN-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
   powerpc64-linux-ld: warning: discarding dynamic section .glink
   powerpc64-linux-ld: warning: discarding dynamic section .plt
   powerpc64-linux-ld: linkage table error against `cmd_db_ready'
   powerpc64-linux-ld: stubs don't match calculated size
   powerpc64-linux-ld: can not build stubs: bad value
   powerpc64-linux-ld: drivers/pci/controller/dwc/pcie-qcom.o: in function `qcom_pcie_probe':
>> pcie-qcom.c:(.text+0x1894): undefined reference to `cmd_db_ready'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

