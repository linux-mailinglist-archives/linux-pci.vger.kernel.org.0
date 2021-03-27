Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A53134B568
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 09:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhC0IRz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 04:17:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15350 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhC0IRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 04:17:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6s9B2YVnz945J;
        Sat, 27 Mar 2021 16:15:42 +0800 (CST)
Received: from [10.174.177.160] (10.174.177.160) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 16:17:40 +0800
Subject: Re: [PATCH 0/4] PCI: Correct function names in the header
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ruscur@russell.cc>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210325075144.180030-1-wangxiongfeng2@huawei.com>
 <YF0zzabwhiKYRq/f@rocinante>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <df875d72-8acc-defc-5e9d-5b153ce38570@huawei.com>
Date:   Sat, 27 Mar 2021 16:17:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YF0zzabwhiKYRq/f@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.160]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Krzysztof

On 2021/3/26 9:07, Krzysztof Wilczyński wrote:
> Hi,
> 
> [...]
>>   PCI: acpi_pcihp: Correct acpi_pci_check_ejectable() function name in
>>     the header
>>   PCI/AER: Correct function names in the header
>>   PCI/PME: Correct pcie_pme_init() function name in the header
>>   PCI/ATS: Correct pci_max_pasids() function name in header
> [...]
> 
> All of this has already been fixed in the following series:
> 
>   https://lore.kernel.org/linux-pci/20210311001724.423356-1-kw@linux.com/

Thanks for your remind. I will skip this series in the future.

Thanks,
Xiongfeng

> 
> Krzysztof
> .
> 
