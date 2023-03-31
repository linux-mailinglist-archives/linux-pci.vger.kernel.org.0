Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7495D6D1807
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 09:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCaHEU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 03:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCaHEI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 03:04:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E50A1A47C;
        Fri, 31 Mar 2023 00:03:53 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pnrlh4Xjsz17QW7;
        Fri, 31 Mar 2023 15:00:32 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 15:03:50 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <jonathan.cameron@huawei.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 0/4] Improve PTT filter interface
Date:   Fri, 31 Mar 2023 15:03:06 +0800
Message-ID: <20230331070310.5465-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

This series tends to improve the PTT's filter interface in 2 aspects (Patch 2&3):
- Support dynamically filter updating to response to hotplug
  Previous the supported filter list is settled down once the driver probed and
  it maybe out-of-date if hotplug events happen later. User need to reload the
  driver to update list. Patch 1/2 enable the driver to update the list by
  registering a PCI bus notifier and the filter list will always be the latest.
- Export the available filters through sysfs
  Previous user needs to calculate the filters and filter value using device's
  BDF number, which requires the user to know the hardware well. Patch 3/3 tends
  to export the available filter information through sysfs attributes, the filter
  value will be gotten by reading the file. This will be more user friendly.

In order to support above function, this series also includes a patch 1/4 to factor
out the allocation and release function of PTT filters.

Also includes an improvement. Patch 4 tends to set proper PMU capability to avoid
collecting unnecessary data to save the storage.

Change since v1:
- Drop the patch for handling the cpumask since it seems to be redundant
- Refine of the codes per Jonathan
- Add Patch 1/4 for refactor the filters allocation and release
- Thanks the review of Jonathan.
Link: https://lore.kernel.org/linux-pci/d496ee4f-641a-a726-ab3f-62b587422b61@huawei.com/T/#m47e4de552d69920035214b3e91080cdc185f61f5

Yicong Yang (4):
  hwtracing: hisi_ptt: Factor out filter allocation and release
    operation
  hwtracing: hisi_ptt: Add support for dynamically updating the filter
    list
  hwtracing: hisi_ptt: Export available filters through sysfs
  hwtracing: hisi_ptt: Advertise PERF_PMU_CAP_NO_EXCLUDE for PTT PMU

 .../ABI/testing/sysfs-devices-hisi_ptt        |  50 +++
 Documentation/trace/hisi-ptt.rst              |  12 +-
 drivers/hwtracing/ptt/hisi_ptt.c              | 421 ++++++++++++++++--
 drivers/hwtracing/ptt/hisi_ptt.h              |  52 +++
 4 files changed, 506 insertions(+), 29 deletions(-)

-- 
2.24.0

