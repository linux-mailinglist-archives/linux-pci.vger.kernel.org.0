Return-Path: <linux-pci+bounces-4095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622BB868DA4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8696F1C20A27
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70152F91;
	Tue, 27 Feb 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEdQ7GWG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684B12A14B
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029887; cv=none; b=HkoV438SErLs4nd+8NwiW8ndC2mbtJhNJmYQHaSrnGyNudF4BGR5UJopOsm0QBe4ufFYqlbKlCZabIONuFR2u23EJtubKHYBBBKpsopZbmWp3UDFR2bZSwQCIitDLkXsY5As6O75R+6DywHJvmyzioiHkqL7ZFRS+id2z+6jGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029887; c=relaxed/simple;
	bh=oYsliGiRTJiRs4Lxx7SIcNlCK2XdURe1cZNFGAXUyDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pBx+J2fHz2pWgsN7kxwSaQDSko5e5k8TBvE/WhfCK6LiB4YoLIKxY6FyQEyOrlWCfCGPcO3R9XllsLaR8ZaXeAUwmBFyN2GxlgEhxNU6w77pMP2a0FWiY6V0pfa3ROGI8idH8jP+OW2i3ZLuLlUt33/+G8Vz0qNBhzwtWcoB2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEdQ7GWG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709029886; x=1740565886;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oYsliGiRTJiRs4Lxx7SIcNlCK2XdURe1cZNFGAXUyDw=;
  b=LEdQ7GWGcuvLyuXeb1vnQL7y0UpvwvzOU/h6PoryLCpUZHUnZ4nkrHxX
   r2+ynBcU/rpFNZLIsNEAxlx7aFyhdYoTRXi9P5cTzSXDfMtqUes/sY2PE
   OHXsIMHTZD7szNmOSJopw6Mi3MzYLvUmJfg5NA3jRCCd8vBLme4xLWHaR
   5F/u5SGbUDGWT/n8O1xRGL5mC7k9RFC3I+feCdlJgZRTAbG6rJbcPp4Kr
   m9iwWJIr2xL0dLxFMfdfTutxtaK1jQbKLtT43Qk9q1rVBc5An7B4hvg5Z
   Vm9gJAk/RJ1WvONUtP2Woti3vWqak/TNmpJOExICU2WnkG7gIOsYtIvYL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3521744"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3521744"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:31:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7409137"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Feb 2024 02:31:24 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reuk4-000B9D-2b;
	Tue, 27 Feb 2024 10:31:20 +0000
Date: Tue, 27 Feb 2024 18:31:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: [pci:wip/2402-bjorn-osc-dpc 3/3] drivers/pci/pci-acpi.c:1424:9:
 error: implicit declaration of function 'pci_acpi_add_edr_notifier'; did you
 mean 'pci_acpi_add_pm_notifier'?
Message-ID: <202402271824.MzpOujLC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2402-bjorn-osc-dpc
head:   f76758eebe9e2f81b37e41d2bdc70825cdb879d7
commit: f76758eebe9e2f81b37e41d2bdc70825cdb879d7 [3/3] PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240227/202402271824.MzpOujLC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240227/202402271824.MzpOujLC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402271824.MzpOujLC-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pci-acpi.c: In function 'pci_acpi_setup':
>> drivers/pci/pci-acpi.c:1424:9: error: implicit declaration of function 'pci_acpi_add_edr_notifier'; did you mean 'pci_acpi_add_pm_notifier'? [-Werror=implicit-function-declaration]
    1424 |         pci_acpi_add_edr_notifier(pci_dev);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         pci_acpi_add_pm_notifier
   drivers/pci/pci-acpi.c: In function 'pci_acpi_cleanup':
>> drivers/pci/pci-acpi.c:1451:9: error: implicit declaration of function 'pci_acpi_remove_edr_notifier'; did you mean 'pci_acpi_remove_pm_notifier'? [-Werror=implicit-function-declaration]
    1451 |         pci_acpi_remove_edr_notifier(pci_dev);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         pci_acpi_remove_pm_notifier
   cc1: some warnings being treated as errors


vim +1424 drivers/pci/pci-acpi.c

