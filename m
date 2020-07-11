Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F021C33D
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 11:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGKJFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jul 2020 05:05:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:34623 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgGKJFA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Jul 2020 05:05:00 -0400
IronPort-SDR: tv9u+ur2NxdA5dW7n3VUkjbPJZ60y3kL67lv1+LC1pJbwwYqHnQQpw5hP5HA5EbLmeSsJZL2bu
 SFKw5ej++Igg==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="127940613"
X-IronPort-AV: E=Sophos;i="5.75,338,1589266800"; 
   d="gz'50?scan'50,208,50";a="127940613"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 01:40:58 -0700
IronPort-SDR: xufTiTmx8P4NGtY2oq/Mto8IKGkV3G8yUUeoNLaNtGLyveSt1NQuoQU6PNNrUqbvaSNhwFkBha
 hUK9b49cMvpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,338,1589266800"; 
   d="gz'50?scan'50,208,50";a="484421220"
Received: from lkp-server02.sh.intel.com (HELO 0fc60ea15964) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2020 01:40:55 -0700
Received: from kbuild by 0fc60ea15964 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1juB42-0001Hl-MA; Sat, 11 Jul 2020 08:40:54 +0000
Date:   Sat, 11 Jul 2020 16:40:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     kbuild-all@lists.01.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rich Felker <dalias@libc.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Hanjun Guo <guohanjun@huawei.com>,
        "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH v7 08/12] device core: Introduce DMA range map,
 supplanting dma_pfn_offset
