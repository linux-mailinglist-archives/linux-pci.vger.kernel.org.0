Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688D8A0FBC
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 04:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfH2Cyg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 22:54:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:56354 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfH2Cyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 22:54:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 19:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="332367936"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 28 Aug 2019 19:54:35 -0700
Received: from [10.226.39.5] (leichuan-mobl.gar.corp.intel.com [10.226.39.5])
        by linux.intel.com (Postfix) with ESMTP id A9FCD580423;
        Wed, 28 Aug 2019 19:54:32 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dwc: PCI: intel: Intel PCIe RC controller driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     eswara.kota@linux.intel.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, hch@infradead.org,
        jingoohan1@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, qi-ming.wu@intel.com, kishon@ti.com
References: <9bd455a628d4699684c0f9d439b64af1535cccc6.1566208109.git.eswara.kota@linux.intel.com>
 <20190824210302.3187-1-martin.blumenstingl@googlemail.com>
 <2c71003f-06d1-9fe2-2176-94ac816b40e3@linux.intel.com>
 <CAFBinCDSJdq6axcYM7AkqvzUbc6X1zfOZ85Q-q1-FPwVxvgnpA@mail.gmail.com>
 <9ba19f08-e25a-4d15-8854-8dc4f9b6faca@linux.intel.com>
 <CAFBinCDX2BqiKcZM-C0m7gsi4BPSK0gM15r0jHmL3+AKxff=wQ@mail.gmail.com>
 <7c0fd56f-ecc5-40c2-c435-3805ca1f97c7@linux.intel.com>
 <CAFBinCBa9G+E+vjmQCGBx=zRG80ad1am_1TrNbAMvqKCQU38gw@mail.gmail.com>
From:   "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Message-ID: <ee561743-d4bc-0aa4-ded7-bfa6bd3a509b@linux.intel.com>
Date:   Thu, 29 Aug 2019 10:54:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBa9G+E+vjmQCGBx=zRG80ad1am_1TrNbAMvqKCQU38gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/29/2019 3:36 AM, Martin Blumenstingl wrote:
> On Wed, Aug 28, 2019 at 5:35 AM Chuan Hua, Lei
> <chuanhua.lei@linux.intel.com> wrote:
> [...]
>>>>>>>> +static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
>>>>>>>> +{
>>>>>>>> +    struct device *dev = lpp->pci->dev;
>>>>>>>> +    int ret = 0;
>>>>>>>> +
>>>>>>>> +    lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>>>>>>>> +    if (IS_ERR(lpp->reset_gpio)) {
>>>>>>>> +            ret = PTR_ERR(lpp->reset_gpio);
>>>>>>>> +            if (ret != -EPROBE_DEFER)
>>>>>>>> +                    dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
>>>>>>>> +            return ret;
>>>>>>>> +    }
>>>>>>>> +    /* Make initial reset last for 100ms */
>>>>>>>> +    msleep(100);
>>>>>>> why is there lpp->rst_interval when you hardcode 100ms here?
>>>>>> There are different purpose. rst_interval is purely for asserted reset
>>>>>> pulse.
>>>>>>
>>>>>> Here 100ms is to make sure the initial state keeps at least 100ms, then we
>>>>>> can reset.
>>>>> my interpretation is that it totally depends on the board design or
>>>>> the bootloader setup.
>>>> Partially, you are right. However, we should not add some dependency
>>>> here from
>>>> bootloader and board. rst_interval is just to make sure the pulse (low
>>>> active or high active)
>>>> lasts the specified the time.
>>> +Cc Kishon
>>>
>>> he recently added support for a GPIO reset line to the
>>> pcie-cadence-host.c [0] and I believe he's also maintaining
>>> pci-keystone.c which are both using a 100uS delay (instead of 100ms).
>>> I don't know the PCIe spec so maybe Kishon can comment on the values
>>> that should be used according to the spec.
>>> if there's then a reason why values other than the ones from the spec
>>> are needed then there should be a comment explaining why different
>>> values are needed (what problem does it solve).
>> spec doesn't guide this part. It is a board or SoC specific setting.
>> 100us also should work. spec only requirs reset duration should last
>> 100ms. The idea is that before reset assert and deassert, make sure the
>> default deassert status keeps some time. We take this value from
>> hardware suggestion long time back. We can reduce this value to 100us,
>> but we need to test on the board.
> OK. I don't know how other PCI controller drivers manage this. if the
> PCI maintainers are happy with this then I am as well
> maybe it's worth changing the comment to indicate that this delay was
> suggested by the hardware team (so it's clear that this is not coming
> from the PCI spec)
Dilip will change to 100us delay and run the test. I also need to run 
some tests for old boards(XRX350/550/PRX300) to confirm this has no 
impact on function.
> [...]
>>>>>>>> +static void __intel_pcie_remove(struct intel_pcie_port *lpp)
>>>>>>>> +{
>>>>>>>> +    pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
>>>>>>>> +                        0, PCI_COMMAND);
>>>>>>> I expect logic like this to be part of the PCI subsystem in Linux.
>>>>>>> why is this needed?
>>>>>>>
>>>>>>> [...]
>>>>>> bind/unbind case we use this. For extreme cases, we use unbind and bind
>>>>>> to reset
>>>>>> PCI instead of rebooting.
>>>>> OK, but this does not seem Intel/Lantiq specific at all
>>>>> why isn't this managed by either pcie-designware-host.c or the generic
>>>>> PCI/PCIe subsystem in Linux?
>>>> I doubt if other RC driver will support bind/unbind. We do have this
>>>> requirement due to power management from WiFi devices.
>>> pcie-designware-host.c will gain .remove() support in Linux 5.4
>>> I don't understand how .remove() and then .probe() again is different
>>> from .unbind() followed by a .bind()
>> Good. If this is the case, bind/unbind eventually goes to probe/remove,
>> so we can remove this.
> OK. as far as I understand you need to call dw_pcie_host_deinit from
> the .remove() callback (which is missing in this version)
> (I'm using drivers/pci/controller/dwc/pcie-tegra194.c as an example,
> this driver is in linux-next and thus will appear in Linux 5.4)
Thanks for your information. We should adapt this in next version.
>
>
> Martin
