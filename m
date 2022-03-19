Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108614DE7E7
	for <lists+linux-pci@lfdr.de>; Sat, 19 Mar 2022 13:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiCSMlg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Mar 2022 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiCSMlg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Mar 2022 08:41:36 -0400
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE444338D;
        Sat, 19 Mar 2022 05:40:15 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.21])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nVYNP-0001Oy-P6; Sat, 19 Mar 2022 12:40:11 +0000
Message-ID: <9cc22be4-abba-ef75-a340-af7afb08f480@codethink.co.uk>
Date:   Sat, 19 Mar 2022 12:40:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [V3] PCI: fu740: Drop to 2.5GT/s to fix initial device probing on
 some boards
Content-Language: en-GB
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, bhelgaas@google.com,
        robh@kernel.org, lorenzo.pieralisi@arm.com,
        greentime.hu@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>
References: <mhng-0c8e7e26-5480-4573-b7f6-27b09f06de59@palmer-ri-x1c9>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <mhng-0c8e7e26-5480-4573-b7f6-27b09f06de59@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/03/2022 23:03, Palmer Dabbelt wrote:
> On Fri, 18 Mar 2022 08:24:30 PDT (-0700), ben.dooks@codethink.co.uk wrote:
>> The fu740 PCIe core does not probe any devices on the SiFive Unmatched
>> board without this fix (or having U-Boot explicitly start the PCIe via
>> either boot-script or user command). The fix is to start the link at
>> 2.5GT/s speeds and once the link is up then change the maximum speed back
>> to the default.
>>
>> The U-Boot driver claims to set the link-speed to 2.5GT/s to get the 
>> probe
>> to work (and U-Boot does print link up at 2.5GT/s) in the following code:
>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c?id=v2022.01#L271 
>>
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> -- 
> 
> A "--" triggers some mail handles to think the rest of this is a 
> signature, git folks usually use a "---" to indicate a comment that 
> shouldn't be part of what's eventually merged (like this changelog stuff).
> 
>> Note, this patch has had significant re-work since the previous 4
>> sets, including trying to fix style, message, reliance on the U-Boot
>> fix and the comments about usage of LINK_CAP and reserved fields.
>>
>> v2:
>> - fix issues with Gen1/2.5GTs
>> - updated comment on the initial probe
>> - run tests with both uninitialised and initialsed pcie from uboot
>> ---
>>  drivers/pci/controller/dwc/pcie-fu740.c | 52 ++++++++++++++++++++++++-
>>  1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c 
>> b/drivers/pci/controller/dwc/pcie-fu740.c
>> index 842b7202b96e..ecac0364178a 100644
>> --- a/drivers/pci/controller/dwc/pcie-fu740.c
>> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
>> @@ -181,10 +181,60 @@ static int fu740_pcie_start_link(struct dw_pcie 
>> *pci)
> 
> Is there an errata?  IIUC this will trigger the workaround on all 
> FU740s, but from the description it seems like more of a board bug than 
> a chip bug.  The distinction doesn't really matter, as there's only one 
> board for this chip (and I'm assuming that'll always be the case), but 
> if there's an errata (or any way this is documented) it might make 
> things a bit easier to sort out if we end up with another similar 
> chip/board.
> 
> Either way
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I'm assuming you, or someone else, has tested this on the board?  I'm 
> pretty sure I've got one lying around somewhere, but I don't regularly 
> use it.  I can dust it off if nobody else has tried this, but happy to 
> avoid the need to do so.


I've been trying this on my own Unmatched board, where I often use
network boot. We have also tested with a new-ish U-Boot (2022.01 I
think) with both "pci enum" and not. It has been on our test board
for over a week without an issue.

I will have a look for v4 about changing the WARN_ON() to something
more useful.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
