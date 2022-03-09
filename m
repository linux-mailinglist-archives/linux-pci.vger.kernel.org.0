Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA044D2E97
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 13:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiCIMCM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 07:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiCIMCK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 07:02:10 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C79157228;
        Wed,  9 Mar 2022 04:01:11 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KD9dY6bNCz1GByS;
        Wed,  9 Mar 2022 19:56:17 +0800 (CST)
Received: from kwepeml500003.china.huawei.com (7.221.188.182) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 20:01:06 +0800
Received: from [10.136.108.160] (10.136.108.160) by
 kwepeml500003.china.huawei.com (7.221.188.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 20:01:05 +0800
Subject: [PATCH v2] PCI: dwc: Fix setting error return on MSI DMA mapping
 failure
References: <CAL_JsqJNMGobo1iaBjqSQJXNy9arXGU+et20dMueCK44seGnQw@mail.gmail.com>
To:     <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhangjianrong (E)" <zhangjianrong5@huawei.com>
CC:     caiyadong <caiyadong@huawei.com>,
        "xuetao (kirin)" <xuetao09@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>,
        <songxiaowei@hisilicon.com>, <guhengsheng@hisilicon.com>
From:   Jiantao Zhang <water.zhangjiantao@huawei.com>
X-Forwarded-Message-Id: <CAL_JsqJNMGobo1iaBjqSQJXNy9arXGU+et20dMueCK44seGnQw@mail.gmail.com>
Message-ID: <30170911-0e2f-98ce-9266-70465b9073e5@huawei.com>
Date:   Wed, 9 Mar 2022 20:01:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJNMGobo1iaBjqSQJXNy9arXGU+et20dMueCK44seGnQw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.108.160]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 kwepeml500003.china.huawei.com (7.221.188.182)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When dma_mapping_error() returns error because of no enough memory,
but dw_pcie_host_init() returns success, which will mislead the callers.

Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
Signed-off-by: Jianrong Zhang <zhangjianrong5@huawei.com>
Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
---
   drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
   1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f4755f3a03be..9dcb51728dd1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -390,7 +390,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
                                 sizeof(pp->msi_msg),
                                 DMA_FROM_DEVICE,
                                 DMA_ATTR_SKIP_CPU_SYNC);
-            if (dma_mapping_error(pci->dev, pp->msi_data)) {
+            ret = dma_mapping_error(pci->dev, pp->msi_data);
+            if (ret) {
                   dev_err(pci->dev, "Failed to map MSI data\n");
                   pp->msi_data = 0;
                   goto err_free_msi;


--
2.17.1

Jiantao Zhang


On Tue, Mar 8, 2022 at 9:45 AM Zhangjiantao(Kirin,Nanjing)
<water.zhangjiantao@huawei.com> wrote:
> When dma_mapping_error() returns error because of no enough memory available, dw_pcie_host_init() will return success, which will mislead the callers.

Again, wrap long lines. And please reword the subject as I previously 
suggested.

It should be 'PATCH v2', not 'PATCH2' in the subject. 'git send-email
-v2' does that for you.

> Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
>

Drop the blank line here.


> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>

As you are sending the patch, your S-o-b goes last. And the author
name still doesn't match here: 'Jiantao Zhang' vs.
'Zhangjiantao(Kirin,Nanjing)'

> Signed-off-by: Jianrong Zhang <zhangjianrong5@huawei.com>
> ---
>    drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>    1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f4755f3a03be..9dcb51728dd1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -390,7 +390,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                                  sizeof(pp->msi_msg),
>                                  DMA_FROM_DEVICE,
>                                  DMA_ATTR_SKIP_CPU_SYNC);
> -            if (dma_mapping_error(pci->dev, pp->msi_data)) {
> +            ret = dma_mapping_error(pci->dev, pp->msi_data);
> +            if (ret) {
>                    dev_err(pci->dev, "Failed to map MSI data\n");
>                    pp->msi_data = 0;
>                    goto err_free_msi;
> --
> 2.17.1
>
> Jiantao Zhang
>
> On 2022/3/5 5:39, Bjorn Helgaas wrote:
>> On Fri, Mar 04, 2022 at 12:06:10PM +0000, Zhangjiantao(Kirin,Nanjing) wrote:

All this should not be in new versions of patches.

>>> When dma_mapping_error returns error because of no enough memory available, dw_pcie_host_init will return success, which will mislead the callers.
>> Wrap to fit in 75 columns, add "()" after function names.
>>> Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>
>>> Signed-off-by: zhangjiantao <water.zhangjiantao@huawei.com>
>>>
>>> ---
>>>     drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>>>     1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index f4755f3a03be..ac691d733848 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -393,6 +393,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>                 if (dma_mapping_error(pci->dev, pp->msi_data)) {
>>>                     dev_err(pci->dev, "Failed to map MSI data\n");
>>>                     pp->msi_data = 0;
>>> +                ret = -1;
>> We should save the return value from dma_mapping_error() and return
>> *that*, not -1.
>>
>> Whitespace error (indent with tabs, same as the surrounding code).
>>
>>>                     goto err_free_msi;
>>>                 }
>>>             }
>>> --
>>> 2.17.1
>>>
>> .
