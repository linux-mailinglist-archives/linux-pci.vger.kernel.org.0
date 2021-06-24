Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4B3B2D1F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 13:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhFXLCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 07:02:40 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8300 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhFXLCj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 07:02:39 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G9cV22mrpz1BRGv;
        Thu, 24 Jun 2021 18:55:06 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 19:00:16 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 24 Jun 2021 19:00:15 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v7 0/2] drivers/perf: hisi: Add support for PCIe PMU
Date:   Thu, 24 Jun 2021 18:59:42 +0800
Message-ID: <1624532384-43002-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

