Return-Path: <linux-pci+bounces-22906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B6A4EEAA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 21:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D63AAE1D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 20:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875D325F965;
	Tue,  4 Mar 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7kC52JP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BF277817
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121093; cv=none; b=Tsj7MyNERljVVao5c2XsAHtnj/NknLmUznvxFjJVALrf6b6r/WU/bLgvYf90t8ebjl2rlmDU9zr15h180Lm/N0fg3LPsJi0Gd3VuLiSzmCrdAgYbPPa4eVnUdxqA2bGUBm1kKx87t1tgNMAljdDGfUo88e+Ad1Mniea0T1Mmt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121093; c=relaxed/simple;
	bh=Vnv99RWNGluKpYHXL7lFNjVLkjdeSGN36GQK6E9XPj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFxWsZiY7ofF2P/xkhbsjn+tXC1CHsLFBLDXXFzSoYqbZp+XiooZqfWlrIHmWEZgf+NNbLeQMUr3k9PrBQLbVYWAhviAm7hLw4ejA8cATq6FL5ly7SoB17BGS8QDWA+q/ST77ygJPIDXdZuQQW1Gkgc61Em8dv1rK8kkDB5cBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7kC52JP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741121092; x=1772657092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vnv99RWNGluKpYHXL7lFNjVLkjdeSGN36GQK6E9XPj8=;
  b=i7kC52JPX5Or3IPYTnxo+ERcvM4dxnXKp4lR6gCuLSJ3F8JzwOVYPbON
   3B22wqeZoZ8oqoSt7Hpth49Oaw6d459tSsNLtBMtYKDaFmQPA6F/5dl50
   DNhTSPWdRCTMjnFlr7P2ZPwFTOLvr6/3+teRBmf3yZD+zKZBWdHbOqHog
   z7KWCZgELys2EdEHSB7A1f3N2Rs3uuGBJhdC338/CziomXtwFhAGUYlnh
   tNW1rYtKeXIy71vdIbnihPt5nT1zNbxULphkhdBbNTio0MBPFDtesynF2
   gsFQVVfS1KDZt90NgzkvDpQ2MQ6EgttTN1sb6KPV7RGPLknlfMnIKVvS1
   A==;
X-CSE-ConnectionGUID: FTqprg+MRY+WX/Bo8Vl9Eg==
X-CSE-MsgGUID: GGuMpKMLTAG5bbaOC15xdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="44867513"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="44867513"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 12:44:51 -0800
X-CSE-ConnectionGUID: zSPDW30oSReEUr3P2Iihwg==
X-CSE-MsgGUID: 6Nkh5EyLQiOggjWVC1fsaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118379129"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 04 Mar 2025 12:44:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpZ89-000KFe-1h;
	Tue, 04 Mar 2025 20:44:45 +0000
Date: Wed, 5 Mar 2025 04:44:31 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <202503050439.9Ubeq0dP-lkp@intel.com>
References: <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7eb172143d5508b4da468ed59ee857c6e5e01da6]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/configfs-tsm-Namespace-TSM-report-symbols/20250304-152958
base:   7eb172143d5508b4da468ed59ee857c6e5e01da6
patch link:    https://lore.kernel.org/r/174107250147.1288555.16948528371146013276.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250305/202503050439.9Ubeq0dP-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503050439.9Ubeq0dP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503050439.9Ubeq0dP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/ide.c:7:
   In file included from include/linux/pci.h:37:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/ide.c:322:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     322 |                 struct pci_dev *rp = pcie_find_root_port(ide->pdev);
         |                 ^
   4 warnings generated.


vim +322 drivers/pci/ide.c

   306	
   307	static struct pci_ide_partner *to_settings(struct pci_dev *pdev, struct pci_ide *ide)
   308	{
   309		if (!pci_is_pcie(pdev)) {
   310			pci_warn_once(pdev, "not a PCIe device\n");
   311			return NULL;
   312		}
   313	
   314		switch (pci_pcie_type(pdev)) {
   315		case PCI_EXP_TYPE_ENDPOINT:
   316			if (pdev != ide->pdev) {
   317				pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
   318				return NULL;
   319			}
   320			return &ide->partner[PCI_IDE_EP];
   321		case PCI_EXP_TYPE_ROOT_PORT:
 > 322			struct pci_dev *rp = pcie_find_root_port(ide->pdev);
   323	
   324			if (pdev != pcie_find_root_port(ide->pdev)) {
   325				pci_warn_once(pdev, "setup expected Root Port: %s\n",
   326					      pci_name(rp));
   327				return NULL;
   328			}
   329			return &ide->partner[PCI_IDE_RP];
   330		default:
   331			pci_warn_once(pdev, "invalid device type\n");
   332			return NULL;
   333		}
   334	}
   335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

