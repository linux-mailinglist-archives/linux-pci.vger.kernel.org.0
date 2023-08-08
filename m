Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427097735C3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 03:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjHHBMV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 21:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHHBMU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 21:12:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB8119B0
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 18:12:18 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKZnr0szGzNmq6;
        Tue,  8 Aug 2023 09:08:48 +0800 (CST)
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 09:12:15 +0800
Subject: Re: [PATCH 0/3] PCI: Use pci_dev_id() to simplify the code
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <alyssa@rosenzweig.io>, <maz@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <mahesh@linux.ibm.com>, <oohall@gmail.com>, <lukas@wunner.de>,
        <linux-pci@vger.kernel.org>, <yangyingliang@huawei.com>
References: <20230807211645.GA272058@bhelgaas>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <64b329f1-1753-a9ab-1d50-c6202cebe669@huawei.com>
Date:   Tue, 8 Aug 2023 09:12:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20230807211645.GA272058@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/8/8 5:16, Bjorn Helgaas wrote:
> On Mon, Aug 07, 2023 at 09:48:55PM +0800, Xiongfeng Wang wrote:
>> PCI core API pci_dev_id() can be used to get the BDF number for a pci
>> device. We don't need to compose it mannually. Use pci_dev_id() to
>> simplify the code and make the code more readable.
>>
>> Xiongfeng Wang (3):
>>   PCI: apple: use pci_dev_id() to simplify the code
>>   PCI/AER: Use pci_dev_id() to simplify the code
>>   PCI/IOV: Use pci_dev_id() to simplify the code
>>
>>  drivers/pci/controller/pcie-apple.c | 4 ++--
>>  drivers/pci/iov.c                   | 3 +--
>>  drivers/pci/pcie/aer.c              | 4 ++--
>>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> Applied to pci/misc for v6.6, thanks!
> 
> There are several similar cases outside drivers/pci/ that it would be
> nice to clean up as well.

Sure, I will do that. Thanks !

Thanks,
Xiongfeng

> 
> Bjorn
> .
> 
