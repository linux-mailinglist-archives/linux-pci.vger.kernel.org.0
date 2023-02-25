Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523576A2B51
	for <lists+linux-pci@lfdr.de>; Sat, 25 Feb 2023 19:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBYSh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Feb 2023 13:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjBYSh0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Feb 2023 13:37:26 -0500
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Feb 2023 10:37:24 PST
Received: from smtp-outbound9.duck.com (smtp-outbound9.duck.com [20.67.221.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E07313D79
        for <linux-pci@vger.kernel.org>; Sat, 25 Feb 2023 10:37:24 -0800 (PST)
MIME-Version: 1.0
Subject: ASMedia ASM1812 PCIe switch causes system to freeze hard
Content-Type: text/plain;
        charset=US-ASCII;
        format=flowed
Content-Transfer-Encoding: 7bit
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Received: by smtp-inbound1.duck.com; Sat, 25 Feb 2023 13:37:23 -0500
Message-ID: <9B577F97-4E03-4D1D-B6F2-909897F938CC.1@smtp-inbound1.duck.com>
Date:   Sat, 25 Feb 2023 13:37:23 -0500
From:   fk1xdcio@duck.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com; h=From:
 Date: Message-ID: To: Content-Transfer-Encoding: Content-Type: Subject:
 MIME-Version; q=dns/txt; s=postal-KpyQVw; t=1677350243;
 bh=/J/JjXmSFS2ucJEFuNJ+A9usjiCA/sWH8eerPUSleMs=;
 b=BhXRYwaHQFIQwM8TvZPcm61Cc/U+/uHaIIL2FfgeqXthGqNZAFFZsbk0+zoVd3lU62uuYLvir
 CqKpUDee9jx8xX1QBVSChLPdNxrylUJbBgh6l+ZdDCQ2HqXc8rycKusR9KUc9KBkqaWnBz74xTT
 T5GqdrhgreyGuL6UStqsZE8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'm testing a generic 4-port PCIe x4 2.5Gbps Ethernet NIC. It uses an 
ASM1812 for the PCI packet switch to four RTL8125BG network controllers.

The more load I put on the NIC the faster the system freezes. For 
example if I activate four 2.5Gbps fully saturated network connections 
then the system hard freezes almost immediately. When the system freezes 
it seems completely dead. SysRq doesn't work, serial consoles are dead, 
etc. so I haven't been able to get much debugging information. I have 
tested on various different physical systems, Xeon E5, Xeon E3, i7, and 
they all behave the same so it doesn't seem like a system hardware 
issue.

Disabling IOMMU makes it run for a little longer before crashing.

The tiny bit of error information I have been able to get under various 
conditions (eg. disabling ASPM, forcing D0, etc):
   Test #1:
   pcieport 0000:04:02.0: Unable to change power state from D3hot to D0, 
device inaccessible

   Test #2:
   pcieport 0000:04:02.0: can't change power state from D3cold to D0 
(config space inaccessible)
   pcieport 0000:03:00.0: Wakeup disabled by ACPI
   pcieport 0000:04:02.0: PME# disabled

   Test #3:
   enp7s0: cmd = 0xff, should be 0x07 \x0a.
   enp7s0: pci link is down \x0a.

At times there are several of those errors printed for the different PCI 
devices of the NIC before the system locks up.

Setting "pci=nommconf" on the kernel command line is the only thing that 
seems to fix the issue but performance is degraded when using 
bidirectional transfers. 2.5Gbps TX but only 1.5Gbps RX compared to 
MMCONFIG enabled which gets full 2.5Gbps bidirectional.

So it seems the MMCONFIG works sometimes but eventually something 
happens and it becomes inaccessible at which point the system freezes. 
Is there a way to keep MMCONFIG enabled for other devices but not this 
ASM1812 device? Or better, is there a way to debug and fix MMCONFIG for 
the device?
