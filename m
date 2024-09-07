Return-Path: <linux-pci+bounces-12922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE2097030C
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02078B21AC4
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DAB15C131;
	Sat,  7 Sep 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb0g/hPe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6FA93D;
	Sat,  7 Sep 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725724377; cv=none; b=ftRVl5MhFoi6klX43JEkYQUXHa4V4PYnjq/EUu7p1E71/HLPTAjRlLBZiwLKwTC8pxx7CBseBPNtv263tTs8JzK3xumHvDjcGr4Akl6VKyfgBem7OBu/l/VVwVHkHaatYlQ5Y9IfcI5OeUxnkzPYqkUhWDNBbo/1PDylAiFvuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725724377; c=relaxed/simple;
	bh=af2RuJlyRSy9sAYrpdJKVJIieJRObkqtTIwAoB3wxGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYA6trq3eGVv/9BBCYaJMFqAs6t5jRss+v3pPUrI0+tOiJ1nXK/vzbS2x/XU4O3jPmYR0bUBcIzNYSjHWFf2UU6Uxp6zeQ3zFs4SGCKnM0IqYy6w7f/z4R7O4HOpaATTTTi1FraBAw/PM7ImJfCfp09KVgN6tps8j2/xqmm8Hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb0g/hPe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725724374; x=1757260374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=af2RuJlyRSy9sAYrpdJKVJIieJRObkqtTIwAoB3wxGk=;
  b=Wb0g/hPe9cekTctmh4ZWe0WjYqV9jOdzD1eK+U8UDUcDys/6MENiIe6u
   +NzPvJYuiHl86DbLXwcnTwk2a5KA5GCNq4ossUZVucWAQN/Yzo2S2S3EW
   ytqZn3kEledjOxYjulUtEuArTUYJfQeEtVCvuOrmj89Q6+p/0PssMcwt3
   Oj3TxwZxmgc06nWGv5wRsLOVzu4uq9OnbfTnqxWQn//oSU3YEy8YLY8qZ
   bQnn3QzZ35fwOfeYNa5NfCP5Rcd2/C1XfeIn3Gxu9vc4A+ihT1heIX/+d
   24U1246E7txsZm6pIvDZpdhA0dHoSDlz5R6JDPka/V8JvUAgnq+SWGaog
   w==;
X-CSE-ConnectionGUID: u5+7Jbo4SVGumrypViyR7g==
X-CSE-MsgGUID: x8JCHMFwRvG3dbD8QLAA+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24617365"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="24617365"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 08:52:54 -0700
X-CSE-ConnectionGUID: 5owZJk0JTrySKpCJLAgCQg==
X-CSE-MsgGUID: ymEl5IaWTyCOTc+/z2rb2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="71192917"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Sep 2024 08:52:51 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smxk0-000CfT-1z;
	Sat, 07 Sep 2024 15:52:48 +0000
Date: Sat, 7 Sep 2024 23:52:48 +0800
From: kernel test robot <lkp@intel.com>
To: Riyan Dhiman <riyandhiman14@gmail.com>, jim2101024@gmail.com,
	nsaenz@kernel.org, lorian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: Re: [PATCH next] PCI: brmstb: Fix type mismatch for num_inbound_wins
 in brcm_pcie_setup()
Message-ID: <202409072334.YP8Xi0bX-lkp@intel.com>
References: <20240904161953.46790-2-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904161953.46790-2-riyandhiman14@gmail.com>

Hi Riyan,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240904]

