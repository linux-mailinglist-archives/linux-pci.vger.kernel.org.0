Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8646331135
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 15:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCHOs2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 09:48:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13450 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCHOsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 09:48:03 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DvLkw5qpmzjWmZ;
        Mon,  8 Mar 2021 22:46:32 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Mar 2021 22:47:53 +0800
Subject: Re: [PATCH RESEND] lspci: Decode VF 10-Bit Tag Requester
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
References: <1614770048-41209-1-git-send-email-liudongdong3@huawei.com>
 <YEQwTRKNmnNk1OY+@rocinante>
CC:     <mj@ucw.cz>, <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <0a2925d2-5f2a-18e8-179c-f1bd6bb259ec@huawei.com>
Date:   Mon, 8 Mar 2021 22:47:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YEQwTRKNmnNk1OY+@rocinante>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Krzysztof

Many thanks for your review.

On 2021/3/7 9:45, Krzysztof Wilczyński wrote:
> Hi,
>
> [+cc Bjorn who was workingo on making commas usage more consistent]
>
> Thank you for sending the patch over.
>
>> Decode VF 10-Bit Tag Requester Supported and Enable bit
>> in SR-IOV Capabilities Register.
>>
>> Sample output:
>>   IOVCap: Migration-, 10BitTagReq+, Interrupt Message Number: 000
>>   IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy- 10BitTagReq+
> [...]
>
> Would you be able to move the "10BitTagReq" in the "IOVCtl" after the
> "Migration" so that its placement is consistent with the "IOVCap"?  This
> would be also along the lines of how the same files is already used in
> the ls-caps.c file.

To be honest, I am not sure this is suitable.
PCIe 5.0r1.0 spec section 9.3.3.2 SR-IOV Capabilities Register
VF 10-Bit Tag Requester Supported defined in BIT[2].

9.3.3.3 SR-IOV Control Register (Offset 08h)
VF 10-Bit Tag Requester Enable defined in BIT[5] and this is after the 
BIT[4] ARI Capable Hierarchy.

Howerver if we need to keep consistent with the "IOVCap". I can
move the "10BitTagReq" in the "IOVCtl" after the "Migration".

>
> Bjorn was also working on making a lot of the commas usage throughout to
> follow the best practice, thus I believe that the commas there would not
> be needed.  Having said that, it might be better to follow the current
> style present there at the moment.
>
> See 018f413 ("lspci: Use commas more consistently") for more details on
> Bjorn's work to normalise the usage of commas.

Good suggestion, will fix.
>
> Additionally, with the new fields, would you also have to update some of
> the tests files?  For example:
>
>   Index File                Line Content
>       0 tests/cap-dvsec-cxl   81 Capabilities: [b80 v1] Single Root I/O Virtualization (SR-IOV)
>       1 tests/cap-dvsec-cxl   82 IOVCap: Migration-, Interrupt Message Number: 000
>       2 tests/cap-dvsec-cxl   83 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
>       3 tests/cap-dvsec-cxl   84 IOVSta: Migration-
>       4 tests/cap-pcie-2      50 Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
>       5 tests/cap-pcie-2      51 IOVCap:  Migration-, Interrupt Message Number: 000
>       6 tests/cap-pcie-2      52 IOVCtl:  Enable+ Migration- Interrupt- MSE+ ARIHierarchy-
>       7 tests/cap-pcie-2      53 IOVSta:  Migration-
>       8 tests/cap-ea-1        59 Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
>       9 tests/cap-ea-1        60 IOVCap:  Migration-, Interrupt Message Number: 000
>      10 tests/cap-ea-1        61 IOVCtl:  Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
>      11 tests/cap-ea-1        62 IOVSta:  Migration-
>
OK, will do.

Thanks,
Dongdong
> Otheriwse, it looks good!  Thank you!
>
> Krzysztof
> .
>
