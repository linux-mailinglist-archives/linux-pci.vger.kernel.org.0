Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9447360465
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 10:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhDOIhG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 04:37:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhDOIhG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 04:37:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BCD06105A;
        Thu, 15 Apr 2021 08:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618475803;
        bh=/z+DiHu2gjNfvnCahqiPqFCMARaDeKT5rduKLDW4FxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dv7GhPqiIkzwF+Zzu5K10tkK+CLz2K3U6KV+1DIlhZd6qXlcGZYn8Qy7hPi5L9a9P
         zd7++dShkgUxSg/kPLJCb1RfzNqrZF5sOuLDgziYKFAKKZqSYQT7gkl0uGt/pGn8Ox
         Ze+yrvYtLmk8YfuvaatCsPfSf8uo7dx3pqqLE5XM3wDM1yx5OVQTFfR/FNqPnK4wtY
         iX8TU8f2DB2bShDCrZpjOA3l3oKlNO57g0PGtabvG51coLC3iW+1Q5honqq/13Gs4e
         4U/M+GLGPzLxmtZLA0XIgqyK+GJD+Y4xmdyIAMNHHeiBMJ6RXJLCWQRuCEeZx+6yaE
         t1p+NqY0iLbMw==
Received: by pali.im (Postfix)
        id 12F6DAF7; Thu, 15 Apr 2021 10:36:40 +0200 (CEST)
Date:   Thu, 15 Apr 2021 10:36:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Set linux,pci-domain
 to zero
Message-ID: <20210415083640.ntg6kv6ayppxldgd@pali>
References: <20210412123936.25555-1-pali@kernel.org>
 <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 13 April 2021 13:17:29 Rob Herring wrote:
> On Mon, Apr 12, 2021 at 7:41 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > Since commit 526a76991b7b ("PCI: aardvark: Implement driver 'remove'
> > function and allow to build it as module") PCIe controller driver for
> > Armada 37xx can be dynamically loaded and unloaded at runtime. Also driver
> > allows dynamic binding and unbinding of PCIe controller device.
> >
> > Kernel PCI subsystem assigns by default dynamically allocated PCI domain
> > number (starting from zero) for this PCIe controller every time when device
> > is bound. So PCI domain changes after every unbind / bind operation.
> 
> PCI host bridges as a module are relatively new, so seems likely a bug to me.

Why a bug? It is there since 5.10 and it is working.

> > Alternative way for assigning PCI domain number is to use static allocated
> > numbers defined in Device Tree. This option has requirement that every PCI
> > controller in system must have defined PCI bus number in Device Tree.
> 
> That seems entirely pointless from a DT point of view with a single PCI bridge.

If domain id is not specified in DT then kernel uses counter and assigns
counter++. So it is not pointless if we want to have stable domain id.

> > Armada 37xx has only one PCIe controller, so assign for it PCI domain 0 in
> > Device Tree.
> >
> > After this change PCI domain on Armada 37xx is always zero, even after
> > repeated unbind and bind operations.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
> > ---
> >  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > index 7a2df148c6a3..f02058ef5364 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > @@ -495,6 +495,7 @@
> >                                         <0 0 0 2 &pcie_intc 1>,
> >                                         <0 0 0 3 &pcie_intc 2>,
> >                                         <0 0 0 4 &pcie_intc 3>;
> > +                       linux,pci-domain = <0>;
> >                         max-link-speed = <2>;
> >                         phys = <&comphy1 0>;
> >                         pcie_intc: interrupt-controller {
> > --
> > 2.20.1
> >
