Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0083DC0C5
	for <lists+linux-pci@lfdr.de>; Sat, 31 Jul 2021 00:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhG3WFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 18:05:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:31042 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233072AbhG3WFS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Jul 2021 18:05:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="192771391"
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="gz'50?scan'50,208,50";a="192771391"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 15:05:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="gz'50?scan'50,208,50";a="667457265"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2021 15:05:07 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9acs-000AO3-LM; Fri, 30 Jul 2021 22:05:06 +0000
Date:   Sat, 31 Jul 2021 06:04:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [pci:wip/bjorn-vpd-v2 5/9] drivers/pci/vpd.c:89:7: warning: format
 specifies type 'size_t' (aka 'unsigned long') but the argument has type
 'unsigned char'
Message-ID: <202107310602.vLHoTLr2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git wip/bjorn-vpd-v2
head:   d4466f3225fe2067d1a815ce03e1ab7abc6c3c28
commit: 49c5c3061498060f93d08a2386503596e0ff14be [5/9] PCI/VPD: Don't check Large Resource Item Names for validity
config: x86_64-randconfig-c001-20210730 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 4f71f59bf3d9914188a11d0c41bedbb339d36ff5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=49c5c3061498060f93d08a2386503596e0ff14be
        git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags pci wip/bjorn-vpd-v2
        git checkout 49c5c3061498060f93d08a2386503596e0ff14be
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/vpd.c:89:7: warning: format specifies type 'size_t' (aka 'unsigned long') but the argument has type 'unsigned char' [-Wformat]
                                            tag, off + 1);
                                            ^~~
   include/linux/pci.h:2465:67: note: expanded from macro 'pci_warn'
   #define pci_warn(pdev, fmt, arg...)     dev_warn(&(pdev)->dev, fmt, ##arg)
                                                                  ~~~    ^~~
   include/linux/dev_printk.h:114:33: note: expanded from macro 'dev_warn'
           _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
>> drivers/pci/vpd.c:89:12: warning: data argument not used by format string [-Wformat-extra-args]
                                            tag, off + 1);
                                                 ^
   include/linux/pci.h:2465:67: note: expanded from macro 'pci_warn'
   #define pci_warn(pdev, fmt, arg...)     dev_warn(&(pdev)->dev, fmt, ##arg)
                                                                  ~~~    ^
   include/linux/dev_printk.h:114:33: note: expanded from macro 'dev_warn'
           _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^
>> drivers/pci/vpd.c:89:7: warning: variable 'tag' is uninitialized when used here [-Wuninitialized]
                                            tag, off + 1);
                                            ^~~
   include/linux/pci.h:2465:67: note: expanded from macro 'pci_warn'
   #define pci_warn(pdev, fmt, arg...)     dev_warn(&(pdev)->dev, fmt, ##arg)
                                                                         ^~~
   include/linux/dev_printk.h:114:33: note: expanded from macro 'dev_warn'
           _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                          ^~~~~~~~~~~
   drivers/pci/vpd.c:79:20: note: initialize the variable 'tag' to silence this warning
                   unsigned char tag;
                                    ^
                                     = '\0'
   3 warnings generated.


vim +89 drivers/pci/vpd.c

    67	
    68	/**
    69	 * pci_vpd_size - determine actual size of Vital Product Data
    70	 * @dev:	pci device struct
    71	 * @old_size:	current assumed size, also maximum allowed size
    72	 */
    73	static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
    74	{
    75		size_t off = 0;
    76		unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
    77	
    78		while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
    79			unsigned char tag;
    80			size_t size;
    81	
    82			if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
    83				goto error;
    84	
    85			if (header[0] & PCI_VPD_LRDT) {
    86				/* Large Resource Data Type Tag */
    87				if (pci_read_vpd(dev, off + 1, 2, &header[1]) != 2) {
    88					pci_warn(dev, "failed VPD read at offset %zu\n",
  > 89						 tag, off + 1);
    90					return 0;
    91				}
    92				size = pci_vpd_lrdt_size(header);
    93				if (off + size > PCI_VPD_MAX_SIZE)
    94					goto error;
    95	
    96				off += PCI_VPD_LRDT_TAG_SIZE + size;
    97			} else {
    98				/* Short Resource Data Type Tag */
    99				tag = pci_vpd_srdt_tag(header);
   100				size = pci_vpd_srdt_size(header);
   101				if (size == 0 || off + size > PCI_VPD_MAX_SIZE)
   102					goto error;
   103	
   104				off += PCI_VPD_SRDT_TAG_SIZE + size;
   105				if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
   106					return off;
   107			}
   108		}
   109		return 0;
   110	
   111	error:
   112		pci_info(dev, "invalid VPD tag %#04x at offset %zu%s\n",
   113			 header[0], off, off == 0 ?
   114			 "; assume missing optional EEPROM" : "");
   115		return 0;
   116	}
   117	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
