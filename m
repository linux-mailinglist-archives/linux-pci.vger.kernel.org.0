Return-Path: <linux-pci+bounces-31555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E6CAF9DF5
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 04:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D2518890B6
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 02:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95533274FFB;
	Sat,  5 Jul 2025 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhZHEEHr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CDA26C381;
	Sat,  5 Jul 2025 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751683998; cv=none; b=a7BvLB2zPq79DTLZ1pZryE52XHTl9pM+aO99Vq99OB5txgxpYjNh98OWoPsEP3QpwVOsRYFHjTBEZ/tJKkoYkosOaVae8v5Y96v6gm3iA+rF6m8Yf9sUbBjJBfgQbiPd4L+iOnHVYRZ7CDX4vWzUjfow85afE1ifLRX3Udi4GRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751683998; c=relaxed/simple;
	bh=2nZbo35y6gk+in29UzPb+vRtobSykQnOD+dufXdKmLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJGo2M+AmgKNfMbZuJeYMVMcA3NgYX+2lh/ZtrNRvqW3rs3DO9KMy4ekFq4JjYOICGtCle/0l4BbLX/QczEiyHvzPUvriZq4ZfmpVgcx/xOFvc3IGliOwJwsu3GH8arNfwJV+229hodJTd4qxfsS5qayWdob/AGnf6mNa06Fisk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhZHEEHr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751683997; x=1783219997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2nZbo35y6gk+in29UzPb+vRtobSykQnOD+dufXdKmLI=;
  b=BhZHEEHrLDyr8E02uHc7G1TlfXndsXuv95gSWQW/pTFvqkgW8Qa3SMEi
   61qe2HIL9GYyuBDhdyCwL/FuHFJj1OYN9IiU2ult0RbP3zrAsrAJpfF+S
   PKEa7nuj8qLaa9kt/9qBn8PHsapjkXk+dmwl+XhUiKtfb8apz4o5FlaRm
   D1Ac/RXX4qLkcXsIxf1ILvlRjh72Dhdx2QAezMs4qGSkMwbMq2Xc29qln
   DcKUoJbpEp6uZ9UDZXkYecLn0MMVACgX7zwUqURATKRrBmGbBSnwUANS8
   wn2K5bF7oWO21MrLGgU4KEr6PMW1UUcVZ9jnUjuLDm8swkczododdyw6O
   A==;
X-CSE-ConnectionGUID: UFr0vv5zS/agSyMVcA+Awg==
X-CSE-MsgGUID: WTDtG0srTt2acFPdvL+B8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="64692095"
X-IronPort-AV: E=Sophos;i="6.16,289,1744095600"; 
   d="scan'208";a="64692095"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 19:53:16 -0700
X-CSE-ConnectionGUID: BMKELaOYS5KCT3z7M7H3TQ==
X-CSE-MsgGUID: BE2p0KTaQAiynZsX8RzyzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,289,1744095600"; 
   d="scan'208";a="154841049"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 Jul 2025 19:53:09 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXt1X-0004Dn-0g;
	Sat, 05 Jul 2025 02:53:07 +0000
Date: Sat, 5 Jul 2025 10:52:17 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michal Simek <monstr@monstr.eu>,
	Daire McNamara <daire.mcnamara@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 14/16] PCI: hv: Switch to msi_create_parent_irq_domain()
Message-ID: <202507051005.SB1ajh7M-lkp@intel.com>
References: <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>

Hi Nam,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[cannot apply to pci/for-linus linus/master v6.16-rc4 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/PCI-dwc-Switch-to-msi_create_parent_irq_domain/20250626-230029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao%40linutronix.de
patch subject: [PATCH 14/16] PCI: hv: Switch to msi_create_parent_irq_domain()
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250705/202507051005.SB1ajh7M-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250705/202507051005.SB1ajh7M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507051005.SB1ajh7M-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "irq_domain_free_irqs_top" [drivers/pci/controller/pci-hyperv.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

