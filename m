Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F52B59E2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 07:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKQGzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 01:55:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7694 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKQGzC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 01:55:02 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CZxWf0lVBzkYTV;
        Tue, 17 Nov 2020 14:54:38 +0800 (CST)
Received: from [10.174.179.81] (10.174.179.81) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 14:54:50 +0800
Subject: Re: [PATCH] PCI: dwc: fix error return code in dw_pcie_host_init()
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201116135023.57321-1-wanghai38@huawei.com>
 <20201117094906.6e196cac@xhacker.debian>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <ddb1ed3c-da47-ff01-76ce-958ec31f0cec@huawei.com>
Date:   Tue, 17 Nov 2020 14:54:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201117094906.6e196cac@xhacker.debian>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.81]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2020/11/17 9:49, Jisheng Zhang 写道:
> On Mon, 16 Nov 2020 21:50:23 +0800 Wang Hai wrote:
>
>>
>> Fix to return a negative error code from the error handling
>> case instead of 0, as done elsewhere in this function.
> good catch.
>
>> Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>>
>>                          if (dma_mapping_error(pci->dev, pp->msi_data)) {
>>                                  dev_err(pci->dev, "Failed to map MSI data\n");
>>                                  pp->msi_data = 0;
>> +                               ret = -ENOMEM;
> what about use the return value of dma_maping_error()? I.E
>
> ret = dma_mapping_error()
> if (ret) {
> ....
> }
>

Thanks for your review,  I just sent v2

"[PATCH v2] PCI: dwc: fix error return code in dw_pcie_host_init()"

> .
>
