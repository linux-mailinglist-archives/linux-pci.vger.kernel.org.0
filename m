Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D413149C38
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2020 19:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgAZSNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Jan 2020 13:13:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:36752 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgAZSNH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Jan 2020 13:13:07 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 10:13:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,366,1574150400"; 
   d="scan'208";a="246211153"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2020 10:13:01 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ivmP7-0007e3-2V; Mon, 27 Jan 2020 02:13:01 +0800
Date:   Mon, 27 Jan 2020 02:12:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, helgaas@kernel.org, lenb@kernel.org,
        bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com, Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH v2 2/2] PCI: hip: Add handling of HiSilicon hip PCIe
 controller's errors
Message-ID: <202001270152.aPmzPfjp%lkp@intel.com>
References: <20200124123938.16524-3-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124123938.16524-3-shiju.jose@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shiju,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pm/linux-next]
[also build test WARNING on linux/master linus/master v5.5-rc7]
[cannot apply to pci/next next-20200121]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Shiju-Jose/ACPI-APEI-Add-support-to-notify-the-vendor-specific-HW-errors/20200125-171952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-153-g47b6dfef-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/controller/pcie-hisi-error.c:53:8: sparse: sparse: symbol 'hisi_pcie_sec_type' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
