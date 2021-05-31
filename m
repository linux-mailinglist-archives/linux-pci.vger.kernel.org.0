Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45388395CCB
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 15:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhEaNiC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 09:38:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2919 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhEaNft (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 09:35:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ftx4y4WTDz66jj;
        Mon, 31 May 2021 21:30:58 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 21:33:54 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 31 May 2021 21:33:54 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v6 0/2] drivers/perf: hisi: Add support for PCIe PMU
Date:   Mon, 31 May 2021 21:32:29 +0800
Message-ID: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

This patchset is based on 5.13-rc3. 

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

 Documentation/admin-guide/perf/hisi-pcie-pmu.rst |  104 +++
 MAINTAINERS                                      |    6 +
 drivers/perf/Kconfig                             |    2 +
 drivers/perf/Makefile                            |    1 +
 drivers/perf/pci/Kconfig                         |   16 +
 drivers/perf/pci/Makefile                        |    2 +
 drivers/perf/pci/hisilicon/Makefile              |    3 +
 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c       | 1019 ++++++++++++++++++++++
 include/linux/cpuhotplug.h                       |    1 +
 9 files changed, 1154 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hisi-pcie-pmu.rst
 create mode 100644 drivers/perf/pci/Kconfig
 create mode 100644 drivers/perf/pci/Makefile
 create mode 100644 drivers/perf/pci/hisilicon/Makefile
 create mode 100644 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c

-- 
2.7.4

