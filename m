Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9F944DFCD
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 02:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhKLBg4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 20:36:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:2782 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhKLBg4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 20:36:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="219945899"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="gz'50?scan'50,208,50";a="219945899"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 17:34:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="gz'50?scan'50,208,50";a="452965075"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2021 17:34:05 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mlLS8-000HPf-A8; Fri, 12 Nov 2021 01:34:04 +0000
Date:   Fri, 12 Nov 2021 09:33:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/driver 17/24] drivers/misc/cxl/pci.c:1816:29:
 error: assignment discards 'const' qualifier from pointer target type
Message-ID: <202111120955.M4Pkd0T4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver
head:   0508b6f72f055b88df518db4f3811bda9bb35da4
commit: 115c9d41e58388415f4956d0a988c90fb48663b9 [17/24] cxl: Factor out common dev->driver expressions
config: powerpc64-allnoconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=115c9d41e58388415f4956d0a988c90fb48663b9
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci pci/driver
        git checkout 115c9d41e58388415f4956d0a988c90fb48663b9
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/misc/cxl/pci.c: In function 'cxl_vphb_error_detected':
>> drivers/misc/cxl/pci.c:1816:29: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
    1816 |                 err_handler = afu_drv->err_handler;
         |                             ^
   drivers/misc/cxl/pci.c: In function 'cxl_pci_slot_reset':
   drivers/misc/cxl/pci.c:2041:37: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
    2041 |                         err_handler = afu_drv->err_handler;
         |                                     ^
   drivers/misc/cxl/pci.c: In function 'cxl_pci_resume':
   drivers/misc/cxl/pci.c:2090:37: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
    2090 |                         err_handler = afu_drv->err_handler;
         |                                     ^
   cc1: all warnings being treated as errors
--
   drivers/misc/cxl/guest.c: In function 'pci_error_handlers':
>> drivers/misc/cxl/guest.c:34:29: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
      34 |                 err_handler = afu_drv->err_handler;
         |                             ^
   cc1: all warnings being treated as errors


vim +/const +1816 drivers/misc/cxl/pci.c

  1793	
  1794	static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
  1795							pci_channel_state_t state)
  1796	{
  1797		struct pci_dev *afu_dev;
  1798		struct pci_driver *afu_drv;
  1799		struct pci_error_handlers *err_handler;
  1800		pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
  1801		pci_ers_result_t afu_result = PCI_ERS_RESULT_NEED_RESET;
  1802	
  1803		/* There should only be one entry, but go through the list
  1804		 * anyway
  1805		 */
  1806		if (afu == NULL || afu->phb == NULL)
  1807			return result;
  1808	
  1809		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
  1810			afu_drv = afu_dev->driver;
  1811			if (!afu_drv)
  1812				continue;
  1813	
  1814			afu_dev->error_state = state;
  1815	
> 1816			err_handler = afu_drv->err_handler;
  1817			if (err_handler)
  1818				afu_result = err_handler->error_detected(afu_dev,
  1819									 state);
  1820			/* Disconnect trumps all, NONE trumps NEED_RESET */
  1821			if (afu_result == PCI_ERS_RESULT_DISCONNECT)
  1822				result = PCI_ERS_RESULT_DISCONNECT;
  1823			else if ((afu_result == PCI_ERS_RESULT_NONE) &&
  1824				 (result == PCI_ERS_RESULT_NEED_RESET))
  1825				result = PCI_ERS_RESULT_NONE;
  1826		}
  1827		return result;
  1828	}
  1829	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--J/dobhs11T7y2rNN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
+P8D5Tb/T4+DAAA=

--J/dobhs11T7y2rNN--
