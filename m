Return-Path: <linux-pci+bounces-11955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C779959F06
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 15:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70F6B211AD
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988B1AD5CE;
	Wed, 21 Aug 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOxsU67/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7391A4B6D;
	Wed, 21 Aug 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248178; cv=none; b=juVhxOi18AwGgSGAcMw2154wkwAyOaj8iH7bXbjoS4ulL0qPl08pdxN4cH50DukErh41hHi5YuRxPKYQFg3VHCog1hdZr9nslfcEx66PaRPsnFZ5+DU58OtNUfiEzZta+/tkoJEWw32aKcjrzoSE9DCcthgzU1MZ3CZHhp6yReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248178; c=relaxed/simple;
	bh=AEJbp7hVLecs4V0ZKO8ceLa7mXoNjWImzSmkrnUPgOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omIB3F1Uw4T9d99OZZ4XgIS90KpIYa77ZCBUqJzxMG77guORTcNvI3+CdnZwjARYPdMw//3YeKXk6Mpys4itdilmdzSZ7QNbEnvjqFSgtbqbg07n4e7mhGRpmEnQWxd7p+P+I6SzQLeg8YqGNZdCxbwV7p9NT6MldGDo8ObU2js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOxsU67/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724248177; x=1755784177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AEJbp7hVLecs4V0ZKO8ceLa7mXoNjWImzSmkrnUPgOE=;
  b=DOxsU67/rCKzojykqJy6WvHcRCLtORlTzBU8btIq0yI53O11FQhunQL4
   AYt1iP3mLdRAHZVTlXEIbQA3ZTl8hmSF0m67nVkO17CQ3fLOD4OJvLvfg
   JD0jDI3kGzpikb73CpnSpxrLC4vkL7MXQFCpLcvcu6FZRfDqYYQl06D0g
   dwjBN5/mRTSOpriD0mCpUTob5CgsaWyvFxPLCqJeP9bMFWH+q8RSHAeIU
   Ru8DRyS62nUJDLvWOQR6Ym7/N9jqRCbDB91cO9Qm/lSjaPKKYhGyLnWOv
   PLRqvyZvrm6RVTlEc6bYFVprEkzt9szU76N8HlOADm9WkhOVzJT4GTIr2
   Q==;
X-CSE-ConnectionGUID: S5eaNH+6RU6YfBo6MqQ7Cw==
X-CSE-MsgGUID: pCXSUqf2RPekPddislqeUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22771102"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22771102"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:49:36 -0700
X-CSE-ConnectionGUID: qQN1NnVwSJaGDM1H9I+faQ==
X-CSE-MsgGUID: gQShTbnhQUK/iNTWuJgBxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61120963"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Aug 2024 06:49:34 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgliN-000BQK-1P;
	Wed, 21 Aug 2024 13:49:31 +0000
Date: Wed, 21 Aug 2024 21:49:24 +0800
From: kernel test robot <lkp@intel.com>
To: Shijith Thotton <sthotton@marvell.com>, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, Shijith Thotton <sthotton@marvell.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jerinj@marvell.com, schalla@marvell.com, vattunuru@marvell.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	D Scott Phillips <scott@os.amperecomputing.com>
Subject: Re: [PATCH] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Message-ID: <202408212127.ed49pQkJ-lkp@intel.com>
References: <20240820152734.642533-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820152734.642533-1-sthotton@marvell.com>

Hi Shijith,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.11-rc4 next-20240821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shijith-Thotton/PCI-hotplug-Add-OCTEON-PCI-hotplug-controller-driver/20240820-233005
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240820152734.642533-1-sthotton%40marvell.com
patch subject: [PATCH] PCI: hotplug: Add OCTEON PCI hotplug controller driver
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20240821/202408212127.ed49pQkJ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408212127.ed49pQkJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408212127.ed49pQkJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/hotplug/octep_hp.c: In function 'octep_hp_intr_handler':
>> drivers/pci/hotplug/octep_hp.c:190:21: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Wimplicit-function-declaration]
     190 |         slot_mask = readq(hp_ctrl->base + OCTEP_HP_INTR_OFFSET(vec_type));
         |                     ^~~~~
         |                     readl
>> drivers/pci/hotplug/octep_hp.c:210:9: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Wimplicit-function-declaration]
     210 |         writeq(slot_mask, hp_ctrl->base + OCTEP_HP_INTR_OFFSET(vec_type));
         |         ^~~~~~
         |         writel


vim +190 drivers/pci/hotplug/octep_hp.c

   178	
   179	static irqreturn_t octep_hp_intr_handler(int irq, void *data)
   180	{
   181		struct octep_hp_controller *hp_ctrl = data;
   182		struct pci_dev *pdev = hp_ctrl->pdev;
   183		enum octep_hp_vec_type vec_type;
   184		struct octep_hp_cmd *hp_cmd;
   185		u64 slot_mask;
   186	
   187		vec_type = pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(OCTEP_HP_VEC_ENA)) == irq ?
   188			OCTEP_HP_VEC_ENA : OCTEP_HP_VEC_DIS;
   189	
 > 190		slot_mask = readq(hp_ctrl->base + OCTEP_HP_INTR_OFFSET(vec_type));
   191		if (!slot_mask) {
   192			dev_err(&pdev->dev, "Invalid slot mask %llx\n", slot_mask);
   193			return IRQ_HANDLED;
   194		}
   195	
   196		hp_cmd = kzalloc(sizeof(*hp_cmd), GFP_ATOMIC);
   197		if (!hp_cmd)
   198			return IRQ_HANDLED;
   199	
   200		hp_cmd->slot_mask = slot_mask;
   201		hp_cmd->vec_type = vec_type;
   202	
   203		/* Add the command to the list and schedule the work */
   204		spin_lock(&hp_ctrl->hp_cmd_lock);
   205		list_add_tail(&hp_cmd->list, &hp_ctrl->hp_cmd_list);
   206		spin_unlock(&hp_ctrl->hp_cmd_lock);
   207		schedule_work(&hp_ctrl->work);
   208	
   209		/* Clear the interrupt */
 > 210		writeq(slot_mask, hp_ctrl->base + OCTEP_HP_INTR_OFFSET(vec_type));
   211	
   212		return IRQ_HANDLED;
   213	}
   214	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

