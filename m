Return-Path: <linux-pci+bounces-35419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9D0B43074
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 05:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F135E7C6B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 03:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B2293C4E;
	Thu,  4 Sep 2025 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nW/g39gI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955632877E3;
	Thu,  4 Sep 2025 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756956157; cv=none; b=hkN1OBYLi0YD/5tGf5db9zeZGA56iVPLJM3vXrkmEL1Y3+lMv96pn1fiAXOvEkd4Scgt6yCpr2ws2nBECaZI+/LI4ZJQ87HvDuipMO2KPgfV75LroNAanPwlyZ9kITbfSUcqMZLX6k4QF+1tgS+LbhUWrRN3lSlh01Wm0NFagZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756956157; c=relaxed/simple;
	bh=bNSAahrLsh5lIaRJtRcrZ2VrezcQXtPhuB+zZ94/O9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkNZWFdPt1o4Nbr0ktpwPaoxVn4IpcUhU6b1rsQcdJUZ066F4T8P8/gJhAgoXSRyTb0+o0cA//pKXdL8ldCSNjsCZNzwjIf3kfVuSBoPZOc4S4myW12gIuH50/OaOwuOfyu64ABDNievEk/L5IBPmULaq5/9H41K03bdpVIshx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nW/g39gI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756956156; x=1788492156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bNSAahrLsh5lIaRJtRcrZ2VrezcQXtPhuB+zZ94/O9Q=;
  b=nW/g39gI6GK2t0cLfd2hQg4s+31u2Nm0nLHA27HdUYSWozlntN7n9seN
   ajeyO2b6W2fs4aY9ESQAYoze4pYF2+cSsG6C1/2RmTihON1NmK3bKCB9L
   XQmhZtDZxfn0vDXzvPivDtYVc0GbCp6ub/BWEQR0HSSyBNNDBaPPf/rpQ
   4vjN0MJ9erj0CvO1+rJRfoisBsWDhgZV+qytfAfoDtq4HdW6apObWB0Er
   XKNy+/PN9z+wvAtzrFOsEkrNNbcWHa/g0Ctb/TXbHvZMMx/mgyt1+UxZ0
   0+2992AKu9yMe2+uDFvSEM3LPNj9+eomFlf1l/i2laRI7Kw9glHUpvi+Y
   Q==;
X-CSE-ConnectionGUID: W05EzdIMR9OWrDpDlxtI/w==
X-CSE-MsgGUID: P8HsuEztSSCEME/G9pnarQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="76888141"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="76888141"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 20:22:35 -0700
X-CSE-ConnectionGUID: 5lDAPx0BTNOEIpwwL2WBRA==
X-CSE-MsgGUID: oUclYMeDRJiAetZVddROEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="171056164"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 03 Sep 2025 20:22:31 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uu0YO-0004hL-2j;
	Thu, 04 Sep 2025 03:22:28 +0000
Date: Thu, 4 Sep 2025 11:19:30 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 5/5] PCI: qcom: Allow pwrctrl core to toggle PERST#
 for new DT binding
Message-ID: <202509041110.4DgQKyf1-lkp@intel.com>
References: <20250903-pci-pwrctrl-perst-v2-5-2d461ed0e061@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-pci-pwrctrl-perst-v2-5-2d461ed0e061@oss.qualcomm.com>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f5ae30d69d7543eee0d70083daf4de8fe15d585]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-qcom-Wait-for-PCIE_RESET_CONFIG_WAIT_MS-after-PERST-deassert/20250903-151623
base:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
patch link:    https://lore.kernel.org/r/20250903-pci-pwrctrl-perst-v2-5-2d461ed0e061%40oss.qualcomm.com
patch subject: [PATCH v2 5/5] PCI: qcom: Allow pwrctrl core to toggle PERST# for new DT binding
config: i386-buildonly-randconfig-002-20250904 (https://download.01.org/0day-ci/archive/20250904/202509041110.4DgQKyf1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250904/202509041110.4DgQKyf1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509041110.4DgQKyf1-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-qcom.c: In function 'qcom_pcie_host_init':
>> drivers/pci/controller/dwc/pcie-qcom.c:1405:23: error: 'struct pci_host_bridge' has no member named 'toggle_perst'
    1405 |         pci->pp.bridge->toggle_perst = qcom_pcie_toggle_perst;
         |                       ^~


vim +1405 drivers/pci/controller/dwc/pcie-qcom.c

  1368	
  1369	static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
  1370	{
  1371		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
  1372		struct qcom_pcie *pcie = to_qcom_pcie(pci);
  1373		int ret;
  1374	
  1375		qcom_ep_reset_assert(pcie, NULL);
  1376	
  1377		ret = pcie->cfg->ops->init(pcie);
  1378		if (ret)
  1379			return ret;
  1380	
  1381		ret = qcom_pcie_phy_power_on(pcie);
  1382		if (ret)
  1383			goto err_deinit;
  1384	
  1385		if (pcie->cfg->ops->post_init) {
  1386			ret = pcie->cfg->ops->post_init(pcie);
  1387			if (ret)
  1388				goto err_disable_phy;
  1389		}
  1390	
  1391		/*
  1392		 * Only deassert PERST# for all devices here if legacy binding is used.
  1393		 * For the new binding, pwrctrl driver is expected to toggle PERST# for
  1394		 * individual devices.
  1395		 */
  1396		if (list_empty(&pcie->perst))
  1397			qcom_ep_reset_deassert(pcie, NULL);
  1398	
  1399		if (pcie->cfg->ops->config_sid) {
  1400			ret = pcie->cfg->ops->config_sid(pcie);
  1401			if (ret)
  1402				goto err_assert_reset;
  1403		}
  1404	
> 1405		pci->pp.bridge->toggle_perst = qcom_pcie_toggle_perst;
  1406	
  1407		return 0;
  1408	
  1409	err_assert_reset:
  1410		qcom_ep_reset_assert(pcie, NULL);
  1411	err_disable_phy:
  1412		qcom_pcie_phy_power_off(pcie);
  1413	err_deinit:
  1414		pcie->cfg->ops->deinit(pcie);
  1415	
  1416		return ret;
  1417	}
  1418	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

