Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C9039935A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 21:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhFBTQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 15:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhFBTQk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 15:16:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D5A5613EA;
        Wed,  2 Jun 2021 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622661296;
        bh=9xSLMbvjfOnGtkRnLq693w5O8xbiW95iltXDEXpWTlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YO1LHbzG0NgS2UidWcUAg85nXU8ZjOoAhkkhnJsAUwlgP/kTNQEEISJbRymp7abj+
         anfuMAGAXcFOofqS77q/e3HVx13MuJJjzsDFa2g/MkG48Znu9wfwZvicv+Mti54wrT
         5g0BEA90O6/YMzP6t6K68E00Fk7QfwwH7k9ctR64x/j+dteHjm5o6AkQ3D+trusJIW
         FPjCFVWUTJyuOBPPr/CKk2b3Kx0sbObJkpAf1H1v9UsUNPJhjLgsbngAEbMKcC2oEk
         BS4HSNTepNQ7CqrTfRCBXtl6+3eqvgT8cTVedTf+T5aJLdKuS1OKIonigO+CELz15f
         TGw/q37Q8bO+Q==
Date:   Wed, 2 Jun 2021 14:14:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Stefan Chulski <stefanc@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Stefan Roese <sr@denx.de>, Phil Sutter <phil@nwl.cc>,
        Mario Six <mario.six@gdsys.cc>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [EXT] Re: pci mvebu issue (memory controller)
Message-ID: <20210602191455.GA2038253@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602110703.ymdt6nxsjl7e6glk@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 02, 2021 at 01:07:03PM +0200, Pali Rohár wrote:

> In configuration with *bad* suffix is used U-Boot which does not ignore
> PCIe device Memory controller and configure it when U-Boot initialize.
> In this configuration loaded kernel is unable to initialize wifi cards.
> 
> In configuration with *ok* suffix is U-Boot explicitly patched to
> ignores PCIe device Memory controller and loaded kernel can use wifi
> cards without any issue.
> 
> In both configurations is used same kernel version. As I wrote in
> previous emails kernel already ignores and hides Memory controller PCIe
> device, so lspci does not see it.
> 
> In attachment I'm sending dmesg and lspci outputs from Linux and pci
> output from U-Boot.
> 
> What is suspicious for me is that this Memory controller device is at
> the same bus as wifi card. PCIe is "point to point", so at the other end
> of link should be only one device... Therefore I'm not sure if kernel
> can handle such thing like "two PCIe devices" at other end of PCIe link.
> 
> Could you look at attached logs if you see something suspicious here? Or
> if you need other logs (either from U-Boot or kernel) please let me
> know.
> 
> Note that U-Boot does not see PCIe Bridge as it is emulated only by
> kernel. So U-Boot enumerates buses from zero and kernel from one (as
> kernel's bus zero is for emulated PCIe Bridges).

I've lost track of what the problem is or what patch we're evaluating.

Here's what I see from dmesg/lspci/uboot:

  # dmesg (both bad/ok) and lspci:
  00:01.0 [11ab:6820] Root Port to [bus 01]
  00:02.0 [11ab:6820] Root Port to [bus 02]
  00:03.0 [11ab:6820] Root Port to [bus 03]
  01:00.0 [168c:002e] Atheros AR9287 NIC
  02:00.0 [168c:0046] Atheros QCA9984 NIC
  03:00.0 [168c:003c] Atheros QCA986x/988x NIC

The above looks perfectly reasonable.

  # uboot (bad):
  00.00.00 [11ab:6820] memory controller
  00.01.00 [168c:002e] NIC
  01.00.00 [11ab:6820] memory controller
  01.01.00 [168c:0046] NIC
  02.00.00 [11ab:6820] memory controller
  02.01.00 [168c:003c] NIC

The above looks dubious at best.  Bus 00 clearly must be a root bus
because bus 00 can never be a bridge's secondary bus.

Either buses 01 and 02 need to also be root buses (e.g., if we had
three host bridges, one leading to bus 00, another to bus 01, and
another to bus 02), OR there must be Root Ports that act as bridges
leading from bus 00 to bus 01 and bus 02.  The "memory controllers"
are vendor/device ID [11ab:6820], which Linux thinks are Root Ports,
so I assume they are really Root Ports (or some emulation of them).

It's *possible* to have both a Root Port and a NIC on bus 0, as shown
here.  However, the NIC would have to be a Root Complex integrated
Endpoint, and this NIC ([168c:002e]) is not one of those.  It's a
garden-variety PCIe legacy endpoint connected by a link.  So this NIC
cannot actually be on bus 00.

All these NICs are PCIe legacy endpoints with links, so they all must
have a Root Port leading to them.  So this topology is not really
possible.

  # uboot (ok):
  00.00.00 [168c:002e] NIC
  01.00.00 [168c:0046] NIC
  02.00.00 [168c:003c] NIC

This topology is impossible from a PCI perspective because there's no
way to get from bus 00 to bus 01 or 02.
