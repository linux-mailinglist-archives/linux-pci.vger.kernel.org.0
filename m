Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39267F0D14
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 08:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjKTH71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 02:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTH71 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 02:59:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA60C0;
        Sun, 19 Nov 2023 23:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700467163; x=1732003163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JzSFdhpu4Z2Dl0iRmYFt0FhnPqgEZQkDIIi0hsLtfRY=;
  b=K1jdFrhvb4x0CEMUALYXqV/qwg78WVvlBF3S50M/tut32YDnFc6aYgTs
   cSO7YaO36lFSNAWRWxPnA9pA3tBvyv79/hn2OUJLKSPCmqLjin6PXUdLF
   WRBxKr/9ZJFMrtu/fCcEQHkp0jTXi0iTdwW/rrBXf9PrI18kCH9WJZeXU
   RP2WGGn11j11GKmJeSfFV9m3zVDLUPljphCB31h8yY/TRvogcYM46qXy5
   8Z8plrub4BPGSbmOo2np9Rs27rMGISm5BbH19WHQLjmy1Sdsf0AFc4HAa
   Os3jhURtws0wTqOJcuw0pS2Wjs93jX5gmrb7ZET4iEYq26Rx7wbA2ZPNl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="390432918"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="390432918"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 23:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1097677168"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="1097677168"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2023 23:59:19 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4zBc-0006CC-2s;
        Mon, 20 Nov 2023 07:59:16 +0000
Date:   Mon, 20 Nov 2023 15:58:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-pci@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        chenhuacai@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v5] pci: loongson: Workaround MIPS firmware MRRS settings
Message-ID: <202311201537.u2ZGD7A8-lkp@intel.com>
References: <20231119215635.52810-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119215635.52810-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jiaxun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.7-rc2 next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaxun-Yang/pci-loongson-Workaround-MIPS-firmware-MRRS-settings/20231120-055946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231119215635.52810-1-jiaxun.yang%40flygoat.com
patch subject: [PATCH v5] pci: loongson: Workaround MIPS firmware MRRS settings
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20231120/202311201537.u2ZGD7A8-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311201537.u2ZGD7A8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311201537.u2ZGD7A8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/controller/pci-loongson.c:10:
   drivers/pci/controller/pci-loongson.c:122:50: error: 'loongson_mrrs_quirk_old' undeclared here (not in a function)
     122 | DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk_old);
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pci.h:2241:57: note: in definition of macro 'DECLARE_PCI_FIXUP_SECTION'
    2241 |                 = { vendor, device, class, class_shift, hook };
         |                                                         ^~~~
   drivers/pci/controller/pci-loongson.c:122:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_ENABLE'
     122 | DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk_old);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pci-loongson.c:92:13: warning: 'loongson_set_min_mrrs_quirk' defined but not used [-Wunused-function]
      92 | static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/loongson_set_min_mrrs_quirk +92 drivers/pci/controller/pci-loongson.c

    54	
    55	/* Fixup wrong class code in PCIe bridges */
    56	static void bridge_class_quirk(struct pci_dev *dev)
    57	{
    58		dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
    59	}
    60	DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
    61				DEV_LS7A_PCIE_PORT0, bridge_class_quirk);
    62	DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
    63				DEV_LS7A_PCIE_PORT1, bridge_class_quirk);
    64	DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
    65				DEV_LS7A_PCIE_PORT2, bridge_class_quirk);
    66	
    67	static void system_bus_quirk(struct pci_dev *pdev)
    68	{
    69		/*
    70		 * The address space consumed by these devices is outside the
    71		 * resources of the host bridge.
    72		 */
    73		pdev->mmio_always_on = 1;
    74		pdev->non_compliant_bars = 1;
    75	}
    76	DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
    77				DEV_LS2K_APB, system_bus_quirk);
    78	DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
    79				DEV_LS7A_CONF, system_bus_quirk);
    80	DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
    81				DEV_LS7A_LPC, system_bus_quirk);
    82	
    83	/*
    84	 * Some Loongson PCIe ports have h/w limitations of maximum read
    85	 * request size. They can't handle anything larger than this.
    86	 * Sane firmware will set proper MRRS at boot, so we only need
    87	 * no_inc_mrrs for bridges. However, some MIPS Loongson firmware
    88	 * won't set MRRS properly, and we have to enforce maximum safe
    89	 * MRRS, which is 256 bytes.
    90	 */
    91	#ifdef CONFIG_MIPS
  > 92	static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
    93	{
    94		struct pci_bus *bus = pdev->bus;
    95		struct pci_dev *bridge;
    96		static const struct pci_device_id bridge_devids[] = {
    97			{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
    98			{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
    99			{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
   100			{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
   101			{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
   102			{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
   103			{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
   104			{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
   105			{ 0, },
   106		};
   107	
   108		/* look for the matching bridge */
   109		while (!pci_is_root_bus(bus)) {
   110			bridge = bus->self;
   111			bus = bus->parent;
   112	
   113			if (pci_match_id(bridge_devids, bridge)) {
   114				if (pcie_get_readrq(pdev) > 256) {
   115					pci_info(pdev, "limiting MRRS to 256\n");
   116					pcie_set_readrq(pdev, 256);
   117				}
   118				break;
   119			}
   120		}
   121	}
   122	DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk_old);
   123	#endif
   124	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
