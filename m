Return-Path: <linux-pci+bounces-21681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D790A38FFC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 01:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BB97A161A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 00:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D4EEC3;
	Tue, 18 Feb 2025 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHwoitdL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765CC8EB;
	Tue, 18 Feb 2025 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739839021; cv=none; b=mCd+zWLj339Ktp6W0x48oK15SENuqFXWUyLUM7j6Ij0nvMRkcca6u9BpLk+FcI4F2/uALHa3Vc0DR3LqLXYbjrEqbTZa9Ysx14nFzd/e7/+Tu0b78KulFOng85zTB0GAaV1+I87DjNJ1rF91yfCF1XMyIVaLRJJn4uel0OQkjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739839021; c=relaxed/simple;
	bh=Ny5YdOPUC/jjkTovynaC4bFLGUWHmOsAUX5YovP2erk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeCDNlNvL+19NKuu+aOKo1RQaoo9Uxkh36ZW5Gv68D23ER7hwhr9XZSVIcCFi25RoYsBzHmMLGuE+rXBKXbOgfCwr4G6kuLHY/4mruYVbtx0ju7Ul4uStIvuHkqbv/B7msjOaHZj/YRe7LpuVFwTErZes50WyHRuvpNY30mNUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHwoitdL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739839019; x=1771375019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ny5YdOPUC/jjkTovynaC4bFLGUWHmOsAUX5YovP2erk=;
  b=hHwoitdLevZ313bwTRw0ay/sHRJk1lCopmw8SEQ22337HgbVko9iQZ6+
   /lwTmbIQcQ+c9zfjwbAhcDq7b/zT/fObBH8eHxA9lbXRdAAWL8XuC5hAP
   CElBdsHPocofLnzIJp0kLKGq85gjUB4HacIFpyoPIFDkt8S++PPHyocKb
   RCV7zclluivwQonxKy0gC5ROrLmfX+QRbwrrTU+Mh0TdJ5f66NAgFg44e
   P6TlzSz1Ioj6H1A3zkeJxi0cKRcyGkU0tofj1Rf3onDl4kve01fTwlDYL
   /m5s3t3MasAq2vBKV3n9ZAzHefdd04z/ThtGnMPjV9iZFTSbEJDQaRdQC
   A==;
X-CSE-ConnectionGUID: BMBTcpAySzCujQXORFnSPw==
X-CSE-MsgGUID: 5YYNXkxwQUekt8ODLEBDKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="57925331"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="57925331"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 16:36:58 -0800
X-CSE-ConnectionGUID: eMXxnhFWSZqSzMmcCwBiMQ==
X-CSE-MsgGUID: 8/qY5GQfQM+imgwsKRbQew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114107634"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Feb 2025 16:36:52 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkBbV-001Dj9-1S;
	Tue, 18 Feb 2025 00:36:49 +0000
Date: Tue, 18 Feb 2025 08:36:34 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
	quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
	quic_mrana@quicinc.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 4/8] PCI: dwc: qcom: Update ICC & OPP votes based upon
 the requested speed
Message-ID: <202502180859.1y6qqeIk-lkp@intel.com>
References: <20250217-mhi_bw_up-v1-4-9bad1e42bdb1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-mhi_bw_up-v1-4-9bad1e42bdb1@oss.qualcomm.com>

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0ad2507d5d93f39619fc42372c347d6006b64319]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Chaitanya-Chundru/PCI-update-current-bus-speed-as-part-of-pci_bus_add_devices/20250217-144050
base:   0ad2507d5d93f39619fc42372c347d6006b64319
patch link:    https://lore.kernel.org/r/20250217-mhi_bw_up-v1-4-9bad1e42bdb1%40oss.qualcomm.com
patch subject: [PATCH 4/8] PCI: dwc: qcom: Update ICC & OPP votes based upon the requested speed
config: powerpc64-randconfig-002-20250218 (https://download.01.org/0day-ci/archive/20250218/202502180859.1y6qqeIk-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250218/202502180859.1y6qqeIk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502180859.1y6qqeIk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-qcom.c:1319:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (!IS_ERR(opp)) {
                       ^~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-qcom.c:1328:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/pci/controller/dwc/pcie-qcom.c:1319:3: note: remove the 'if' if its condition is always true
                   if (!IS_ERR(opp)) {
                   ^~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-qcom.c:1311:13: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           } else if (pcie->use_pm_opp) {
                      ^~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-qcom.c:1328:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/pci/controller/dwc/pcie-qcom.c:1311:9: note: remove the 'if' if its condition is always true
           } else if (pcie->use_pm_opp) {
                  ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-qcom.c:1302:9: note: initialize the variable 'ret' to silence this warning
           int ret, freq_mbps;
                  ^
                   = 0
   2 warnings generated.


vim +1319 drivers/pci/controller/dwc/pcie-qcom.c

  1296	
  1297	static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
  1298	{
  1299		struct dw_pcie *pci = pcie->pci;
  1300		unsigned long freq_kbps;
  1301		struct dev_pm_opp *opp;
  1302		int ret, freq_mbps;
  1303	
  1304		if (pcie->icc_mem) {
  1305			ret = icc_set_bw(pcie->icc_mem, 0,
  1306					 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
  1307			if (ret) {
  1308				dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
  1309					ret);
  1310			}
  1311		} else if (pcie->use_pm_opp) {
  1312			freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
  1313			if (freq_mbps < 0)
  1314				return -EINVAL;
  1315	
  1316			freq_kbps = freq_mbps * KILO;
  1317			opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
  1318							 true);
> 1319			if (!IS_ERR(opp)) {
  1320				ret = dev_pm_opp_set_opp(pci->dev, opp);
  1321				if (ret)
  1322					dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
  1323						freq_kbps * width, ret);
  1324				dev_pm_opp_put(opp);
  1325			}
  1326		}
  1327	
  1328		return ret;
  1329	}
  1330	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

