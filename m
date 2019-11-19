Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F919101099
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 02:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfKSBUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 20:20:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7138 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726952AbfKSBUE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 20:20:04 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CD066DF6A20C892A6598;
        Tue, 19 Nov 2019 09:20:01 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 09:19:54 +0800
Subject: Re: [PATCH] PCI: exynos: Use PTR_ERR_OR_ZERO() to simplify code
To:     Jingoo Han <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1574076480-50196-1-git-send-email-zhengbin13@huawei.com>
 <SL2P216MB01057BE74411EC7BE168E193AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <34079004-e87c-1799-137f-5a03deedc205@huawei.com>
Date:   Tue, 19 Nov 2019 09:19:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <SL2P216MB01057BE74411EC7BE168E193AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019/11/19 0:35, Jingoo Han wrote:
> On 11/18/19, 6:20 AM, zhengbin wrote:
>> Fixes coccicheck warning:
>>
>> drivers/pci/controller/dwc/pci-exynos.c:95:1-3: WARNING: PTR_ERR_OR_ZERO can be used
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> Please write your full name correctly (First name + Second name). 
> If 'zhengbin' is just your first name, you have to add your second name.
> Or, if  'zhengbin' is already your full name, please separate it with capitalized characters and spaces,
> for example, 'Zheng Bin'.

thanks for your remind. In the previous patch, this is rejected, see details on

https://lkml.org/lkml/2019/5/31/535

So please ignore it

>
>> ---
>>  drivers/pci/controller/dwc/pci-exynos.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
> [.....]
>
> .
>

