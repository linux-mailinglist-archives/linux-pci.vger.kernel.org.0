Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C6F40C423
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbhIOLKk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 07:10:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15422 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbhIOLKi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Sep 2021 07:10:38 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H8cnM4RVfzRCCx;
        Wed, 15 Sep 2021 19:05:11 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 19:09:17 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 15 Sep 2021 19:09:17 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v10 0/2]  drivers/perf: hisi: Add support for PCIe PMU
Date:   Wed, 15 Sep 2021 15:45:22 +0800
Message-ID: <20210915074524.18040-1-liuqi115@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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

Example usage of counting PCIe rx memory write latency::

  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency/
  $# perf stat -e hisi_pcie0_core0/rx_mwr_cnt/
  $# perf stat -g -e hisi_pcie0_core0/rx_mwr_latency/ -e hisi_pcie0_core0/rx_mwr_cnt/

average rx memory write latency can be calculated like this:
  latency = rx_mwr_latency / rx_mwr_cnt.

Common PMU events and metrics will be described in JSON file, and will be add
in userspace perf tool latter.

Changes since v9:
- Add check in hisi_pcie_pmu_validate_event_group to count counters accurently .
- Link: https://lore.kernel.org/linux-arm-kernel/20210818051246.29545-1-liuqi115@huawei.com/

Changes since v8:
- Remove subevent parameter in attr->config.
- Check the counter scheduling constraints when accepting an event group.
- Link: https://lore.kernel.org/linux-arm-kernel/20210728080932.72515-1-liuqi115@huawei.com/

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

 .../admin-guide/perf/hisi-pcie-pmu.rst        | 106 ++
 MAINTAINERS                                   |   2 +
 drivers/perf/hisilicon/Kconfig                |   9 +
 drivers/perf/hisilicon/Makefile               |   2 +
 drivers/perf/hisilicon/hisi_pcie_pmu.c        | 985 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 6 files changed, 1105 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hisi-pcie-pmu.rst
 create mode 100644 drivers/perf/hisilicon/hisi_pcie_pmu.c

-- 
2.33.0

