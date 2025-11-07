Return-Path: <linux-pci+bounces-40550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D201DC3E592
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 04:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4C7B4E371C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 03:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50D92F6901;
	Fri,  7 Nov 2025 03:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdMebRk8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055962F616C;
	Fri,  7 Nov 2025 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486151; cv=none; b=ss2ow8b54v7eCIH0H8PPWzkPrf4gKZbrUhR7VmI6bnjUJFQF3dip3hSBXM6HTgjsf2pgInlrnAhmsHWideBbOpSgVSpdktVS5+6H4KRiRH9qetc/f919ukYiAHipMDn/sWZwVfx0PVTnWpR0OfnHJIgqQQ2WlxaH8pA182SGKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486151; c=relaxed/simple;
	bh=IImINCHPo8SydfXgzNxPKnocMV0I2PHbN0YbvkHwWSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HemAU03x2lIIOgW1qrfsAdlmLsDarhRvrjJ91z7QEGlC5cnSz4xG0ALqI+sYD0PUcNNsgkhBjsI0Bdqmpc3GuxV+X8PCrNAOteNjYZjDJG7bG9GpmOwozIu3KC7gVAFW7tmHK2DRp6UAKcQquAzYuU7/oirXPKSgSaHH93uNZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdMebRk8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762486150; x=1794022150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IImINCHPo8SydfXgzNxPKnocMV0I2PHbN0YbvkHwWSE=;
  b=JdMebRk8Xj33YjbNGVzPqXhj9xaqt2xFnHX4kF1uzam9FVCVUA/F/tlc
   kH3Yq9jJjUUw/MaRn9hHJGSMqwRsvGQb86oFomCdJKgiNLf/siODYq9a5
   ATYo8z7cdG1C6k41SydMFsMdzBY4VRdAfyOLs3cphWskqeVsu1K0ObdGn
   nF2f1A61ZGj+zdnx9jtQPkiJ/vUJ5q7WXcqpFfddqsuC1cwzp61PRE0jy
   CdfG2OweSCZQ4pgrvIULPwFOsu3buIm/5WbxpXfXolOCGcpI/QNCMCA3h
   8mrXCqTjZtizrsDqHDljZuHQ/Bi6QHgUxIXRQxWi8Rks+hhM37ddC91c5
   w==;
X-CSE-ConnectionGUID: NCei9HNURhaS5eYJvVeeIw==
X-CSE-MsgGUID: MueM+MNSQIWMykfIrhGjGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="82263948"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="82263948"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 19:29:09 -0800
X-CSE-ConnectionGUID: Z6/WTQBjRRq8v4/Nzqz/1g==
X-CSE-MsgGUID: phJBU6CNQ6OYLjJ23GpONA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="193102109"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2025 19:29:06 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHD9q-000Uem-1y;
	Fri, 07 Nov 2025 03:29:03 +0000
Date: Fri, 7 Nov 2025 11:28:26 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, will@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, linux-arm-msm@vger.kernel.org,
	zhangsenchuan@eswincomputing.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] PCI: dwc: Skip PME_Turn_Off and L2/L3 transition if
 no device is available
Message-ID: <202511071025.JM5nTGnO-lkp@intel.com>
References: <20251106061326.8241-4-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106061326.8241-4-manivannan.sadhasivam@oss.qualcomm.com>

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.18-rc4 next-20251106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/PCI-host-common-Add-an-API-to-check-for-any-device-under-the-Root-Ports/20251106-141822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20251106061326.8241-4-manivannan.sadhasivam%40oss.qualcomm.com
patch subject: [PATCH 3/3] PCI: dwc: Skip PME_Turn_Off and L2/L3 transition if no device is available
config: arm-randconfig-001-20251107 (https://download.01.org/0day-ci/archive/20251107/202511071025.JM5nTGnO-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511071025.JM5nTGnO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511071025.JM5nTGnO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware-host.c:1133:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1133 |         if (!pci_root_ports_have_device(pci->pp.bridge->bus))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware-host.c:1176:9: note: uninitialized use occurs here
    1176 |         return ret;
         |                ^~~
   drivers/pci/controller/dwc/pcie-designware-host.c:1133:2: note: remove the 'if' if its condition is always false
    1133 |         if (!pci_root_ports_have_device(pci->pp.bridge->bus))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1134 |                 goto stop_link;
         |                 ~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware-host.c:1131:9: note: initialize the variable 'ret' to silence this warning
    1131 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +1133 drivers/pci/controller/dwc/pcie-designware-host.c

  1126	
  1127	int dw_pcie_suspend_noirq(struct dw_pcie *pci)
  1128	{
  1129		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
  1130		u32 val;
  1131		int ret;
  1132	
> 1133		if (!pci_root_ports_have_device(pci->pp.bridge->bus))
  1134			goto stop_link;
  1135	
  1136		/*
  1137		 * If L1SS is supported, then do not put the link into L2 as some
  1138		 * devices such as NVMe expect low resume latency.
  1139		 */
  1140		if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
  1141			return 0;
  1142	
  1143		if (pci->pp.ops->pme_turn_off) {
  1144			pci->pp.ops->pme_turn_off(&pci->pp);
  1145		} else {
  1146			ret = dw_pcie_pme_turn_off(pci);
  1147			if (ret)
  1148				return ret;
  1149		}
  1150	
  1151		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
  1152					val == DW_PCIE_LTSSM_L2_IDLE ||
  1153					val <= DW_PCIE_LTSSM_DETECT_WAIT,
  1154					PCIE_PME_TO_L2_TIMEOUT_US/10,
  1155					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
  1156		if (ret) {
  1157			/* Only log message when LTSSM isn't in DETECT or POLL */
  1158			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
  1159			return ret;
  1160		}
  1161	
  1162		/*
  1163		 * Per PCIe r6.0, sec 5.3.3.2.1, software should wait at least
  1164		 * 100ns after L2/L3 Ready before turning off refclock and
  1165		 * main power. This is harmless when no endpoint is connected.
  1166		 */
  1167		udelay(1);
  1168	
  1169	stop_link:
  1170		dw_pcie_stop_link(pci);
  1171		if (pci->pp.ops->deinit)
  1172			pci->pp.ops->deinit(&pci->pp);
  1173	
  1174		pci->suspended = true;
  1175	
  1176		return ret;
  1177	}
  1178	EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
  1179	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

