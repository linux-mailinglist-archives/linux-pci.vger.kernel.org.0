Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF339649A
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhEaQFD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 12:05:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34020 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhEaQCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 12:02:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14VG0f4L088390;
        Mon, 31 May 2021 11:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622476841;
        bh=vnWFPHz+nHDKi1o49MLpJkwWMgq1Vhx/5uo3qsnHzYk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Z0ga/5N1RWzO0Tdn5z/gw7bGBlPnQagEKgBnzwVQMIkBo1+Y0kn/xV6RAtWhPezZw
         Ajt5A6fqV0SuR5/3HFcUxd1h5Ke/HUZyDkoThCLAVEFZIIu2izqfMolxn8Z/+abYX7
         q5LdizoHTP3DKLJLcKEvL0Uvr/y04lOYOATdI624=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14VG0fcJ092636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 May 2021 11:00:41 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 11:00:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 31 May 2021 11:00:41 -0500
Received: from [10.250.233.152] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14VG0YgG008762;
        Mon, 31 May 2021 11:00:35 -0500
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
Date:   Mon, 31 May 2021 21:30:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 31/05/21 7:24 pm, Luca Ceresoli wrote:
> Hi Pali,
> 
> On 31/05/21 15:32, Pali Rohár wrote:
>> On Monday 31 May 2021 11:05:40 Luca Ceresoli wrote:
>>> The PCIe PERSTn reset pin is active low and should be asserted, then
>>> deasserted.
>>>
>>> The current implementation only drives the pin once in "HIGH" position,
>>> thus presumably it was intended to deassert the pin. This has two problems:
>>>
>>>   1) it assumes the pin was asserted by other means before loading the
>>>      driver
>>>   2) it has the wrong polarity, since "HIGH" means "active", and the pin is
>>>      presumably configured as active low coherently with the PCIe
>>>      convention, thus it is driven physically to 0, keeping the device
>>>      under reset unless the pin is configured as active high.
>>>
>>> Fix both problems by:
>>>
>>>   1) keeping devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH) as is, but
>>>      assuming the pin is correctly configured as "active low" this now
>>>      becomes a reset assertion
>>>   2) adding gpiod_set_value(reset, 0) after a delay to deassert reset
>>>
>>> Fixes: 78bdcad05ea1 ("PCI: dra7xx: Add support to make GPIO drive PERST# line")
>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>>
>>> ---
>>>
>>> Changes v1 -> v2:
>>>  - No changes to the patch
>>>  - Reword commit message according to suggestions from Bjorn Helgaas (from
>>>    another patchset)
>>>  - Add Fixes: tag
>>> ---
>>>  drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>>> index cb5d4c245ff6..11f392b7a9a2 100644
>>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>>> @@ -801,6 +801,8 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>>>  		dev_err(&pdev->dev, "gpio request failed, ret %d\n", ret);
>>>  		goto err_gpio;
>>>  	}
>>> +	usleep_range(1000, 2000);
>>
>> Hello! Just a note that this is again a new code pattern in another
>> driver for different wait value of PCIe Warm Reset timeout. I sent email
>> about these issues:
>> https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
>>
>> Luca, how did you choose value 1000-2000 us? Do you have some reference
>> or specification which says that this value needs to be used?
> 
> Sadly I haven't access to the PCIe specification.
> 
> I'd be very happy to know what a correct value should be and update my
> patch.

I had given the timing mentioned in the specification here
https://lore.kernel.org/r/023c9b59-70bb-ed8d-a4c0-76eae726b574@ti.com

The PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION defines the Power
Sequencing and Reset Signal Timings in Table 2-4. Please also refer Figure
2-10: Power Up of the CEM.

╔═════════════╤══════════════════════════════════════╤═════╤═════╤═══════╗
║ Symbol      │ Parameter                            │ Min │ Max │ Units ║
╠═════════════╪══════════════════════════════════════╪═════╪═════╪═══════╣
║ T PVPERL    │ Power stable to PERST# inactive      │ 100 │     │ ms    ║
╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
║ T PERST-CLK │ REFCLK stable before PERST# inactive │ 100 │     │ μs    ║
╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
║ T PERST     │ PERST# active time                   │ 100 │     │ μs    ║
╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
║ T FAIL      │ Power level invalid to PERST# active │     │ 500 │ ns    ║
╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
║ T WKRF      │ WAKE# rise – fall time               │     │ 100 │ ns    ║
╚═════════════╧══════════════════════════════════════╧═════╧═════╧═══════╝

The de-assertion of #PERST is w.r.t both power stable and refclk stable.

I'm yet to validate this patch, but IIRC devm_gpiod_get_optional(dev,
NULL, GPIOD_OUT_HIGH) will already de-assert the PERST line. Please note
the board here can have various combinations of NOT gate before the gpio
line is actually connected to the connector.

Thanks
Kishon
