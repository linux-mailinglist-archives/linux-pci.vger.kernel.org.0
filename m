Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78C94C22B5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 04:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiBXDxs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 22:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBXDxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 22:53:48 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864DC25A305;
        Wed, 23 Feb 2022 19:53:17 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K3zQz4h3Jz1FDMW;
        Thu, 24 Feb 2022 11:48:43 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 11:53:14 +0800
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v4 2/8] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To:     John Garry <john.garry@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
References: <20220221084307.33712-1-yangyicong@hisilicon.com>
 <20220221084307.33712-3-yangyicong@hisilicon.com>
 <c7d8cff4-b84e-1b73-1d54-2e221b90dac1@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <e78f6e5e-a0c3-4976-4f46-e3369635ee3d@huawei.com>
Date:   Thu, 24 Feb 2022 11:53:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <c7d8cff4-b84e-1b73-1d54-2e221b90dac1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/2/22 19:06, John Garry wrote:
> On 21/02/2022 08:43, Yicong Yang wrote:
>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
>> integrated Endpoint(RCiEP) device, providing the capability
>> to dynamically monitor and tune the PCIe traffic, and trace
>> the TLP headers.
>>
>> Add the driver for the device to enable the trace function.
>> This patch adds basic function of trace, including the device's
>> probe and initialization, functions for trace buffer allocation
>> and trace enable/disable, register an interrupt handler to
>> simply response to the DMA events. The user interface of trace
>> will be added in the following patch.
>>
> 
> Fill commit message lines upto 75 characters

Hi John,

Thanks for the comments.

The commit message is within 75 characters. I checked again and checkpatch
didn't warning for this.

> 
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   drivers/Makefile                 |   1 +
>>   drivers/hwtracing/Kconfig        |   2 +
>>   drivers/hwtracing/ptt/Kconfig    |  11 +
>>   drivers/hwtracing/ptt/Makefile   |   2 +
>>   drivers/hwtracing/ptt/hisi_ptt.c | 370 +++++++++++++++++++++++++++++++
>>   drivers/hwtracing/ptt/hisi_ptt.h | 149 +++++++++++++
>>   6 files changed, 535 insertions(+)
>>   create mode 100644 drivers/hwtracing/ptt/Kconfig
>>   create mode 100644 drivers/hwtracing/ptt/Makefile
>>   create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>>   create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
>>
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index a110338c860c..ab3411e4eba5 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -175,6 +175,7 @@ obj-$(CONFIG_USB4)        += thunderbolt/
>>   obj-$(CONFIG_CORESIGHT)        += hwtracing/coresight/
>>   obj-y                += hwtracing/intel_th/
>>   obj-$(CONFIG_STM)        += hwtracing/stm/
>> +obj-$(CONFIG_HISI_PTT)        += hwtracing/ptt/
>>   obj-$(CONFIG_ANDROID)        += android/
>>   obj-$(CONFIG_NVMEM)        += nvmem/
>>   obj-$(CONFIG_FPGA)        += fpga/
>> diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
>> index 13085835a636..911ee977103c 100644
>> --- a/drivers/hwtracing/Kconfig
>> +++ b/drivers/hwtracing/Kconfig
>> @@ -5,4 +5,6 @@ source "drivers/hwtracing/stm/Kconfig"
>>     source "drivers/hwtracing/intel_th/Kconfig"
>>   +source "drivers/hwtracing/ptt/Kconfig"
>> +
>>   endmenu
>> diff --git a/drivers/hwtracing/ptt/Kconfig b/drivers/hwtracing/ptt/Kconfig
>> new file mode 100644
>> index 000000000000..41fa83921a07
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config HISI_PTT
>> +    tristate "HiSilicon PCIe Tune and Trace Device"
>> +    depends on ARM64 && PCI && HAS_DMA && HAS_IOMEM
> 
> why no compile test support?
> 

I'll add compile test on ARM64.

