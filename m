Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EEE29F540
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 20:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgJ2TaZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 15:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbgJ2TaZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Oct 2020 15:30:25 -0400
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED0D3204FD;
        Thu, 29 Oct 2020 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603999824;
        bh=MKfSe1ErAg1ensKCCgvIbXqQFpX3QbKj0Wf0wExX180=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LGGw3FyNE/xfEtfU/rXpitDOkY0ZfMTLXTYs/a8KLT1a8GuhRBUxbDvZUbaXUNegd
         NRlvRDcdC9bYCHInrsKlOyoDyO3dynfK5Y3UJ8M0PNjvQkHz2fM44z1yUnZ2gaznkx
         MReo3sAVrr2UfSvJOXuUpVz/KGYsPDG/m9vWKv2I=
Date:   Thu, 29 Oct 2020 14:30:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>, vtolkm@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201029193022.GA476048@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871rhhmgkq.fsf@toke.dk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 29, 2020 at 12:12:21PM +0100, Toke Høiland-Jørgensen wrote:
> Pali Rohár <pali@kernel.org> writes:

> > I have been testing mainline kernel on Turris Omnia with two PCIe
> > default cards (WLE200 and WLE900) and it worked fine. But I do not know
> > if I had ASPM enabled or not.
> >
> > So it is working fine for you when CONFIG_PCIEASPM is disabled and whole
> > issue is only when CONFIG_PCIEASPM is enabled?
> 
> Yup, exactly. And I'm also currently testing with the default WLE200/900
> cards... I just tried sticking an MT76-based WiFi card into the third
> PCI slot, and that doesn't come up either when I enable PCIEASPM.

Huh.  So IIUC, the following cases all try to retrain the link and it
fails to come up again:

  - aardvark + WLE900VX (see commit 43fc679ced18)
  - mvebu + WLE200
  - mvebu + WLE900
  - mvebu + MT76

In all these cases, Linux was able to enumerate the NIC, which means
the link was up when firmware handed it off.

I think Linux decided the Common Clock Configuration was wrong, so it
tried to fix it and retrain the link, and the link didn't come back
up.

I don't have "lspci -vv" output from all of them, but in vtolkm's
case, the firmware handed off with:

  00:02.0 Root Port to [bus 02]  SlotClk+ CommClk+
  02:00.0 QCA986x/988x NIC       SlotClk+ CommClk-

Per spec (PCIe r5, sec 7.5.3.7), SlotClk is HwInit and CommClk is RW
and should power up as 0.  If I'm reading the implementation note
correctly, if SlotClk is set on both ends of the link, software should
set CommClk, so the config above *does* look wrong, and CommClk+ on
the Root Port suggests that firmware set it.

I think both the aardvark and mvebu systems probably use U-Boot.  I
don't know U-Boot at all, but I don't see anything in it that touches
Link Control.  I'm curious what happens if you put one of these cards
in a PC.  If anybody tries it, please collect the "sudo lspci -vv" and
dmesg output.

We could quirk these NICs to avoid the retrain, but since aardvark and
mvebu have no obvious connection and WLE200/WLE900 and MT76 have no
obvious connection, I doubt there's a simple hardware defect that
explains all these.  

Maybe we're doing something wrong in the retrain, but obviously the
link came up in the first place.  AFAIK the only thing we're changing
is the CommClk setting, and that looks legitimate per spec.

Another experiment: build kernel without CONFIG_PCIEASPM, set $ROOT
and $NIC appropriately, and try the following:

  # Set $ROOT and $NIC (update to match your system):

    # ROOT=00:02.0
    # NIC=02:00.0

  # Dump the Root Port and NIC Link registers:

    # setpci -s$ROOT CAP_EXP+0xc.l              # Link Capabilities
    # setpci -s$ROOT CAP_EXP+0x10.w             # Link Control
    # setpci -s$ROOT CAP_EXP+0x12.w             # Link Status

    # setpci -s$NIC  CAP_EXP+0xc.l              # Link Capabilities
    # setpci -s$NIC  CAP_EXP+0x10.w             # Link Control
    # setpci -s$NIC  CAP_EXP+0x12.w             # Link Status

  # Retrain the link:

    # setpci -s$ROOT CAP_EXP+0x10.w=0x0020      # Link Control Retrain Link
    # sleep 1
    # setpci -s$ROOT CAP_EXP+0x12.w             # Link Status
    # setpci -s$NIC  CAP_EXP+0x12.w             # Link Status

  # Set CommClk+ and retrain the link:

    # setpci -s$NIC  CAP_EXP+0x10.w=0x0040      # Link Control Common Clock
    # setpci -s$ROOT CAP_EXP+0x10.w=0x0040      # Link Control Common Clock
    # setpci -s$ROOT CAP_EXP+0x10.w=0x0060      # Link Control RL + CC
    # sleep 1
    # setpci -s$ROOT CAP_EXP+0x12.w             # Link Status
    # setpci -s$NIC  CAP_EXP+0x12.w             # Link Status
