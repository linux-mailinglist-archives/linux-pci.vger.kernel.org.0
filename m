Return-Path: <linux-pci+bounces-10532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C1C935162
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 19:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4A5283EC0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B114535D;
	Thu, 18 Jul 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmgOcFNc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A01145356;
	Thu, 18 Jul 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721325295; cv=none; b=WgM2yTURSFpMF4f7oKdK9dvpUojFW2K4D4gpDenq2+7KWR4Xua+QERBM7BmL8ssxz4cbsSfMkYmlRJ/HcQk6rB0IMcG47OBOa/yJIYbiA84HbzODhx23035dNNBosxw2XLHaRt0e+DS44OJ2Gdmno5VM9iOFlyUI8aB3ovGBX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721325295; c=relaxed/simple;
	bh=X6jIlfRKMPKmywDaK5B+vu56+DcG5UEkdLppnfbwn9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqOThebVCh5kq6WI8auICdbd/dAsmfMDue7N2llQFw3xoYR3yExPbdFgYGo3oc+btpsQshNPEKJHHkJJ1BusqT71kqOzKIgYtl8nPe6uePZgX57lX0ZSO1BQ4ffVi3njSD3wcnN8OkiYzNaDFx+wB2qqgYnhc0ciRnJZesSQ5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmgOcFNc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721325294; x=1752861294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X6jIlfRKMPKmywDaK5B+vu56+DcG5UEkdLppnfbwn9A=;
  b=YmgOcFNchRrZL1FMwzsAV7awQOnjkgKYlITUwJTgq6KO2oTldx5nDqRS
   UMKQ81xIbizHqk4IXaVIZfJHKZjrOntgczVd2qAGETR99UY31OUSH6FfR
   XneohxTVEZTH97eqSWgx/A3b2R+0QPmyzOlX6GZDWQQsVf1FMsF7sN2yN
   dPIOQauBuJt+AsBBlc98ajByQ7qV0pRFiST2VSdd3zca67kUritvKSCuG
   C/PXpRw3ic5HkD4XCUhGE27XwvCDI5jjHV62AhBzycm0IUckdjmsQuR0u
   4RgrXt9wq1IIK7aljhRP87m+RIj17Ud5Wq6gLXgo7CU6KFBV50QjDij5a
   A==;
X-CSE-ConnectionGUID: jlP5v9jpR4aUQVrheE2Qzg==
X-CSE-MsgGUID: odVTBz95QSu3Om7p6VVC5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="30067124"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="30067124"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 10:54:53 -0700
X-CSE-ConnectionGUID: DmbDazKDTIujuQlms22ytw==
X-CSE-MsgGUID: 6HtGeUCMTcSNafbbvmS4HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="50606615"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jul 2024 10:54:48 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUVL4-000hUQ-1g;
	Thu, 18 Jul 2024 17:54:46 +0000
Date: Fri, 19 Jul 2024 01:53:47 +0800
From: kernel test robot <lkp@intel.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, rafael@kernel.org, lenb@kernel.org,
	james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
	bhelgaas@google.com, robert.moore@intel.com, yazen.ghannam@amd.com,
	avadhut.naik@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com,
	TonyWWang-oc@zhaoxin.com, leoliu-oc@zhaoxin.com
Subject: Re: [PATCH v3 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
Message-ID: <202407190133.KRXYQI5m-lkp@intel.com>
References: <20240718062405.30571-2-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718062405.30571-2-LeoLiu-oc@zhaoxin.com>

Hi LeoLiu-oc,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/for-linus]
[also build test WARNING on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.10 next-20240718]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/ACPI-APEI-Add-hest_parse_pcie_aer/20240718-144218
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20240718062405.30571-2-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH v3 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
config: x86_64-randconfig-161-20240718 (https://download.01.org/0day-ci/archive/20240719/202407190133.KRXYQI5m-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407190133.KRXYQI5m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407190133.KRXYQI5m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/apei/hest.c: In function 'hest_source_is_pcie_aer':
>> drivers/acpi/apei/hest.c:155:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
     155 |                 if (pcie_type != PCI_EXP_TYPE_ROOT_PORT)
         |                    ^
   drivers/acpi/apei/hest.c:157:9: note: here
     157 |         case ACPI_HEST_TYPE_AER_ENDPOINT:
         |         ^~~~
   drivers/acpi/apei/hest.c:158:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
     158 |                 if (pcie_type != PCI_EXP_TYPE_ENDPOINT)
         |                    ^
   drivers/acpi/apei/hest.c:160:9: note: here
     160 |         case ACPI_HEST_TYPE_AER_BRIDGE:
         |         ^~~~
   drivers/acpi/apei/hest.c:161:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
     161 |                 if (pcie_type != PCI_EXP_TYPE_PCI_BRIDGE && pcie_type != PCI_EXP_TYPE_PCIE_BRIDGE)
         |                    ^
   drivers/acpi/apei/hest.c:163:9: note: here
     163 |         default:
         |         ^~~~~~~


vim +155 drivers/acpi/apei/hest.c

   144	
   145	static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr, struct pci_dev *dev)
   146	{
   147		u16 hest_type = hest_hdr->type;
   148		u8 pcie_type = pci_pcie_type(dev);
   149		struct acpi_hest_aer_common *common;
   150	
   151		common = (struct acpi_hest_aer_common *)(hest_hdr + 1);
   152	
   153		switch (hest_type) {
   154		case ACPI_HEST_TYPE_AER_ROOT_PORT:
 > 155			if (pcie_type != PCI_EXP_TYPE_ROOT_PORT)
   156				return false;
   157		case ACPI_HEST_TYPE_AER_ENDPOINT:
   158			if (pcie_type != PCI_EXP_TYPE_ENDPOINT)
   159				return false;
   160		case ACPI_HEST_TYPE_AER_BRIDGE:
   161			if (pcie_type != PCI_EXP_TYPE_PCI_BRIDGE && pcie_type != PCI_EXP_TYPE_PCIE_BRIDGE)
   162				return false;
   163		default:
   164			return false;
   165		}
   166	
   167		if (common->flags & ACPI_HEST_GLOBAL)
   168			return true;
   169	
   170		if (hest_match_pci_devfn(common, dev))
   171			return true;
   172	
   173		return false;
   174	}
   175	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

