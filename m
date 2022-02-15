Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AEE4B6B1F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 12:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbiBOLdG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 06:33:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiBOLck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 06:32:40 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D881D308
        for <linux-pci@vger.kernel.org>; Tue, 15 Feb 2022 03:32:20 -0800 (PST)
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jyf6n1c6KzbkSF;
        Tue, 15 Feb 2022 19:31:13 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 15 Feb 2022 19:32:18 +0800
Subject: Re: [PATCH] PCI: Support BAR sizes up to 8TB
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
References: <20220118092117.10089-1-liudongdong3@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <d6709b5a-dc40-9c96-608c-413202c7b120@huawei.com>
Date:   Tue, 15 Feb 2022 19:32:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220118092117.10089-1-liudongdong3@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

Gentle ping...

On 2022/1/18 17:21, Dongdong Liu wrote:
> Current kernel reports disabling BAR if device with a 4TB BAR as it
> only supports BAR size to 128GB.
>
> pci 0000:01:00.0: disabling BAR 4:
> [mem 0x00000000-0x3ffffffffff 64bit pref] (bad alignment 0x40000000000)
>
> Increase the maximum BAR size from 128GB to 8TB for future expansion.
>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> ---
>  drivers/pci/setup-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 547396ec50b5..a7893bf2f580 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -994,7 +994,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  {
>  	struct pci_dev *dev;
>  	resource_size_t min_align, align, size, size0, size1;
> -	resource_size_t aligns[18]; /* Alignments from 1MB to 128GB */
> +	resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
>  	int order, max_order;
>  	struct resource *b_res = find_bus_resource_of_type(bus,
>  					mask | IORESOURCE_PREFETCH, type);
>
