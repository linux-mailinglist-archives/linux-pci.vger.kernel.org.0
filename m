Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26497D10AA
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 15:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377435AbjJTNmu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377446AbjJTNmt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 09:42:49 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA94D55;
        Fri, 20 Oct 2023 06:42:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VuXDwgq_1697809354;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VuXDwgq_1697809354)
          by smtp.aliyun-inc.com;
          Fri, 20 Oct 2023 21:42:38 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: [PATCH v9 0/4] drivers/perf: add Synopsys DesignWare PCIe PMU driver support
Date:   Fri, 20 Oct 2023 21:42:26 +0800
Message-Id: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change Log
==========

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

Shuai Xue (4):
  docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
  PCI: Add Alibaba Vendor ID to linux/pci_ids.h
  drivers/perf: add DesignWare PCIe PMU driver
  MAINTAINERS: add maintainers for DesignWare PCIe PMU driver

 .../admin-guide/perf/dwc_pcie_pmu.rst         |  94 +++
 Documentation/admin-guide/perf/index.rst      |   1 +
 MAINTAINERS                                   |   7 +
 drivers/infiniband/hw/erdma/erdma_hw.h        |   2 -
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/dwc_pcie_pmu.c                   | 770 ++++++++++++++++++
 include/linux/pci_ids.h                       |   2 +
 8 files changed, 882 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
 create mode 100644 drivers/perf/dwc_pcie_pmu.c

-- 
2.39.3

