Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793926B848F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 23:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCMWNy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 18:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCMWNx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 18:13:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6651D3CE15
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 15:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19C24B81200
        for <linux-pci@vger.kernel.org>; Mon, 13 Mar 2023 22:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D07C433D2;
        Mon, 13 Mar 2023 22:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678745628;
        bh=+8tOmHTqJ47gSKhnzOkgV/8AZfGqnD5W+8PG3DLroJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aUJ4JEl9qf545zb+c1a1H4q/BBg5eUtgG9YEaFlUJBroCw/mD0x7JcX+qMjRo+cKz
         AF5nQu546eFoytR/7hw0R0XHLrx9AVqOE5P/54SiIdtaCfTb5us/tUSIfA87R5499H
         1XFkWrf4tOL2U+CFvpSPLNoUPLL4q0LvdqL6HKWAgptBXmb+wA+I28IkSXdyJz0u9A
         9vcSQuVFkz7MbGVyaFZ5CEt8dUYlfww8hQsec5lUFaYoChzbQCtRNTARLjszX0aq9I
         qcmd5rO1qhjPhaSieFVYGb9YO5GZcLwCOJFHh3MCcdpD01nmREPYOX6/BGtD3uKZ9d
         4uDeYJIaxTXoQ==
Date:   Mon, 13 Mar 2023 17:13:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     gael.seibert@gmx.fr
Cc:     Bjorn Helgaas <bjorn.helgaas@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: Re: The MSI Driver Guide HOWTO
Message-ID: <20230313221347.GA1547532@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-94b2d3db-178a-413e-aaee-ee4a4e5e6a95-1678520915759@msvc-mesg-gmx026>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[I added back linux-pci so the discussion doesn't get broken up]

On Sat, Mar 11, 2023 at 08:48:35AM +0100, gael.seibert@gmx.fr wrote:
> > Envoyé: vendredi 10 mars 2023 À 23:25
> > De: "Bjorn Helgaas" <bjorn.helgaas@gmail.com>
> > À: gael.seibert@gmx.fr
> > Cc: "Bjorn Helgaas" <helgaas@kernel.org>, linux-pci@vger.kernel.org
> > Objet: Re: The MSI Driver Guide HOWTO
> > 
> > On Fri, Mar 10, 2023 at 3:32 PM <gael.seibert@gmx.fr> wrote:
> > > On 10/03/2023 19:41:02, Bjorn Helgaas wrote:
> > > > On Fri, Mar 10, 2023 at 11:23:14AM +0100, gael.seibert@gmx.fr wrote:
> > > > > On 09/03/2023 23:55:03, Bjorn Helgaas wrote:
> > > > > > On Thu, Mar 09, 2023 at 10:57:51AM +0100, rec wrote:
> > > > > > > On 09/03/2023 00:03:04, Bjorn Helgaas wrote:
> > > > > > > > On Tue, Mar 07, 2023 at 12:22:44PM +0100, rec wrote:
> > > > > > > > > Like asked in :
> > > > https://www.kernel.org/doc/html/latest/PCI/msi-howto.html#disabling-msis-globally
> > > > > > >
> > > > > > > > Thanks for the report!  I assume this means your system has
> > > > problems
> > > > > > > > with MSIs, and booting with "pci=nomsi" makes it work better?
> > > > > > >
> > > > > > > You are welcome,
> > > > > > > The system doesn't boot completely without the "pci=nomsi"
> > > > option.
> > > > > >
> > > > > > What exactly do you mean by "it doesn't boot completely"?  I
> > > > compared
> > > > > > the two dmesg logs, and I see that the "with MSI" log also has the
> > > > > > "single" parameter, so it will only boot to single-user mode.
> > > > >
> > > > > It does it mean than either the boot stop or the system halt,
> > > > power-off
> > > > > before it can be possible to connect tty console or display manager.
> > > >
> > > > Wow.  I'm not sure what would cause a sudden halt or power-off like
> > > > that.  Is there any indication on the console when this happens?  Can
> > > > you try adding the following to your kernel boot parameters to see if
> > > > you can catch anything via a photo or video (you may have to adjust
> > > > the boot_delay to make things readable):
> > > >
> > > >   nosmp ignore_loglevel lpj=lpj=7000000 boot_delay=100
> > >
> > > It will be possible that is a fan problem with a cpu temperature.
> > > (Probably)
> > > I attach a video to the boot.
> > 
> > Thanks for this.  I should have asked at the very beginning whether
> > there are any older kernels that work correctly without "pci=nomsi".
> > If there is such an older kernel, we can try to figure out what change
> > broke it.  Otherwise, I'm running out of ideas.
> 
> I could remove this olde kernel 4. I dont know why i'm keeping this.
> The matter, i was not be able access to a Debian display manager
> with the kernel 5. Since kernel 6, from bookworm repertory, GNOME
> get fine.

I'm not sure what you mean.  I guess you mean that v4.x Linux kernels
didn't need "pci=nomsi"?

> > > > I'm curious about the Ricoh thing because I don't see an obvious MSI
> > > > connection.  Can you collect the output of "sudo lspci -vv"?  The
> > > > lspci output in your initial email wasn't collected as root, so it
> > > > doesn't include information about Capabilities (including MSI).
> > >
> > > Output of #lspci --vv attached
> > 
> > Thanks!  I was hoping something from lspci would connect with
> > ricoh_mmc_fixup_rl5c476(), where we get the "proprietary Ricoh MMC
> > controller" message, e.g., if that function looked at the MSI
> > Capability or something.  But 00:0d has four functions and none of
> > them has an MSI Capability.  And 00:0d.0 has nothing we know about at
> > the offsets the function uses:
> > 
> >   00:0d.0 FireWire (IEEE 1394): Ricoh Co Ltd R5C832
> >     Capabilities: [dc] Power Management version 2
> 
> Well, i Guess this 00:0d.0 FireWire is a link from bios CMOS memory
> adresse. Nothing Can be do without more informations from Ricoh Co
> Ltd R5C832 ?

I asked about this because when you boot with "pci=nomsi", your dmesg
log contains this:

  pci 0000:00:0d.0: proprietary Ricoh MMC controller disabled (via FireWire function)

This comes from ricoh_mmc_fixup_rl5c476(), and you *only* see it when
booting with "pci=nomsi".  So I was trying to figure out why
"pci=nomsi" would affect that function.  But I don't see anything that
relates them.

I'm trying to figure out what happens when you don't use "pci=nomsi".
Earlier you said the system doesn't boot completely.  But you *did*
manage to collect the journalctl log.  Do you mean you are able to log
in on the text console, but the graphical display manager doesn't
start?

Bjorn
