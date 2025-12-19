Return-Path: <linux-pci+bounces-43347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A19EBCCE802
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 06:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67844302ABAA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 05:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B22222C4;
	Fri, 19 Dec 2025 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miNJO5tr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862022D793
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766121356; cv=none; b=HM55QSLzxkLACU/OU0bj0xJci5UyfiFS1Y6EZxJj3qjnQNUg/AdOFHIOFWc44D4ckANkP/zWtwPB79+nqBicZnY2VreL5dzNZeP5lerdNG5+IAlGU+l++BBFPICN1EeKjV24mC2jj+BwyvJxx1O13MuI8V08bnuDBgriHBI93AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766121356; c=relaxed/simple;
	bh=cFqyeFbB1zVEz+ivYITj2OeUc7Hd+oEnsWJEaRGYWjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OsXQPAo2eWzFZlSPH755D2Pt8TTRAGJhTD+jK8CFIHNuHJxqNfTH0F7BRdIt25za40Ag5SVsMvuMvTyPzu2y73iB1htHYamBSBqXXtvaYMOpvNIre/VWiwIPE8z7SFYpwpExQCmwDGr+hf1a2db/DXBGrsL/gZbaRqakuRHN9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miNJO5tr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766121355; x=1797657355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cFqyeFbB1zVEz+ivYITj2OeUc7Hd+oEnsWJEaRGYWjg=;
  b=miNJO5trWwxvXk6DrQh4auVbZNSR/YJnXbha7oZtzpeZmnuZw3wz+rOI
   vauljEHxynLPr1twGGyQ7zPh/CkmZAMFuY6sPdGk54/Wygy25Sd4kQh3v
   /TFN5aFrYIzZiZm6CXPmhLcktOq0gAM8dfbPQHhFLFGQZm8kWCbVohpDK
   +595hyHCmqnjCz7ATDQ8XHMzUP1v/lGWxOGi/O+9t01crpr6cqmK6IcM/
   0ShEg2shWsMlG5DRla7tj2CbwfurS7xDcjc6l8+E8CoP+jAFV3vTkxJEZ
   ZiBMpgcSdkE0GMt4YlEZPkzoMD7ZvoQPlR0fIq85FexEk8Ph6P/2sWCVZ
   A==;
X-CSE-ConnectionGUID: TNHp1w9pQJyeyyp80spMEw==
X-CSE-MsgGUID: Zx62NsgbTXGBeG7Txkv3zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="93556432"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="93556432"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 21:15:54 -0800
X-CSE-ConnectionGUID: +zQry788TjetSQu2CUO0Hw==
X-CSE-MsgGUID: Y6uVMh4hQQOk0iJkU/K5eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="198372333"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Dec 2025 21:15:52 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWSqE-0000000033Y-2cSe;
	Fri, 19 Dec 2025 05:15:50 +0000
Date: Fri, 19 Dec 2025 13:15:28 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [pci:controller/dwc 8/8]
 drivers/pci/controller/dwc/pcie-designware-host.c:1175:6: warning: variable
 'ret' is used uninitialized whenever 'if' condition is true
Message-ID: <202512191339.583iyg1a-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
head:   c4a86e6600fa082d6646044fcce2183ad5e52283
commit: c4a86e6600fa082d6646044fcce2183ad5e52283 [8/8] PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3 transition during suspend if link is not up
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20251219/202512191339.583iyg1a-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251219/202512191339.583iyg1a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512191339.583iyg1a-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware-host.c:1175:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1175 |         if (!dw_pcie_link_up(pci))
         |             ^~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware-host.c:1218:9: note: uninitialized use occurs here
    1218 |         return ret;
         |                ^~~
   drivers/pci/controller/dwc/pcie-designware-host.c:1175:2: note: remove the 'if' if its condition is always false
    1175 |         if (!dw_pcie_link_up(pci))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
    1176 |                 goto stop_link;
         |                 ~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware-host.c:1173:9: note: initialize the variable 'ret' to silence this warning
    1173 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +1175 drivers/pci/controller/dwc/pcie-designware-host.c

  1168	
  1169	int dw_pcie_suspend_noirq(struct dw_pcie *pci)
  1170	{
  1171		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
  1172		u32 val;
  1173		int ret;
  1174	
> 1175		if (!dw_pcie_link_up(pci))
  1176			goto stop_link;
  1177	
  1178		/*
  1179		 * If L1SS is supported, then do not put the link into L2 as some
  1180		 * devices such as NVMe expect low resume latency.
  1181		 */
  1182		if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
  1183			return 0;
  1184	
  1185		if (pci->pp.ops->pme_turn_off) {
  1186			pci->pp.ops->pme_turn_off(&pci->pp);
  1187		} else {
  1188			ret = dw_pcie_pme_turn_off(pci);
  1189			if (ret)
  1190				return ret;
  1191		}
  1192	
  1193		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
  1194					val == DW_PCIE_LTSSM_L2_IDLE ||
  1195					val <= DW_PCIE_LTSSM_DETECT_WAIT,
  1196					PCIE_PME_TO_L2_TIMEOUT_US/10,
  1197					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
  1198		if (ret) {
  1199			/* Only log message when LTSSM isn't in DETECT or POLL */
  1200			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
  1201			return ret;
  1202		}
  1203	
  1204		/*
  1205		 * Per PCIe r6.0, sec 5.3.3.2.1, software should wait at least
  1206		 * 100ns after L2/L3 Ready before turning off refclock and
  1207		 * main power. This is harmless when no endpoint is connected.
  1208		 */
  1209		udelay(1);
  1210	
  1211	stop_link:
  1212		dw_pcie_stop_link(pci);
  1213		if (pci->pp.ops->deinit)
  1214			pci->pp.ops->deinit(&pci->pp);
  1215	
  1216		pci->suspended = true;
  1217	
  1218		return ret;
  1219	}
  1220	EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
  1221	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

