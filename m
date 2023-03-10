Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3B6B5036
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 19:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCJSlK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 13:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCJSlI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 13:41:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DE811E6FB
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 10:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 971E4CE293C
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 18:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D248C433D2;
        Fri, 10 Mar 2023 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678473663;
        bh=7Q7nBdE+Gn4rGMRx5LTVH1SDIrlejqxGZZ647G6KSvI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TTfelb++JEI0ZSQbPp7MIDtkEmKCGbcrW6fUu4dIamMFshqP8pyTBcQbcZvIpJ7/E
         b82aNfBTXNzGn2fvxsbNJWXfyziAKyu/M5JnWS2Nw3HigeuO1E2syHWiOdX9SnO8p2
         9TZuUmo1SUMnmY/dYCPlB3v3OTAIEX9pH9GQlHyNN0ZSjsK5OCeu6XseZZVC+Z1Hrn
         Yo3rCzIhGgaxezWk5bhTUa4BWLaeaquoM6CxtwuUCErs1Kcz9/ZBI9Qj5SScZIZnXU
         fozpf227A9kKtJE64LUpwuOZ2inhD+XxIwYaEVo8OianRprQJHrf03I/npxmWPLMKl
         99M5QcDcgmYmA==
Date:   Fri, 10 Mar 2023 12:41:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     gael.seibert@gmx.fr
Cc:     linux-pci@vger.kernel.org
Subject: Re: The MSI Driver Guide HOWTO
Message-ID: <20230310184102.GA1267642@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN44ZY2G.XQXJA4JD.P37YMNSZ@LGXWN7Q2.OD5XUULU.2REDJUZ5>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 11:23:14AM +0100, gael.seibert@gmx.fr wrote:
> On 09/03/2023 23:55:03, Bjorn Helgaas wrote:
> > On Thu, Mar 09, 2023 at 10:57:51AM +0100, rec wrote:
> > > On 09/03/2023 00:03:04, Bjorn Helgaas wrote:
> > > > On Tue, Mar 07, 2023 at 12:22:44PM +0100, rec wrote:
> > > > > Like asked in : https://www.kernel.org/doc/html/latest/PCI/msi-howto.html#disabling-msis-globally
> > >
> > > > Thanks for the report!  I assume this means your system has problems
> > > > with MSIs, and booting with "pci=nomsi" makes it work better?
> > >
> > > You are welcome,
> > > The system doesn't boot completely without the "pci=nomsi" option.
> > 
> > What exactly do you mean by "it doesn't boot completely"?  I compared
> > the two dmesg logs, and I see that the "with MSI" log also has the
> > "single" parameter, so it will only boot to single-user mode.
> 
> It does it mean than either the boot stop or the system halt, power-off
> before it can be possible to connect tty console or display manager.

Wow.  I'm not sure what would cause a sudden halt or power-off like
that.  Is there any indication on the console when this happens?  Can
you try adding the following to your kernel boot parameters to see if
you can catch anything via a photo or video (you may have to adjust
the boot_delay to make things readable):

  nosmp ignore_loglevel lpj=lpj=7000000 boot_delay=100

> Attach with this message the bootmsi log without the single option.

Thanks for the log!  I don't see many interesting differences.

  - Command line: BOOT_IMAGE=/boot/vmlinuz-6.1.0-5-amd64 root=UUID=ad672b5b-e68c-4aaf-8bde-113269cba2d8 ro
  + Command line: BOOT_IMAGE=/boot/vmlinuz-6.1.0-5-amd64 root=UUID=ad672b5b-e68c-4aaf-8bde-113269cba2d8 ro pci=nomsi quiet
  - acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
  + acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments HPX-Type3]
  - acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug AER PCIeCapability]
  + acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]

As expected when Linux is not using MSI.

  + pci 0000:00:0d.0: proprietary Ricoh MMC controller disabled (via FireWire function)
  + pci 0000:00:0d.0: MMC cards are now supported by standard SDHCI controller

Peculiar.

  - pcieport 0000:00:07.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- IbPresDis- LLActRep-

As expected when Linux is not using AER, pciehp, etc.

I'm curious about the Ricoh thing because I don't see an obvious MSI
connection.  Can you collect the output of "sudo lspci -vv"?  The
lspci output in your initial email wasn't collected as root, so it
doesn't include information about Capabilities (including MSI).

Bjorn
