Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4DD50078A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiDNHv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 03:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiDNHv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 03:51:57 -0400
X-Greylist: delayed 2305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 00:49:31 PDT
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0CA12602;
        Thu, 14 Apr 2022 00:49:29 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.21])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1netd6-0005jh-I9; Thu, 14 Apr 2022 08:11:00 +0100
Message-ID: <3acd20b2-5882-7cc0-8a7b-7b406b768c1c@codethink.co.uk>
Date:   Thu, 14 Apr 2022 08:11:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [V3] PCI: fu740: Drop to 2.5GT/s to fix initial device probing on
 some boards
Content-Language: en-GB
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Neill Whillans <neill.whillans@codethink.co.uk>
References: <20220318152430.526320-1-ben.dooks@codethink.co.uk>
 <2442936e-a53e-59bf-488f-95eac26d1252@ghiti.fr>
 <85e864fd-762e-0780-f829-bfbb178ab24e@ghiti.fr>
 <bded4b1e-3404-6bcd-3289-dc8d5b4d713a@codethink.co.uk>
 <alpine.DEB.2.21.2204140048460.9383@angie.orcam.me.uk>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <alpine.DEB.2.21.2204140048460.9383@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/04/2022 01:10, Maciej W. Rozycki wrote:
> On Wed, 23 Mar 2022, Ben Dooks wrote:
> 
>>> FWIW, I have tested this and it solved my issue with nvme not being probed,
>>> so:
>>>
>>> Tested-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
>>
>> Ok, great. Our test rig seems to be still working with this.
> 
>   I ran simple verification of your change by interrupting U-Boot after a
> power-up and issuing:
> 
> => setenv boot_pci_enum true
> 
> at the command prompt before booting from the uSD card and curiously
> enough the root port comes up with the Link Capabilities Register
> reporting the lack of Link Bandwidth Notification Capability in this
> scenario, while it reports its presence if booted undisturbed, i.e.:
> 
> 		LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <4us, L1 <4us
> 			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp+
> 
> vs:
> 
> 		LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <4us, L1 <4us
> 			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
> 
> It is fully reproducible.
> 
>   Any idea what might be causing it?  I can't see it being explicitly set
> or cleared anywhere, be it in U-Boot or Linux, so it must be done by the
> device itself depending on something.  And the lack of this capability
> seems to me like non-compliance for a multiple-lane, multiple-speed
> device.

I'll see if we can reproduce this


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
