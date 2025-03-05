Return-Path: <linux-pci+bounces-22965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16D0A4FEA5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2610D7A7011
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8956243369;
	Wed,  5 Mar 2025 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBvJ8s4M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B012230BD9
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177986; cv=none; b=Y+CSUAWADU6lvGuRnC1UIIoLd3r2y0V8cIgVs9/71LMC0uhgfMSGtEwYiAq2MxuiCxWqcOBtTnbdr3y8C+/Nb8J7/nPEut7mO6lz7aY9v2BeJOsbAgkJLzf9FSvEJaXFtzILnzK9yKk7wLlbfa1A/4exW2PM7b6Gu8AgOk3Z0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177986; c=relaxed/simple;
	bh=MY4NkJMgNuThrBNquBSiScNhOWXhVfL9Nxx5FV6sinA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT24mxf+h+OLg+KUVK78g7gi0coR0R/D6IvmU0bGw+EqeRzqu+6bYu9jFb77S9Qw6OvWd48F7a8T9Z3y4LG0D91COi3awWro3ClM8IllzhXyhRww+hYkpcAbil/TKXsUH8XcA987WqKUM3KGiObwdI3jS9MMrI0jECNGa2H01jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBvJ8s4M; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741177985; x=1772713985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MY4NkJMgNuThrBNquBSiScNhOWXhVfL9Nxx5FV6sinA=;
  b=PBvJ8s4Mq2HtJ9sABq0LRPdq8agKVlOF2MCInBs3fnGbQHpbtgLJZekF
   Kax6upScB/rR+B90NeWEfr+qefOeSgaYidCRJOcl3U9VgwqQMXfdqcf1p
   4z26da4fWSHtuYRt5wy2pNLo1YzvLCXnQL/g5i92MCRLNFgl2qvirfZSv
   xRu/Zm/7vwYWiR5xMgmiE2mTYDaGOAdYZPJAS2vwVTB9oTxHDI7r+8HBf
   Ar9KPAEqLHjjgwBxVHHScOYOVZk80vuHE5em+UWImmD/e0PF79wIEpmEe
   qsHtRp0lA14SfnIaGvkQSGjb4lDJ0dWDxB43NTjXAmRnIP98vckbrALfB
   w==;
X-CSE-ConnectionGUID: N9kb5clBTRuqeI8d7IJwLw==
X-CSE-MsgGUID: +iroa+DKTa2inI0LVH2nCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42274289"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42274289"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 04:33:04 -0800
X-CSE-ConnectionGUID: M81unOAeSiCDOjADajyr1Q==
X-CSE-MsgGUID: K+SUYzkkQAaYguIVDQXFNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155889623"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Mar 2025 04:33:01 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpnvn-000Kws-0k;
	Wed, 05 Mar 2025 12:32:59 +0000
Date: Wed, 5 Mar 2025 20:32:46 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <202503052042.Clxxh3ZH-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 7eb172143d5508b4da468ed59ee857c6e5e01da6]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/configfs-tsm-Namespace-TSM-report-symbols/20250304-152958
base:   7eb172143d5508b4da468ed59ee857c6e5e01da6
patch link:    https://lore.kernel.org/r/174107250147.1288555.16948528371146013276.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20250305/202503052042.Clxxh3ZH-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503052042.Clxxh3ZH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503052042.Clxxh3ZH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/ide.c:322:3: error: expected expression
                   struct pci_dev *rp = pcie_find_root_port(ide->pdev);
                   ^
>> drivers/pci/ide.c:326:20: error: use of undeclared identifier 'rp'
                                         pci_name(rp));
                                                  ^
   2 errors generated.


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
 > 326					      pci_name(rp));
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

