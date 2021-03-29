Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC95034CE4F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhC2Ky5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:54:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15094 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbhC2Kya (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 06:54:30 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F88Xy5dRHz19K4Q;
        Mon, 29 Mar 2021 18:52:18 +0800 (CST)
Received: from [10.69.38.196] (10.69.38.196) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 18:54:12 +0800
Subject: Re: [PATCH] PCI/AER: Use consistent format when print PCI device
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>
References: <1616752057-9720-1-git-send-email-yangyicong@hisilicon.com>
 <YF20lDlJlikTKNkI@rocinante>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <09488bb3-69f3-706f-69b1-9c538ff6adf2@hisilicon.com>
Date:   Mon, 29 Mar 2021 18:54:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YF20lDlJlikTKNkI@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/3/26 18:16, Krzysztof Wilczyński wrote:
> Hi Yicong,
> 
>> We use format domain:bus:slot.function when print
>> PCI device. Use consistent format in AER messages.
> 
> A small nitpick: the commit message and in the subject line it should
> probably use "printing" rather than "print".  But I suppose whoever is
> going be applying this patch can fix this, so probably no need to send
> another version, unless you really want to do it.
> 

sorry for the late reply. it's ok for me to get this fixed in a v2 one. :)

> [...]
>> -			pr_err("AER recover: Can not find pci_dev for %04x:%02x:%02x:%x\n",
>> +			pr_err("AER recover: Can not find pci_dev for %04x:%02x:%02x.%x\n",
>>  			       entry.domain, entry.bus,
>>  			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
> [...]
>> -		pr_err("AER recover: Buffer overflow when recovering AER for %04x:%02x:%02x:%x\n",
>> +		pr_err("AER recover: Buffer overflow when recovering AER for %04x:%02x:%02x.%x\n",
>>  		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> 
> Seems like a good idea!  This BDF-like notation is used at few other
> places.  Nice catch.
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 

thanks.

Yicong
