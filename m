Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD0E4596C0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 22:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhKVVf1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 22 Nov 2021 16:35:27 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:38869 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232661AbhKVVf0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 16:35:26 -0500
Received: from [77.244.183.192] (port=61912 helo=[192.168.178.42])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mpGvB-0008T2-UG; Mon, 22 Nov 2021 22:32:17 +0100
Subject: Re: [PATCH v2] PCI: apple: Follow the PCIe specifications when
 resetting the port
To:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, kernel-team@android.com,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20211122104156.518063-1-maz@kernel.org>
 <20211122120347.6qyiycqqjkgqvtta@pali> <87zgpw5jza.wl-maz@kernel.org>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <4fd0438e-b86b-2e1a-ea9a-2297d3580836@lucaceresoli.net>
Date:   Mon, 22 Nov 2021 22:32:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87zgpw5jza.wl-maz@kernel.org>
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

Hi Marc,

On 22/11/21 15:43, Marc Zyngier wrote:
> On Mon, 22 Nov 2021 12:03:47 +0000,
> Pali Rohár <pali@kernel.org> wrote:
>>
>> On Monday 22 November 2021 10:41:56 Marc Zyngier wrote:
>>> While the Apple PCIe driver works correctly when directly booted
>>> from the firmware, it fails to initialise when the kernel is booted
>>> from a bootloader using PCIe such as u-boot.
>>>
>>> That's beacuse we're missing a proper reset of the port (we only
>>> clear the reset, but never assert it).
>>>
>>> The PCIe spec requirements are two-fold:
>>>
>>> - #PERST must be asserted before setting up the clocks, and
>>>   stay asserted for at least 100us (Tperst-clk).
>>>
>>> - Once #PERST is deasserted, the OS must wait for at least 100ms
>>>   "from the end of a Conventional Reset" before we can start talking
>>>   to the devices
>>>
>>> Implementing this results in a booting system.
>>>
>>> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Pali Rohár <pali@kernel.org>
>>
>> Looks good, but see comment below.
>>
>> Acked-by: Pali Rohár <pali@kernel.org>
> 
> Thanks for that.
> 
>>
>>> ---
>>>  drivers/pci/controller/pcie-apple.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>>> index 1bf4d75b61be..957960a733c4 100644
>>> --- a/drivers/pci/controller/pcie-apple.c
>>> +++ b/drivers/pci/controller/pcie-apple.c
>>> @@ -539,13 +539,23 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>>>  
>>>  	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
>>>  
>>> +	/* Engage #PERST before setting up the clock */
>>> +	gpiod_set_value(reset, 0);
>>> +
>>>  	ret = apple_pcie_setup_refclk(pcie, port);
>>>  	if (ret < 0)
>>>  		return ret;
>>>  
>>> +	/* The minimal Tperst-clk value is 100us (PCIe CMS r2.0, 2.6.2) */
>>> +	usleep_range(100, 200);
>>> +
>>> +	/* Deassert #PERST */
>>>  	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
>>>  	gpiod_set_value(reset, 1);
>>
>> + Luca
>>
>> Just one comment. PERST# (PCIe Reset) is active-low signal. De-asserting
>> means to really set value to 1.
>>
>> But there was a discussion that de-asserting should be done by call:
>>   gpiod_set_value(reset, 0);
>>
>> https://lore.kernel.org/linux-pci/51be082a-ff10-8a19-5648-f279aabcac51@lucaceresoli.net/
>>
>> Could we make this new pcie-apple.c driver to use gpiod_set_value(reset, 0)
>> for de-asserting, like in other drivers?

I agree it should be done right from the beginning since this is a new
driver. Fixing it later is a painful process.

> I guess it depends whether you care about the assertion or the signal
> itself. I think we may have a bug in the way the GPIOs are handled at
> the moment, as it makes no difference whether I register the GPIO are
> active high or active low...
>
> I guess that will be yet another thing to debug, but in the meantime
> we have a reliable reset.

Strange, in my case the "active low" pin polarity is correctly picked up
from device tree by the gpiolib code, thus using gpio_set_value(gpiod,
1) asserts the pin as it should, resulting in an electrically low pin.

-- 
Luca

