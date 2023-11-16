Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05787EDC8C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 09:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjKPICw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 03:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjKPICw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 03:02:52 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BF2E1;
        Thu, 16 Nov 2023 00:02:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VwVk1Zu_1700121763;
Received: from 30.240.112.215(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VwVk1Zu_1700121763)
          by smtp.aliyun-inc.com;
          Thu, 16 Nov 2023 16:02:45 +0800
Message-ID: <7e383d7f-8df5-4d49-a45e-3dbe23b2c925@linux.alibaba.com>
Date:   Thu, 16 Nov 2023 16:02:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com>
 <20231104133216.42056-5-xueshuai@linux.alibaba.com>
 <32626689-c8b1-9bd-b00-5285c633bfbc@os.amperecomputing.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <32626689-c8b1-9bd-b00-5285c633bfbc@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/11/16 11:50, Ilkka Koskinen wrote:
> 
> Hi Shuai,
> 
> I have a few comments below
> 
> 
...
> 
>> +static void dwc_pcie_pmu_time_based_event_enable(struct dwc_pcie_pmu *pcie_pmu,
>> +                      bool enable)
>> +{
>> +    struct pci_dev *pdev = pcie_pmu->pdev;
>> +    u16 ras_des_offset = pcie_pmu->ras_des_offset;
>> +
>> +    if (enable)
>> +        pci_clear_and_set_dword(pdev,
>> +            ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL,
>> +            DWC_PCIE_TIME_BASED_TIMER_START, 0x1);
>> +    else
>> +        pci_clear_and_set_dword(pdev,
>> +            ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL,
>> +            DWC_PCIE_TIME_BASED_TIMER_START, 0x0);
> 
> It's a matter of taste, but you could simply do:
> 
>     pci_clear_and_set_dword(pdev,
>                  ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL,
>                  DWC_PCIE_TIME_BASED_TIMER_START, enable);
> 
> 
> However, I'm fine with either way.

Good suggestion, will fix it.

> 
>> +static u64 dwc_pcie_pmu_read_lane_event_counter(struct perf_event *event)
>> +{
>> +    struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>> +    struct pci_dev *pdev = pcie_pmu->pdev;
>> +    u16 ras_des_offset = pcie_pmu->ras_des_offset;
>> +    u32 val;
>> +
>> +    pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_DATA, &val);
>> +
>> +    return val;
>> +}
> 
> ...
> 
>> +static int dwc_pcie_register_dev(struct pci_dev *pdev)
>> +{
>> +    struct platform_device *plat_dev;
>> +    struct dwc_pcie_dev_info *dev_info;
>> +    int ret;
>> +    u32 bdf;
>> +
>> +    bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +    plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", bdf,
>> +                         pdev, sizeof(*pdev));
>> +    ret = PTR_ERR_OR_ZERO(plat_dev);
>> +    if (ret)
>> +             return ret;
> 
> platform_device_register_data() doesn't return a null pointer and you don't really need 'ret'. You could do something like instead:
> 
>    if (IS_ERR(plat_dev))
>           return PTR_ERR(plat_dev);
> 
>> +    dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
>> +    if (!dev_info)
>> +        return -ENOMEM;
>> +
>> +    /* Cache platform device to handle pci device hotplug */
>> +    dev_info->plat_dev = plat_dev;
>> +    dev_info->pdev = pdev;
>> +    list_add(&dev_info->dev_node, &dwc_pcie_dev_info_head);
>> +
>> +    return 0;
>> +}
>> +
>> +static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
>> +                     unsigned long action, void *data)
>> +{
>> +    struct device *dev = data;
>> +    struct pci_dev *pdev = to_pci_dev(dev);
>> +    struct dwc_pcie_dev_info *dev_info;
>> +
>> +    switch (action) {
>> +    case BUS_NOTIFY_ADD_DEVICE:
>> +        if (!dwc_pcie_match_des_cap(pdev))
>> +            return NOTIFY_DONE;
>> +        if (dwc_pcie_register_dev(pdev))
>> +            return NOTIFY_BAD;
>> +        break;
>> +    case BUS_NOTIFY_DEL_DEVICE:
>> +        dev_info = dwc_pcie_find_dev_info(pdev);
>> +        if (!dev_info)
>> +            return NOTIFY_DONE;
>> +        dwc_pcie_unregister_dev(dev_info);
>> +        break;
>> +    }
>> +
>> +    return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block dwc_pcie_pmu_nb = {
>> +    .notifier_call = dwc_pcie_pmu_notifier,
>> +};
>> +
>> +static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>> +{
>> +    struct pci_dev *pdev = plat_dev->dev.platform_data;
>> +    struct dwc_pcie_pmu *pcie_pmu;
>> +    char *name;
>> +    u32 bdf, val;
>> +    u16 vsec;
>> +    int ret;
>> +
>> +    vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
>> +                    DWC_PCIE_VSEC_RAS_DES_ID);
> 
> You nicely changed to use vendor list in this version but here the driver still tries to find Alibaba specific capability.

Sorry, I missed here.

> I guess, you could search again using the vendor list. The other option would be to make dwc_pcie_match_des_cap() to return the vendor id, pass it to dwc_pcie_register_dev(), which would add it to device's platform data with
> the pointer to the pci device.

The dwc_pcie_pmu_probe() is called by device which has DWC_PCIE_VSEC_RAS_DES_ID cap.
So I guess I can use pdev->vendor directly here, e.g?

	pci_find_vsec_capability(pdev, pdev->vendor, DWC_PCIE_VSEC_RAS_DES_ID);

Best Regards,
Shuai
