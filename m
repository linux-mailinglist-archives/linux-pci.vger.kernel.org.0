Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71D96B8457
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 22:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCMV6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 17:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCMV6F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 17:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B18E3C0
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 14:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2561661518
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 21:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51133C4339B;
        Mon, 13 Mar 2023 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678744640;
        bh=rGEQOty72lY/fj8kCjR8gYilCLrUoQ7HXoGPGVDTyC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S5TxBNiQKLA6XyKZ2X7yNgciE/v6uby/oH4UbJNAYLxBbORqzC4kdUPe7kfOdowfc
         we0eGRGexCBUVA0fseZeIG67QjckbjLHQLnR+mHKtxG+HxHL6jEd/206sw03Wt2pIO
         zYdbM8PB56DvMd6e9CpaweZ5kFJQt45nrLRrV6EuWS0DvqYt0LDkKCq7ofLbhtcSLL
         tyOCxCN3C7fdAqZcLMvXatKRs1NxxVzgxp96r8L32ayarbKlyFekOW9dtzVZxWME8Z
         ChwN59JaBiQSjvsZ0kvaFbiIZ7JqAAjPb0r9wSdOimyHuaIB/Kxmi1Q/lBE8oNqG3R
         qxoEYbL/pCvpQ==
Date:   Mon, 13 Mar 2023 16:57:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     fk1xdcio@duck.com
Cc:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: ASMedia ASM1812 PCIe switch causes system to freeze hard
Message-ID: <20230313215718.GA1546868@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308204942.GA1032495@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 02:49:42PM -0600, Bjorn Helgaas wrote:
> On Sat, Feb 25, 2023 at 01:37:23PM -0500, fk1xdcio@duck.com wrote:
> > I'm testing a generic 4-port PCIe x4 2.5Gbps Ethernet NIC. It uses an
> > ASM1812 for the PCI packet switch to four RTL8125BG network controllers.
> > 
> > The more load I put on the NIC the faster the system freezes. For example if
> > I activate four 2.5Gbps fully saturated network connections then the system
> > hard freezes almost immediately. When the system freezes it seems completely
> > dead. SysRq doesn't work, serial consoles are dead, etc. so I haven't been
> > able to get much debugging information. I have tested on various different
> > physical systems, Xeon E5, Xeon E3, i7, and they all behave the same so it
> > doesn't seem like a system hardware issue.
> > 
> > Disabling IOMMU makes it run for a little longer before crashing.
> > 
> > The tiny bit of error information I have been able to get under various
> > conditions (eg. disabling ASPM, forcing D0, etc):
> >   Test #1:
> >   pcieport 0000:04:02.0: Unable to change power state from D3hot to D0,
> > device inaccessible
> > 
> >   Test #2:
> >   pcieport 0000:04:02.0: can't change power state from D3cold to D0 (config
> > space inaccessible)
> >   pcieport 0000:03:00.0: Wakeup disabled by ACPI
> >   pcieport 0000:04:02.0: PME# disabled
> > 
> >   Test #3:
> >   enp7s0: cmd = 0xff, should be 0x07 \x0a.
> >   enp7s0: pci link is down \x0a.
> > 
> > At times there are several of those errors printed for the different PCI
> > devices of the NIC before the system locks up.
> > 
> > Setting "pci=nommconf" on the kernel command line is the only thing that
> > seems to fix the issue but performance is degraded when using bidirectional
> > transfers. 2.5Gbps TX but only 1.5Gbps RX compared to MMCONFIG enabled which
> > gets full 2.5Gbps bidirectional.
> > 
> > So it seems the MMCONFIG works sometimes but eventually something happens
> > and it becomes inaccessible at which point the system freezes. Is there a
> > way to keep MMCONFIG enabled for other devices but not this ASM1812 device?
> > Or better, is there a way to debug and fix MMCONFIG for the device?
> 
> Thanks for the report!
> 
> So IIUC, "pci=nommconf" avoids the system hang completely, but network
> performance is lower.  Do the NIC stats show packet drops that might
> explain the performance problem?
> 
> You mentioned later that you see AER errors caused by ASPM, and they
> go away if you disable power management (but the hard lockups still
> happen).  Is it "pcie_aspm=off" or "pcie_port_pm=off" or something
> else that makes this diffference?

I don't want to forget about this issue.  Have you learned anything
new, e.g., any answers to the questions above?  I don't have any good
ideas yet, but if we keep pushing on it, we might be able to figure
out something.

Bjorn
