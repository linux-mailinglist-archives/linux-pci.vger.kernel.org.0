Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769776B8D4C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 09:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCNI2m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 04:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCNI2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 04:28:30 -0400
Received: from smtp-outbound9.duck.com (smtp-outbound9.duck.com [20.67.221.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8388030F1
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 01:28:28 -0700 (PDT)
MIME-Version: 1.0
Subject: Re: ASMedia ASM1812 PCIe switch causes system to freeze hard
References: <20230313215718.GA1546868@bhelgaas>
 <1BD0E6B9-0611-4879-BA26-DDA87E772512.1@smtp-inbound1.duck.com>
Content-Type: text/plain;
        charset=US-ASCII;
        format=flowed
Content-Transfer-Encoding: 7bit
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Oliver O'Halloran <oohall@gmail.com>
Received: by smtp-inbound1.duck.com; Tue, 14 Mar 2023 04:28:26 -0400
Message-ID: <3E5BFF96-1037-46A5-B5E6-DB1ED7DFBEDC.1@smtp-inbound1.duck.com>
Date:   Tue, 14 Mar 2023 04:28:26 -0400
From:   fk1xdcio@duck.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com; h=From:
 Date: Message-ID: Cc: To: Content-Transfer-Encoding: Content-Type:
 References: Subject: MIME-Version; q=dns/txt; s=postal-KpyQVw;
 t=1678782507; bh=PuZCFo+0bWSHgSij99kJ8/OarA4MCdyXHvIO9a8UcMA=;
 b=N8Lo9ApPuZTqqCCCi9q6WbRmmV5ef0KpJ7/6TaCbfo09tK0Afzyt2idsC59c1QnTC27TsZzaC
 UJo/WuO06knhAQ4c7tHohoJKYfx/YCgEdyxA2bddV6AW7z/wnPzU45+dd8KsYLk5AYbnPCihCI7
 ij60JGVdvN+P7VD1h+VeSjg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-03-13 17:57, Bjorn Helgaas wrote:
> On Wed, Mar 08, 2023 at 02:49:42PM -0600, Bjorn Helgaas wrote:
>> On Sat, Feb 25, 2023 at 01:37:23PM -0500, fk1xdcio@duck.com wrote:
>> > I'm testing a generic 4-port PCIe x4 2.5Gbps Ethernet NIC. It uses an
>> > ASM1812 for the PCI packet switch to four RTL8125BG network controllers.
>> >
>> > The more load I put on the NIC the faster the system freezes. For example if
>> > I activate four 2.5Gbps fully saturated network connections then the system
>> > hard freezes almost immediately. When the system freezes it seems completely
>> > dead. SysRq doesn't work, serial consoles are dead, etc. so I haven't been
>> > able to get much debugging information. I have tested on various different
>> > physical systems, Xeon E5, Xeon E3, i7, and they all behave the same so it
>> > doesn't seem like a system hardware issue.
>> >
>> > Disabling IOMMU makes it run for a little longer before crashing.
>> >
>> > The tiny bit of error information I have been able to get under various
>> > conditions (eg. disabling ASPM, forcing D0, etc):
>> >   Test #1:
>> >   pcieport 0000:04:02.0: Unable to change power state from D3hot to D0,
>> > device inaccessible
>> >
>> >   Test #2:
>> >   pcieport 0000:04:02.0: can't change power state from D3cold to D0 (config
>> > space inaccessible)
>> >   pcieport 0000:03:00.0: Wakeup disabled by ACPI
>> >   pcieport 0000:04:02.0: PME# disabled
>> >
>> >   Test #3:
>> >   enp7s0: cmd = 0xff, should be 0x07 \x0a.
>> >   enp7s0: pci link is down \x0a.
>> >
>> > At times there are several of those errors printed for the different PCI
>> > devices of the NIC before the system locks up.
>> >
>> > Setting "pci=nommconf" on the kernel command line is the only thing that
>> > seems to fix the issue but performance is degraded when using bidirectional
>> > transfers. 2.5Gbps TX but only 1.5Gbps RX compared to MMCONFIG enabled which
>> > gets full 2.5Gbps bidirectional.
>> >
>> > So it seems the MMCONFIG works sometimes but eventually something happens
>> > and it becomes inaccessible at which point the system freezes. Is there a
>> > way to keep MMCONFIG enabled for other devices but not this ASM1812 device?
>> > Or better, is there a way to debug and fix MMCONFIG for the device?
>> 
>> Thanks for the report!
>> 
>> So IIUC, "pci=nommconf" avoids the system hang completely, but network
>> performance is lower.  Do the NIC stats show packet drops that might
>> explain the performance problem?
>> 
>> You mentioned later that you see AER errors caused by ASPM, and they
>> go away if you disable power management (but the hard lockups still
>> happen).  Is it "pcie_aspm=off" or "pcie_port_pm=off" or something
>> else that makes this diffference?
> 
> I don't want to forget about this issue.  Have you learned anything
> new, e.g., any answers to the questions above?  I don't have any good
> ideas yet, but if we keep pushing on it, we might be able to figure
> out something.
> 
> Bjorn

It's going to take some time before I can test again because the card is 
in a production server. During my next maintenance period I'll pull it 
and re-test because I can't find my old logs.

I don't remember seeing any errors on the NIC stats. I was testing 
performance with iperf3 bidirectional mode and only one direction slows 
down while the other runs at full speed. With MMCONFIG enabled then the 
bidirectional test runs at full speed in both directions until it 
crashes. It still crashes in unidirectional mode too.

I was disabling ASPM with pcie_aspm=off

Chris
