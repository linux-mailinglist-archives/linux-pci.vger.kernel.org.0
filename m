Return-Path: <linux-pci+bounces-6915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079D98B83ED
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 03:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C45B22905
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 01:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639CC46BA;
	Wed,  1 May 2024 01:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WS/INw1a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF22F2D;
	Wed,  1 May 2024 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714526291; cv=none; b=UKYx6Y3peAYVUHUJPot9xN0cZxeIrqocvGXLF8j4A7GVHAigDCPp8+/3ncryt6424sN8DnKiXqk0TNvH3e+SAECtydQZRYzejTTjmK+nWrxlj1gCm6Umxz9zO8HQaQo2TZvctzckPC8KLgRX1m2WhcAzI3WJkGFoK7TzC6w3kME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714526291; c=relaxed/simple;
	bh=eslk4RXtVzrUKHMd3hyKeU3x1b+T2v/SCHfrtS6lqWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u62ftksca5OydcPuQmQjlEabmtJ0WrpWwV9Wq2Zyo+3Ud66O4Qs22Mf7fEdRM8QtwrgDJSmJEEEeUGMRxz1IdQthjEGsbXK+NQmEUFjLSTIG/6VjQLXx+PXhYl2pxJ69LiqLYnJLgQNvX3nh29x9+5M+SYCO6P0XWWXrbjzO54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WS/INw1a; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714526289; x=1746062289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eslk4RXtVzrUKHMd3hyKeU3x1b+T2v/SCHfrtS6lqWQ=;
  b=WS/INw1aBQTyHEGfwBp+yE7R2TVmzkFM92IXuQdt3D3qf7HZBRrCOeyB
   IqUN3Po6q2/l5CaT2eOgyN7yp04YCy8xo0PVKXM6nOavZTkrdEwdZA/uC
   B4h3eKJ6KV/VLWBBOBa4KQjLRqL9mFhW89DZeP7GMH8wE5wI///1CuKKZ
   9j+HNlWL3APhRcTmxV4CaAmHUscHoXWsUuonOqU6Um9vVaCJNca8xJplj
   aul3XjDurf1E/UXZ0yhnD12/Bs0b/0+IvFfw1mc9ALwn9ecKnyLJWtIkY
   HPn5/ZMY43AAfPt9P5HwVESdgGlktlay7d7KxwKhErTVvcl//jiHjQn5M
   Q==;
X-CSE-ConnectionGUID: woNqX4mvQrG5sfWSP/ln+g==
X-CSE-MsgGUID: crTUkD1STIiyzXmJxvkmCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21409908"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="21409908"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 18:18:08 -0700
X-CSE-ConnectionGUID: nRIGhYRISwKhyAuauiQVuA==
X-CSE-MsgGUID: FTINHPgNRwGEoMEThalDww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26752237"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 30 Apr 2024 18:18:01 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1ybe-0008jX-2I;
	Wed, 01 May 2024 01:17:58 +0000
Date: Wed, 1 May 2024 09:17:23 +0800
From: kernel test robot <lkp@intel.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 12/17] irqchip: Add support for LAN966x OIC
Message-ID: <202405010842.zim8X3E5-lkp@intel.com>
References: <20240430083730.134918-13-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083730.134918-13-herve.codina@bootlin.com>

Hi Herve,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master v6.9-rc6 next-20240430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/mfd-syscon-Add-reference-counting-and-device-managed-support/20240430-164912
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20240430083730.134918-13-herve.codina%40bootlin.com
patch subject: [PATCH 12/17] irqchip: Add support for LAN966x OIC
config: hexagon-randconfig-r071-20240501 (https://download.01.org/0day-ci/archive/20240501/202405010842.zim8X3E5-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405010842.zim8X3E5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405010842.zim8X3E5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/irqchip/irq-lan966x-oic.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/irqchip/irq-lan966x-oic.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/irqchip/irq-lan966x-oic.c:15:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/irqchip/irq-lan966x-oic.c:225:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (lan966x_oic->irq < 0) {
               ^~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-lan966x-oic.c:253:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/irqchip/irq-lan966x-oic.c:225:2: note: remove the 'if' if its condition is always false
           if (lan966x_oic->irq < 0) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-lan966x-oic.c:204:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   7 warnings generated.


vim +225 drivers/irqchip/irq-lan966x-oic.c

   197	
   198	static int lan966x_oic_probe(struct platform_device *pdev)
   199	{
   200		struct device_node *node = pdev->dev.of_node;
   201		struct lan966x_oic_data *lan966x_oic;
   202		struct device *dev = &pdev->dev;
   203		struct irq_chip_generic *gc;
   204		int ret;
   205		int i;
   206	
   207		lan966x_oic = devm_kmalloc(dev, sizeof(*lan966x_oic), GFP_KERNEL);
   208		if (!lan966x_oic)
   209			return -ENOMEM;
   210	
   211		lan966x_oic->regs = devm_platform_ioremap_resource(pdev, 0);
   212		if (IS_ERR(lan966x_oic->regs))
   213			return dev_err_probe(dev, PTR_ERR(lan966x_oic->regs),
   214					     "failed to map resource\n");
   215	
   216		lan966x_oic->domain = irq_domain_alloc_linear(of_node_to_fwnode(node),
   217							      LAN966X_OIC_NR_IRQ,
   218							      &irq_generic_chip_ops, NULL);
   219		if (!lan966x_oic->domain) {
   220			dev_err(dev, "failed to create an IRQ domain\n");
   221			return -EINVAL;
   222		}
   223	
   224		lan966x_oic->irq = platform_get_irq(pdev, 0);
 > 225		if (lan966x_oic->irq < 0) {
   226			dev_err_probe(dev, lan966x_oic->irq, "failed to get the IRQ\n");
   227			goto err_domain_free;
   228		}
   229	
   230		ret = irq_alloc_domain_generic_chips(lan966x_oic->domain, 32, 1, "lan966x-oic",
   231						     handle_level_irq, 0, 0, 0);
   232		if (ret) {
   233			dev_err_probe(dev, ret, "failed to alloc irq domain gc\n");
   234			goto err_domain_free;
   235		}
   236	
   237		/* Init chips */
   238		BUILD_BUG_ON(DIV_ROUND_UP(LAN966X_OIC_NR_IRQ, 32) != ARRAY_SIZE(lan966x_oic_chip_regs));
   239		for (i = 0; i < ARRAY_SIZE(lan966x_oic_chip_regs); i++) {
   240			gc = irq_get_domain_generic_chip(lan966x_oic->domain, i * 32);
   241			lan966x_oic_chip_init(lan966x_oic, gc, &lan966x_oic_chip_regs[i]);
   242		}
   243	
   244		irq_set_chained_handler_and_data(lan966x_oic->irq, lan966x_oic_irq_handler,
   245						 lan966x_oic->domain);
   246	
   247		irq_domain_publish(lan966x_oic->domain);
   248		platform_set_drvdata(pdev, lan966x_oic);
   249		return 0;
   250	
   251	err_domain_free:
   252		irq_domain_free(lan966x_oic->domain);
   253		return ret;
   254	}
   255	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

