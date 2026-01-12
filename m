Return-Path: <linux-pci+bounces-44468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D67D10BAE
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 07:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE8B8300DDA9
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 06:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BFB315D30;
	Mon, 12 Jan 2026 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j566+UPn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9530F812;
	Mon, 12 Jan 2026 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200186; cv=none; b=SZLct2VQaeeijekNGayAwJedytkZp927UGcEzhKGBnNchfYHQDhAqDb0SOKlVuaN3xLimJZF+rSRZeJVzSQspN84ivDexnXKUP5cEA+/k9kgZLpU/4FQ9kJPRb8UXSnvXnWlBsYDpj/dMZasXlHM7A10vn+5nXENwr7aakhYarQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200186; c=relaxed/simple;
	bh=KRUlzmZT+Po3605XqLGK09mDfYi+PQG5J8+1DirPpHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idB9PA3KeOWPsQ4USATPwzSHoIsonUFdJqqC+oQ/f12lgpoiYWZql6PTrUFMROlXc3d/r1nQsyaW63j1Hc46ZnS4zVePiH58e0XLl9VqjK/c69iAdts/tub7K3cxLpDlx3lg13Kbxq3raohNpJk3O2NJ3ETflgj56igimOp+Zts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j566+UPn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768200184; x=1799736184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KRUlzmZT+Po3605XqLGK09mDfYi+PQG5J8+1DirPpHE=;
  b=j566+UPn17nW0VlMd8in9zN7Ap4XKJ/YrXRazq8niO13l+3jrizhmceK
   MhMC6x61HIm+ftuWjX/LrThQZcXd3w7JjP35qPfXF0fsBhTMoZAcSAUr/
   sWXpnCQmJHgeVao14nDbMmWU+M7iSvrg2OPo+bOLw6lv/1QzmENU+a7V3
   0+W0nJ4pIt25Wutj64aZ2DA1A3z49VNnsQydnSNhYIhGINZ1NMelji2U8
   wl5B7lKnLHKzQbD7OsPaDE+mulAMcydje2C35lUMisOxMF5vYNalQDQsd
   VA5oGoFGNrbwAOgZL0tykS50mNpQQ/dEjPl8xfugC0A2JJm7zpYSRqOq9
   A==;
X-CSE-ConnectionGUID: R+8dLbE5Q82mWNvBDq2a3g==
X-CSE-MsgGUID: ShetzyQsSlejVmGHu7zcsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="87057181"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="87057181"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 22:43:04 -0800
X-CSE-ConnectionGUID: +5Qtarv8RWW4G95y5DgeJg==
X-CSE-MsgGUID: fJOLnsbZQiCSQQ+NuTJRFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204082216"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Jan 2026 22:43:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfBdi-00000000D4G-3xjw;
	Mon, 12 Jan 2026 06:42:58 +0000
Date: Mon, 12 Jan 2026 14:42:32 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition
 trace support
