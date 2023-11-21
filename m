Return-Path: <linux-pci+bounces-7-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB797F231E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 02:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EA0282246
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 01:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B646FC4;
	Tue, 21 Nov 2023 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1460EAC;
	Mon, 20 Nov 2023 17:34:10 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VwqXEfT_1700530445;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VwqXEfT_1700530445)
          by smtp.aliyun-inc.com;
          Tue, 21 Nov 2023 09:34:08 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: ilkka@os.amperecomputing.com,
	kaishen@linux.alibaba.com,
	helgaas@kernel.org,
	yangyicong@huawei.com,
	will@kernel.org,
	Jonathan.Cameron@huawei.com,
	baolin.wang@linux.alibaba.com,
	robin.murphy@arm.com
Cc: chengyou@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	rdunlap@infradead.org,
	mark.rutland@arm.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com
Subject: [PATCH v11 0/5] drivers/perf: add Synopsys DesignWare PCIe PMU driver support
Date: Tue, 21 Nov 2023 09:33:55 +0800
Message-Id: <20231121013400.18367-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change Log
==========
change sinces v10:
- Rename to pci_clear_and_set_config_dword() to retain the "config"
  information and match the other accessors. (Per Bjorn)
- Align pci_clear_and_set_config_dword() and its call site (Per Bjorn)
- Polish commit log (Per Bjorn)
- Simplify dwc_pcie_pmu_time_based_event_enable() with bool value (Per Ilkka)
- Fix dwc_pcie_register_dev() return value (Per Ilkka)
- Fix vesc capability discovery by pdev->vendor (Per Ilkka)
- pick up Acked-by tag from Bjorn for Patch 3/5
- pick up Tested-by tag from Ilkka for all patch set

changes since v9:
- move the &plat_dev->dev to previous line to warp more beautiful (Per Jonathan)
- rename error label with the same suffix 'err'  (Per Jonathan)
- drop unnecessary else branch and return directly (Per Baolin)
- warp out set prev_count from dwc_pcie_pmu_set_period (Per Baolin)
- use PMU_FORMAT_ATTR to simplify format sysfs stuff (Per Will)
- export pci_clear_and_set_dword() to simplify _enable() functions  (Per Will)
- simplify _read() function by unconditionally calculate with unit in bytes plused if branch for group#1 event (Per Will and Robin)
- simplify _update() function by unconditionally mask with 64-bit width plused if branch for lane event (Per Will)
- add type sanity check in _init() (Per Will)
- test with fuzzing tool before this new version (Per Will)
- register a platform device for each PCI device to probe RAS_DES PMU cap (Per Robin)
- add dwc_pcie_vendor_ids to extend vendor id for future added device (Per Krishna)
- pickup review-by tag from Baolin, Yicong and Jonathan 


changes since v8:
- tidy up doc and pick up Reviewed-by tag in pathc 1/4 (Per Yicong and Jonathan)
- rename ras_des as ras_des_offset and remove coment about it (Per Jonathan)
- keep exact reverse order of what happened in probe when unregister pmu (Per Jonathan)
- remove the hender length check to make the driver more compatible (Per Jonathan)
- move unwind of register pmu forward to fix list_del() on something that was never added (Per Jonathan)
- use devm_add_action_or_reset() to unwind bus_register_notifier() (Per Jonathan)
- use local pdev directly in dwc_pcie_pmu_offline_cpu() and dwc_pcie_pmu_probe() (Per Jonathan)
- use the approach of a gotos to handle errors in dwc_pcie_pmu_init() (Per Jonathan)
- multiply the counter value at point of read by 16 for group#1 events (Per Jonathan)

changes since v7:
- add config help with alibaba name (per Bjorn)
- remove the ARM64 dependency (per Bjorn and Jonathan)
- fix typo and column warp (per Bjorn) 
- move list_del() after perf_pmu_unregister() (per Bjorn) 
- reorder the funtions by interests (per Bjorn)
- rewrite commit log about PMU counters, also update doc (per Bjorn)
- extend to support stat time-based analysis and lane event at the same time (per Bjorn and Jonathan)
Link: https://lore.kernel.org/linux-arm-kernel/20231012032856.2640-2-xueshuai@linux.alibaba.com/T/

changes since v6:
- improve editorial things in doc (Per Jonathan)
- change config help to generic text (Per Jonathan)
- remove macro to_dwc_pcie_pmu by moving pmu as the first member to struct dwc_pcie_pmu (Per Yicong)
- add event type check in dwc_pcie_event_show() to keep consistent with other function (Per Jonathan)
- remove intended blank line (Per Yicong)
- protect against lower 32 bits of counter overflow by try again trick (Per Jonathan)
- call pci_dev_put on all the return branch to keep the refcnt balance (Per Jonathan and Yicong)
- use devm_add_action_or_reset() to automatic unwind (Per Jonathan)
- fix picking numa-aware context cpu up when offline and offline cpu (Per Jonathan)
- simplify online cpu by init pcie_pmu->on_cpu as -1 (Per Jonathan)
- add bus_register_notifier() to handle rootport hotplug (Per Yicong)
- pick up Acked-by from Bjorn for patch 2/4 (Per Bjorn)
Link: https://lore.kernel.org/lkml/20230606074938.97724-1-xueshuai@linux.alibaba.com/T/

