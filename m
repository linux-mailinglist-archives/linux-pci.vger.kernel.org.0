Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA41139ED4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 02:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgANBRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 20:17:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729088AbgANBRI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 20:17:08 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 081629E8C5DCA82DDE57;
        Tue, 14 Jan 2020 09:17:05 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 09:16:56 +0800
Subject: Re: [Patch] PCI:add 32 GT/s decoding in some macros
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200113211728.GA113776@google.com>
CC:     <linux-pci@vger.kernel.org>, <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <f2005ec1-841e-a6a7-cfe3-cf460b7a3d0a@hisilicon.com>
Date:   Tue, 14 Jan 2020 09:17:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200113211728.GA113776@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/1/14 5:17, Bjorn Helgaas wrote:
> On Mon, Jan 13, 2020 at 10:40:20AM +0800, Yicong Yang wrote:
>> Link speed 32.0 GT/s is supported in PCIe r5.0. Add in macro
>> PCIE_SPEED2STR and PCIE_SPEED2MBS_ENC to correctly decode.
>> This patch is a complementary to
>> commit de76cda215d5 ("PCI: Decode PCIe 32 GT/s link speed")
> Thanks for the patch!  Can you please rework current_link_speed_show()
> (which was updated by de76cda215d5 ("PCI: Decode PCIe 32 GT/s link
> speed")) so we don't duplicate the strings there and in
> PCIE_SPEED2STR()?
>
> Maybe something like:
>
>   switch (linkstat & PCI_EXP_LNKSTA_CLS) {
>   case PCI_EXP_LNKSTA_CLS_32_0GB:
>     speed = PCIE_SPEED2STR(PCIE_SPEED_32_0GT);
>     break;
>   ...
>
> My goal is to both remove the string duplication and make it more
> likely that when we add the *next* new speed, we'll catch everything
> the first time around.
>
> Bjorn

fine. I'll send a v2 patch.

thanks
Yang

>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/pci/pci.h | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 3f6947e..2cd64bd 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -288,7 +288,8 @@ void pci_bus_put(struct pci_bus *bus);
>>
>>  /* PCIe link information */
>>  #define PCIE_SPEED2STR(speed) \
>> -	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
>> +	((speed) == PCIE_SPEED_32_0GT ? "32 GT/s" : \
>> +	 (speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
>>  	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
>>  	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
>>  	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
>> @@ -296,7 +297,8 @@ void pci_bus_put(struct pci_bus *bus);
>>
>>  /* PCIe speed to Mb/s reduced by encoding overhead */
>>  #define PCIE_SPEED2MBS_ENC(speed) \
>> -	((speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
>> +	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
>> +	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
>>  	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
>>  	 (speed) == PCIE_SPEED_5_0GT  ?  5000*8/10 : \
>>  	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
>> --
>> 2.8.1
>>
> .
>


