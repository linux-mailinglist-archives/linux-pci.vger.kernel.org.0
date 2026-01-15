Return-Path: <linux-pci+bounces-44943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A30CD24D16
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2D6D302C8E2
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE739C64A;
	Thu, 15 Jan 2026 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fScTsD0z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7438D361DD1;
	Thu, 15 Jan 2026 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485013; cv=none; b=WjbokAONfccewjisqk4uTMGO/FWjofBYndllXa15Y31im4Ah2JRJsCwT2gztaxRjg2MHVPfv3qsoj7PsFLws4furxeiXf2ZOmvSlrUIYPkPkyxP71HaaY+y+hfseaYWceIl+j0XWwMjHzx9htIWLppUoUNw7wqbEMayZbbc2uq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485013; c=relaxed/simple;
	bh=9BuasZ0t33a7AsjKXVovC2XLmPpO90VhX+AWfX4/5cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ak4XuW+uO7vzLRtpKMejai3G+hQxBfuF/b+IyZXFOVaxq/lNT+HZ8lexnYMgYUB4ZUDXtSPqMmpemN8vJ1APBF45WeHPP++yvrpOld/Ekj062xe8zt5/UTugKxcGJa4CpZAUKYQo6qrg2i/TrTuKV8ZFpyCQRDE5Ek1sKGgrFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fScTsD0z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768485011; x=1800021011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BuasZ0t33a7AsjKXVovC2XLmPpO90VhX+AWfX4/5cY=;
  b=fScTsD0zvJleJjihxGPHylvh8WVboaYf4StEhkgPl7ErOZmx2f6adFQk
   oI7IS+w095dA4Ez2w1FE+F8TfDAqgjzfB2len/cPAraPQBSV0jOVWO1fU
   SEzfrme6ZGvbzW4SY3HvlGhJbm/thkDNUViyjzBWCyF/TYKJx/ylRHfWf
   xXlflRh7iSYxBgB6hRtFyJxC4pyCzLpJ3K3AqxyPSsKUQ1j2ertnDPs/w
   xyG71EE6xq/DG0rJtgNGVE20QFrD/LUfP9uHj/ZFY5O3M3LsJvFxJRhCf
   LAH4QZ8ymSSYuqZxvXs/Tr1VPO7o8xIXKcGZoU5BM8VrulcmiQxhKgVN7
   Q==;
X-CSE-ConnectionGUID: 8xUdU+aoSGKI+152Pih5pQ==
X-CSE-MsgGUID: Pj/iApEnT62LOk/kr1MtGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="73641271"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="73641271"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 05:50:11 -0800
X-CSE-ConnectionGUID: AZ9/3ya5TCiOyR984WpPMA==
X-CSE-MsgGUID: AGN9oiwIQOiOpBYwKn7DfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="204838423"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jan 2026 05:50:06 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgNjg-00000000I1s-0ySb;
	Thu, 15 Jan 2026 13:50:04 +0000
Date: Thu, 15 Jan 2026 21:49:06 +0800
From: kernel test robot <lkp@intel.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH 10/16] PCI: rzg3s-host: Explicitly set class code for
 RZ/G3E compatibility
Message-ID: <202601152104.pV9uMS76-lkp@intel.com>
References: <20260114153337.46765-11-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114153337.46765-11-john.madieu.xa@bp.renesas.com>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260114]
[cannot apply to pci/next pci/for-linus geert-renesas-devel/next geert-renesas-drivers/renesas-clk linus/master v6.19-rc5 v6.19-rc4 v6.19-rc3 v6.19-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Madieu/PCI-rzg3s-host-Fix-reset-handling-in-probe-error-path/20260114-234634
base:   next-20260114
patch link:    https://lore.kernel.org/r/20260114153337.46765-11-john.madieu.xa%40bp.renesas.com
patch subject: [PATCH 10/16] PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
config: powerpc64-randconfig-002-20260115 (https://download.01.org/0day-ci/archive/20260115/202601152104.pV9uMS76-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601152104.pV9uMS76-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601152104.pV9uMS76-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-rzg3s-host.c:1090:11: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    1090 |                                FIELD_PREP(mask, PCI_CLASS_BRIDGE_PCI_NORMAL));
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:137:3: note: expanded from macro 'FIELD_PREP'
     137 |                 __BF_FIELD_CHECK_REG(_mask, 0ULL, "FIELD_PREP: ");      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:79:50: note: expanded from macro '__BF_FIELD_CHECK_REG'
      79 |         BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
      80 |                          __bf_cast_unsigned(reg, ~0ull),                \
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      81 |                          pfx "type of reg too small for mask")
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/linux/compiler_types.h:667:22: note: expanded from macro 'compiletime_assert'
     667 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:655:23: note: expanded from macro '_compiletime_assert'
     655 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:647:9: note: expanded from macro '__compiletime_assert'
     647 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   1 warning generated.


vim +1090 drivers/pci/controller/pcie-rzg3s-host.c

  1057	
  1058	static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
  1059	{
  1060		struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
  1061		u32 mask = GENMASK(31, 8);
  1062		struct resource_entry *ft;
  1063		struct resource *bus;
  1064		u8 subordinate_bus;
  1065		u8 secondary_bus;
  1066		u8 primary_bus;
  1067	
  1068		ft = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
  1069		if (!ft)
  1070			return -ENODEV;
  1071	
  1072		bus = ft->res;
  1073		primary_bus = bus->start;
  1074		secondary_bus = bus->start + 1;
  1075		subordinate_bus = bus->end;
  1076	
  1077		/* Enable access control to the CFGU */
  1078		writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
  1079			       host->axi + RZG3S_PCI_PERM);
  1080	
  1081		/* HW manual recommends to write 0xffffffff on initialization */
  1082		writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
  1083		writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
  1084	
  1085		/*
  1086		 * Explicitly program class code. RZ/G3E requires this configuration.
  1087		 * Harmless for RZ/G3S where this matches the hardware default.
  1088		 */
  1089		rzg3s_pcie_update_bits(host->pcie, PCI_CLASS_REVISION, mask,
> 1090				       FIELD_PREP(mask, PCI_CLASS_BRIDGE_PCI_NORMAL));
  1091	
  1092		/* Disable access control to the CFGU */
  1093		writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
  1094	
  1095		/* Update bus info */
  1096		writeb_relaxed(primary_bus, host->pcie + PCI_PRIMARY_BUS);
  1097		writeb_relaxed(secondary_bus, host->pcie + PCI_SECONDARY_BUS);
  1098		writeb_relaxed(subordinate_bus, host->pcie + PCI_SUBORDINATE_BUS);
  1099	
  1100		return 0;
  1101	}
  1102	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

