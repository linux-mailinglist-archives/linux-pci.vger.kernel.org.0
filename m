Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D963D8985
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhG1ILg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 04:11:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7882 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbhG1ILd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jul 2021 04:11:33 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GZR9F06TBz80cw;
        Wed, 28 Jul 2021 16:07:45 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:11:30 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:11:29 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v8 0/2] drivers/perf: hisi: Add support for PCIe PMU
Date:   Wed, 28 Jul 2021 16:09:30 +0800
Message-ID: <20210728080932.72515-1-liuqi115@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema757-chm.china.huawei.com (10.1.198.199)
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

Changes since v7:
- Drop headerfile cpumask.h and cpuhotplug.h.
- Rename events in perf list: bw->flux, lat->delay, as driver doesn't
  process bandwidth and average latency data.
- Link: https://lore.kernel.org/linux-arm-kernel/1624532384-43002-1-git-send-email-liuqi115@huawei.com/

Changes since v6:
- Move the driver to drivers/perf/hisilicon.
- Treat content in PMU counter and ext_counter as different PMU events, and
  export them separately.
- Address the comments from Will and Krzysztof.
- Link: https://lore.kernel.org/linux-arm-kernel/1622467951-32114-1-git-send-email-liuqi115@huawei.com/

Changes since v5:
- Fix some errors when build under ARCH=xtensa.
- Link: https://lore.kernel.org/linux-arm-kernel/1621946795-14046-1-git-send-email-liuqi115@huawei.com/

Changes since v4:
- Replace irq_set_affinity_hint() with irq_set_affinity().
- Link: https://lore.kernel.org/linux-arm-kernel/1621417741-5229-1-git-send-email-liuqi115@huawei.com/

Changes since v3:
- Fix some warnings when build under 32bits architecture.
- Address the comments from John.
- Link: https://lore.kernel.org/linux-arm-kernel/1618490885-44612-1-git-send-email-liuqi115@huawei.com/

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

 Documentation/admin-guide/perf/hisi-pcie-pmu.rst | 104 +++
 MAINTAINERS                                      |   2 +
 drivers/perf/hisilicon/Kconfig                   |   9 +
 drivers/perf/hisilicon/Makefile                  |   2 +
 drivers/perf/hisilicon/hisi_pcie_pmu.c           | 967 +++++++++++++++++++++++
 include/linux/cpuhotplug.h                       |   1 +
 6 files changed, 1085 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hisi-pcie-pmu.rst
 create mode 100644 drivers/perf/hisilicon/hisi_pcie_pmu.c

-- 
2.7.4

