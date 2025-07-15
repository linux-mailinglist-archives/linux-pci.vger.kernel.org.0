Return-Path: <linux-pci+bounces-32204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC45B06946
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 00:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F369C17B8AB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 22:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008BE2C3246;
	Tue, 15 Jul 2025 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjntJWWi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A29D27991C;
	Tue, 15 Jul 2025 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618535; cv=none; b=XBe0ZaWuCBBh6OvqI8RTeDpjgLBm2DL0GgVTU9L++2THzqz+im3glcJkGBZs+JjgnzPbbHtwyHN1vIfErC8Nwl8XezmGBxV6DVddztsJ4Igk59nqxDgdT7LDLJMwcNlOwfVYSV8Y6EdS5ERyafkyKxungT5ijzgDvFh3Ep5MN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618535; c=relaxed/simple;
	bh=G7+Ffs9WIWMcBynLHK1Sql++GiExP0QoYD+fUsrCxEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV61cocqtE0PFe/Ix6UYhpHoZMWCyKsFssi8Mn9GbrqjC5qWJM0Y+A4LXGBhiOnXkTh4J+c40mtND7odsYIqlHYamqNVA74VmDtZ+3ycdI6E1XWjxKGM+nlrZPXddvKueV+4AMkl8KPkV4VAL9cEp2oG7iX3UIaYEvZR2a+D3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjntJWWi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752618534; x=1784154534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G7+Ffs9WIWMcBynLHK1Sql++GiExP0QoYD+fUsrCxEU=;
  b=MjntJWWiFH68fbDelxxuKuqNH7ZrjP3Dn5jdJ5HUK3L5HvdzsGuVaGaH
   6ghvybO0YMDh/yGFLtIrmuLYFMZVSXqZ3wUNByn8ngwwzg1RvdEzF8bo4
   MmUqZAhdcrZrVe2Z7EZfQZ6uzos+qc1mRo2kEUjvFPc2SWCf02QSq1L2K
   Hhm6L9CZNL1QCmLOzdsZKzOJbnwHTpZvwQOJxRAMxCHptblvL5Tddtidh
   shDGQbUT8V8IPP6ZV96Bwt8H+Qamh4q/haJS/uwhCofIlIwVr/kVpgW1K
   jDXQ8Q1dC5CQ+nVmfK07ovMV40ui6RQ8AOqQfdlxQ+xYMh5+hq64GfHuo
   Q==;
X-CSE-ConnectionGUID: a+AX4N2HTJW/QKd71Nl12w==
X-CSE-MsgGUID: 3ZsPuTlSTNuJAnMYBmFxQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54562886"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="54562886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 15:28:54 -0700
X-CSE-ConnectionGUID: 43scBKa2Q+GlwkjRdyCeQg==
X-CSE-MsgGUID: nj7Vi7qCQFKk7YaTE34tRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="181023525"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Jul 2025 15:28:49 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubo8k-000Bbf-0v;
	Tue, 15 Jul 2025 22:28:46 +0000
Date: Wed, 16 Jul 2025 06:28:22 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
	p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 09/10] PCI: aspeed: Add ASPEED PCIe RC driver
Message-ID: <202507160642.yzIrPY1i-lkp@intel.com>
References: <20250715034320.2553837-10-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715034320.2553837-10-jacky_chou@aspeedtech.com>

Hi Jacky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus robh/for-next linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.16-rc6 next-20250715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Chou/dt-bindings-soc-aspeed-Add-ASPEED-PCIe-Config-support/20250715-114814
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250715034320.2553837-10-jacky_chou%40aspeedtech.com
patch subject: [PATCH v2 09/10] PCI: aspeed: Add ASPEED PCIe RC driver
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250716/202507160642.yzIrPY1i-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160642.yzIrPY1i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160642.yzIrPY1i-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/controller/pcie-aspeed.c:179 struct member 'pciephy' not described in 'aspeed_pcie_port'
   Warning: drivers/pci/controller/pcie-aspeed.c:179 Excess struct member 'phy' description in 'aspeed_pcie_port'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

