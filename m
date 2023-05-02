Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6516F4955
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 19:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjEBRvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBRvR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 13:51:17 -0400
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 10:51:12 PDT
Received: from mail1.kuutio.org (mail1.kuutio.org [54.37.79.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA0D10F8
        for <linux-pci@vger.kernel.org>; Tue,  2 May 2023 10:51:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 272301FE0C;
        Tue,  2 May 2023 19:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :from:from:references:content-language:subject:subject
        :user-agent:mime-version:date:date:message-id:received:received;
         s=dkim; t=1683049389; x=1685641390; bh=lyjHCOgghIhXPGmRDAaXn7hX
        LKnM0SyPB24urboSP7U=; b=e6RPOuWcu2lMbMZK0woDDFPZixSRrEar10QrDsBP
        3zLn0DS9SaFbBkErD33+spbByFIZTIIHCjz8AxaMz0GMQ65fJmRTONNdOgAz1lfo
        5ZDGWuNZBGM+39/lm0IforEr8Guzr3kE/LtNZ93V71hCnhmnRmcnvZwKcYR9f9fd
        ULs7AoevYM1lgvx/Bl4lc4+e7pTzv/NmC+28IUvT7SJC7C+y2WxldeIRl299dz5D
        hydz2r1K+tDguoWtp0pM5m8j1lFjcH68gLhi61HdCinz6zfjvblLtAc/hswoM3Os
        Bp2C/llAuucy4vKVc6bcGPF6/Hc1mecEpXK5NmjD8yNU/hmGBWglY+ESajMuMCOY
        kjqogF6X5v7ZUQ4FbOhD7fLQjVOQURhATcR7u8CwDk6TaGDPppx7hL1lLCNaTqe5
        ivfNlw1RBIAAzD31s3EvZ81wZLMTgYtC2ruF1cnkhhoQPBEDamJDPGMVGF8a0U2u
        Tt6+7Xt+DvhAKSXUD2+q0YTN2lW8JAJuZtd0UuTqJdkEHS1rr0hOtc3nbdEvFYJ4
        jyDEr5MpRyEVT2tVgyqmIPxLxxAIPThDpqePiiUw+FjstEMKYuYG/JPBoPV/cmVU
        1PFF0mEYCzNO55FAQX6Nlm2ackJ8Y90VvTq9ON0k1XTIIVYQ+BeZ0uVhHdKL/b+G
        p6g=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id fYH8V72N1TwO; Tue,  2 May 2023 19:43:09 +0200 (CEST)
Received: from [IPV6:2001:998:13:e1::beee] (unknown [IPv6:2001:998:13:e1::beee])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 7916B1FD48;
        Tue,  2 May 2023 19:43:09 +0200 (CEST)
Message-ID: <bfa3e61f-97a4-362f-3359-63795a220d4c@lemmela.net>
Date:   Tue, 2 May 2023 20:43:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] PCI: mediatek: increase link training timeout
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20230501203602.GA604568@bhelgaas>
From:   =?UTF-8?Q?Oskari_Lemmel=c3=a4?= <oskari@lemmela.net>
In-Reply-To: <20230501203602.GA604568@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1.5.2023 23.36, Bjorn Helgaas wrote:
> On Sun, Mar 26, 2023 at 03:12:17PM +0300, Oskari Lemmela wrote:
>> Some PCI devices fail to complete link training in 100ms.
>> Increase link training timeout by 20ms to 120ms.
>>
>> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Doesn't look like this went anywhere, probably because we really don't
> have enough information about why and where this is needed.
>
> Does this mean some *endpoints* don't train fast enough?  Or is this
> something to do with MediaTek host controllers?
>
> If some endpoints don't train correctly, maybe it's a defect that
> we should have a quirk for so we can wait longer for all host
> controllers, not just MediaTek.  Or maybe it's a signal integrity
> problem or something on systems using MediaTek?
I can't rule out the possibility that the PCIe signal path in the
BananaPi R64 board might be sub-optimal, and training just takes a bit
longer. It might even be that LTSSM timeout is hit once in L0 or L1 state.

The same endpoints work without problems on the MT7621 board with
the timeout value of 100ms. One difference is that the MT7621 only
supports PCIe gen1 speeds, which are faster to train.
> Is the 100ms (or 120ms) based on some requirement from the spec?
> If so, it would be good to include the reference.
I looked into the PCIe spec a bit more and there is no clear timeout value
for link training. State-specific timeout values are defined in the
LTSSM definition.
The timeout values for these states are Detect (12ms), Polling (24ms),
Configuration (24ms), L0 (24ms), L1 (32ms), L2 (24ms) and Recovery (24ms).
The total timeout value of the necessary state transitions is 140ms
(Detect->Polling-> Configuration->L0->L1->L2). If you switch once from
L1 state
to recovery state and from there L0->L1->L2, the maximum timeout will be
a total of 220ms.

>> ---
>>  drivers/pci/controller/pcie-mediatek.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
>> index ae5ad05ddc1d..67b8cf0dc9f7 100644
>> --- a/drivers/pci/controller/pcie-mediatek.c
>> +++ b/drivers/pci/controller/pcie-mediatek.c
>> @@ -720,10 +720,10 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>>  	if (soc->need_fix_device_id)
>>  		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
>>  
>> -	/* 100ms timeout value should be enough for Gen1/2 training */
>> +	/* 120ms timeout value should be enough for Gen1/2 training */
> There are a lot of 100ms-ish delays in PCIe.  It would be nice to have
> a #define for this so we can connect this back to something in the
> spec and potentially share it across host controller drivers.
It might be a good idea to set the timeout to at least 140ms or even 220ms.

Oskari
> Bjorn
>
>>  	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
>>  				 !!(val & PCIE_PORT_LINKUP_V2), 20,
>> -				 100 * USEC_PER_MSEC);
>> +				 120 * USEC_PER_MSEC);
>>  	if (err)
>>  		return -ETIMEDOUT;
>>  
>> @@ -785,10 +785,10 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
>>  	val &= ~PCIE_PORT_PERST(port->slot);
>>  	writel(val, pcie->base + PCIE_SYS_CFG);
>>  
>> -	/* 100ms timeout value should be enough for Gen1/2 training */
>> +	/* 120ms timeout value should be enough for Gen1/2 training */
>>  	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS, val,
>>  				 !!(val & PCIE_PORT_LINKUP), 20,
>> -				 100 * USEC_PER_MSEC);
>> +				 120 * USEC_PER_MSEC);
>>  	if (err)
>>  		return -ETIMEDOUT;
>>  
>> -- 
>> 2.34.1
>>

