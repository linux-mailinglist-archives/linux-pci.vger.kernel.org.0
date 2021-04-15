Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B9A3609BC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 14:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhDOMs0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 08:48:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16126 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDOMsZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 08:48:25 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FLfFF6z49zpYZF;
        Thu, 15 Apr 2021 20:45:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 20:47:49 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v3 0/2] drivers/perf: hisi: Add support for PCIe PMU
Date:   Thu, 15 Apr 2021 20:48:03 +0800
Message-ID: <1618490885-44612-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset adds support for HiSilicon PCIe Performance Monitoring
Unit(PMU). It is a PCIe Root Complex integrated End Point(RCiEP) device
added on Hip09. Each PCIe Core has a PMU RCiEP to monitor multi root
ports and all Endpoints downstream these root ports.

HiSilicon PCIe PMU is supported to collect performance data of PCIe bus,
such as: bandwidth, latency etc.

This patchset is based on 5.12-rc6. 

Changes since v2:
- Address the comments from John.
- Link: https://lore.kernel.org/linux-arm-kernel/1617959157-22956-1-git-send-email-liuqi115@huawei.com/

Changes since v1:
- Drop the internal Reviewed-by tag.
- Fix some build warnings when W=1.
- Link: https://lore.kernel.org/linux-arm-kernel/1617788943-52722-1-git-send-email-liuqi115@huawei.com/

Qi Liu (2):
  docs: perf: Add description for HiSilicon PCIe PMU driver
  drivers/perf: hisi: Add driver for HiSilicon PCIe PMU

 Documentation/admin-guide/perf/hisi-pcie-pmu.rst |  104 +++
 MAINTAINERS                                      |    6 +
 drivers/perf/Kconfig                             |    2 +
 drivers/perf/Makefile                            |    1 +
 drivers/perf/pci/Kconfig                         |   16 +
 drivers/perf/pci/Makefile                        |    2 +
 drivers/perf/pci/hisilicon/Makefile              |    3 +
 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c       | 1014 ++++++++++++++++++++++
 include/linux/cpuhotplug.h                       |    1 +
 9 files changed, 1149 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hisi-pcie-pmu.rst
 create mode 100644 drivers/perf/pci/Kconfig
 create mode 100644 drivers/perf/pci/Makefile
 create mode 100644 drivers/perf/pci/hisilicon/Makefile
 create mode 100644 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c

-- 
2.7.4

