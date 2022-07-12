Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FD357187A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 13:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiGLL1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGLL1P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 07:27:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CB42F3B5
        for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2022 04:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657625234; x=1689161234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=69+kbG0tq7oeIcas49yyGin4VqWwYxLBRJtlwlIyde4=;
  b=PQz2veqp8pe3wJzemYlD2C6GCIj48V6yUFZFtiznGqaXMxlPdE1WeZOc
   7zTALXTtqc6zb1jhiSUk4ZJ+1FJolKEJ1JJOXDGK3CHWxM7xHpCs8p9Ad
   4pdHWM1OXphZpaIn0M8oDQBDPFDJ0ETnxUhKDDXIj6vCOHrMZOIAFGHHC
   7kS8WkMnjCkdomJJD7ZIbM9SfXKqScRBqWTSX3F/xoRQNnXeVI9PTcEtC
   7YZd70/lCUcAmUqHXLNHZUJp3zVLdNIhxN7nlUJ2UaM7NODaU5ZAtp/e3
   ZBTPjCtc6BzuomNOuuF0YLlCAfbyt1vzgcWcPPsOmrE/VFCb8ZEiQHY5G
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="371216775"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="371216775"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="662919108"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2022 04:27:12 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBE2p-00024d-Hr;
        Tue, 12 Jul 2022 11:27:11 +0000
Date:   Tue, 12 Jul 2022 19:26:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [helgaas-pci:pci/aspm 1/1] drivers/pci/pci.c:1391:17: error:
 implicit declaration of function 'pcie_aspm_pm_state_change'
Message-ID: <202207121915.ogXzRUd6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aspm
head:   a27544423802e94e88da50b6bfd6cceedcd7dab6
commit: a27544423802e94e88da50b6bfd6cceedcd7dab6 [1/1] PCI/ASPM: Remove pcie_aspm_pm_state_change()
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220712/202207121915.ogXzRUd6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=a27544423802e94e88da50b6bfd6cceedcd7dab6
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci pci/aspm
        git checkout a27544423802e94e88da50b6bfd6cceedcd7dab6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/pci.c: In function 'pci_set_low_power_state':
>> drivers/pci/pci.c:1391:17: error: implicit declaration of function 'pcie_aspm_pm_state_change' [-Werror=implicit-function-declaration]
    1391 |                 pcie_aspm_pm_state_change(dev->bus->self);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pcie_aspm_pm_state_change +1391 drivers/pci/pci.c

