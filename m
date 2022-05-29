Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC05371BD
	for <lists+linux-pci@lfdr.de>; Sun, 29 May 2022 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiE2QPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 May 2022 12:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiE2QPC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 May 2022 12:15:02 -0400
X-Greylist: delayed 1091 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 May 2022 09:15:00 PDT
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D3191545
        for <linux-pci@vger.kernel.org>; Sun, 29 May 2022 09:15:00 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.17])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nvLHZ-0005f7-KS; Sun, 29 May 2022 16:56:45 +0100
Message-ID: <ddc1462c-be74-420a-6809-c868fa056fa7@codethink.co.uk>
Date:   Sun, 29 May 2022 16:56:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
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
 <3acd20b2-5882-7cc0-8a7b-7b406b768c1c@codethink.co.uk>
 <alpine.DEB.2.21.2205020049130.9383@angie.orcam.me.uk>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <alpine.DEB.2.21.2205020049130.9383@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/05/2022 12:46, Maciej W. Rozycki wrote:
> Hi Ben,
> 
>>>    Any idea what might be causing it?  I can't see it being explicitly set
>>> or cleared anywhere, be it in U-Boot or Linux, so it must be done by the
>>> device itself depending on something.  And the lack of this capability
>>> seems to me like non-compliance for a multiple-lane, multiple-speed
>>> device.
>>
>> I'll see if we can reproduce this
> 
>   Have you been able to look into it?
> 

I can't see anything obvious from the code, however my SD card image
does not have lspci on it and I have not had time to make a new image
to test.

I wonder if anyone at SiFive can comment on this?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