Message-ID: <202007111647.9sYKNpfb%lkp@intel.com>
References: <20200708193219.47134-9-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20200708193219.47134-9-james.quinlan@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jim,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on robh/for-next sunxi/sunxi/for-next linuxtv-media/master usb/usb-testing linus/master v5.8-rc4 next-20200710]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jim-Quinlan/PCI-brcmstb-enable-PCIe-for-STB-chips/20200709-033557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: m68k-randconfig-r035-20200710 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/of/device.c: In function 'of_dma_configure':
>> drivers/of/device.c:116:37: error: dereferencing pointer to incomplete type 'const struct bus_dma_region'
     116 |   for (dma_start = ~(dma_addr_t)0; r->size; r++) {
         |                                     ^~
>> drivers/of/device.c:116:46: error: increment of pointer to an incomplete type 'const struct bus_dma_region'
     116 |   for (dma_start = ~(dma_addr_t)0; r->size; r++) {
         |                                              ^~
   In file included from drivers/of/device.c:8:
   At top level:
   include/linux/dma-mapping.h:498:12: warning: 'dma_attach_offset_range' defined but not used [-Wunused-function]
     498 | static int dma_attach_offset_range(struct device *dev, phys_addr_t cpu_start,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/of/address.c: In function 'dma_create_offset_map':
>> drivers/of/address.c:929:37: error: dereferencing pointer to incomplete type 'struct bus_dma_region'
     929 |  r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
         |                                     ^~
>> drivers/of/address.c:950:4: error: increment of pointer to an incomplete type 'struct bus_dma_region'
     950 |   r++;
         |    ^~
   In file included from include/linux/pci-dma-compat.h:8,
                    from include/linux/pci.h:2415,
                    from drivers/of/address.c:11:
   At top level:
   include/linux/dma-mapping.h:498:12: warning: 'dma_attach_offset_range' defined but not used [-Wunused-function]
     498 | static int dma_attach_offset_range(struct device *dev, phys_addr_t cpu_start,
         |            ^~~~~~~~~~~~~~~~~~~~~~~

vim +116 drivers/of/device.c

    74	
    75	/**
    76	 * of_dma_configure - Setup DMA configuration
    77	 * @dev:	Device to apply DMA configuration
    78	 * @np:		Pointer to OF node having DMA configuration
    79	 * @force_dma:  Whether device is to be set up by of_dma_configure() even if
    80	 *		DMA capability is not explicitly described by firmware.
    81	 *
    82	 * Try to get devices's DMA configuration from DT and update it
    83	 * accordingly.
    84	 *
    85	 * If platform code needs to use its own special DMA configuration, it
    86	 * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
    87	 * to fix up DMA configuration.
    88	 */
    89	int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
    90	{
    91		const struct iommu_ops *iommu;
    92		const struct bus_dma_region *map;
    93		dma_addr_t dma_start = 0;
    94		u64 mask, end, size = 0;
    95		bool coherent;
    96		int ret;
    97	
    98		map = of_dma_get_range(np);
    99		ret = PTR_ERR_OR_ZERO(map);
   100		if (ret < 0) {
   101			/*
   102			 * For legacy reasons, we have to assume some devices need
   103			 * DMA configuration regardless of whether "dma-ranges" is
   104			 * correctly specified or not.
   105			 */
   106			if (!force_dma)
   107				return ret == -ENODEV ? 0 : ret;
   108	
   109			dma_start = 0;
   110			map = NULL;
   111		} else if (map) {
   112			const struct bus_dma_region *r = map;
   113			dma_addr_t dma_end = 0;
   114	
   115			/* Determine the overall bounds of all DMA regions */
 > 116			for (dma_start = ~(dma_addr_t)0; r->size; r++) {
   117				/* Take lower and upper limits */
   118				if (r->dma_start < dma_start)
   119					dma_start = r->dma_start;
   120				if (r->dma_start + r->size > dma_end)
   121					dma_end = r->dma_start + r->size;
   122			}
   123			size = dma_end - dma_start;
   124	
   125			/*
   126			 * Add a work around to treat the size as mask + 1 in case
   127			 * it is defined in DT as a mask.
   128			 */
   129			if (size & 1) {
   130				dev_warn(dev, "Invalid size 0x%llx for dma-range(s)\n", size);
   131				size = size + 1;
   132			}
   133	
   134			if (!size) {
   135				dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
   136				kfree(map);
   137				return -EINVAL;
   138			}
   139		}
   140	
   141		/*
   142		 * If @dev is expected to be DMA-capable then the bus code that created
   143		 * it should have initialised its dma_mask pointer by this point. For
   144		 * now, we'll continue the legacy behaviour of coercing it to the
   145		 * coherent mask if not, but we'll no longer do so quietly.
   146		 */
   147		if (!dev->dma_mask) {
   148			dev_warn(dev, "DMA mask not set\n");
   149			dev->dma_mask = &dev->coherent_dma_mask;
   150		}
   151	
   152		if (!size && dev->coherent_dma_mask)
   153			size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
   154		else if (!size)
   155			size = 1ULL << 32;
   156	
   157		/*
   158		 * Limit coherent and dma mask based on size and default mask
   159		 * set by the driver.
   160		 */
   161		end = dma_start + size - 1;
   162		mask = DMA_BIT_MASK(ilog2(end) + 1);
   163		dev->coherent_dma_mask &= mask;
   164		*dev->dma_mask &= mask;
   165		/* ...but only set bus limit if we found valid dma-ranges earlier */
   166		if (!ret)
   167			dev->bus_dma_limit = end;
   168	
   169		coherent = of_dma_is_coherent(np);
   170		dev_dbg(dev, "device is%sdma coherent\n",
   171			coherent ? " " : " not ");
   172	
   173		iommu = of_iommu_configure(dev, np);
   174		if (PTR_ERR(iommu) == -EPROBE_DEFER) {
   175			kfree(map);
   176			return -EPROBE_DEFER;
   177		}
   178	
   179		dev_dbg(dev, "device is%sbehind an iommu\n",
   180			iommu ? " " : " not ");
   181	
   182		arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
   183	
   184		dev->dma_range_map = map;
   185		return 0;
   186	}
   187	EXPORT_SYMBOL_GPL(of_dma_configure);
   188	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6c2NcOVqGQ03X4Wi--
