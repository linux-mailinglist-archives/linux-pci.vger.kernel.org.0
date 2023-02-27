Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95446A3E2D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 10:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjB0JU6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 04:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjB0JUq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 04:20:46 -0500
Received: from smtp-outbound9.duck.com (smtp-outbound9.duck.com [20.67.221.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72433420A
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2023 01:17:31 -0800 (PST)
MIME-Version: 1.0
Subject: Re: ASMedia ASM1812 PCIe switch causes system to freeze hard
References: <8e7978f65c6606fb2d48483435c78bd3@cutk.com>
 <756173E3-354E-4AC4-89D7-9096B62E344C.1@smtp-inbound1.duck.com>
 <CAOSf1CGoAVrzb7nrMgZ6tZP-Akx7DvGD5RBu9KjprP5r2DtQiA@mail.gmail.com>
 <9C53F704-1C13-4191-8890-20B18A23E94B.1@smtp-inbound1.duck.com>
Content-Type: text/plain;
        charset=UTF-8;
        format=flowed
Content-Transfer-Encoding: 8bit
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Received: by smtp-inbound1.duck.com; Mon, 27 Feb 2023 04:17:29 -0500
Message-ID: <FE51C066-F5EC-4D3E-A43A-8C409E5D23C7.1@smtp-inbound1.duck.com>
Date:   Mon, 27 Feb 2023 04:17:29 -0500
From:   fk1xdcio@duck.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com; h=From:
 Date: Message-ID: Cc: To: Content-Transfer-Encoding: Content-Type:
 References: Subject: MIME-Version; q=dns/txt; s=postal-KpyQVw;
 t=1677489450; bh=waVo6wHj95g3HbUrcdnTRctAJndKb6kfwEp+oEcbPYs=;
 b=rJkuQbYH5XlCPh/jgL7BZ0ci4TXRrzUOWUDsKZyzvZ6QPa/M+60NmgJkonTySgOPeGm3g/GCi
 8dAO6vC7Cb1Zo9KAUBuHTA6CRroCi5KFM+GsA9xrRiGgxpiawFhslp/FbiDsN2ygmbxGLWZQ02o
 DqXWUwlpL4dJ0dmvjEPW6XE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-02-27 03:12, Oliver O'Halloran wrote:
> On Sun, Feb 26, 2023 at 6:20 AM <fk1xdcio@duck.com> wrote:
>> 
>> On 2023-02-25 13:28, Chris wrote:
>> > I'm testing a generic 4-port PCIe x4 2.5Gbps Ethernet NIC. It uses an
>> > ASM1812 for the PCI packet switch to four RTL8125BG network
>> > controllers.
>> 
>> Sorry, I forget my attachment with the PCI device information.
> 
> Looks like your mail client is breaking threads.
> 
> Anyway, the only thing of interest I can see in the log is that AER is
> reporting correctable errors on three of your four NICs:
> 
> 07:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
> 2.5GbE Controller (rev 05)
> Capabilities: [100 v2] Advanced Error Reporting
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> 08:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
> 2.5GbE Controller (rev 05)
> Capabilities: [100 v2] Advanced Error Reporting
> CESta: RxErr+ BadTLP- BadDLLP+ Rollover- Timeout+ AdvNonFatalErr-
> 09:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
> 2.5GbE Controller (rev 05)
> Capabilities: [100 v2] Advanced Error Reporting
> CESta: RxErr+ BadTLP- BadDLLP+ Rollover- Timeout+ AdvNonFatalErr-
> 0a:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
> 2.5GbE Controller (rev 05)
> Capabilities: [100 v2] Advanced Error Reporting
> CESta: RxErr+ BadTLP- BadDLLP+ Rollover- Timeout+ AdvNonFatalErr-
> 
> Bad Data Link Layer Packet errors suggest that specific card has
> signal integrity issues. Assuming that's true, more traffic to the NIC
> means more opportunities for uncorrectable errors which would explain
> the hard lockups. I'm not sure why setting pci=nommconf seems to fix
> the problem, but my guess it's just masking the issue. The AER
> capability is in the extended config space which requires the memory
> mapped config space to access so disabling that probably just stops
> the kernel from noticing that errors are occuring. The network stack
> is pretty forgiving of errors since it can just drop packets which
> might also explain the lower throughput too.


Yes, sorry about the thread. It's probably something I did.

Thanks for the information.

The AER errors are caused by ASPM. If I disable power management then 
they go away. The hard lockups still occur though so it seems like it 
might be a separate issue.

Obviously the chipset is buggy but I'm trying to work around it as best 
I can. I may just have to add a quirk and disable MMCONFIG for this 
chipset (if that's possible).
