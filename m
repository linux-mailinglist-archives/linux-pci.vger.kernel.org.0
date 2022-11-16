Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A23C62B156
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 03:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKPCeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 21:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiKPCea (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 21:34:30 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0930186C9;
        Tue, 15 Nov 2022 18:34:27 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBnDZ4zZRzRpDM;
        Wed, 16 Nov 2022 10:34:06 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 10:34:25 +0800
Message-ID: <f15ea524-be5a-c72f-0968-63168ddb23b8@huawei.com>
Date:   Wed, 16 Nov 2022 10:34:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] PCI: dwc: add missing free_irq() in ks_pcie_remove() and
 error path in ks_pcie_probe()
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <Sergey.Semin@baikalelectronics.ru>,
        <mani@kernel.org>, <kishon@ti.com>, <naveennaidu479@gmail.com>,
        <pali@kernel.org>, <ffclaire1224@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221116022147.2636355-1-ruanjinjie@huawei.com>
Content-Language: en-US
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20221116022147.2636355-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The fix has a problem, I will send v2 soon.

On 2022/11/16 10:21, ruanjinjie wrote:
> free_irq() is missing in ks_pcie_remove() and some cases of error
> in ks_pcie_probe(), fix that.
> 
> Fixes: 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 78818853af9e..fc854ccaf155 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1179,12 +1179,16 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  		num_lanes = 1;
>  
>  	phy = devm_kzalloc(dev, sizeof(*phy) * num_lanes, GFP_KERNEL);
> -	if (!phy)
> -		return -ENOMEM;
> +	if (!phy) {
> +		ret = -ENOMEM;
> +		goto free_irq;
> +	}
>  
>  	link = devm_kzalloc(dev, sizeof(*link) * num_lanes, GFP_KERNEL);
> -	if (!link)
> -		return -ENOMEM;
> +	if (!link) {
> +		ret = -ENOMEM;
> +		goto free_irq;
> +	}
>  
>  	for (i = 0; i < num_lanes; i++) {
>  		snprintf(name, sizeof(name), "pcie-phy%d", i);
> @@ -1300,6 +1304,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	while (--i >= 0 && link[i])
>  		device_link_del(link[i]);
>  
> +free_irq:
> +	free_irq(irq, ks_pcie);
>  	return ret;
>  }
>  
> @@ -1315,6 +1321,7 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
>  	ks_pcie_disable_phy(ks_pcie);
>  	while (num_lanes--)
>  		device_link_del(link[num_lanes]);
> +	free_irq(irq, ks_pcie);
>  
>  	return 0;
>  }
