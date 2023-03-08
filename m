Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EBB6B1358
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 21:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCHUt7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 15:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCHUts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 15:49:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA9E8537E
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 12:49:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEC296194E
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 20:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCDAC433D2;
        Wed,  8 Mar 2023 20:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678308584;
        bh=BXCY59MwfGhke6W0vZwZYsrbAuV0LQ1wzQmlab4ZGv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BA7Y71B2jCQYqW0Wrd5osJUDj/F1e1GAfgJnXkUl+2jjVrmBxCtNyFrAzskj1xcFb
         d6P9rpOQ/LxHXhl6k2anfUBsk4ft1e8BrLci2tRuNRayXZ9EaIXnjGZNkVv5MWawiz
         wDqqluNqT2i7HWtoglrdB/8msduP0OmcSyhMytqXqQ3QwQpipzRE9GCnGEjrDnP1C7
         yr10N+CH2u1NJ8mtexSO+AHrn+RaYichokVg26BUjW7EITG5bOrcV5F5uXsafefr5m
         KPUIQterEYz4E8722wWEHDR7YMbibW28jSlQj2ij30MCQ42OyTor1xzME9jtQk16E1
         KxEBFGDQKYg+Q==
Date:   Wed, 8 Mar 2023 14:49:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     fk1xdcio@duck.com
Cc:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: ASMedia ASM1812 PCIe switch causes system to freeze hard
Message-ID: <20230308204942.GA1032495@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B577F97-4E03-4D1D-B6F2-909897F938CC.1@smtp-inbound1.duck.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 25, 2023 at 01:37:23PM -0500, fk1xdcio@duck.com wrote:
> I'm testing a generic 4-port PCIe x4 2.5Gbps Ethernet NIC. It uses an
> ASM1812 for the PCI packet switch to four RTL8125BG network controllers.
> 
> The more load I put on the NIC the faster the system freezes. For example if
> I activate four 2.5Gbps fully saturated network connections then the system
> hard freezes almost immediately. When the system freezes it seems completely
> dead. SysRq doesn't work, serial consoles are dead, etc. so I haven't been
> able to get much debugging information. I have tested on various different
> physical systems, Xeon E5, Xeon E3, i7, and they all behave the same so it
> doesn't seem like a system hardware issue.
> 
> Disabling IOMMU makes it run for a little longer before crashing.
> 
> The tiny bit of error information I have been able to get under various
> conditions (eg. disabling ASPM, forcing D0, etc):
>   Test #1:
>   pcieport 0000:04:02.0: Unable to change power state from D3hot to D0,
> device inaccessible
> 
>   Test #2:
>   pcieport 0000:04:02.0: can't change power state from D3cold to D0 (config
> space inaccessible)
>   pcieport 0000:03:00.0: Wakeup disabled by ACPI
>   pcieport 0000:04:02.0: PME# disabled
> 
>   Test #3:
>   enp7s0: cmd = 0xff, should be 0x07 \x0a.
>   enp7s0: pci link is down \x0a.
> 
> At times there are several of those errors printed for the different PCI
> devices of the NIC before the system locks up.
> 
> Setting "pci=nommconf" on the kernel command line is the only thing that
> seems to fix the issue but performance is degraded when using bidirectional
> transfers. 2.5Gbps TX but only 1.5Gbps RX compared to MMCONFIG enabled which
> gets full 2.5Gbps bidirectional.
> 
> So it seems the MMCONFIG works sometimes but eventually something happens
> and it becomes inaccessible at which point the system freezes. Is there a
> way to keep MMCONFIG enabled for other devices but not this ASM1812 device?
> Or better, is there a way to debug and fix MMCONFIG for the device?

Thanks for the report!

So IIUC, "pci=nommconf" avoids the system hang completely, but network
performance is lower.  Do the NIC stats show packet drops that might
explain the performance problem?

You mentioned later that you see AER errors caused by ASPM, and they
go away if you disable power management (but the hard lockups still
happen).  Is it "pcie_aspm=off" or "pcie_port_pm=off" or something
else that makes this diffference?

I like Oliver's point about "pci=nommconf" disabling access to
extended config space (although I'm not 100% sure about this because I
think arch/x86/pci/direct.c provides non-MMCONFIG accessors that can
reach the extended space -- the "pci=nommconf" dmesg log might have a
hint, and the lspci in that case would show for sure).

Prior to f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
native") (which appeared in v6.0), error reporting was enabled by the
AER driver.  The AER driver doesn't work on your system because the
Root Ports don't support AER, so prior to v6.0, error reporting may
not be enabled.

Starting with v6.0, error reporting should be enabled even if the Root
Port doesn't support AER, as it is per the DevCtl bits below.  In
v5.15, those DevCtl bits may not be set.  But you said v5.15 is also
broken, so maybe this commit isn't related.

I don't quite see the ASPM connection.  The r8169 driver apparently
tries to disable ASPM [1], but it seems that Linux shouldn't be
changing any ASPM configuration.  Your dmesg [2] contains:

  acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration   
  r8169 0000:07:00.0: can't disable ASPM; OS doesn't have ASPM control

And it looks like BIOS left ASPM disabled anyway.  From your lspci
output [2]:

  04:03.0 PCI bridge: ASMedia Technology Inc. ASM1812 6-Port PCIe x4
    Bus: primary=04, secondary=07, subordinate=07
      DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
      LnkCtl:	ASPM Disabled
  07:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
      DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
      LnkCtl:	ASPM Disabled

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/realtek/r8169_main.c?id=v6.2#n5203
[2] https://lore.kernel.org/all/AF9C0500-2909-4FF4-8E4E-3BAD8FD8AA14.1@smtp-inbound1.duck.com/