0e5dd46b761195 Rafael J. Wysocki 2009-03-26  1322  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1323  /**
7957d201456f43 Rafael J. Wysocki 2022-05-05  1324   * pci_set_low_power_state - Put a PCI device into a low-power state.
7957d201456f43 Rafael J. Wysocki 2022-05-05  1325   * @dev: PCI device to handle.
7957d201456f43 Rafael J. Wysocki 2022-05-05  1326   * @state: PCI power state (D1, D2, D3hot) to put the device into.
7957d201456f43 Rafael J. Wysocki 2022-05-05  1327   *
7957d201456f43 Rafael J. Wysocki 2022-05-05  1328   * Use the device's PCI_PM_CTRL register to put it into a low-power state.
7957d201456f43 Rafael J. Wysocki 2022-05-05  1329   *
7957d201456f43 Rafael J. Wysocki 2022-05-05  1330   * RETURN VALUE:
7957d201456f43 Rafael J. Wysocki 2022-05-05  1331   * -EINVAL if the requested state is invalid.
7957d201456f43 Rafael J. Wysocki 2022-05-05  1332   * -EIO if device does not support PCI PM or its PM capabilities register has a
7957d201456f43 Rafael J. Wysocki 2022-05-05  1333   * wrong version, or device doesn't support the requested state.
7957d201456f43 Rafael J. Wysocki 2022-05-05  1334   * 0 if device already is in the requested state.
7957d201456f43 Rafael J. Wysocki 2022-05-05  1335   * 0 if device's power state has been successfully changed.
7957d201456f43 Rafael J. Wysocki 2022-05-05  1336   */
7957d201456f43 Rafael J. Wysocki 2022-05-05  1337  static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
7957d201456f43 Rafael J. Wysocki 2022-05-05  1338  {
7957d201456f43 Rafael J. Wysocki 2022-05-05  1339  	u16 pmcsr;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1340  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1341  	if (!dev->pm_cap)
7957d201456f43 Rafael J. Wysocki 2022-05-05  1342  		return -EIO;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1343  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1344  	/*
7957d201456f43 Rafael J. Wysocki 2022-05-05  1345  	 * Validate transition: We can enter D0 from any state, but if
7957d201456f43 Rafael J. Wysocki 2022-05-05  1346  	 * we're already in a low-power state, we can only go deeper.  E.g.,
7957d201456f43 Rafael J. Wysocki 2022-05-05  1347  	 * we can go from D1 to D3, but we can't go directly from D3 to D1;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1348  	 * we'd have to go from D3 to D0, then to D1.
7957d201456f43 Rafael J. Wysocki 2022-05-05  1349  	 */
7957d201456f43 Rafael J. Wysocki 2022-05-05  1350  	if (dev->current_state <= PCI_D3cold && dev->current_state > state) {
0aacdc95740180 Rafael J. Wysocki 2022-05-05  1351  		pci_dbg(dev, "Invalid power transition (from %s to %s)\n",
7957d201456f43 Rafael J. Wysocki 2022-05-05  1352  			pci_power_name(dev->current_state),
7957d201456f43 Rafael J. Wysocki 2022-05-05  1353  			pci_power_name(state));
7957d201456f43 Rafael J. Wysocki 2022-05-05  1354  		return -EINVAL;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1355  	}
7957d201456f43 Rafael J. Wysocki 2022-05-05  1356  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1357  	/* Check if this device supports the desired state */
7957d201456f43 Rafael J. Wysocki 2022-05-05  1358  	if ((state == PCI_D1 && !dev->d1_support)
7957d201456f43 Rafael J. Wysocki 2022-05-05  1359  	   || (state == PCI_D2 && !dev->d2_support))
7957d201456f43 Rafael J. Wysocki 2022-05-05  1360  		return -EIO;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1361  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1362  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
7957d201456f43 Rafael J. Wysocki 2022-05-05  1363  	if (PCI_POSSIBLE_ERROR(pmcsr)) {
7957d201456f43 Rafael J. Wysocki 2022-05-05  1364  		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
7957d201456f43 Rafael J. Wysocki 2022-05-05  1365  			pci_power_name(dev->current_state),
7957d201456f43 Rafael J. Wysocki 2022-05-05  1366  			pci_power_name(state));
1aa85bb14d8ed0 Rafael J. Wysocki 2022-05-05  1367  		dev->current_state = PCI_D3cold;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1368  		return -EIO;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1369  	}
7957d201456f43 Rafael J. Wysocki 2022-05-05  1370  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1371  	pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1372  	pmcsr |= state;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1373  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1374  	/* Enter specified state */
7957d201456f43 Rafael J. Wysocki 2022-05-05  1375  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
7957d201456f43 Rafael J. Wysocki 2022-05-05  1376  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1377  	/* Mandatory power management transition delays; see PCI PM 1.2. */
7957d201456f43 Rafael J. Wysocki 2022-05-05  1378  	if (state == PCI_D3hot)
7957d201456f43 Rafael J. Wysocki 2022-05-05  1379  		pci_dev_d3_sleep(dev);
7957d201456f43 Rafael J. Wysocki 2022-05-05  1380  	else if (state == PCI_D2)
7957d201456f43 Rafael J. Wysocki 2022-05-05  1381  		udelay(PCI_PM_D2_DELAY);
7957d201456f43 Rafael J. Wysocki 2022-05-05  1382  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1383  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
7957d201456f43 Rafael J. Wysocki 2022-05-05  1384  	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1385  	if (dev->current_state != state)
7957d201456f43 Rafael J. Wysocki 2022-05-05  1386  		pci_info_ratelimited(dev, "Refused to change power state from %s to %s\n",
7957d201456f43 Rafael J. Wysocki 2022-05-05  1387  				     pci_power_name(dev->current_state),
7957d201456f43 Rafael J. Wysocki 2022-05-05  1388  				     pci_power_name(state));
7957d201456f43 Rafael J. Wysocki 2022-05-05  1389  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1390  	if (dev->bus->self)
7957d201456f43 Rafael J. Wysocki 2022-05-05 @1391  		pcie_aspm_pm_state_change(dev->bus->self);
7957d201456f43 Rafael J. Wysocki 2022-05-05  1392  
7957d201456f43 Rafael J. Wysocki 2022-05-05  1393  	return 0;
7957d201456f43 Rafael J. Wysocki 2022-05-05  1394  }
7957d201456f43 Rafael J. Wysocki 2022-05-05  1395  

:::::: The code at line 1391 was first introduced by commit
:::::: 7957d201456f436557870cf8bbd47328a280c522 PCI/PM: Relocate pci_set_low_power_state()

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