617654aae50eb5 Mika Westerberg            2018-08-16  1417  
4795448117824c Rafael J. Wysocki          2021-09-18  1418  void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1419  {
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1420  	struct pci_dev *pci_dev = to_pci_dev(dev);
f084280cd34e37 Rafael J. Wysocki          2013-12-29  1421  
e33caa82e221b0 Aaron Lu                   2015-03-25  1422  	pci_acpi_optimize_delay(pci_dev, adev->handle);
99b50be9d8ec9e Rajat Jain                 2020-07-07  1423  	pci_acpi_set_external_facing(pci_dev);
ac1c8e35a3262d Kuppuswamy Sathyanarayanan 2020-03-23 @1424  	pci_acpi_add_edr_notifier(pci_dev);
e33caa82e221b0 Aaron Lu                   2015-03-25  1425  
f084280cd34e37 Rafael J. Wysocki          2013-12-29  1426  	pci_acpi_add_pm_notifier(adev, pci_dev);
f084280cd34e37 Rafael J. Wysocki          2013-12-29  1427  	if (!adev->wakeup.flags.valid)
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1428  		return;
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1429  
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1430  	device_set_wakeup_capable(dev, true);
6299cf9ec3985c Mika Westerberg            2018-09-27  1431  	/*
6299cf9ec3985c Mika Westerberg            2018-09-27  1432  	 * For bridges that can do D3 we enable wake automatically (as
6299cf9ec3985c Mika Westerberg            2018-09-27  1433  	 * we do for the power management itself in that case). The
6299cf9ec3985c Mika Westerberg            2018-09-27  1434  	 * reason is that the bridge may have additional methods such as
6299cf9ec3985c Mika Westerberg            2018-09-27  1435  	 * _DSW that need to be called.
6299cf9ec3985c Mika Westerberg            2018-09-27  1436  	 */
6299cf9ec3985c Mika Westerberg            2018-09-27  1437  	if (pci_dev->bridge_d3)
6299cf9ec3985c Mika Westerberg            2018-09-27  1438  		device_wakeup_enable(dev);
6299cf9ec3985c Mika Westerberg            2018-09-27  1439  
8370c2dc4c7b91 Rafael J. Wysocki          2017-06-24  1440  	acpi_pci_wakeup(pci_dev, false);
53b22f900c2d28 Mika Westerberg            2019-06-25  1441  	acpi_device_power_add_dependent(adev, dev);
62d528712c1db6 Rafael J. Wysocki          2022-04-04  1442  
62d528712c1db6 Rafael J. Wysocki          2022-04-04  1443  	if (pci_is_bridge(pci_dev))
62d528712c1db6 Rafael J. Wysocki          2022-04-04  1444  		acpi_dev_power_up_children_with_adr(adev);
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1445  }
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1446  
4795448117824c Rafael J. Wysocki          2021-09-18  1447  void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1448  {
6299cf9ec3985c Mika Westerberg            2018-09-27  1449  	struct pci_dev *pci_dev = to_pci_dev(dev);
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1450  
ac1c8e35a3262d Kuppuswamy Sathyanarayanan 2020-03-23 @1451  	pci_acpi_remove_edr_notifier(pci_dev);
f084280cd34e37 Rafael J. Wysocki          2013-12-29  1452  	pci_acpi_remove_pm_notifier(adev);
6299cf9ec3985c Mika Westerberg            2018-09-27  1453  	if (adev->wakeup.flags.valid) {
53b22f900c2d28 Mika Westerberg            2019-06-25  1454  		acpi_device_power_remove_dependent(adev, dev);
6299cf9ec3985c Mika Westerberg            2018-09-27  1455  		if (pci_dev->bridge_d3)
6299cf9ec3985c Mika Westerberg            2018-09-27  1456  			device_wakeup_disable(dev);
6299cf9ec3985c Mika Westerberg            2018-09-27  1457  
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1458  		device_set_wakeup_capable(dev, false);
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1459  	}
6299cf9ec3985c Mika Westerberg            2018-09-27  1460  }
d2e5f0c16ad60a Rafael J. Wysocki          2012-12-23  1461  

:::::: The code at line 1424 was first introduced by commit
:::::: ac1c8e35a3262d04cc81b07fac6480a3539e3b0f PCI/DPC: Add Error Disconnect Recover (EDR) support

:::::: TO: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

