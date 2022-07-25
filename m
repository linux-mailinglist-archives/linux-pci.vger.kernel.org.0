Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1794D57F859
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 04:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiGYCpZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jul 2022 22:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiGYCpY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jul 2022 22:45:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DE6DFBC;
        Sun, 24 Jul 2022 19:45:23 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lrkpt59H0zjXN9;
        Mon, 25 Jul 2022 10:42:30 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 10:45:21 +0800
Received: from [127.0.0.1] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Jul
 2022 10:45:20 +0800
Message-ID: <52cc2ddf-1a16-32c0-5c44-0f4c389fd626@huawei.com>
Date:   Mon, 25 Jul 2022 10:45:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] PCI: imx6: Fix build error unused-function
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220724101353.127875-1-renzhijie2@huawei.com>
 <CAK8P3a317gaAjwLhaxbR8bwZW60htG4pV+_DoS8VFkR39yCLMQ@mail.gmail.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <CAK8P3a317gaAjwLhaxbR8bwZW60htG4pV+_DoS8VFkR39yCLMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

在 2022/7/24 23:40, Arnd Bergmann 写道:
> On Sun, Jul 24, 2022 at 12:13 PM Ren Zhijie <renzhijie2@huawei.com> wrote:
>> If CONFIG_PM_SLEEP is not set,
>> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:
>>
>> drivers/pci/controller/dwc/pci-imx6.c:973:13: error: ‘imx6_pcie_host_exit’ defined but not used [-Werror=unused-function]
>>   static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
>>               ^~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pci-imx6.c:904:13: error: ‘imx6_pcie_stop_link’ defined but not used [-Werror=unused-function]
>>   static void imx6_pcie_stop_link(struct dw_pcie *pci)
>>               ^~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make[4]: *** [drivers/pci/controller/dwc/pci-imx6.o] Error 1
>>
>> These two functions imx6_pcie_host_exit() and imx6_pcie_stop_link() only be called by imx6_pcie_suspend_noirq(), which was warpped by CONFIG_PM_SLEEP.
>> To fix build error unused-function, use __maybe_unused to attach them.
>>
>> Fixes: 25ae5434c3de ("PCI: imx6: Reformat suspend callback to keep symmetric with resume")
>> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> There is already a better fix for this, see
> https://lore.kernel.org/all/20220719210427.GA1568454@bhelgaas/
>
> If you come across other suspend/resume functions that trigger the
> unused-function
> warning, please use the same method there instead of adding __maybe_unused
> or #ifdef annotations.
>
>        Arnd

Hi, Arnd

Thanks for your reply. I have actually met the other warning, and I use 
the new  marco RUNTIME_PM_OPS to replace the old one,see

https://lore.kernel.org/all/20220725023611.57055-1-renzhijie2@huawei.com/


Thanks,

Ren Zhijie

> .

