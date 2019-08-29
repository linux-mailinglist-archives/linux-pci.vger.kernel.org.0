Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD9A10AB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 07:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfH2FLF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 01:11:05 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56854 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2FLF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 01:11:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7T5AI74066124;
        Thu, 29 Aug 2019 00:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567055418;
        bh=RhWCtfcsf2MC9bAiCnYjqaLKzSINxy+e1qfbLxx2SuI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ullb8FkoCQAe0n4YKyQhEw/xdY/HaqClFGHrV3wtv8Vsui3PD4DBSkE7uQXv7psqb
         fPKRCNaUJSy3r3xnCR6xRPgTZxiPhd0tU8bzjyYuXNkzqtT/+JTUOqp295ckpPoY4n
         1gJXx8EljqwxilpS/1nmW6+vaS41mmmDdTEImW+4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7T5AIdv118034
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Aug 2019 00:10:18 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 29
 Aug 2019 00:10:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 29 Aug 2019 00:10:18 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7T5AD4O062393;
        Thu, 29 Aug 2019 00:10:14 -0500
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
CC:     <eswara.kota@linux.intel.com>, <andriy.shevchenko@intel.com>,
        <cheol.yong.kim@intel.com>, <devicetree@vger.kernel.org>,
        <gustavo.pimentel@synopsys.com>, <hch@infradead.org>,
        <jingoohan1@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <qi-ming.wu@intel.com>
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
 <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com>
 <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
 <9ba19f08-e25a-4d15-8854-8dc4f9b6faca@linux.intel.com>
 <CAFBinCDX2BqiKcZM-C0m7gsi4BPSK0gM15r0jHmL3+AKxff=wQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <023c9b59-70bb-ed8d-a4c0-76eae726b574@ti.com>
Date:   Thu, 29 Aug 2019 10:40:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDX2BqiKcZM-C0m7gsi4BPSK0gM15r0jHmL3+AKxff=wQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

On 28/08/19 2:08 AM, Martin Blumenstingl wrote:
> Hello,
> 
> On Tue, Aug 27, 2019 at 5:09 AM Chuan Hua, Lei
> <chuanhua.lei@linux.intel.com> wrote:
>>
>> Hi Martin,
>>
>> Thanks for your feedback. Please check the comments below.
>>
>> On 8/27/2019 5:15 AM, Martin Blumenstingl wrote:
>>> Hello,
>>>
>>> On Mon, Aug 26, 2019 at 5:31 AM Chuan Hua, Lei
>>> <chuanhua.lei@linux.intel.com> wrote:
>>>> Hi Martin,
>>>>
>>>> Thanks for your valuable comments. I reply some of them as below.
>>> you're welcome
>>>
>>> [...]
>>>>>> +config PCIE_INTEL_AXI
>>>>>> +        bool "Intel AHB/AXI PCIe host controller support"
>>>>> I believe that this is mostly the same IP block as it's used in Lantiq
>>>>> (xDSL) VRX200 SoCs (with MIPS cores) which was introduced in 2010
>>>>> (before Intel acquired Lantiq).
>>>>> This is why I would have personally called the driver PCIE_LANTIQ
>>>> VRX200 SoC(internally called VR9) was the first PCIe SoC product which
>>>> was using synopsys
>>>>
>>>> controller v3.30a. It only supports PCIe Gen1.1/1.0. The phy is internal
>>>> phy from infineon.
>>> thank you for these details
>>> I wasn't aware that the PCIe PHY on these SoCs was developed by
>>> Infineon nor is the DWC version documented anywhere
>>
>> VRX200/ARX300 PHY is internal value. There are a lot of hardcode which was
>> from hardware people. From XRX500, we switch to synopsis PHY. However, later
>> comboPHY is coming to the picture. Even though we have one same controller
>> with different versions, we most likely will have three different phy
>> drivers.
> that is a good argument for using a separate PHY driver and
> integrating that using the PHY subsystem (which is already the case in
> this patch revision)
> 
.
.
<snip>
>>>>>> +static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
>>>>>> +{
>>>>>> +    struct device *dev = lpp->pci->dev;
>>>>>> +    int ret = 0;
>>>>>> +
>>>>>> +    lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>>>>>> +    if (IS_ERR(lpp->reset_gpio)) {
>>>>>> +            ret = PTR_ERR(lpp->reset_gpio);
>>>>>> +            if (ret != -EPROBE_DEFER)
>>>>>> +                    dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
>>>>>> +            return ret;
>>>>>> +    }
>>>>>> +    /* Make initial reset last for 100ms */
>>>>>> +    msleep(100);
>>>>> why is there lpp->rst_interval when you hardcode 100ms here?
>>>> There are different purpose. rst_interval is purely for asserted reset
>>>> pulse.
>>>>
>>>> Here 100ms is to make sure the initial state keeps at least 100ms, then we
>>>> can reset.
>>> my interpretation is that it totally depends on the board design or
>>> the bootloader setup.
>>
>> Partially, you are right. However, we should not add some dependency
>> here from
>> bootloader and board. rst_interval is just to make sure the pulse (low
>> active or high active)
>> lasts the specified the time.
> +Cc Kishon
> 
> he recently added support for a GPIO reset line to the
> pcie-cadence-host.c [0] and I believe he's also maintaining
> pci-keystone.c which are both using a 100uS delay (instead of 100ms).
> I don't know the PCIe spec so maybe Kishon can comment on the values
> that should be used according to the spec.
> if there's then a reason why values other than the ones from the spec
> are needed then there should be a comment explaining why different
> values are needed (what problem does it solve).

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

In my code I used T PERST-CLK (i.e REFCLK stable before PERST# inactive).
REFCLK to the card is enabled as part of PHY enable and then wait for 100μs
before making PERST# inactive.

Power to the device is given during board power up and the assumption here is
it will take more the 100ms for the probe to be invoked after board power up
(i.e after ROM, bootloaders and linux kernel). But if you have a regulator that
is enabled in PCI probe, then T PVPERL (100ms) should also used in probe.

Thanks
Kishon
