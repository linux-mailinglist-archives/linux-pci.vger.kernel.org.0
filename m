Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBA49808E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 14:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbiAXNMi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 08:12:38 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35860 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242754AbiAXNMh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 08:12:37 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jj9Ny5Z7jzcck6;
        Mon, 24 Jan 2022 21:11:46 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 21:12:35 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <john.garry@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>, <song.bao.hua@hisilicon.com>
Subject: [PATCH v3 0/8] Add support for HiSilicon PCIe Tune and Trace device
Date:   Mon, 24 Jan 2022 21:11:10 +0800
Message-ID: <20220124131118.17887-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
integrated Endpoint (RCiEP) device, providing the capability
to dynamically monitor and tune the PCIe traffic (tune),
and trace the TLP headers (trace).

PTT tune is designed for monitoring and adjusting PCIe link parameters.
We provide several parameters of the PCIe link. Through the driver,
user can adjust the value of certain parameter to affect the PCIe link
for the purpose of enhancing the performance in certian situation.

PTT trace is designed for dumping the TLP headers to the memory, which
can be used to analyze the transactions and usage condition of the PCIe
Link. Users can choose filters to trace headers, by either requester
ID, or those downstream of a set of Root Ports on the same core of the
PTT device. It's also supported to trace the headers of certain type and
of certain direction.

The driver registers a PMU device for each PTT device. The trace can
be used through `perf record` and the traced headers can be decoded
by `perf report`. The perf command support for the device is also
added in this patchset. The tune can be used through the sysfs
attributes of related PMU device. See the documentation for the
detailed usage.

Change since v2:
- address the comments from Mathieu
  - rename the directory to ptt to match the function of the device
  - spinoff the declarations to a separate header
  - split the trace function to several patches
  - some other comments.
- make default smmu domain type of PTT device to identity
  Drop the RMR as it's not recommended and use an iommu_def_domain_type
  quirk to passthrough the device DMA as suggested by Robin. 
Link: https://lore.kernel.org/linux-pci/20211116090625.53702-1-yangyicong@hisilicon.com/

Change since v1:
- switch the user interface of trace to perf from debugfs
- switch the user interface of tune to sysfs from debugfs
- add perf tool support to start trace and decode the trace data
- address the comments of documentation from Bjorn
- add RMR[1] support of the device as trace works in RMR mode or
  direct DMA mode. RMR support is achieved by common APIs rather
  than the APIs implemented in [1].
Link: https://lore.kernel.org/lkml/1618654631-42454-1-git-send-email-yangyicong@hisilicon.com/

[1] https://lore.kernel.org/linux-acpi/20210805080724.480-1-shameerali.kolothum.thodi@huawei.com/

Qi Liu (1):
  perf tool: Add support for HiSilicon PCIe Tune and Trace device driver

Yicong Yang (7):
  hwtracing: Add trace function support for HiSilicon PCIe Tune and
    Trace device
  hisi_ptt: Register PMU device for PTT trace
  hisi_ptt: Add support for dynamically updating the filter list
  hisi_ptt: Add tune function support for HiSilicon PCIe Tune and Trace
    device
  docs: Add HiSilicon PTT device driver documentation
  MAINTAINERS: Add maintainer for HiSilicon PTT driver
  iommu/arm-smmu-v3: Make default domain type of HiSilicon PTT device to
    identity

 Documentation/trace/hisi-ptt.rst              |  304 +++++
 MAINTAINERS                                   |    7 +
 drivers/Makefile                              |    1 +
 drivers/hwtracing/Kconfig                     |    2 +
 drivers/hwtracing/ptt/Kconfig                 |   11 +
 drivers/hwtracing/ptt/Makefile                |    2 +
 drivers/hwtracing/ptt/hisi_ptt.c              | 1124 +++++++++++++++++
 drivers/hwtracing/ptt/hisi_ptt.h              |  239 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   16 +
 tools/perf/arch/arm/util/auxtrace.c           |   56 +-
 tools/perf/arch/arm/util/pmu.c                |    3 +
 tools/perf/arch/arm64/util/Build              |    2 +-
 tools/perf/arch/arm64/util/hisi_ptt.c         |  195 +++
 tools/perf/util/Build                         |    2 +
 tools/perf/util/auxtrace.c                    |    4 +
 tools/perf/util/auxtrace.h                    |    1 +
 tools/perf/util/hisi-ptt-decoder/Build        |    1 +
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   |  170 +++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |   28 +
 tools/perf/util/hisi_ptt.c                    |  228 ++++
 tools/perf/util/hisi_ptt.h                    |   28 +
 21 files changed, 2420 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/trace/hisi-ptt.rst
 create mode 100644 drivers/hwtracing/ptt/Kconfig
 create mode 100644 drivers/hwtracing/ptt/Makefile
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
 create mode 100644 tools/perf/arch/arm64/util/hisi_ptt.c
 create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
 create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
 create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
 create mode 100644 tools/perf/util/hisi_ptt.c
 create mode 100644 tools/perf/util/hisi_ptt.h

-- 
2.24.0

