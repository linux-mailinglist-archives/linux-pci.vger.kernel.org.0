Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE6396FCB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 11:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhFAJFS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 1 Jun 2021 05:05:18 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54700 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232869AbhFAJFR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 05:05:17 -0400
Received: from [77.244.183.192] (port=62922 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lo0JD-000FyI-5R; Tue, 01 Jun 2021 11:03:35 +0200
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <e1e09f57-2504-6e46-ebd6-61947e0a195c@lucaceresoli.net>
Date:   Tue, 1 Jun 2021 11:03:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: it-IT
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On 31/05/21 18:00, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 31/05/21 7:24 pm, Luca Ceresoli wrote:
>> Hi Pali,
>>
>> On 31/05/21 15:32, Pali Rohár wrote:
>>> On Monday 31 May 2021 11:05:40 Luca Ceresoli wrote:
>>>> The PCIe PERSTn reset pin is active low and should be asserted, then
>>>> deasserted.
>>>>
>>>> The current implementation only drives the pin once in "HIGH" position,
>>>> thus presumably it was intended to deassert the pin. This has two problems:
>>>>
>>>>   1) it assumes the pin was asserted by other means before loading the
>>>>      driver
>>>>   2) it has the wrong polarity, since "HIGH" means "active", and the pin is
>>>>      presumably configured as active low coherently with the PCIe
>>>>      convention, thus it is driven physically to 0, keeping the device
>>>>      under reset unless the pin is configured as active high.
>>>>
>>>> Fix both problems by:
>>>>
>>>>   1) keeping devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH) as is, but
>>>>      assuming the pin is correctly configured as "active low" this now
>>>>      becomes a reset assertion
>>>>   2) adding gpiod_set_value(reset, 0) after a delay to deassert reset
>>>>
>>>> Fixes: 78bdcad05ea1 ("PCI: dra7xx: Add support to make GPIO drive PERST# line")
>>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>>>
>>>> ---
>>>>
>>>> Changes v1 -> v2:
>>>>  - No changes to the patch
>>>>  - Reword commit message according to suggestions from Bjorn Helgaas (from
>>>>    another patchset)
>>>>  - Add Fixes: tag
>>>> ---
>>>>  drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
>>>> index cb5d4c245ff6..11f392b7a9a2 100644
>>>> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
>>>> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
>>>> @@ -801,6 +801,8 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>>>>  		dev_err(&pdev->dev, "gpio request failed, ret %d\n", ret);
>>>>  		goto err_gpio;
>>>>  	}
>>>> +	usleep_range(1000, 2000);
>>>
>>> Hello! Just a note that this is again a new code pattern in another
>>> driver for different wait value of PCIe Warm Reset timeout. I sent email
>>> about these issues:
>>> https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/
>>>
>>> Luca, how did you choose value 1000-2000 us? Do you have some reference
>>> or specification which says that this value needs to be used?
>>
>> Sadly I haven't access to the PCIe specification.
>>
>> I'd be very happy to know what a correct value should be and update my
>> patch.
> 
> I had given the timing mentioned in the specification here
> https://lore.kernel.org/r/023c9b59-70bb-ed8d-a4c0-76eae726b574@ti.com
> 
> The PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION defines the Power
> Sequencing and Reset Signal Timings in Table 2-4. Please also refer Figure
> 2-10: Power Up of the CEM.
> 
> ╔═════════════╤══════════════════════════════════════╤═════╤═════╤═══════╗
> ║ Symbol      │ Parameter                            │ Min │ Max │ Units ║
> ╠═════════════╪══════════════════════════════════════╪═════╪═════╪═══════╣
> ║ T PVPERL    │ Power stable to PERST# inactive      │ 100 │     │ ms    ║
> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
> ║ T PERST-CLK │ REFCLK stable before PERST# inactive │ 100 │     │ μs    ║
> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
> ║ T PERST     │ PERST# active time                   │ 100 │     │ μs    ║
> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
> ║ T FAIL      │ Power level invalid to PERST# active │     │ 500 │ ns    ║
> ╟─────────────┼──────────────────────────────────────┼─────┼─────┼───────╢
> ║ T WKRF      │ WAKE# rise – fall time               │     │ 100 │ ns    ║
> ╚═════════════╧══════════════════════════════════════╧═════╧═════╧═══════╝
> 
> The de-assertion of #PERST is w.r.t both power stable and refclk stable.
> 
> I'm yet to validate this patch, but IIRC devm_gpiod_get_optional(dev,
> NULL, GPIOD_OUT_HIGH) will already de-assert the PERST line. 

Perhaps in all the cases you faced, but GPIOD_OUT_HIGH [0] really means
"active", not "electrically high", and here we want reset to be
deasserted (=deactivated), not asserted (=activated).

I guess it works when the GPIO drives PERSTn without inversion (no NOT
gates or an even number of NOT gates) _and_ device tree does specify the
GPIO as active high (which is incorrect: PERSTn is active low).

> Please note
> the board here can have various combinations of NOT gate before the
> gpio
> line is actually connected to the connector.

Exactly for this reason a portable driver must never drive the signal
"electrically low" or "electrically high". That's why with my patch I
propose to give the proper interpretation [1] to GPIOD_OUT_HIGH, i.e.
"active", i.e. "reset asserted". Device tree will describe if active
means electrically low (no NOT gates between GPIO pin and device PERSTn
pin) or high (odd number of NOT gates).

Additionally, as per patch description, even in the cases where the
driver deasserts the reset, it does not assert it. Should the signal be
asserted before dra7xx_pcie_probe(), devm_gpiod_get_optional(dev, NULL,
GPIOD_OUT_HIGH) would not move the line and thus would not reset the device.

The only problem I can imagine with my patch is with existing code. If
you have a board with the reset GPIO described as active high in DT
while it is active low (no/even NOR gates on board), then you should
apply this patch _and_ fix the board device tree.

I hope the intent of the patch is clearer now.

[0]
https://www.kernel.org/doc/html/latest/driver-api/gpio/consumer.html#obtaining-and-disposing-gpios
[1]
https://www.kernel.org/doc/html/latest/driver-api/gpio/consumer.html#the-active-low-and-open-drain-semantics

-- 
Luca

