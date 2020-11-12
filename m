Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF12B0ACB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 17:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgKLQ4P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 11:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgKLQ4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 11:56:15 -0500
X-Greylist: delayed 545 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Nov 2020 08:56:15 PST
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A7C0613D1
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 08:56:14 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id B23B8282269E4;
        Thu, 12 Nov 2020 17:47:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 80734D1743; Thu, 12 Nov 2020 17:47:05 +0100 (CET)
Date:   Thu, 12 Nov 2020 17:47:05 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: brcmstb: Restore initial fundamental reset
Message-ID: <20201112164705.GA20154@wunner.de>
References: <20201112131400.3775119-1-phil@raspberrypi.com>
 <883066bd-2a0c-f0d8-c556-7df0e73f0503@gmail.com>
 <CA+-6iNxc9UiEqFXj4jMJRXW1XAS7aB4hANa7mHRsK8++t2A18A@mail.gmail.com>
 <CAMEGJJ12UT5KN6G2-xZ4oHn4Dpj=_k77DW=Hb324HYabUyw4pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMEGJJ12UT5KN6G2-xZ4oHn4Dpj=_k77DW=Hb324HYabUyw4pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12, 2020 at 04:42:28PM +0000, Phil Elwell wrote:
> On Thu, 12 Nov 2020 at 16:28, Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > As for me considering that  this line is superfluous -- which
> > apparently it is not : AFAIK PERST# is always asserted from cold start
> > on all Brcm STB SOCs, and I expected the same on the RPi.  Asserting
> > PERST# at this point in time should be a no-op.  Is this not the case?
> 
> The reason it isn't superfluous here is that when using USB to boot,
> the Raspberry Pi BCM2711 firmware will already have configured the
> PCIe bus once, so another reset is necessary.

I think that begs the question why the firmware doesn't reset the
PCIe bus before handing over control to the kernel?

Thanks,

Lukas
