Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068E5310229
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 02:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhBEBVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 20:21:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12076 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhBEBVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 20:21:49 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWyHx2NfTzMT2x;
        Fri,  5 Feb 2021 09:19:25 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Feb 2021
 09:20:59 +0800
Subject: Re: [PATCH 1/1] PCI/AER: Change to use helper pcie_aer_is_native() in
 some places
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
References: <1612420127-6447-1-git-send-email-tanxiaofei@huawei.com>
 <YBxsCPEFe0lxhDMO@rocinante>
CC:     <helgaas@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <sean.v.kelley@intel.com>, <Jonathan.Cameron@huawei.com>,
        <refactormyself@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
From:   tanxiaofei <tanxiaofei@huawei.com>
Message-ID: <064df5a3-3a55-544e-b9d0-314abade1ace@huawei.com>
Date:   Fri, 5 Feb 2021 09:20:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YBxsCPEFe0lxhDMO@rocinante>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 2021/2/5 5:50, Krzysztof Wilczyński wrote:
> Hi Tan,
>
> This is very nice!  Thank you for this.
>
> [...]
>>  	if (dev->aer_cap && pci_aer_available() &&
>> -	    (pcie_ports_native || host->native_aer)) {
>> +	    pcie_aer_is_native(dev)) {
>>  		services |= PCIE_PORT_SERVICE_AER;
> [...]
>
> A suggestion.  You could improve this even further, for example:
>
>   if (pci_aer_available() && pcie_aer_is_native(dev)) {
>
> This is because the pcie_aer_is_native() function performs the
> dev->aer_cap check internally, so we could rely on it, and avoid
> checking the same thing twice.
>
> What do you think?
>

Yes, it's better, i will send v2 patch including this.thanks.

> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
>
> Krzysztof
>
> .
>

