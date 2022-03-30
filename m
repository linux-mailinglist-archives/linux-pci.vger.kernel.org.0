Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D854ECFC3
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 00:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiC3Wph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 18:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiC3Wph (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 18:45:37 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8736B13D3A
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 15:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648680229; x=1680216229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mjpwTFWFKllqpW+nyHbY5ranGG60/S6m6C614Pwsq8o=;
  b=QQObP7ZaZJ7rmjebnKZq0rghydzOev1GjUK7ZkzZ+tLBd5Zb4D2c1dI0
   lHAajzMgwknbqRCoxeJ0q9tKKnnuQ4dbV5evRH4/037dDtLiuwZuwnXM6
   PPox+1FAH9Nur2seeCWuh7RAZqQWQFF0WV4cfYjjQv44Uxns6TebgEOON
   W9OvGU3wqI6OnvQo/9cJprkzX4WBLAADLjkDdIfylA9B7pq7AFoG8qrmq
   Udecom2k03u7RSSbPxe2je4oW+ghBBSw/2hCcJxY+TW/g+n9Opy2fmLPO
   mNwbrCZmjMTqRtxbZU2uZtFDawef7QY8yI1uCoAW+vvs4qo6rcw/fuc0N
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320358680"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="320358680"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="522086220"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Mar 2022 15:43:47 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZh2Y-0000bM-Fk;
        Wed, 30 Mar 2022 22:43:46 +0000
Date:   Thu, 31 Mar 2022 06:43:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [helgaas-pci:for-linus 4/4]
 drivers/pci/controller/pci-hyperv.c:1486:9: error: implicit declaration of
 function 'hv_set_msi_entry_from_desc'
Message-ID: <202203310629.C8KmndLW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
head:   18146f25ac6695ce2ed09503de46dafd2b1f36a6
commit: 18146f25ac6695ce2ed09503de46dafd2b1f36a6 [4/4] PCI: hv: Remove unused hv_set_msi_entry_from_desc()
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220331/202203310629.C8KmndLW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=18146f25ac6695ce2ed09503de46dafd2b1f36a6
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci for-linus
        git checkout 18146f25ac6695ce2ed09503de46dafd2b1f36a6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/pci-hyperv.c: In function 'hv_irq_unmask':
>> drivers/pci/controller/pci-hyperv.c:1486:9: error: implicit declaration of function 'hv_set_msi_entry_from_desc' [-Werror=implicit-function-declaration]
    1486 |         hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/hv_set_msi_entry_from_desc +1486 drivers/pci/controller/pci-hyperv.c

4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1450  
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1451  /**
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1452   * hv_irq_unmask() - "Unmask" the IRQ by setting its current
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1453   * affinity.
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1454   * @data:	Describes the IRQ
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1455   *
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1456   * Build new a destination for the MSI and make a hypercall to
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1457   * update the Interrupt Redirection Table. "Device Logical ID"
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1458   * is built out of this PCI bus's instance GUID and the function
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1459   * number of the device.
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1460   */
542ccf4551fa01 drivers/pci/host/pci-hyperv.c       Tobias Klauser   2016-10-31  1461  static void hv_irq_unmask(struct irq_data *data)
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1462  {
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1463  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
61bfd920abbf2c drivers/pci/controller/pci-hyperv.c Boqun Feng       2020-02-10  1464  	struct hv_retarget_device_interrupt *params;
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1465  	struct hv_pcibus_device *hbus;
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1466  	struct cpumask *dest;
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1467  	cpumask_var_t tmp;
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1468  	struct pci_bus *pbus;
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1469  	struct pci_dev *pdev;
0de8ce3ee8e38c drivers/pci/host/pci-hyperv.c       Long Li          2016-11-08  1470  	unsigned long flags;
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1471  	u32 var_size = 0;
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1472  	int cpu, nr_bank;
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1473  	u64 res;
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1474  
79aa801e899417 drivers/pci/host/pci-hyperv.c       Dexuan Cui       2017-11-01  1475  	dest = irq_data_get_effective_affinity_mask(data);
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1476  	pdev = msi_desc_to_pci_dev(msi_desc);
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1477  	pbus = pdev->bus;
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1478  	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1479  
0de8ce3ee8e38c drivers/pci/host/pci-hyperv.c       Long Li          2016-11-08  1480  	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
0de8ce3ee8e38c drivers/pci/host/pci-hyperv.c       Long Li          2016-11-08  1481  
0de8ce3ee8e38c drivers/pci/host/pci-hyperv.c       Long Li          2016-11-08  1482  	params = &hbus->retarget_msi_interrupt_params;
0de8ce3ee8e38c drivers/pci/host/pci-hyperv.c       Long Li          2016-11-08  1483  	memset(params, 0, sizeof(*params));
0de8ce3ee8e38c drivers/pci/host/pci-hyperv.c       Long Li          2016-11-08  1484  	params->partition_id = HV_PARTITION_ID_SELF;
b59fb7b60d47b2 drivers/pci/controller/pci-hyperv.c Wei Liu          2021-02-03  1485  	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
1cf106d93245f4 drivers/pci/controller/pci-hyperv.c Boqun Feng       2020-02-10 @1486  	hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
0de8ce3ee8e38c drivers/pci/host/pci-hyperv.c       Long Li          2016-11-08  1487  	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1488  			   (hbus->hdev->dev_instance.b[4] << 16) |
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1489  			   (hbus->hdev->dev_instance.b[7] << 8) |
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1490  			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1491  			   PCI_FUNC(pdev->devfn);
831c1ae725f7d2 drivers/pci/controller/pci-hyperv.c Sunil Muthuswamy 2022-01-05  1492  	params->int_target.vector = hv_msi_get_int_vector(data);
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1493  
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1494  	/*
721612994f53ed drivers/pci/controller/pci-hyperv.c Thomas Gleixner  2020-10-24  1495  	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1496  	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1497  	 * spurious interrupt storm. Not doing so does not seem to have a
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1498  	 * negative effect (yet?).
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1499  	 */
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1500  
14ef39fddd2367 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2019-11-24  1501  	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1502  		/*
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1503  		 * PCI_PROTOCOL_VERSION_1_2 supports the VP_SET version of the
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1504  		 * HVCALL_RETARGET_INTERRUPT hypercall, which also coincides
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1505  		 * with >64 VP support.
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1506  		 * ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1507  		 * is not sufficient for this hypercall.
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1508  		 */
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1509  		params->int_target.flags |=
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1510  			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1511  
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1512  		if (!alloc_cpumask_var(&tmp, GFP_ATOMIC)) {
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1513  			res = 1;
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1514  			goto exit_unlock;
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1515  		}
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1516  
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1517  		cpumask_and(tmp, dest, cpu_online_mask);
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1518  		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1519  		free_cpumask_var(tmp);
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1520  
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1521  		if (nr_bank <= 0) {
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1522  			res = 1;
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1523  			goto exit_unlock;
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1524  		}
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1525  
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1526  		/*
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1527  		 * var-sized hypercall, var-size starts after vp_mask (thus
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1528  		 * vp_set.format does not count, but vp_set.valid_bank_mask
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1529  		 * does).
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1530  		 */
c8ccf7599ddac5 drivers/pci/controller/pci-hyperv.c Maya Nakamura    2019-03-01  1531  		var_size = 1 + nr_bank;
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1532  	} else {
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1533  		for_each_cpu_and(cpu, dest, cpu_online_mask) {
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1534  			params->int_target.vp_mask |=
7415aea6072bab drivers/pci/host/pci-hyperv.c       Vitaly Kuznetsov 2017-08-02  1535  				(1ULL << hv_cpu_number_to_vp_number(cpu));
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1536  		}
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1537  	}
0de8ce3ee8e38c drivers/pci/host/pci-hyperv.c       Long Li          2016-11-08  1538  
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1539  	res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1540  			      params, NULL);
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1541  
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1542  exit_unlock:
0de8ce3ee8e38c drivers/pci/host/pci-hyperv.c       Long Li          2016-11-08  1543  	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1544  
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1545  	/*
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1546  	 * During hibernation, when a CPU is offlined, the kernel tries
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1547  	 * to move the interrupt to the remaining CPUs that haven't
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1548  	 * been offlined yet. In this case, the below hv_do_hypercall()
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1549  	 * always fails since the vmbus channel has been closed:
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1550  	 * refer to cpu_disable_common() -> fixup_irqs() ->
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1551  	 * irq_migrate_all_off_this_cpu() -> migrate_one_irq().
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1552  	 *
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1553  	 * Suppress the error message for hibernation because the failure
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1554  	 * during hibernation does not matter (at this time all the devices
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1555  	 * have been frozen). Note: the correct affinity info is still updated
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1556  	 * into the irqdata data structure in migrate_one_irq() ->
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1557  	 * irq_do_set_affinity() -> hv_set_affinity(), so later when the VM
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1558  	 * resumes, hv_pci_restore_msi_state() is able to correctly restore
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1559  	 * the interrupt with the correct affinity.
915cff7f38c5e4 drivers/pci/controller/pci-hyperv.c Dexuan Cui       2020-10-02  1560  	 */
753ed9c95c37d0 drivers/pci/controller/pci-hyperv.c Joseph Salisbury 2021-04-16  1561  	if (!hv_result_success(res) && hbus->state != hv_pcibus_removing)
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1562  		dev_err(&hbus->hdev->device,
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1563  			"%s() failed: %#llx", __func__, res);
7dcf90e9e03243 drivers/pci/host/pci-hyperv.c       Jork Loeser      2017-05-24  1564  
d9932b46915664 drivers/pci/controller/pci-hyperv.c Sunil Muthuswamy 2022-01-05  1565  	if (data->parent_data->chip->irq_unmask)
d9932b46915664 drivers/pci/controller/pci-hyperv.c Sunil Muthuswamy 2022-01-05  1566  		irq_chip_unmask_parent(data);
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1567  	pci_msi_unmask_irq(data);
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1568  }
4daace0d8ce851 drivers/pci/host/pci-hyperv.c       Jake Oshins      2016-02-16  1569  

:::::: The code at line 1486 was first introduced by commit
:::::: 1cf106d93245f436c10e73cd3d4b885067d4bbcc PCI: hv: Introduce hv_msi_entry

:::::: TO: Boqun Feng <boqun.feng@gmail.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
