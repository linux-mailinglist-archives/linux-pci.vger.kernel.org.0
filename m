Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05807928B5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjIEQX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 12:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354308AbjIEKkH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 06:40:07 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74313E8;
        Tue,  5 Sep 2023 03:40:02 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 385AdcUM085354;
        Tue, 5 Sep 2023 05:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693910378;
        bh=IEGtvOplK8tYLUbkKdeIFl1pBYO1Ul1m2t260iBSZ4E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=BG8uVS0SC/m8qYToFzh09jECI5Al6rMABO1abPcr8QSkUVo85kgmrYa2vxVV0XWN2
         z8p8+XIC7NI1zAD+3iNeQQIiFBhPLT1bXmfSO/luEEs33qt/DpsGTdPGcgyRc5ZIO7
         jH2icq6VCE1cZt2+qTbL+c54EYaDKY601re0pHY4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 385Adc84012893
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Sep 2023 05:39:38 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 05:39:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 05:39:38 -0500
Received: from [172.24.19.15] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 385AdYIL014368;
        Tue, 5 Sep 2023 05:39:35 -0500
Message-ID: <ed9164d7-e2a2-1a63-3574-a305d8f8d3fc@ti.com>
Date:   Tue, 5 Sep 2023 16:09:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXTERNAL] Re: [RFC PATCH 2/2] PCI: j721e: Add support to build
 pci-j721e as a kernel module
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230817170417.GA320486@bhelgaas>
Content-Language: en-US
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <20230817170417.GA320486@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/17/2023 10:34 PM, Bjorn Helgaas wrote:
> On Thu, Aug 17, 2023 at 05:38:23PM +0530, Achal Verma wrote:
>> pci-j721e driver can be build as a in-built kernel driver only, which is
>> not required as it is not used during boot time in most cases.
>> This change add support to build pci-j721e as a kernel loadable module.
>>
>> J721e PCIe controller can work in both host mode and end-point mode.
>> In order to enable host mode driver and endpoint driver to be built
>> independently either as built-in or kernel module, the pcie-j721e.c driver
>> is refactored into following components:
>>
>> 1) pci-j721e-host.c: Driver used when PCIe controller has to be
>> initialized in host mode.
>>
>> 2) pci-j721e-ep.c: Driver used when PCIe controller has to be
>> initialized in endpoint mode.
>>
>> 3) pci-j721e.c: contains common code required in both modes.
> 
> Sounds like at least two commits (I'm not sure what the best order
> would be):
> 
>    1) Split into separate host mode and endpoint mode drivers
> 
>    2) Make both drivers tristate

So one patch for .c files and Makefile and other one for Kconfig.
> 
> It looks like you implement both module loading and removal.  Do we
> now think removal of these modules is safe?  IIRC there used to be a
> question related to irq_desc lifetimes, e.g., there's some discussion
> here: https://lore.kernel.org/linux-pci/87k085xekg.wl-maz@kernel.org/
> 
> The ability to *load* drivers as modules is definitely useful.  The
> ability to *remove* them is useful for developers but not really
> useful for users.
> 
> But I guess j721e_pcie_remove() already exists, so maybe you're not
> changing anything as far as irq_desc lifetimes
I went through the email-thread you have shared.
It looks like its related to the issue when pcie bridge driver also 
working as a interrupt domain/controller for EP.
In case of legacy interrupt support, its required that pcie host driver 
free interrupt mapping before freeing the interrupt domain.

Note that current upstream implementation of pci-j721e doesn't support 
interrupt domain, so issue doesn't applies here but its there in TI 
kernel and I believe we are handling this in proper way by freeing the 
mappings before.

Also pci-j721e remove() was lacking some important clean-up functions 
including pci_remove_root_bus() without which remove wasn't possible, so 
added required calls and checked the correct sequence of calls.

I have tested load/un-load multiple times on J784S4 EVM PCIe1 instance, 
it worked fine but reload after load->un-load in case of j721e fails 
leading to kernel hung, I suspect this as something to do with improper 
(sequence) handling of refclk for endpoint (shutting down and then 
powering up) as the only difference between these is that for J784S4 
both host controller and EP side use shared ref-clk generated by pcie 
phy while in j721e case host controller use pcie-phy clock while EP side 
uses board generated ref-clock, so something to do with power and clock 
off/on sequence.
> 
> Since you're splitting into new files, maybe this is an opportunity to
> fix my naming mistake of suggesting a "pci-" prefix instead of
> "pcie-"?
> 
> Bjorn
> 
>>   config PCI_J721E_HOST
>> -	bool "TI J721E PCIe controller (host mode)"
>> +	tristate "TI J721E PCIe controller (host mode)"
>>   	depends on OF
>>   	select PCIE_CADENCE_HOST
>>   	select PCI_J721E
>> @@ -56,7 +56,7 @@ config PCI_J721E_HOST
>>   	  core.
>>   
>>   config PCI_J721E_EP
>> -	bool "TI J721E PCIe controller (endpoint mode)"
>> +	tristate "TI J721E PCIe controller (endpoint mode)"
>>   	depends on OF
>>   	depends on PCI_ENDPOINT
>>   	select PCIE_CADENCE_EP
> 
>> +static struct platform_driver j721e_pcie_ep_driver = {
>> +	.probe  = j721e_pcie_probe,
>> +	.remove_new = j721e_pcie_remove,
>> +	.driver = {
>> +		.name	= "j721e-pcie-ep",
>> +		.of_match_table = of_j721e_pcie_ep_match,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +};
> 
>> +static struct platform_driver j721e_pcie_host_driver = {
>> +	.probe  = j721e_pcie_probe,
>> +	.remove_new = j721e_pcie_remove,
>> +	.driver = {
>> +		.name	= "j721e-pcie-host",
>> +		.of_match_table = of_j721e_pcie_host_match,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +};
