Return-Path: <linux-pci+bounces-10528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB4093511E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED6CB22BEA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8414534A;
	Thu, 18 Jul 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPPtoIzQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FC144300;
	Thu, 18 Jul 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322654; cv=none; b=pVS1g7a9yjLobi/xBjAVGwex09eLck1EhliEIEkuY7KxMonQd+uDNHPQ9/nhH2W8HIfKGdfe+xIYa+GTQClAwIE0PV253resz1dPYdY4Lo/riq+tIIZre+e5k7N9a7m+7jSLwXVd+hzcDSjgKcgEQgwoPtkKToKQsjfSqJ6gWxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322654; c=relaxed/simple;
	bh=n33IQJIKmhz52gVW94yS+nDVo20lt9j5mcPLmaVzON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgAB9qajNR7gZkYBMcAH6/SGjzQlPeqS8w/o2YAS56rz4hW79RgehO4H1rSx0nAf6Magnd57R1AIxtRj8Qep+/MAs1PuvTZMsYcts8rPr6QwXVZZEELYK3WuJHh4ejyrF93uAZiAYeHylc7XDdVSgSIYCvjZRX/nC99fHzHAd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPPtoIzQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721322652; x=1752858652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n33IQJIKmhz52gVW94yS+nDVo20lt9j5mcPLmaVzON4=;
  b=PPPtoIzQHnRNhTmogWfiPIq82Ae1Fs9z8jTMvDX26t7KPR1X8YyxtTBC
   myUDX89AcQCuisNrYq7XNSE2Q7kggQxuZ8FIXe81nJANgpzmuPVAwe4iK
   HhuHSitye1XAAfj0wvx357+HeTV7TQHsuwkBWny2zSmR0N/6xrboKJ9cZ
   d2uqn+qkWkovvU2tnIf/8WsmOse1OMakAqL9tBWnkF/MgfxPYIaYNiykz
   gKs21FKzKcekI4AY+dRHCkcISQedQIwiquww3iaUyumwy5ZJtBra4z+n/
   XLB2SvF4hfwqQ2kUODqM/JNppZhOPnDg95ttL1gzmNgBfAltvxEvKtFIs
   w==;
X-CSE-ConnectionGUID: gzA/KCLHRUGaJMLBtCLfUA==
X-CSE-MsgGUID: 2XIodvfjTE+HEwuUKqFiPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="12612529"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="12612529"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 10:10:51 -0700
X-CSE-ConnectionGUID: cw1Mc/AbQ7yBC0ZFnkEc2A==
X-CSE-MsgGUID: zxFxd2nNTDGm9ENgS2X6Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="81862218"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jul 2024 10:10:48 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUUeT-000hSM-1g;
	Thu, 18 Jul 2024 17:10:45 +0000
Date: Fri, 19 Jul 2024 01:10:35 +0800
From: kernel test robot <lkp@intel.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, rafael@kernel.org, lenb@kernel.org,
	james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
	bhelgaas@google.com, robert.moore@intel.com, yazen.ghannam@amd.com,
	avadhut.naik@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, TonyWWang-oc@zhaoxin.com,
	leoliu-oc@zhaoxin.com
Subject: Re: [PATCH v3 1/3] ACPI/APEI: Add hest_parse_pcie_aer()
Message-ID: <202407190015.eutiIYQp-lkp@intel.com>
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
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240719/202407190015.eutiIYQp-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240719/202407190015.eutiIYQp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407190015.eutiIYQp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/apei/hest.c:157:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     157 |         case ACPI_HEST_TYPE_AER_ENDPOINT:
         |         ^
   drivers/acpi/apei/hest.c:157:2: note: insert '__attribute__((fallthrough));' to silence this warning
     157 |         case ACPI_HEST_TYPE_AER_ENDPOINT:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/acpi/apei/hest.c:157:2: note: insert 'break;' to avoid fall-through
     157 |         case ACPI_HEST_TYPE_AER_ENDPOINT:
         |         ^
         |         break; 
   drivers/acpi/apei/hest.c:160:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     160 |         case ACPI_HEST_TYPE_AER_BRIDGE:
         |         ^
   drivers/acpi/apei/hest.c:160:2: note: insert '__attribute__((fallthrough));' to silence this warning
     160 |         case ACPI_HEST_TYPE_AER_BRIDGE:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/acpi/apei/hest.c:160:2: note: insert 'break;' to avoid fall-through
     160 |         case ACPI_HEST_TYPE_AER_BRIDGE:
         |         ^
         |         break; 
   drivers/acpi/apei/hest.c:163:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     163 |         default:
         |         ^
   drivers/acpi/apei/hest.c:163:2: note: insert '__attribute__((fallthrough));' to silence this warning
     163 |         default:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/acpi/apei/hest.c:163:2: note: insert 'break;' to avoid fall-through
     163 |         default:
         |         ^
         |         break; 
   3 warnings generated.


vim +157 drivers/acpi/apei/hest.c

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
   155			if (pcie_type != PCI_EXP_TYPE_ROOT_PORT)
   156				return false;
 > 157		case ACPI_HEST_TYPE_AER_ENDPOINT:
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