url:    https://github.com/intel-lab-lkp/linux/commits/Riyan-Dhiman/PCI-brmstb-Fix-type-mismatch-for-num_inbound_wins-in-brcm_pcie_setup/20240905-002339
base:   next-20240904
patch link:    https://lore.kernel.org/r/20240904161953.46790-2-riyandhiman14%40gmail.com
patch subject: [PATCH next] PCI: brmstb: Fix type mismatch for num_inbound_wins in brcm_pcie_setup()
config: i386-buildonly-randconfig-006-20240907 (https://download.01.org/0day-ci/archive/20240907/202409072334.YP8Xi0bX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409072334.YP8Xi0bX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409072334.YP8Xi0bX-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/pcie-brcmstb.c: In function 'brcm_pcie_setup':
>> drivers/pci/controller/pcie-brcmstb.c:1034:9: error: expected ',' or ';' before 'int'
    1034 |         int num_inbound_wins = 0;
         |         ^~~
>> drivers/pci/controller/pcie-brcmstb.c:1093:9: error: 'num_inbound_wins' undeclared (first use in this function); did you mean 'inbound_wins'?
    1093 |         num_inbound_wins = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
         |         ^~~~~~~~~~~~~~~~
         |         inbound_wins
   drivers/pci/controller/pcie-brcmstb.c:1093:9: note: each undeclared identifier is reported only once for each function it appears in


vim +1034 drivers/pci/controller/pcie-brcmstb.c

  1025	
  1026	static int brcm_pcie_setup(struct brcm_pcie *pcie)
  1027	{
  1028		struct inbound_win inbound_wins[PCIE_BRCM_MAX_INBOUND_WINS];
  1029		void __iomem *base = pcie->base;
  1030		struct pci_host_bridge *bridge;
  1031		struct resource_entry *entry;
  1032		u32 tmp, burst, aspm_support;
  1033		u8 num_out_wins = 0
> 1034		int num_inbound_wins = 0;
  1035		int memc, ret;
  1036	
  1037		/* Reset the bridge */
  1038		ret = pcie->bridge_sw_init_set(pcie, 1);
  1039		if (ret)
  1040			return ret;
  1041	
  1042		/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
  1043		if (pcie->soc_base == BCM2711) {
  1044			ret = pcie->perst_set(pcie, 1);
  1045			if (ret) {
  1046				pcie->bridge_sw_init_set(pcie, 0);
  1047				return ret;
  1048			}
  1049		}
  1050	
  1051		usleep_range(100, 200);
  1052	
  1053		/* Take the bridge out of reset */
  1054		ret = pcie->bridge_sw_init_set(pcie, 0);
  1055		if (ret)
  1056			return ret;
  1057	
  1058		tmp = readl(base + HARD_DEBUG(pcie));
  1059		if (is_bmips(pcie))
  1060			tmp &= ~PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
  1061		else
  1062			tmp &= ~PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
  1063		writel(tmp, base + HARD_DEBUG(pcie));
  1064		/* Wait for SerDes to be stable */
  1065		usleep_range(100, 200);
  1066	
  1067		/*
  1068		 * SCB_MAX_BURST_SIZE is a two bit field.  For GENERIC chips it
  1069		 * is encoded as 0=128, 1=256, 2=512, 3=Rsvd, for BCM7278 it
  1070		 * is encoded as 0=Rsvd, 1=128, 2=256, 3=512.
  1071		 */
  1072		if (is_bmips(pcie))
  1073			burst = 0x1; /* 256 bytes */
  1074		else if (pcie->soc_base == BCM2711)
  1075			burst = 0x0; /* 128 bytes */
  1076		else if (pcie->soc_base == BCM7278)
  1077			burst = 0x3; /* 512 bytes */
  1078		else
  1079			burst = 0x2; /* 512 bytes */
  1080	
  1081		/*
  1082		 * Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN,
  1083		 * RCB_MPS_MODE, RCB_64B_MODE
  1084		 */
  1085		tmp = readl(base + PCIE_MISC_MISC_CTRL);
  1086		u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
  1087		u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
  1088		u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
  1089		u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK);
  1090		u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
  1091		writel(tmp, base + PCIE_MISC_MISC_CTRL);
  1092	
> 1093		num_inbound_wins = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
  1094		if (num_inbound_wins < 0)
  1095			return num_inbound_wins;
  1096	
  1097		set_inbound_win_registers(pcie, inbound_wins, num_inbound_wins);
  1098	
  1099		if (!brcm_pcie_rc_mode(pcie)) {
  1100			dev_err(pcie->dev, "PCIe RC controller misconfigured as Endpoint\n");
  1101			return -EINVAL;
  1102		}
  1103	
  1104		tmp = readl(base + PCIE_MISC_MISC_CTRL);
  1105		for (memc = 0; memc < pcie->num_memc; memc++) {
  1106			u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
  1107	
  1108			if (memc == 0)
  1109				u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(0));
  1110			else if (memc == 1)
  1111				u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(1));
  1112			else if (memc == 2)
  1113				u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(2));
  1114		}
  1115		writel(tmp, base + PCIE_MISC_MISC_CTRL);
  1116	
  1117		/*
  1118		 * We ideally want the MSI target address to be located in the 32bit
  1119		 * addressable memory area. Some devices might depend on it. This is
  1120		 * possible either when the inbound window is located above the lower
  1121		 * 4GB or when the inbound area is smaller than 4GB (taking into
  1122		 * account the rounding-up we're forced to perform).
  1123		 */
  1124		if (inbound_wins[2].pci_offset >= SZ_4G ||
  1125		    (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
  1126			pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_LT_4GB;
  1127		else
  1128			pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_GT_4GB;
  1129	
  1130	
  1131		/* Don't advertise L0s capability if 'aspm-no-l0s' */
  1132		aspm_support = PCIE_LINK_STATE_L1;
  1133		if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
  1134			aspm_support |= PCIE_LINK_STATE_L0S;
  1135		tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
  1136		u32p_replace_bits(&tmp, aspm_support,
  1137			PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
  1138		writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
  1139	
  1140		/*
  1141		 * For config space accesses on the RC, show the right class for
  1142		 * a PCIe-PCIe bridge (the default setting is to be EP mode).
  1143		 */
  1144		tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
  1145		u32p_replace_bits(&tmp, 0x060400,
  1146				  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
  1147		writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
  1148	
  1149		bridge = pci_host_bridge_from_priv(pcie);
  1150		resource_list_for_each_entry(entry, &bridge->windows) {
  1151			struct resource *res = entry->res;
  1152	
  1153			if (resource_type(res) != IORESOURCE_MEM)
  1154				continue;
  1155	
  1156			if (num_out_wins >= BRCM_NUM_PCIE_OUT_WINS) {
  1157				dev_err(pcie->dev, "too many outbound wins\n");
  1158				return -EINVAL;
  1159			}
  1160	
  1161			if (is_bmips(pcie)) {
  1162				u64 start = res->start;
  1163				unsigned int j, nwins = resource_size(res) / SZ_128M;
  1164	
  1165				/* bmips PCIe outbound windows have a 128MB max size */
  1166				if (nwins > BRCM_NUM_PCIE_OUT_WINS)
  1167					nwins = BRCM_NUM_PCIE_OUT_WINS;
  1168				for (j = 0; j < nwins; j++, start += SZ_128M)
  1169					brcm_pcie_set_outbound_win(pcie, j, start,
  1170								   start - entry->offset,
  1171								   SZ_128M);
  1172				break;
  1173			}
  1174			brcm_pcie_set_outbound_win(pcie, num_out_wins, res->start,
  1175						   res->start - entry->offset,
  1176						   resource_size(res));
  1177			num_out_wins++;
  1178		}
  1179	
  1180		/* PCIe->SCB endian mode for inbound window */
  1181		tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
  1182		u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
  1183			PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
  1184		writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
  1185	
  1186		return 0;
  1187	}
  1188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

