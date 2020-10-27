Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9A29C5E9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 19:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1825164AbgJ0SJN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 27 Oct 2020 14:09:13 -0400
Received: from mail.nic.cz ([217.31.204.67]:38566 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1825160AbgJ0SJN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 14:09:13 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 14:09:12 EDT
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 7271813F62D;
        Tue, 27 Oct 2020 19:03:55 +0100 (CET)
Date:   Tue, 27 Oct 2020 19:03:44 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201027190344.4ffd9186@nic.cz>
In-Reply-To: <87imavwu7b.fsf@toke.dk>
References: <87imavwu7b.fsf@toke.dk>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Are you using stock U-Boot in the Omnia?

Marek

On Tue, 27 Oct 2020 16:43:20 +0100
Toke Høiland-Jørgensen <toke@redhat.com> wrote:

> Hi everyone
> 
> I'm trying to get a mainline kernel to run on my Turris Omnia, and am
> having some trouble getting the PCI bus to work correctly. Specifically,
> I'm running a 5.10-rc1 kernel (torvalds/master as of this moment), with
> the resource request fix[0] applied on top.
> 
> The kernel boots fine, and the patch in [0] makes the PCI devices show
> up. But I'm still getting initialisation errors like these:
> 
> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004 != 0xffffffff)
> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004 != 0xffffffff)
> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000000 != 0xffffffff)
> 
> and the WiFi drivers fail to initialise with what appears to me to be
> errors related to the bus rather than to the drivers themselves:
> 
> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported by this driver
> [    3.517049] ath: phy0: Unable to initialize hardware; initialization status: -95
> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed with rc=134
> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
> [    3.548735] ath10k_pci 0000:02:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device : -110
> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error -110
> 
> lspci looks OK, though:
> 
> # lspci
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev 04)
> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) (rev 01)
> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter (rev ff)
> 
> Does anyone have any clue what could be going on here? Is this a bug, or
> did I miss something in my config or other initialisation? I've tried
> with both the stock u-boot distributed with the board, and with an
> upstream u-boot from latest master; doesn't seem to make any different.
> 
> Any pointers will be greatly appreciated!
> 
> Thanks,
> 
> -Toke
> 
> 
> [0] https://lore.kernel.org/linux-pci/20201023145252.2691779-1-robh@kernel.org/
