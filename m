Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A52585A92
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jul 2022 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiG3NWU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jul 2022 09:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiG3NWU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jul 2022 09:22:20 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDF51834B;
        Sat, 30 Jul 2022 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Cc:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aSywYrwf15BzW6MvNi6pyYXRXgcXxNaIrSSYrdc6ocA=; b=Md3+EonKfWw4OKarokgWoQ8pQN
        qG/WdCaH8ZbNrYJ2XTGW5lOXrCkAcU2ckWIkQ6H8UZARydrcymwEnjKM6K7Q3zp2UVmvyCMD9WvdA
        oef89z5sznf9lD0LXSa0iA4FT1wKADamB4RW22QrXcAFrdbzMKrUNqjbeZIoXkS2CQ5Har8rGU1od
        uiI5GvTJwyNg5Wlv25NdLifiItj1sTfmSTB3o5n6aIpuCo9NF7aXeRl3ziuXLciVxxvTeVxVUvo3W
        7vU5ekKY0ctjtXC8MTFlAdd29FjTws4OwQi4CnNi2fHsk07mBJHnrJ72jpV+pcfHwRVolmm8pD6do
        lgAiW8pQ==;
Received: from a82-197-11-249.mpynet.fi ([82.197.11.249]:65186 helo=[10.0.2.15])
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1oHmPP-006Mvo-Nw; Sat, 30 Jul 2022 16:21:36 +0300
Message-ID: <d7d5aeb8-46eb-567b-348a-00c5ed76352c@ext.kapsi.fi>
Date:   Sat, 30 Jul 2022 16:21:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     maukka@ext.kapsi.fi, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk,
        lpieralisi@kernel.org, kw@linux.com, thomas.petazzoni@bootlin.com,
        pali@kernel.org
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20220729172251.GA465917@bhelgaas>
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
In-Reply-To: <20220729172251.GA465917@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 82.197.11.249
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 0/2] PCI: mvebu: add support for orion soc
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn!

On 29.07.22 20:22, Bjorn Helgaas wrote:
> On Mon, Jul 18, 2022 at 11:28:40PM +0300, Mauri Sandberg wrote:
>> Hello all!
>>
>> Working in close co-operation with Pali we made an initial attempt at bringing
>> support for orion PCIe into mvebu PCIe driver. Currently the address of
>> workaround memory range is hard coded and based on compatible string only. As
>> Pali describes in another thread, we were not able to figure out what's the
>> correct way to configure a configuration space. That discussion is here:
>> https://lore.kernel.org/linux-pci/20220710225108.bgedria6igtqpz5l@pali/T/#u
>>
>> I tested this with D-Link DNS-323 rev A1 and it's working. As usual, all
>> comments and feedback is welcome.
>>
>> Thanks,
>> Mauri
>>
>> Mauri Sandberg (2):
>>    dt-bindings: PCI: mvebu: Add orion5x compatible
>>    PCI: mvebu: add support for orion5x
>>
>>   .../devicetree/bindings/pci/mvebu-pci.txt     |  1 +
>>   arch/arm/mach-orion5x/common.c                | 13 ----
>>   drivers/pci/controller/Kconfig                |  2 +-
>>   drivers/pci/controller/pci-mvebu.c            | 59 +++++++++++++++++++
>>   4 files changed, 61 insertions(+), 14 deletions(-)
> 
> Hi Mauri,
> 
> Can you address anything in 2/2 (if necessary), incorporate any acks,
> and post a v2?  There was some confusion around the first patch (there
> are two in the thread, likely the same?), and I didn't read the 2/2
> feedback in detail to see if any changes were needed.
> 

I give it a little bit time to see if the discussion on how to configure
the configuration space would pick up, but I'll attend to the comments
and post a clean v2 soonish.

