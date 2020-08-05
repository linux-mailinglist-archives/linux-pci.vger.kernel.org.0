Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AF23CD3F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHERXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 13:23:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:36529 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbgHERRD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 13:17:03 -0400
IronPort-SDR: LQGH8kRQyvZtaU7VF0HHlcL8iKAPP8AsAascKPBBLCai+bQHBhATK1E6Cfjrn6DJR+1lyn04cf
 mlK2q6j1ejRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="170680128"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="170680128"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 10:17:00 -0700
IronPort-SDR: HMdmtqZyX2qk23vvb3cO+QOqW38LuVSDuIA7wCz18fHXeklGjDPZjMLwS1188Q7hUmejFxKxbp
 +DPyUHFtS/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="493363169"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2020 10:16:58 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3N29-0000qo-7y; Wed, 05 Aug 2020 17:16:57 +0000
Date:   Thu, 6 Aug 2020 01:16:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     kbuild-all@lists.01.org, Rich Felker <dalias@libc.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v10 07/11] device-mapping: Introduce DMA range map,
 supplanting dma_pfn_offset
Message-ID: <202008060101.fwG2S6hX%lkp@intel.com>
References: <20200803194529.32357-8-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803194529.32357-8-james.quinlan@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on sunxi/sunxi/for-next linuxtv-media/master usb/usb-testing v5.8]
[cannot apply to robh/for-next linus/master next-20200805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jim-Quinlan/PCI-brcmstb-enable-PCIe-for-STB-chips/20200804-034755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/of/address.c:996:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = 0;
        ^
   drivers/of/address.c:978:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -ENOMEM;
        ^
   drivers/of/address.c:996:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = 0;
        ^

vim +/ret +996 drivers/of/address.c

   920	
   921	#ifdef CONFIG_HAS_DMA
   922	/**
   923	 * of_dma_get_range - Get DMA range info and put it into a map array
   924	 * @np:		device node to get DMA range info
   925	 * @map:	dma range structure to return
   926	 *
   927	 * Look in bottom up direction for the first "dma-ranges" property
   928	 * and parse it.  Put the information into a DMA offset map array.
   929	 *
   930	 * dma-ranges format:
   931	 *	DMA addr (dma_addr)	: naddr cells
   932	 *	CPU addr (phys_addr_t)	: pna cells
   933	 *	size			: nsize cells
   934	 *
   935	 * It returns -ENODEV if "dma-ranges" property was not found for this
   936	 * device in the DT.
   937	 */
   938	int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
   939	{
   940		struct device_node *node = of_node_get(np);
   941		const __be32 *ranges = NULL;
   942		bool found_dma_ranges = false;
   943		struct of_range_parser parser;
   944		struct of_range range;
   945		struct bus_dma_region *r;
   946		int len, num_ranges = 0;
   947		int ret;
   948	
   949		while (node) {
   950			ranges = of_get_property(node, "dma-ranges", &len);
   951	
   952			/* Ignore empty ranges, they imply no translation required */
   953			if (ranges && len > 0)
   954				break;
   955	
   956			/* Once we find 'dma-ranges', then a missing one is an error */
   957			if (found_dma_ranges && !ranges) {
   958				ret = -ENODEV;
   959				goto out;
   960			}
   961			found_dma_ranges = true;
   962	
   963			node = of_get_next_dma_parent(node);
   964		}
   965	
   966		if (!node || !ranges) {
   967			pr_debug("no dma-ranges found for node(%pOF)\n", np);
   968			ret = -ENODEV;
   969			goto out;
   970		}
   971	
   972		of_dma_range_parser_init(&parser, node);
   973		for_each_of_range(&parser, &range)
   974			num_ranges++;
   975	
   976		of_dma_range_parser_init(&parser, node);
   977	
   978		ret = -ENOMEM;
   979		r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
   980		if (!r)
   981			goto out;
   982	
   983		/*
   984		 * Record all info in the generic DMA ranges array for struct device.
   985		 */
   986		*map = r;
   987		for_each_of_range(&parser, &range) {
   988			pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
   989				 range.bus_addr, range.cpu_addr, range.size);
   990			r->cpu_start = range.cpu_addr;
   991			r->dma_start = range.bus_addr;
   992			r->size = range.size;
   993			r->offset = (u64)range.cpu_addr - (u64)range.bus_addr;
   994			r++;
   995		}
 > 996		ret = 0;
   997	
   998	out:
   999		of_node_put(node);
  1000		return ret;
  1001	}
  1002	#endif
  1003	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
