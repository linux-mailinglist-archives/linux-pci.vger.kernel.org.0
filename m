Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2089A115FFE
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2019 01:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfLHAsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Dec 2019 19:48:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:31815 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLHAsn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Dec 2019 19:48:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2019 16:48:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,290,1571727600"; 
   d="scan'208";a="202479633"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Dec 2019 16:48:39 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1idkkY-00094a-Do; Sun, 08 Dec 2019 08:48:38 +0800
Date:   Sun, 8 Dec 2019 08:48:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     James Sewart <jamessewart@arista.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v6 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
Message-ID: <201912080729.iJaJfY0k%lkp@intel.com>
References: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi James,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.4-rc8]
[also build test WARNING on next-20191206]
[cannot apply to pci/next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/James-Sewart/PCI-Fix-off-by-one-in-dma_alias_mask-allocation-size/20191204-034421
base:    af42d3466bdc8f39806b26f593604fdc54140bcb
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-91-g817270f-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/iommu/amd_iommu.c:288:34: sparse: sparse: not enough arguments for function pci_add_dma_alias

vim +288 drivers/iommu/amd_iommu.c

e3156048346c28 Joerg Roedel   2016-04-08  234  
e3156048346c28 Joerg Roedel   2016-04-08  235  static u16 get_alias(struct device *dev)
e3156048346c28 Joerg Roedel   2016-04-08  236  {
e3156048346c28 Joerg Roedel   2016-04-08  237  	struct pci_dev *pdev = to_pci_dev(dev);
e3156048346c28 Joerg Roedel   2016-04-08  238  	u16 devid, ivrs_alias, pci_alias;
e3156048346c28 Joerg Roedel   2016-04-08  239  
6c0b43df74f900 Joerg Roedel   2016-05-09  240  	/* The callers make sure that get_device_id() does not fail here */
e3156048346c28 Joerg Roedel   2016-04-08  241  	devid = get_device_id(dev);
5ebb1bc2d63d90 Arindam Nath   2018-09-18  242  
5ebb1bc2d63d90 Arindam Nath   2018-09-18  243  	/* For ACPI HID devices, we simply return the devid as such */
5ebb1bc2d63d90 Arindam Nath   2018-09-18  244  	if (!dev_is_pci(dev))
5ebb1bc2d63d90 Arindam Nath   2018-09-18  245  		return devid;
5ebb1bc2d63d90 Arindam Nath   2018-09-18  246  
e3156048346c28 Joerg Roedel   2016-04-08  247  	ivrs_alias = amd_iommu_alias_table[devid];
5ebb1bc2d63d90 Arindam Nath   2018-09-18  248  
e3156048346c28 Joerg Roedel   2016-04-08  249  	pci_for_each_dma_alias(pdev, __last_alias, &pci_alias);
e3156048346c28 Joerg Roedel   2016-04-08  250  
e3156048346c28 Joerg Roedel   2016-04-08  251  	if (ivrs_alias == pci_alias)
e3156048346c28 Joerg Roedel   2016-04-08  252  		return ivrs_alias;
e3156048346c28 Joerg Roedel   2016-04-08  253  
e3156048346c28 Joerg Roedel   2016-04-08  254  	/*
e3156048346c28 Joerg Roedel   2016-04-08  255  	 * DMA alias showdown
e3156048346c28 Joerg Roedel   2016-04-08  256  	 *
e3156048346c28 Joerg Roedel   2016-04-08  257  	 * The IVRS is fairly reliable in telling us about aliases, but it
e3156048346c28 Joerg Roedel   2016-04-08  258  	 * can't know about every screwy device.  If we don't have an IVRS
e3156048346c28 Joerg Roedel   2016-04-08  259  	 * reported alias, use the PCI reported alias.  In that case we may
e3156048346c28 Joerg Roedel   2016-04-08  260  	 * still need to initialize the rlookup and dev_table entries if the
e3156048346c28 Joerg Roedel   2016-04-08  261  	 * alias is to a non-existent device.
e3156048346c28 Joerg Roedel   2016-04-08  262  	 */
e3156048346c28 Joerg Roedel   2016-04-08  263  	if (ivrs_alias == devid) {
e3156048346c28 Joerg Roedel   2016-04-08  264  		if (!amd_iommu_rlookup_table[pci_alias]) {
e3156048346c28 Joerg Roedel   2016-04-08  265  			amd_iommu_rlookup_table[pci_alias] =
e3156048346c28 Joerg Roedel   2016-04-08  266  				amd_iommu_rlookup_table[devid];
e3156048346c28 Joerg Roedel   2016-04-08  267  			memcpy(amd_iommu_dev_table[pci_alias].data,
e3156048346c28 Joerg Roedel   2016-04-08  268  			       amd_iommu_dev_table[devid].data,
e3156048346c28 Joerg Roedel   2016-04-08  269  			       sizeof(amd_iommu_dev_table[pci_alias].data));
e3156048346c28 Joerg Roedel   2016-04-08  270  		}
e3156048346c28 Joerg Roedel   2016-04-08  271  
e3156048346c28 Joerg Roedel   2016-04-08  272  		return pci_alias;
e3156048346c28 Joerg Roedel   2016-04-08  273  	}
e3156048346c28 Joerg Roedel   2016-04-08  274  
5f226da1b1d706 Bjorn Helgaas  2019-02-08  275  	pci_info(pdev, "Using IVRS reported alias %02x:%02x.%d "
5f226da1b1d706 Bjorn Helgaas  2019-02-08  276  		"for device [%04x:%04x], kernel reported alias "
e3156048346c28 Joerg Roedel   2016-04-08  277  		"%02x:%02x.%d\n", PCI_BUS_NUM(ivrs_alias), PCI_SLOT(ivrs_alias),
5f226da1b1d706 Bjorn Helgaas  2019-02-08  278  		PCI_FUNC(ivrs_alias), pdev->vendor, pdev->device,
e3156048346c28 Joerg Roedel   2016-04-08  279  		PCI_BUS_NUM(pci_alias), PCI_SLOT(pci_alias),
e3156048346c28 Joerg Roedel   2016-04-08  280  		PCI_FUNC(pci_alias));
e3156048346c28 Joerg Roedel   2016-04-08  281  
e3156048346c28 Joerg Roedel   2016-04-08  282  	/*
e3156048346c28 Joerg Roedel   2016-04-08  283  	 * If we don't have a PCI DMA alias and the IVRS alias is on the same
e3156048346c28 Joerg Roedel   2016-04-08  284  	 * bus, then the IVRS table may know about a quirk that we don't.
e3156048346c28 Joerg Roedel   2016-04-08  285  	 */
e3156048346c28 Joerg Roedel   2016-04-08  286  	if (pci_alias == devid &&
e3156048346c28 Joerg Roedel   2016-04-08  287  	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
7afd16f882887c Linus Torvalds 2016-05-19 @288  		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
5f226da1b1d706 Bjorn Helgaas  2019-02-08  289  		pci_info(pdev, "Added PCI DMA alias %02x.%d\n",
5f226da1b1d706 Bjorn Helgaas  2019-02-08  290  			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias));
e3156048346c28 Joerg Roedel   2016-04-08  291  	}
e3156048346c28 Joerg Roedel   2016-04-08  292  
e3156048346c28 Joerg Roedel   2016-04-08  293  	return ivrs_alias;
e3156048346c28 Joerg Roedel   2016-04-08  294  }
e3156048346c28 Joerg Roedel   2016-04-08  295  

:::::: The code at line 288 was first introduced by commit
:::::: 7afd16f882887c9adc69cd1794f5e57777723217 Merge tag 'pci-v4.7-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
