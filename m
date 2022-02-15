Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841694B6B5E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 12:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbiBOLpI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 06:45:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiBOLpI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 06:45:08 -0500
X-Greylist: delayed 1431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 03:44:57 PST
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FCC60044;
        Tue, 15 Feb 2022 03:44:57 -0800 (PST)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.21])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nJvtI-0005EU-8w; Tue, 15 Feb 2022 11:21:04 +0000
Message-ID: <bfb2b7f9-d2dc-590c-6cec-5923efa9ac80@codethink.co.uk>
Date:   Tue, 15 Feb 2022 11:21:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] PCI: fu740: fix finding GPIOs
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.comv,
        linux-pci@vger.kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, david.abdurachmanov@gmail.com,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20220214160556.GA9253@bhelgaas>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20220214160556.GA9253@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/02/2022 16:05, Bjorn Helgaas wrote:
> [+cc Rob for possible DT/kernel match issue,
> Lorenzo (native host bridge driver maintainer)]
> 
> s/fix finding/Fix finding/ (in subject)
> Or even better, say something specific about the DT properties in
> question, e.g., look for "reset" instead of "reset-gpios".
> 
> On Mon, Feb 14, 2022 at 08:21:43AM +0000, Ben Dooks wrote:
>> The calls to devm_gpiod_get_optional() have the -gpios at the end of
>> the name. This means the pcie driver is not finding the necessary
>> reset or power GPOOs to allow the PCIe devices on the SiFive Unmatched
>> boards.
> 
> s/pcie/PCIe/
> s/GPOOs/GPIOs/

Will fix

> "to allow the PCIe devices ...?"  Something is missing from this
> sentence.  "To allow the devices <to do what>"?  Or maybe the driver
> needs these GPIOs to power up the PCIe devices?
> 
> I guess the implication is that the code looks for "reset-gpios" and
> "pwren-gpios", but the DT contains "reset" and "pwren"?
> 
> But both Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> and arch/riscv/boot/dts/sifive/fu740-c000.dtsi actually do contain
> "reset-gpios" and "pwren-gpios".

Yes, the issue is the gpio core code adds either "-gpio" or "-gpios"
itself, thus the find code does not need this. The error messages and
DT are correct. I'll reword the initial paragraph to note that which
should also deal with the other comments:

The calls to devm_gpiod_get_optional() have the -gpios at the end of
the name but the GPIO core code is already adding the suffix during
the lookup. This means the PCIe driver is not finding the necessary
reset or power lines to allow initialisation of the PCIe.



> If we *do* want to change the code, please change the error messages
> to match.

See above, it is just devm_gpiod_get_optional() parameters at fault.

>> This has not been a noted bug as the PCIe probe from u-boot has been
>> required to get the PCIe working due to other issues with the system
>> setup. It could have been broken since the driver inclusion, and not
>> been noticed as it is not necessary for the driver to funciton.
> 
> s/u-boot/U-Boot/
> s/funciton/function/
> 
> Please add a line about what the connection between U-Boot and this
> issue is, e.g., maybe U-Boot powers up the devices, so we wouldn't
> notice the kernel's inability to do so?

Does a reword to the following make better sense:

This bug has not been noticed as if U-Boot has setup the GPIO lines
for the hardware when it does the PCIe initialisation (either by
booting from PCIe or user command to access PCIe) then the PCIe
will work in Linux. The U-Boot as supplied by SiFive does not by
default initialise any PCIe component.

>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   drivers/pci/controller/dwc/pcie-fu740.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
>> index 00cde9a248b5..842b7202b96e 100644
>> --- a/drivers/pci/controller/dwc/pcie-fu740.c
>> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
>> @@ -259,11 +259,11 @@ static int fu740_pcie_probe(struct platform_device *pdev)
>>   		return PTR_ERR(afp->mgmt_base);
>>   
>>   	/* Fetch GPIOs */
>> -	afp->reset = devm_gpiod_get_optional(dev, "reset-gpios", GPIOD_OUT_LOW);
>> +	afp->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>>   	if (IS_ERR(afp->reset))
>>   		return dev_err_probe(dev, PTR_ERR(afp->reset), "unable to get reset-gpios\n");
>>   
>> -	afp->pwren = devm_gpiod_get_optional(dev, "pwren-gpios", GPIOD_OUT_LOW);
>> +	afp->pwren = devm_gpiod_get_optional(dev, "pwren", GPIOD_OUT_LOW);
>>   	if (IS_ERR(afp->pwren))
>>   		return dev_err_probe(dev, PTR_ERR(afp->pwren), "unable to get pwren-gpios\n");
>>   
>> -- 
>> 2.34.1
>>
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