Message-ID: <202601121428.WVvakywZ-lkp@intel.com>
References: <1768180800-63364-4-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1768180800-63364-4-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on next-20260109]
[cannot apply to pci/for-linus trace/for-next mani-mhi/mhi-next linus/master v6.19-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/PCI-trace-Add-PCI-controller-LTSSM-transition-tracepoint/20260112-100141
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1768180800-63364-4-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH v3 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
config: loongarch-randconfig-002-20260112 (https://download.01.org/0day-ci/archive/20260112/202601121428.WVvakywZ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601121428.WVvakywZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601121428.WVvakywZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-dw-rockchip.c: In function 'rockchip_pcie_ltssm_trace_work':
>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:264:41: error: implicit declaration of function 'dw_pcie_ltssm_status_string' [-Wimplicit-function-declaration]
     264 |                                         dw_pcie_ltssm_status_string(state),
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:264:41: error: passing argument 2 of 'trace_pcie_ltssm_state_transition' makes pointer from integer without a cast [-Wint-conversion]
     264 |                                         dw_pcie_ltssm_status_string(state),
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         int
   In file included from include/trace/events/pci_controller.h:9,
                    from drivers/pci/controller/dwc/pcie-dw-rockchip.c:26:
   include/trace/events/pci_controller.h:20:52: note: expected 'const char *' but argument is of type 'int'
      20 |         TP_PROTO(const char *dev_name, const char *state, u32 rate),
         |                                        ~~~~~~~~~~~~^~~~~
   include/linux/tracepoint.h:288:41: note: in definition of macro '__DECLARE_TRACE'
     288 |         static inline void trace_##name(proto)                          \
         |                                         ^~~~~
   include/linux/tracepoint.h:494:31: note: in expansion of macro 'PARAMS'
     494 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
         |                               ^~~~~~
   include/linux/tracepoint.h:632:9: note: in expansion of macro 'DECLARE_TRACE_EVENT'
     632 |         DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint.h:632:35: note: in expansion of macro 'PARAMS'
     632 |         DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
         |                                   ^~~~~~
   include/trace/events/pci_controller.h:19:1: note: in expansion of macro 'TRACE_EVENT'
      19 | TRACE_EVENT(pcie_ltssm_state_transition,
         | ^~~~~~~~~~~
   include/trace/events/pci_controller.h:20:9: note: in expansion of macro 'TP_PROTO'
      20 |         TP_PROTO(const char *dev_name, const char *state, u32 rate),
         |         ^~~~~~~~


vim +/dw_pcie_ltssm_status_string +264 drivers/pci/controller/dwc/pcie-dw-rockchip.c

   225	
   226	#ifdef CONFIG_TRACING
   227	static void rockchip_pcie_ltssm_trace_work(struct work_struct *work)
   228	{
   229		struct rockchip_pcie *rockchip = container_of(work, struct rockchip_pcie,
   230							trace_work.work);
   231		struct dw_pcie *pci = &rockchip->pci;
   232		enum dw_pcie_ltssm state;
   233		u32 i, l1ss, prev_val = DW_PCIE_LTSSM_UNKNOWN, rate, val;
   234	
   235		for (i = 0; i < PCIE_DBG_LTSSM_HISTORY_CNT; i++) {
   236			val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_DBG_FIFO_STATUS);
   237			rate = FIELD_GET(PCIE_DBG_FIFO_RATE_MASK, val);
   238			l1ss = FIELD_GET(PCIE_DBG_FIFO_L1SUB_MASK, val);
   239			val = FIELD_GET(PCIE_LTSSM_STATUS_MASK, val);
   240	
   241			/*
   242			 * Hardware Mechanism: The ring FIFO employs two tracking counters:
   243			 * - 'last-read-point': maintains the user's last read position
   244			 * - 'last-valid-point': tracks the hardware's last state update
   245			 *
   246			 * Software Handling: When two consecutive LTSSM states are identical,
   247			 * it indicates invalid subsequent data in the FIFO. In this case, we
   248			 * skip the remaining entries. The dual-counter design ensures that on
   249			 * the next state transition, reading can resume from the last user
   250			 * position.
   251			 */
   252			if ((i > 0 && val == prev_val) || val > DW_PCIE_LTSSM_RCVRY_EQ3)
   253				break;
   254	
   255			state = prev_val = val;
   256			if (val == DW_PCIE_LTSSM_L1_IDLE) {
   257				if (l1ss == 2)
   258					state = DW_PCIE_LTSSM_L1_2;
   259				else if (l1ss == 1)
   260					state = DW_PCIE_LTSSM_L1_1;
   261			}
   262	
   263			trace_pcie_ltssm_state_transition(dev_name(pci->dev),
 > 264						dw_pcie_ltssm_status_string(state),
   265						((rate + 1) > pci->max_link_speed) ?
   266						PCI_SPEED_UNKNOWN : PCIE_SPEED_2_5GT + rate);
   267		}
   268	
   269		schedule_delayed_work(&rockchip->trace_work, msecs_to_jiffies(5000));
   270	}
   271	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