>> +    help
>> +      HiSilicon PCIe Tune and Trace Device exists as a PCIe RCiEP
>> +      device, and it provides support for PCIe traffic tuning and
>> +      tracing TLP headers to the memory.
>> +
>> +      This driver can also be built as a module. If so, the module
>> +      will be called hisi_ptt.
>> diff --git a/drivers/hwtracing/ptt/Makefile b/drivers/hwtracing/ptt/Makefile
>> new file mode 100644
>> index 000000000000..908c09a98161
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_HISI_PTT) += hisi_ptt.o
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> new file mode 100644
>> index 000000000000..a5b4f09ccd1e
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -0,0 +1,370 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for HiSilicon PCIe tune and trace device
>> + *
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + * Author: Yicong Yang <yangyicong@hisilicon.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/dma-iommu.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iommu.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/sysfs.h>
>> +
>> +#include "hisi_ptt.h"
>> +
>> +static u16 hisi_ptt_get_filter_val(struct pci_dev *pdev)
>> +{
>> +    if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
>> +        return BIT(HISI_PCIE_CORE_PORT_ID(PCI_SLOT(pdev->devfn)));
>> +
>> +    return PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +}
>> +
>> +static int hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
>> +{
>> +    u32 val;
>> +
>> +    return readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_STS,
>> +                     val, val & HISI_PTT_TRACE_IDLE,
>> +                     HISI_PTT_WAIT_POLL_INTERVAL_US,
>> +                     HISI_PTT_WAIT_TIMEOUT_US);
>> +}
>> +
>> +static int hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
>> +{
>> +    u32 val;
>> +
>> +    return readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
>> +                     val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
>> +                     HISI_PTT_RESET_TIMEOUT_US);
>> +}
>> +
>> +static void hisi_ptt_free_trace_buf(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +    struct device *dev = &hisi_ptt->pdev->dev;
>> +    int i;
>> +
>> +    if (!ctrl->trace_buf)
>> +        return;
>> +
>> +    for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
> 
> it's good practice to use {} for if-else or similar in the loop
> 

ok. will add {}.

>> +        if (ctrl->trace_buf[i].addr)
>> +            dma_free_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
>> +                      ctrl->trace_buf[i].addr,
>> +                      ctrl->trace_buf[i].dma);
>> +
>> +    kfree(ctrl->trace_buf);
>> +    ctrl->trace_buf = NULL;
>> +}
>> +
>> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +    struct device *dev = &hisi_ptt->pdev->dev;
>> +    int i;
>> +
>> +    hisi_ptt->trace_ctrl.buf_index = 0;
>> +
>> +    /* If the trace buffer has already been allocated, zero it. */
>> +    if (ctrl->trace_buf) {
>> +        for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
>> +            memset(ctrl->trace_buf[i].addr, 0, HISI_PTT_TRACE_BUF_SIZE);
>> +        return 0;
>> +    }
>> +
>> +    ctrl->trace_buf = kcalloc(HISI_PTT_TRACE_BUF_CNT, sizeof(struct hisi_ptt_dma_buffer),
>> +                  GFP_KERNEL);
>> +    if (!ctrl->trace_buf)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
>> +        ctrl->trace_buf[i].addr = dma_alloc_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
>> +                                 &ctrl->trace_buf[i].dma,
>> +                                 GFP_KERNEL);
> 
> dmam_alloc_coherent() would mean that we can drop the manual frees
> 

ok. I think you want me to use the devm* APIs consistently in the drivers. So I'll change the
buffer allocating to use that.

>> +        if (!ctrl->trace_buf[i].addr) {
>> +            hisi_ptt_free_trace_buf(hisi_ptt);
>> +            return -ENOMEM;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
>> +{
>> +    writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +    hisi_ptt->trace_ctrl.status = HISI_PTT_TRACE_STATUS_OFF;
>> +}
>> +
>> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +    u32 val;
>> +    int i;
>> +
>> +    /* Check device idle before start trace */
>> +    if (hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
> 
> hisi_ptt_wait_trace_hw_idle() is a bit of an odd odd, as I would expect it to return true when idle
> 

ok. will make it return boolean.

>> +        pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy.\n");
>> +        return -EBUSY;
>> +    }
>> +
>> +    /* Reset the DMA before start tracing */
>> +    val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +    val |= HISI_PTT_TRACE_CTRL_RST;
>> +    writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +    hisi_ptt_wait_dma_reset_done(hisi_ptt);
>> +
>> +    val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +    val &= ~HISI_PTT_TRACE_CTRL_RST;
>> +    writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +    /* Clear the interrupt status */
>> +    writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +    writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
>> +
>> +    /* Configure the trace DMA buffer */
>> +    for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
>> +        writel(lower_32_bits(ctrl->trace_buf[i].dma),
>> +               hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 +
>> +               i * HISI_PTT_TRACE_ADDR_STRIDE);
>> +        writel(upper_32_bits(ctrl->trace_buf[i].dma),
>> +               hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 +
>> +               i * HISI_PTT_TRACE_ADDR_STRIDE);
>> +    }
>> +    writel(HISI_PTT_TRACE_BUF_SIZE, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
>> +
>> +    /* Set the trace control register */
>> +    val = FIELD_PREP(HISI_PTT_TRACE_CTRL_TYPE_SEL, ctrl->type);
>> +    val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_RXTX_SEL, ctrl->direction);
>> +    val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_DATA_FORMAT, ctrl->format);
>> +    val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, hisi_ptt->trace_ctrl.filter);
>> +    if (!hisi_ptt->trace_ctrl.is_port)
>> +        val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
>> +
>> +    /* Start the Trace */
>> +    val |= HISI_PTT_TRACE_CTRL_EN;
>> +    writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +    ctrl->status = HISI_PTT_TRACE_STATUS_ON;
>> +
>> +    return 0;
>> +}
>> +
>> +static irqreturn_t hisi_ptt_irq(int irq, void *context)
> 
> as I said before (I forget the reply), it's odd to add an empty handler.
> 

As mentioned in the commit message this patch only adds IRQ handler for simply
response to the DMA events. Since you find it odd I'll remove the IRQ handler
from this patch.

Thanks.

>> +{
>> +    struct hisi_ptt *hisi_ptt = context;
>> +    u32 status;
>> +
>> +    status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +    if (!(status & HISI_PTT_TRACE_INT_STAT_MASK))
>> +        return IRQ_NONE;
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
> .
