Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B6749D494
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 22:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiAZVgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 16:36:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:11770 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbiAZVgU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jan 2022 16:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643232980; x=1674768980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bqRTT9ljm8wAPAWjm/qjSQ+Xc2PXWiU5LgkFzLANjPk=;
  b=k4hYJMXF0HsXeSgOqwJEpan2CMMXKzhl+BCosEV8Qwl4b+lVfOQcXEoE
   6yDbAw49WisrXNvMHt1umnkibHFyJ+qUSyZ/sxJLxcTC+PqmCTPlfkbQo
   QN1/e/Qc25DWE2Y5trc3axcpsLOxkwkeD1Za3fkwe/K3XEeZ3n017CwPF
   IAk0CEEYkLSxad4pYdIgDs92DM/YnQclCO+3celKF6zGIJ4FewJJoRaY1
   l+7P5hXxUWuqCrZpwTza/+tgTn8fyhuqEL99zObR+tKCV8JFcx58l6UHI
   JoGMDtJqXSUTj9Dy2woveB+TWU/MUfTle6fvofJIb1ddVulC62bSQYNxo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244256208"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="244256208"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 13:36:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="563543478"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2022 13:36:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCpxh-000Lgj-Lg; Wed, 26 Jan 2022 21:36:17 +0000
Date:   Thu, 27 Jan 2022 05:35:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: ACPI: Replace acpi_bus_get_device()
Message-ID: <202201270503.XIRGkUJE-lkp@intel.com>
References: <4389553.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4389553.LvFx2qVVIh@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi "Rafael,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on helgaas-pci/next v5.17-rc1 next-20220125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Rafael-J-Wysocki/PCI-ACPI-Replace-acpi_bus_get_device/20220127-034410
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220127/202201270503.XIRGkUJE-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f04b15e5b428aa6258b15b7e9bd9091cbf175e2f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Rafael-J-Wysocki/PCI-ACPI-Replace-acpi_bus_get_device/20220127-034410
        git checkout f04b15e5b428aa6258b15b7e9bd9091cbf175e2f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/pci/hotplug/acpiphp_ibm.c: In function 'ibm_acpiphp_init':
>> drivers/pci/hotplug/acpiphp_ibm.c:437:21: error: expected statement before ')' token
     437 |         if (!device)) {
         |                     ^
>> drivers/pci/hotplug/acpiphp_ibm.c:437:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     437 |         if (!device)) {
         |         ^~
   drivers/pci/hotplug/acpiphp_ibm.c:437:23: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     437 |         if (!device)) {
         |                       ^


vim +437 drivers/pci/hotplug/acpiphp_ibm.c

   418	
   419	static int __init ibm_acpiphp_init(void)
   420	{
   421		int retval = 0;
   422		acpi_status status;
   423		struct acpi_device *device;
   424		struct kobject *sysdir = &pci_slots_kset->kobj;
   425	
   426		pr_debug("%s\n", __func__);
   427	
   428		if (acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
   429				ACPI_UINT32_MAX, ibm_find_acpi_device, NULL,
   430				&ibm_acpi_handle, NULL) != FOUND_APCI) {
   431			pr_err("%s: acpi_walk_namespace failed\n", __func__);
   432			retval = -ENODEV;
   433			goto init_return;
   434		}
   435		pr_debug("%s: found IBM aPCI device\n", __func__);
   436		device = acpi_fetch_acpi_dev(ibm_acpi_handle);
 > 437		if (!device)) {
   438			pr_err("%s: acpi_fetch_acpi_dev failed\n", __func__);
   439			retval = -ENODEV;
   440			goto init_return;
   441		}
   442		if (acpiphp_register_attention(&ibm_attention_info)) {
   443			retval = -ENODEV;
   444			goto init_return;
   445		}
   446	
   447		ibm_note.device = device;
   448		status = acpi_install_notify_handler(ibm_acpi_handle,
   449				ACPI_DEVICE_NOTIFY, ibm_handle_events,
   450				&ibm_note);
   451		if (ACPI_FAILURE(status)) {
   452			pr_err("%s: Failed to register notification handler\n",
   453					__func__);
   454			retval = -EBUSY;
   455			goto init_cleanup;
   456		}
   457	
   458		ibm_apci_table_attr.size = ibm_get_table_from_acpi(NULL);
   459		retval = sysfs_create_bin_file(sysdir, &ibm_apci_table_attr);
   460	
   461		return retval;
   462	
   463	init_cleanup:
   464		acpiphp_unregister_attention(&ibm_attention_info);
   465	init_return:
   466		return retval;
   467	}
   468	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