GR7OnT31jKnnkQh14pbYkoNji5eL+vBgJvQIukotyzY2JkNR2wyVydilffH46a3ImHv4ybZc
FF0tLWOzRlFLAprL7YbtdkmMPzIkz3vH9g0ToOhi2zVMgJauTPrx3ND1rmW3Kxz9VNmZTZtT
dEDU8CX9Qk9cJTBJJoq499OCbs8Wq7fL65UmGY822LX9+5XqLo9vnxe/vD9eqdw9X0+/Lr4I
rNIWj3RLK4oxfbRHA1ucFJy4t2LrO0K0dc6AKpqSB81ExzqLHSTRySQ7ajBqFGXEVbwnsK9+
YlGN/nNxPb3R1fUKwZDl7xcyzdrDnVzlQfamTpYpH1PIU5JVqo4iL3QwojssS5T0D2LsDCEd
1Rw9W21CRpQvF1kZnWuYgYD+XtJOczGxO6Gx1in+xla2s0r/OlGk9+QywGf5mCiO0UGBjSlL
zR7WS8vwENTQWxZ+GTUkl9xTgbjPiX0QtVvG2YuAzLbU4c4h3jlaP/ASsAWdJ0306cNzCtSc
OBm/ZZ8GgrGl6eAUV29WOqErotakdBKZXsBjA2sZBYnh0e2pxUNbm4UwzLvFL8ZZJw+bhmow
plajX+qESKtRojLT2JCVX9DqZzUeYgnAMvDwwDTT13lKQ9aHLtCGBZ2BvlIdmFiur4ysrFhC
g4sxA0RyqlW+WIYAmM7IOdxoucUWOn3gc3DzA2BIVrGFHhoDmKeo6HeDUB+7mUNXSNztaGTw
bDSmM+BtVzqRq9WfkzF1ZRTIkdIFmU1XY7hJ2GaiAE77dcEofEEqRI469Vn7OTZKdfWmcZgd
Bt8qdoSWWV/ern8tkpfT2/np8fXD3eXt9Pi66KY58iFlq1XW7Y01o6OPbouVIbltfVsxtxrI
tmteGJZp5foGZZpNjnXWua4hpJ3AgJ1NCrDoF8jJjmJBMc5e9N0uNjR3ke9oU5tTj7S9ZpPB
eTkiKmylJ6mmETD3V+6+RLJ/R4TFhrgu/XyMzMsik7GORaSCZRXhP/7N2nQpOHGYZgrTSDx3
DLw63JcJeS8ur88/el3zQ1OW8hhsSqU5+aJIP5OuBbrYmUB5T8y3+3k63EgOkcEXXy5vXE/S
1DM3Pjz8poymermRYxuNVNNgomDjaLOFUU1tBoaGnqXoe4yoZ8TJZjUFDgdMUrZck2hd6p8D
ZNSHiWXYLak+rAtMKpqCwP9urEhxcHzLN80dtt1ytJUOFglX03w223ZHXPwlO5aKpNvOwQzH
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
INMBR5R9Z6kice1nF9oJZcPmbv8H8fxVCQTCAQA=

--X1bOJ3K7DJ5YkBrT--
