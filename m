Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6444D4E507E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 11:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiCWKlw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 06:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiCWKlw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 06:41:52 -0400
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166CA6620E;
        Wed, 23 Mar 2022 03:40:21 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.21])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nWyPV-0006wD-F7; Wed, 23 Mar 2022 10:40:13 +0000
Message-ID: <bded4b1e-3404-6bcd-3289-dc8d5b4d713a@codethink.co.uk>
Date:   Wed, 23 Mar 2022 10:40:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [V3] PCI: fu740: Drop to 2.5GT/s to fix initial device probing on
 some boards
Content-Language: en-GB
To:     Alexandre Ghiti <alex@ghiti.fr>, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Neill Whillans <neill.whillans@codethink.co.uk>
References: <20220318152430.526320-1-ben.dooks@codethink.co.uk>
 <2442936e-a53e-59bf-488f-95eac26d1252@ghiti.fr>
 <85e864fd-762e-0780-f829-bfbb178ab24e@ghiti.fr>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <85e864fd-762e-0780-f829-bfbb178ab24e@ghiti.fr>
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

On 23/03/2022 10:36, Alexandre Ghiti wrote:
> On 3/21/22 14:49, Alexandre Ghiti wrote:
>> Hi Ben,
>>
>> On 3/18/22 16:24, Ben Dooks wrote:
>>> The fu740 PCIe core does not probe any devices on the SiFive Unmatched
>>> board without this fix (or having U-Boot explicitly start the PCIe via
>>> either boot-script or user command). The fix is to start the link at
>>> 2.5GT/s speeds and once the link is up then change the maximum speed 
>>> back
>>> to the default.
>>>
>>> The U-Boot driver claims to set the link-speed to 2.5GT/s to get the 
>>> probe
>>> to work (and U-Boot does print link up at 2.5GT/s) in the following 
>>> code:
>>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c?id=v2022.01#L271 
>>>
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>


[snip]

>>>     static int fu740_pcie_host_init(struct pcie_port *pp)
>>
>> +cc Maciej and David as there is this other fix that seems to do the 
>> same but differently, it's been under review for some time now: 
>> https://lore.kernel.org/all/20220302000043.GA662523@bhelgaas/t/
>>

I did have a quick look, but I think because we don't get any PCIe
probing at-all we don't even have a device to attach to.

>> I fell onto this issue recently, I'll give your patch and the above a 
>> try soon.
> 
> 
> FWIW, I have tested this and it solved my issue with nvme not being 
> probed, so:
> 
> Tested-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>

Ok, great. Our test rig seems to be still working with this.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
