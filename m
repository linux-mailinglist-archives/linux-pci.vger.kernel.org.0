Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D829246426
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFNQbY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 12:31:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16963 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfFNQbY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 12:31:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03cbda0000>; Fri, 14 Jun 2019 09:31:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 09:31:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 09:31:22 -0700
Received: from [10.24.192.32] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 16:31:18 +0000
Subject: Re: [PATCH V4 27/28] PCI: tegra: Add support for GPIO based PERST#
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <vidyas@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-28-mmaddireddy@nvidia.com>
 <20190604132233.GT16519@ulmo>
 <20190613152404.GB30445@e121166-lin.cambridge.arm.com>
 <cb2dd446-1275-7179-33ac-e5c237d81da6@nvidia.com>
 <20190614143222.GB23116@e121166-lin.cambridge.arm.com>
 <1508173d-0ecc-f498-6ab2-78a718086b35@nvidia.com>
 <20190614145023.GA24588@e121166-lin.cambridge.arm.com>
 <20190614152304.GK15526@ulmo>
 <20190614155934.GA28253@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <51e4ae62-f842-1d2f-fbca-0b2063dd53a6@nvidia.com>
Date:   Fri, 14 Jun 2019 22:00:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614155934.GA28253@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560529882; bh=aaJy8i3RUI4KDEDzGhHgTxlB1Byd85kIUp2EQgfmMrY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=lgZgRSj6/shbHUZyLNxEOFJF5hznSaR/FPgvxuFo0tWpIJauY1X1OJSMvvE+R0Hg8
         VRGro/088rhFHnP/qyZ1ExGdMMGfwfC0qIZN4Lv8frKRVUStsMfPlfDsGNFDV2o0Cj
         rnoM545cl8MGDpw2S1smVKP16lN3R0wcfanTXONn2oZTZJtEzE6+KrLUNk76g58X0i
         mp7cYK0OP+E+Tg1vsJLp3alxwzjXmISG0TuJfdYUxnPlNh99ZX4k//cD839yhGAV+Q
         seXK/ehO4lFRYCmKs4YAlZxOriK6lTH61YpbQfCcPNwV0kskfZuVDnVbTTQAlhV+33
         W23HCakkNIwow==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14-Jun-19 9:29 PM, Lorenzo Pieralisi wrote:
