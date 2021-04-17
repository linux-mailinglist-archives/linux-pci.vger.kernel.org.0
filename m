Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79C7362F28
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhDQKUe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Apr 2021 06:20:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17357 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbhDQKU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Apr 2021 06:20:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FMptC5ng1z7vcT;
        Sat, 17 Apr 2021 18:17:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 17 Apr 2021 18:19:49 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <gregkh@linuxfoundation.org>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH RESEND 0/4] Add support for HiSilicon PCIe Tune and Trace device
Date:   Sat, 17 Apr 2021 18:17:07 +0800
Message-ID: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[RESEND with perf and coresight folks Cc'ed]

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

We use debugfs to expose the interface. For tune, one parameter is a
debugfs file and user can set/get the value by reading/writing the
file. For trace, we have several control files for the user to
configure the trace parameters like filters, TLP type and format,
the desired trace data size and so on. There is one data file for
dumping the traced data to the user. The traced data maybe hundreds
of megabytes so sysfs cannot support. The reason for debugfs rather
than character device is that we don't want to have additional
userspace tools. The operation through debugfs is easier and a bit
like ftrace.

The reason for not using perf is because there is no current support
for uncore tracing in the perf facilities. We have our own format
of data and don't need perf doing the parsing. The setting through
perf tools doesn't seem to be friendly as well. For example,
we cannot count on perf to decode the usual format BDF number like
<domain>:<bus>:<dev>.<fn>, which user can use to filter the TLP
headers through the PTT device.

A similar approach for implementing this function is ETM, which use
sysfs for configuring and a character device for dumping data.

Greg has some comments on our implementation and doesn't advocate
to build driver on debugfs [1]. So I resend this series to
collect more feedbacks on the implementation of this driver.

Hi perf and ETM related experts, is it suggested to adapt this driver
to perf? Or is the debugfs approach acceptable? Otherwise use
sysfs + character device like ETM and use perf tools for decoding it?
Any comments is welcomed.

[1] https://lore.kernel.org/linux-pci/1617713154-35533-1-git-send-email-yangyicong@hisilicon.com/

Yicong Yang (4):
  hwtracing: Add trace function support for HiSilicon PCIe Tune and
    Trace device
  hwtracing: Add tune function support for HiSilicon PCIe Tune and Trace
    device
  docs: Add HiSilicon PTT device driver documentation
  MAINTAINERS: Add maintainer for HiSilicon PTT driver

 Documentation/trace/hisi-ptt.rst       |  326 +++++++
 MAINTAINERS                            |    7 +
 drivers/Makefile                       |    1 +
 drivers/hwtracing/Kconfig              |    2 +
 drivers/hwtracing/hisilicon/Kconfig    |   11 +
 drivers/hwtracing/hisilicon/Makefile   |    2 +
 drivers/hwtracing/hisilicon/hisi_ptt.c | 1636 ++++++++++++++++++++++++++++++++
 7 files changed, 1985 insertions(+)
 create mode 100644 Documentation/trace/hisi-ptt.rst
 create mode 100644 drivers/hwtracing/hisilicon/Kconfig
 create mode 100644 drivers/hwtracing/hisilicon/Makefile
 create mode 100644 drivers/hwtracing/hisilicon/hisi_ptt.c

-- 
2.8.1