changes since v5:
- Rewrite the commit log to follow policy in pci_ids.h (Bjorn Helgaas)
- return error code when __dwc_pcie_pmu_probe failed (Baolin Wang)
- call 'cpuhp_remove_multi_state()' when exiting the driver. (Baolin Wang)
- pick up Review-by tag from Baolin for Patch 1 and 3
Link: https://lore.kernel.org/lkml/ZGuSimj1cuQl3W5L@bhelgaas/T/#mba3fa2572dde0deddb40b5b24a31f4df41004bdf

changes since v4:

1. addressing commens from Bjorn Helgaas:
- reorder the includes by alpha
- change all macros with upper-case hex
- change ras_des type into u16
- remove unnecessary outer "()"
- minor format changes

2. Address commensts from Jonathan Cameron:
- rewrite doc and add a example to show how to use lane event

3. fix compile error reported by: kernel test robot
- remove COMPILE_TEST and add depend on PCI in kconfig
- add Reported-by: kernel test robot <lkp@intel.com>

Changes since v3:

1. addressing comments from Robin Murphy:
- add a prepare patch to define pci id in linux/pci_ids.h
- remove unnecessary 64BIT dependency
- fix DWC_PCIE_PER_EVENT_OFF/ON macro
- remove dwc_pcie_pmu struct and move all its fileds into dwc_pcie_rp_info
- remove unnecessary format field show
- use sysfs_emit() instead of all the assorted sprintf() and snprintf() calls.
- remove unnecessary spaces and remove unnecessary cast to follow event show convention
- remove pcie_pmu_event_attr_is_visible
- fix a refcout leak on error branch when walk pci device in for_each_pci_dev
- remove bdf field from dwc_pcie_rp_info and calculate it at runtime
- finish all the checks before allocating rp_info to avoid hanging wasted memory
- remove some unused fields
- warp out control register configuration from sub function to .add()
- make function return type with a proper signature
- fix lane event count enable by clear DWC_PCIE_CNT_ENABLE field first
- pass rp_info directly to the read_*_counter helpers and in start, stop and add callbacks
- move event type validtion into .event_init()
- use is_sampling_event() to be consistent with everything else of pmu drivers
- remove unnecessary dev_err message in .event_init()
- return EINVAL instead EOPNOTSUPP for not a valid event 
- finish all the checks before start modifying the event
- fix sibling event check by comparing event->pmu with sibling->pmu
- probe PMU for each rootport independently
- use .update() as .read() directly
- remove dynamically generating symbolic name of lane event
- redefine static symbolic name of lane event and leave lane filed to user
- add CPU hotplug support

2. addressing comments from Baolin:
- add a mask to avoid possible overflow

Changes since v2 addressing comments from Baolin:
- remove redundant macro definitions
- use dev_err to print error message
- change pmu_is_register to boolean
- use PLATFORM_DEVID_NONE macro
- fix module author format

Changes since v1:

1. address comments from Jonathan:
- drop marco for PMU name and VSEC version
- simplify code with PCI standard marco
- simplify code with FIELD_PREP()/FIELD_GET() to replace shift marco
- name register filed with single _ instead double
- wrap dwc_pcie_pmu_{write}_dword out and drop meaningless snaity check 
- check vendor id while matching vesc with pci_find_vsec_capability()
- remove RP_NUM_MAX and use a list to organize PMU devices for rootports
- replace DWC_PCIE_CREATE_BDF with standard PCI_DEVID
- comments on riping register together

2. address comments from Bjorn:
- rename DWC_PCIE_VSEC_ID to DWC_PCIE_VSEC_RAS_DES_ID
- rename cap_pos to ras_des
- simplify declare of device_attribute with DEVICE_ATTR_RO
- simplify code with PCI standard macro and API like pcie_get_width_cap()
- fix some code style problem and typo
- drop meaningless snaity check of container_of

3. address comments from Yicong:
- use sysfs_emit() to replace sprintf()
- simplify iteration of pci device with for_each_pci_dev
- pick preferred CPUs on a near die and add comments
- unregister PMU drivers only for failed ones
- log on behalf PMU device and give more hint
- fix some code style problem

(Thanks for all comments and they are very valuable to me)

This patchset adds the PCIe Performance Monitoring Unit (PMU) driver support
for T-Head Yitian 710 SoC chip. Yitian 710 is based on the Synopsys PCI Express
Core controller IP which provides statistics feature.

Shuai Xue (5):
  docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
  PCI: Add Alibaba Vendor ID to linux/pci_ids.h
  PCI: Move pci_clear_and_set_dword() helper to PCI header
  drivers/perf: add DesignWare PCIe PMU driver
  MAINTAINERS: add maintainers for DesignWare PCIe PMU driver

 .../admin-guide/perf/dwc_pcie_pmu.rst         |  94 +++
 Documentation/admin-guide/perf/index.rst      |   1 +
 MAINTAINERS                                   |   7 +
 drivers/infiniband/hw/erdma/erdma_hw.h        |   2 -
 drivers/pci/access.c                          |  12 +
 drivers/pci/pcie/aspm.c                       |  65 +-
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/dwc_pcie_pmu.c                   | 792 ++++++++++++++++++
 include/linux/pci.h                           |   2 +
 include/linux/pci_ids.h                       |   2 +
 11 files changed, 948 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
 create mode 100644 drivers/perf/dwc_pcie_pmu.c

-- 
2.39.3