> On Fri, Jun 14, 2019 at 05:23:04PM +0200, Thierry Reding wrote:
>> On Fri, Jun 14, 2019 at 03:50:23PM +0100, Lorenzo Pieralisi wrote:
>>> On Fri, Jun 14, 2019 at 08:08:26PM +0530, Manikanta Maddireddy wrote:
>>>>
>>>> On 14-Jun-19 8:02 PM, Lorenzo Pieralisi wrote:
>>>>> On Fri, Jun 14, 2019 at 04:07:35PM +0530, Manikanta Maddireddy wrote:
>>>>>> On 13-Jun-19 8:54 PM, Lorenzo Pieralisi wrote:
>>>>>>> On Tue, Jun 04, 2019 at 03:22:33PM +0200, Thierry Reding wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>>> +	} else {
>>>>>>>>> +		value = afi_readl(port->pcie, ctrl);
>>>>>>>>> +		value &= ~AFI_PEX_CTRL_RST;
>>>>>>>>> +		afi_writel(port->pcie, value, ctrl);
>>>>>>>>> +	}
>>>>>>>>>  
>>>>>>>>>  	usleep_range(1000, 2000);
>>>>>>>>>  
>>>>>>>>> -	value = afi_readl(port->pcie, ctrl);
>>>>>>>>> -	value |= AFI_PEX_CTRL_RST;
>>>>>>>>> -	afi_writel(port->pcie, value, ctrl);
>>>>>>>>> +	if (port->reset_gpiod) {
>>>>>>>>> +		gpiod_set_value(port->reset_gpiod, 1);
>>>>>>>> After this the port should be functional, right? I think it'd be better
>>>>>>>> to reverse the logic here and move the polarity of the GPIO into device
>>>>>>>> tree. gpiod_set_value() takes care of inverting the level internally if
>>>>>>>> the GPIO is marked as low-active in DT.
>>>>>>>>
>>>>>>>> The end result is obviously the same, but it makes the usage much
>>>>>>>> clearer. If somebody want to write a DT for their board, they will look
>>>>>>>> at the schematics and see a low-active reset line and may be tempted to
>>>>>>>> describe it as such in DT, but with your current code that would be
>>>>>>>> exactly the wrong way around.
>>>>>>> I agree with Thierry here, you should change the logic.
>>>>>>>
>>>>>>> Question: what's the advantage of adding GPIO reset support if that's
>>>>>>> architected already in port registers ? I am pretty sure there is a
>>>>>>> reason behind it (and forgive me the dumb question) and I would like to
>>>>>>> have it written in the commit log.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lorenzo
>>>>>> Each PCIe controller has a dedicated SFIO pin to support PERST#
>>>>>> signal. Port register can control only this particular SFIO pin.
>>>>>> However, in one of the Nvidia platform, instead of using PCIe SFIO
>>>>>> pin, different gpio is routed PCIe slot. This happened because of a
>>>>>> confusion in IO ball naming convention. To support this particular
>>>>>> platform, driver has provide gpio support. I will update the commit
>>>>>> log in V5.
>>>>> What happens on that platform where you trigger reset through a port
>>>>> register with :
>>>>>
>>>>> value = afi_readl(port->pcie, ctrl);
>>>>> value |= AFI_PEX_CTRL_RST;
>>>>> afi_writel(port->pcie, value, ctrl);
>>>>>
>>>>> (imagine the DT is not updated for instance or on current
>>>>> mainline) ?
>>>>>
>>>>> Lorenzo
>>>> Lets take an example of PCIe controller-0, SFIO ball name which is
>>>> controlled by the port-0 register is PEX_L0_RST. It will deassert
>>>> PEX_L0_RST SFIO line but it doesn't go to PCIe slot, so fundamental
>>>> reset(PERST# deassert) is not applied to the endpoint connected to
>>>> that slot.
>>> That's the point I am making, if the reset is not applied nothing
>>> will work (provided PEX_L0_RST does not do any damage either).
>>>
>>> For the platform in question you should make reset-gpios mandatory and
>>> fail if not present (instead of toggling the wrong reset line) there is
>>> no chance the driver can work without that property AFAICS.
>> I'm not sure I understand what you're proposing here. Are you suggesting
>> that we put a check in the driver to see if we're running on a specific
>> board and then fail if the reset-gpios are not there?
> I am just trying to understand what this patch does. By reading it again
> it looks like it makes GPIO PERST# reset mandatory for all platforms
> supported by this driver (because if the driver does not grab an handle
> to the GPIO tegra_pcie_parse_dt() fails), if I read the code correctly,
> apologies if not.
>
> Which makes me question the check:
>
> 	if (port->reset_gpiod) {
> 		gpiod_set_value(port->reset_gpiod, 0);
>
> in tegra_pcie_port_reset(), if we are there port->reset_gpiod can't be
> NULL or I am missing something and also make:
>
> 	} else {
> 		value = afi_readl(port->pcie, ctrl);
> 		value &= ~AFI_PEX_CTRL_RST;
> 		afi_writel(port->pcie, value, ctrl);
> 	}
>
> path dead code.
>
> Is this GPIO based #PERST a per-platform requirement or you want
> to update the driver to always use GPIO based #PERST ?
>
> And if it is a per-platform requirement I assume that a missing
> DT property describing the GPIO #PERST should cause a probe failure,
> not a fallback to port registers reset (which may have unintended
> consequences).
>
> From the commit log it is not clear what this patch does and for what
> reason it does it but it should be, let's define it here and update the
> log accordingly for everyone's benefit.
>
> Lorenzo

GPIO based PERST# is per-platform requirement.
If DT prop is not present, then devm_gpiod_get_from_of_node() returns
NULL gpio_desc.

struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
                                         const char *propname, int index,
                                         enum gpiod_flags dflags,
                                         const char *label)
{
        struct gpio_desc *desc;
        unsigned long lflags = 0;
        enum of_gpio_flags flags;
        bool active_low = false;
        bool single_ended = false;
        bool open_drain = false;
        bool transitory = false;
        int ret;

        desc = of_get_named_gpiod_flags(node, propname,
                                        index, &flags);

        if (!desc || IS_ERR(desc)) {
*/* If it is not there, just return NULL */****if (PTR_ERR(desc) == -ENOENT)****return NULL;*
                return desc;
        }
	...

}

Manikanta


