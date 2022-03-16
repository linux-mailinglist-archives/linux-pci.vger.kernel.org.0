Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B154DAC09
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 08:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354333AbiCPHu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 03:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344701AbiCPHu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 03:50:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCFB5D5D3;
        Wed, 16 Mar 2022 00:49:41 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJMk127WrzcbLf;
        Wed, 16 Mar 2022 15:44:41 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 15:49:38 +0800
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v5 2/8] hwtracing: Add trace function support for
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
References: <20220308084930.5142-1-yangyicong@hisilicon.com>
 <20220308084930.5142-3-yangyicong@hisilicon.com>
 <2049e270-7cf4-84c5-eb84-5bb1a425e897@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <3f8bff53-e6fb-d4ae-b48f-d9d9ef22f929@huawei.com>
Date:   Wed, 16 Mar 2022 15:49:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <2049e270-7cf4-84c5-eb84-5bb1a425e897@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/3/12 1:55, John Garry wrote:
>> +
>> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
> 
> no caller
> 
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
>> +    ctrl->trace_buf = devm_kcalloc(dev, HISI_PTT_TRACE_BUF_CNT,
>> +                       sizeof(struct hisi_ptt_dma_buffer), GFP_KERNEL);
>> +    if (!ctrl->trace_buf)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
>> +        ctrl->trace_buf[i].addr = dmam_alloc_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
>> +                                 &ctrl->trace_buf[i].dma,
>> +                                 GFP_KERNEL);
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
>> +    hisi_ptt->trace_ctrl.started = false;
>> +}
>> +
>> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
> 
> again this function has no caller, so I assume a warn is generated if we only apply up to this patch (when compiling)
> 
> please only add code per-patch which is actually referenced
> 

it's because I split the trace part into 2 patches as 2/8 provides probe and some basic
functions (mentioned in the commit message) and 3/8 adds the PMU device which use the function
in 2/8, assuming that it'll be easier to review..

I think it's suggested to squash patch 2/8 and 3/8, then the comments here is addressed.

>> +{
>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +    u32 val;
>> +    int i;
>> +
>> +    /* Check device idle before start trace */
>> +    if (!hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
>> +        pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy.\n");
> 
> Are we already going to have a "device busy" message? I just wonder if we need this at all
> 

The message is necessary as the caller pmu::start() is void and we cannot pass the failure
to the user by the return value. So a message is printed here to notify user the error reason.

>> +        return -EBUSY;
>> +    }
>> +
>> +    ctrl->started = true;
>> +
[...]
>> +static int hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct pci_dev *pdev = hisi_ptt->pdev;
>> +    struct pci_bus *bus;
>> +    int ret;
>> +    u32 reg;
>> +
>> +    INIT_LIST_HEAD(&hisi_ptt->port_filters);
>> +    INIT_LIST_HEAD(&hisi_ptt->req_filters);
>> +
>> +    /*
>> +     * The device range register provides the information about the
>> +     * root ports which the RCiEP can control and trace. The RCiEP
>> +     * and the root ports it support are on the same PCIe core, with
>> +     * same domain number but maybe different bus number. The device
>> +     * range register will tell us which root ports we can support,
>> +     * Bit[31:16] indicates the upper BDF numbers of the root port,
>> +     * while Bit[15:0] indicates the lower.
>> +     */
>> +    reg = readl(hisi_ptt->iobase + HISI_PTT_DEVICE_RANGE);
>> +    hisi_ptt->upper = FIELD_GET(HISI_PTT_DEVICE_RANGE_UPPER, reg);
>> +    hisi_ptt->lower = FIELD_GET(HISI_PTT_DEVICE_RANGE_LOWER, reg);
>> +
>> +    /*
>> +     * hisi_ptt_init_filters() only fails when the memory allocation failed.
>> +     * We don't check the failure here as it won't fail after adding the
>> +     * support of dynamically updating the filters in the following patch.
> 
> please structure the series such that we don't need to talk about how we will fix it later
> 

will drop the comment here and handle the error as usual.

>> +     */
>> +    bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper));
>> +    if (bus)
>> +        pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
>> +
>> +    ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_release_filters, hisi_ptt);
>> +    if (ret)
>> +        return ret;
>> +
>> +    hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * The DMA of PTT trace can only use direct mapping, due to some
>> + * hardware restriction. Check whether there is an IOMMU or the
>> + * policy of the IOMMU domain is passthrough, otherwise the trace
>> + * cannot work.
>> + *
>> + * The PTT device is supposed to behind the ARM SMMUv3, which
>> + * should have passthrough the device by a quirk.
>> + */
>> +static int hisi_ptt_check_iommu_mapping(struct pci_dev *pdev)
>> +{
>> +    struct iommu_domain *iommu_domain;
>> +
>> +    iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
>> +    if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
>> +        return 0;
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int hisi_ptt_probe(struct pci_dev *pdev,
>> +              const struct pci_device_id *id)
>> +{
>> +    struct hisi_ptt *hisi_ptt;
>> +    int ret;
>> +
>> +    ret = hisi_ptt_check_iommu_mapping(pdev);
>> +    if (ret) {
>> +        pci_err(pdev, "cannot work with non-direct DMA mapping.\n");
> 
> please no double-negatives like this, so maybe "requires direct DMA mappings"
> 

will refine the message.

>> +        return ret;
>> +    }
>> +
>> +    hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
>> +    if (!hisi_ptt)
>> +        return -ENOMEM;
>> +
>> +    mutex_init(&hisi_ptt->mutex);
>> +    hisi_ptt->pdev = pdev;
>> +    pci_set_drvdata(pdev, hisi_ptt);
>> +
>> +    ret = pcim_enable_device(pdev);
>> +    if (ret) {
>> +        pci_err(pdev, "failed to enable device, ret = %d.\n", ret);
> 
> nit: no '.' at end of any messages
> 

will drop '.' for all the messages.

>> +        return ret;
>> +    }
>> +
>> +    ret = pcim_iomap_regions(pdev, BIT(2), DRV_NAME);
>> +    if (ret) {
>> +        pci_err(pdev, "failed to remap io memory, ret = %d.\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
>> +
>> +    ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
>> +    if (ret) {
>> +        pci_err(pdev, "failed to set 64 bit dma mask, ret = %d.\n", ret);
> 
> I do doubt that this message is any use
> 

I think it's useful as with the message it will be easier to find on which stage the probe fails.

Thanks,
Yicong


