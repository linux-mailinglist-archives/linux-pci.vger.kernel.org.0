Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B0E53A44D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348901AbiFALr1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 07:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiFALr0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 07:47:26 -0400
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:101:465::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0681571B
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 04:47:22 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4LCnSK57xdz9sQB;
        Wed,  1 Jun 2022 13:47:13 +0200 (CEST)
Message-ID: <f3731342-3ddb-1eff-3a6e-51bb1defc469@denx.de>
Date:   Wed, 1 Jun 2022 13:47:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] PCI/portdrv: Add option to setup IRQs for
 platform-specific Service Errors
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220531213158.GA780032@bhelgaas>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220531213158.GA780032@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31.05.22 23:31, Bjorn Helgaas wrote:
> On Mon, May 30, 2022 at 10:32:06AM +0200, Pali Rohár wrote:
>> On Monday 30 May 2022 10:18:41 Stefan Roese wrote:
>>> On 28.05.22 02:09, Bjorn Helgaas wrote:
>>>> In subject line, I assume you mean "System Errors" instead of "Service
>>>> Errors"?
>>>
>>> Background: I took over submitting this patchset from Bharat. Here his
>>> last revision:
>>> https://www.spinics.net/lists/kernel/msg2960164.html
> 
> Here's the link to the more usable lore archive:
> https://lore.kernel.org/all/1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com/
> 
>>> To answer your question I personally think too, that "System Errors" is
>>> more appropriate than "Service Errors". But still this patchset replaces
>>> or better enhances the already present pcie_init_service_irqs() by a
>>> platform-specific version. I can only suspect, that this is the
>>> reasoning for this "Service" naming.
>>
>> Hello! Based on the below text "Here the quote from Bharat's original
>> cover letter:" I think that the better naming should be: "Service
>> interrupts". Because it adds support for interrupts from PCIe services
>> like AER, PME or HP. Only AER are errors, other IRQs are just services.
> 
> The question I'm trying to answer is whether this series concerns the
> "System Error" mechanism or the "Error Interrupt" mechanism.  We
> should figure out which one this is and use the correct name.
> 
> The sec 6.2.4.1.2 cited below clearly refers to the AER Root Error
> Command register, which controls interrupt generation via INTx, MSI,
> or MSI-X, i.e., the standard "Error Interrupt" shown on the RIGHT side
> of Figure 6-3 in sec 6.2.6.
> 
> The "System Error" signaling on the LEFT side of Figure 6-3 would be
> controlled by the Root Control register in the PCIe capability.

"System Error" is probably incorrect. You've already stated, that
these error bits are generally disabled in the PCI_EXP_RTCTL reg in
aer_enable_rootport():

	/* Disable system error generation in response to error messages */
	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
				   SYSTEM_ERROR_INTR_ON_MESG_MASK);

This leaves "Error Interrupt", but I might be wrong here.

> It should be easy to use setpci to set/clear these two sets of enable
> bits and figure out which path is of interest here.

Here the value of the PCI_EXP_RTCTL register at runtime:
# setpci -v -s 00:00.0 CAP_EXP+0x1c.w
0000:00:00.0 (cap 10 @60) @7c = 0010

So all "System Error" enable bits are disabled.

Please let me know if I should make some other "setpci" tests.

>>>> On Fri, Jan 14, 2022 at 08:58:33AM +0100, Stefan Roese wrote:
>>>>> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> 
>>>>> As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 (and later versions),
>>>>> platform-specific System Errors like AER can be delivered via platform-
>>>>> specific interrupt lines.
> 
>>>> ...
>>>> 6.7.3.4 ("Software Notification of Hot-Plug Events") talks about PME
>>>> and Hot-Plug Event interrupts, but these aren't errors, and I only see
>>>> signaling via INTx, MSI, or MSI-X.  Is there provision for a different
>>>> method?
>>>
>>> Here the quote from Bharat's original cover letter:
>>> "Some platforms have dedicated IRQ lines for PCIe services like AER/PME
>>> etc. The root complex on these platform will use these seperate IRQ
>>> lines to report AER/PME etc., interrupts and will not generate MSI/
>>> MSI-X/INTx interrupts for these services.
>>
>> This is the best explanation of this change.
> 
> As far as I can tell, "dedicated IRQ lines for services like AER/PME
> etc" would violate the PCIe spec.

AFAICT this is the case here.

>  That's OK, we can work around that
> sort of thing, but it needs to be clearly called out as some kind of
> quirk and not mixed in with things like System Error signaling, which
> is allowed to be platform-specific.

Agreed. So how to process with this patchset? Should I reword the
patch subject line (and the commit text and comments) to something like:

Add option to setup IRQs for platform-specific Error Interrupt ?

Thanks,
Stefan
