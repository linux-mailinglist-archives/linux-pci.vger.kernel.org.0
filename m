Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A58463CC4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 18:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244871AbhK3RbC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 12:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbhK3RaG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 12:30:06 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D3C061574;
        Tue, 30 Nov 2021 09:26:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A1C7E41DF4;
        Tue, 30 Nov 2021 17:26:41 +0000 (UTC)
Subject: Re: [PATCH] PCI: apple: Fix REFCLK1 enable/poll logic
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, bhelgaas@google.com
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211117140044.193865-1-marcan@marcan.st>
 <87v90q7jk3.wl-maz@kernel.org> <20211130164957.GA4920@lpieralisi>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <845d5f52-05ad-fd2c-1ad1-49e081c3ca14@marcan.st>
Date:   Wed, 1 Dec 2021 02:26:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211130164957.GA4920@lpieralisi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01/12/2021 01.49, Lorenzo Pieralisi wrote:
> On Wed, Nov 17, 2021 at 05:56:12PM +0000, Marc Zyngier wrote:
>> On Wed, 17 Nov 2021 14:00:44 +0000,
>> Hector Martin <marcan@marcan.st> wrote:
>>>
>>> REFCLK1 has req/ack bits just like REFCLK0
>>>
>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>> ---
>>>   drivers/pci/controller/pcie-apple.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>>> index b665d29af77a..420c291a5c68 100644
>>> --- a/drivers/pci/controller/pcie-apple.c
>>> +++ b/drivers/pci/controller/pcie-apple.c
>>> @@ -42,8 +42,9 @@
>>>   #define   CORE_FABRIC_STAT_MASK		0x001F001F
>>>   #define CORE_LANE_CFG(port)		(0x84000 + 0x4000 * (port))
>>>   #define   CORE_LANE_CFG_REFCLK0REQ	BIT(0)
>>> -#define   CORE_LANE_CFG_REFCLK1		BIT(1)
>>> +#define   CORE_LANE_CFG_REFCLK1REQ	BIT(1)
>>>   #define   CORE_LANE_CFG_REFCLK0ACK	BIT(2)
>>> +#define   CORE_LANE_CFG_REFCLK1ACK	BIT(3)
>>>   #define   CORE_LANE_CFG_REFCLKEN	(BIT(9) | BIT(10))
>>>   #define CORE_LANE_CTL(port)		(0x84004 + 0x4000 * (port))
>>>   #define   CORE_LANE_CTL_CFGACC		BIT(15)
>>> @@ -481,9 +482,9 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
>>>   	if (res < 0)
>>>   		return res;
>>>   
>>> -	rmw_set(CORE_LANE_CFG_REFCLK1, pcie->base + CORE_LANE_CFG(port->idx));
>>> +	rmw_set(CORE_LANE_CFG_REFCLK1REQ, pcie->base + CORE_LANE_CFG(port->idx));
>>>   	res = readl_relaxed_poll_timeout(pcie->base + CORE_LANE_CFG(port->idx),
>>> -					 stat, stat & CORE_LANE_CFG_REFCLK1,
>>> +					 stat, stat & CORE_LANE_CFG_REFCLK1ACK,
>>>   					 100, 50000);
>>>   
>>>   	if (res < 0)
>>> -- 
>>> 2.33.0
>>>
>>>
>>
>> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
>> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> Hi Hector, Bjorn,
> 
> if this is a fix we can aim at one of the upcoming -rcX.
> 
> It would be nicer though to explain a bit better what it is
> fixing in the commit log (and what's broken if we don't merge it),
> as it stands it is a bit terse.

I don't think anything is broken per se, it still works without this 
patch (probably because the refclk gets enabled fast enough that we 
don't have to wait for it); it's just that I think this is the correct 
logic. This is all reverse engineered anyway, so ultimately there is no 
hardware documentation to point to to say what's right and what's wrong...

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
