Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F73598C6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhDIJIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 05:08:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16501 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhDIJIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 05:08:52 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGsg20KLLzPmnf;
        Fri,  9 Apr 2021 17:05:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 17:08:32 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v2 0/2] drivers/perf: hisi: Add support for PCIe PMU
Date:   Fri, 9 Apr 2021 17:05:55 +0800
Message-ID: <1617959157-22956-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
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

Changes since v1:
- Drop the internal Reviewed-by tag.
- Fix some build warnings when W=1.

Qi Liu (2):
  drivers/perf: hisi: Add driver for HiSilicon PCIe PMU
  docs: perf: Add description for HiSilicon PCIe PMU driver

 Documentation/admin-guide/perf/hisi-pcie-pmu.rst |  104 +++
 MAINTAINERS                                      |    6 +
 drivers/perf/Kconfig                             |    2 +
 drivers/perf/Makefile                            |    1 +
 drivers/perf/pci/Kconfig                         |   16 +
 drivers/perf/pci/Makefile                        |    2 +
 drivers/perf/pci/hisilicon/Makefile              |    5 +
 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c       | 1011 ++++++++++++++++++++++
 include/linux/cpuhotplug.h                       |    1 +
 9 files changed, 1148 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hisi-pcie-pmu.rst
 create mode 100644 drivers/perf/pci/Kconfig
 create mode 100644 drivers/perf/pci/Makefile
 create mode 100644 drivers/perf/pci/hisilicon/Makefile
 create mode 100644 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c

-- 
2.8.1

