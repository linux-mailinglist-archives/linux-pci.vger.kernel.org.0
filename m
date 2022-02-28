Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61C14C7E28
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 00:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiB1XQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 18:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiB1XQa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 18:16:30 -0500
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597674AE2E;
        Mon, 28 Feb 2022 15:15:50 -0800 (PST)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.21])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nOoo1-0002WO-9x; Mon, 28 Feb 2022 22:47:49 +0000
Message-ID: <023a2015-cf04-9673-8e8a-88fe88ee085e@codethink.co.uk>
Date:   Mon, 28 Feb 2022 23:15:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCHv4 2/2] PCI: fu740: Force gen1 for initial device probe
Content-Language: en-GB
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220223205141.GA149346@bhelgaas>
 <alpine.DEB.2.21.2202232100220.27002@angie.orcam.me.uk>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <alpine.DEB.2.21.2202232100220.27002@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23/02/2022 21:19, Maciej W. Rozycki wrote:
> On Wed, 23 Feb 2022, Bjorn Helgaas wrote:
> 
>>> +	dw_pcie_dbi_ro_wr_dis(dw);
>>> +}
>>> +
>>>   static int fu740_pcie_start_link(struct dw_pcie *pci)
>>>   {
>>>   	struct device *dev = pci->dev;
>>>   	struct fu740_pcie *afp = dev_get_drvdata(dev);
>>>   
>>> +	/* Force PCIe gen1 otherwise Unmatched board does not probe */
>>> +	fu740_pcie_force_gen1(pci, afp);
>>
>> I guess the "Unmatched" board is the only thing we need to care about
>> here?  Are there or will there be other boards that don't need this?
> 
>   I wonder if this is the other side of a supposed erratum observed here:
> 
> <https://lore.kernel.org/all/alpine.DEB.2.21.2202010240190.58572@angie.orcam.me.uk/>
> 
> Downstream there's the same ASMedia ASM2824 PCIe switch whose downstream
> ports don't want to train with a Pericom part above Gen1.
> 
>   Of course we don't know an ASM2824 is there until we have successfully
> negotiated the link, so we may have to generalise my proposal if we can
> find a way similar to what I have done for U-boot that does not disturb
> Linux's operation.  This is because there are PCIe option cards out there
> with the ASM2824 onboard, so it could be possible for the problem to
> trigger anywhere where the conditions for the erratum are met.
> 
>   Also in that case retraining should work with the cap removed to get a
> higher final speed just as with the Pericom part.

Possibly. I have just been working on a patch to better force Gen1
speeds and then restore the config which is working on my Unmatched
board.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
