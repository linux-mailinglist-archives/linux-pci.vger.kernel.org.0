Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D9100606
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 13:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfKRM7Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 07:59:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7137 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbfKRM7Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 07:59:24 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6742BFA4C9425313B6B9;
        Mon, 18 Nov 2019 20:59:21 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 20:59:14 +0800
Subject: Re: [PATCH] PCI: kirin: Use PTR_ERR_OR_ZERO() to simplify code
To:     Andrew Murray <andrew.murray@arm.com>
CC:     <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
References: <1574076646-51621-1-git-send-email-zhengbin13@huawei.com>
 <20191118124632.GN43905@e119886-lin.cambridge.arm.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <c87bcd27-faed-11c2-eee2-1768b350ae62@huawei.com>
Date:   Mon, 18 Nov 2019 20:59:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20191118124632.GN43905@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019/11/18 20:46, Andrew Murray wrote:
> On Mon, Nov 18, 2019 at 07:30:46PM +0800, zhengbin wrote:
>> Fixes coccicheck warning:
>>
>> drivers/pci/controller/dwc/pcie-kirin.c:141:1-3: WARNING: PTR_ERR_OR_ZERO can be used
>> drivers/pci/controller/dwc/pcie-kirin.c:177:1-3: WARNING: PTR_ERR_OR_ZERO can be used
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: zhengbin <zhengbin13@huawei.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-kirin.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
>> index c19617a..5b2131f 100644
>> --- a/drivers/pci/controller/dwc/pcie-kirin.c
>> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
>> @@ -138,10 +138,7 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
>>  		return PTR_ERR(kirin_pcie->apb_sys_clk);
>>
>>  	kirin_pcie->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
>> -	if (IS_ERR(kirin_pcie->pcie_aclk))
>> -		return PTR_ERR(kirin_pcie->pcie_aclk);
>> -
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(kirin_pcie->pcie_aclk);
>>  }
>>
>>  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> Thanks for these patches. Though if you resend these next time you ought
> to put them in a single patch series with a cover letter.
>
> I'm not sure on the views of maintainers for other parts of the kernel
> however for PCI this type of change has previously been rejected, see:
>
> https://lkml.org/lkml/2019/5/31/535

got that, thanks. please ignore other pci patches.

>
> I guess coccicheck isn't aware of this.
>
> Thanks,
>
> Andrew Murray
>
>> --
>> 2.7.4
>>
> .
>

