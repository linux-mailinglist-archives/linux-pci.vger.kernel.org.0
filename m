Return-Path: <linux-pci+bounces-36612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A398B8EE7F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 06:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A437AC6AE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 04:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904C1D5ABF;
	Mon, 22 Sep 2025 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJ1BmRC9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2C249E5;
	Mon, 22 Sep 2025 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758514055; cv=none; b=EfnVqhoaXReg70xbBq0GAiYYd74EUju3rgIuAPzajmcONy0zZQ34Oh/VloU/CtoZWRMt1qMZNeaKdxEmUMhXzXuDQ6OF3Pv0X0SkNqmp4EHd7s67pXll0d0DR3HHjg8HnBLq6vdi1qA+oKiDhrwFKeRQHI6pKNLnGFC5RwN9zGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758514055; c=relaxed/simple;
	bh=G2V1IzI07Lo+cAvCBkq1btsiFZLerly8BvX9QTJo0j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqaVoYoHLi6p40MLEV0CcgnRKwfnJl/76pkX3kbW45U8pJBR4clyCyELy6Gu8Ui9uc410RjSRH1QlXo86/8MVN/e1WfjkOL8zyNHPhTzqZ43O9CTFWHbOeZn5osfh44awWbJG5LsQkjMO06Pbn6b6RvxsSlXeJV/h318Xci04Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJ1BmRC9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758514054; x=1790050054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G2V1IzI07Lo+cAvCBkq1btsiFZLerly8BvX9QTJo0j4=;
  b=CJ1BmRC9bMJTpqOz9ku4zrsiOPR/+v6dV64QWGpGj5nTSKvyNKQycTEe
   gNiq7OfLjsaYMiqzpLRC5rKZAroy306un1yLedDy18pyCYsg1tdw4dBbd
   M2XClBTdnm36UQk3tWI1gR3/TyIB8fBCDyt08giHBJA31lvkW58f0puNF
   Hh2zS6LlL3T2QGCwmvK+VrzyGpxnzAzk61EG48FSc76yb5DqO/igQvyEb
   vnYkx9Eea2s+gSPlC5okSTn72cDnRqC6epJXthW/nqXH8QaVj974GFA84
   QNfnBHuM7aixYvPltYjC1sexaa2S2HwQtPnYnX1D3SIKCSJtMh3VfhlW5
   Q==;
X-CSE-ConnectionGUID: IrhIvvCnQGep4OrHCSv72w==
X-CSE-MsgGUID: Wxgn5edHQaedScR3LhDyqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="59809004"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="59809004"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 21:07:33 -0700
X-CSE-ConnectionGUID: zqpl9hnCTuyexJ28zpHKKg==
X-CSE-MsgGUID: yfvJgNhsSFqEUX/ZvNjTxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="176811092"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 21 Sep 2025 21:07:28 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0Xpl-0001J3-1y;
	Mon, 22 Sep 2025 04:07:25 +0000
Date: Mon, 22 Sep 2025 12:07:21 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com,
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com,
	bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, cassel@kernel.org
Subject: Re: [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <202509221101.JBhoJaEX-lkp@intel.com>
References: <20250919155821.95334-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919155821.95334-3-vincent.guittot@linaro.org>

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.17-rc7 next-20250919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Guittot/PCI-s32g-Add-initial-PCIe-support-RC/20250920-005919
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250919155821.95334-3-vincent.guittot%40linaro.org
patch subject: [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support (RC)
config: openrisc-randconfig-r132-20250922 (https://download.01.org/0day-ci/archive/20250922/202509221101.JBhoJaEX-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250922/202509221101.JBhoJaEX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509221101.JBhoJaEX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pcie-s32g.c:133:20: sparse: sparse: symbol 's32g_pcie_ops' was not declared. Should it be static?
   drivers/pci/controller/dwc/pcie-s32g.c: note: in included file (through drivers/pci/controller/dwc/pcie-designware.h):
>> drivers/pci/controller/dwc/../../pci.h:632:17: sparse: sparse: cast from restricted pci_channel_state_t
>> drivers/pci/controller/dwc/../../pci.h:632:17: sparse: sparse: cast to restricted pci_channel_state_t
   drivers/pci/controller/dwc/../../pci.h:635:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/controller/dwc/../../pci.h:635:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/controller/dwc/../../pci.h:635:23: sparse: sparse: cast to restricted pci_channel_state_t
   drivers/pci/controller/dwc/../../pci.h:639:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/controller/dwc/../../pci.h:639:23: sparse: sparse: cast from restricted pci_channel_state_t
   drivers/pci/controller/dwc/../../pci.h:639:23: sparse: sparse: cast to restricted pci_channel_state_t

vim +/s32g_pcie_ops +133 drivers/pci/controller/dwc/pcie-s32g.c

   132	
 > 133	struct dw_pcie_ops s32g_pcie_ops = {
   134		.get_ltssm = s32g_pcie_get_ltssm,
   135		.link_up = s32g_pcie_link_up,
   136		.start_link = s32g_pcie_start_link,
   137		.stop_link = s32g_pcie_stop_link,
   138	};
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

