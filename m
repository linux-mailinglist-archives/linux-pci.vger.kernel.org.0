Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A412248D08
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgHRRes (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 13:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbgHRRel (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 13:34:41 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15B5820674;
        Tue, 18 Aug 2020 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597772080;
        bh=nACaTkW7CDmrUJbnvOXm0y+Culo0AkO1X5rQHrNGYDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E4at6GP88PCCK3vA5rh6n3r6/gW2frOyrBE89rp/3bPNSK0gx9kSKNvLD/0UhYQk5
         hLEREaQnbeWiUdmAMS5AHd7D3xvVJ0Rwznp992cOVvTZi1YazOoHdWhW4LYQS9wsO3
         LUq35VYP0r/flJAWnGuB53UrSmRMH9D75hrM3gaE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k85VO-003yjs-IP; Tue, 18 Aug 2020 18:34:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Aug 2020 18:34:38 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] PCI: rockchip: Work around missing device_type
 property in DT
In-Reply-To: <CAL_JsqL1_d2grS3Pz6NNeVAOMPbx_hAe+MrseQeQp=bHRQ7rfQ@mail.gmail.com>
References: <20200815125112.462652-2-maz@kernel.org>
 <20200815232228.GA1325245@bjorn-Precision-5520>
 <87pn7qnabq.wl-maz@kernel.org>
 <CAL_Jsq+fDNa60+6+s9MwVjUFUPAuc43+uMx4Fm2nZhUgrV7LEg@mail.gmail.com>
 <e2cde177e82fbdf158732ad73ccdc6c5@kernel.org>
 <CAL_JsqL1_d2grS3Pz6NNeVAOMPbx_hAe+MrseQeQp=bHRQ7rfQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <72c10e43023289b9a4c36226fe3fd5d9@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: robh@kernel.org, helgaas@kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, heiko@sntech.de, shawn.lin@rock-chips.com, bhelgaas@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-08-18 15:23, Rob Herring wrote:
> On Tue, Aug 18, 2020 at 1:35 AM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2020-08-17 17:12, Rob Herring wrote:
>> > On Sun, Aug 16, 2020 at 4:40 AM Marc Zyngier <maz@kernel.org> wrote:
>> >>
>> >> On Sun, 16 Aug 2020 00:22:28 +0100,
>> >> Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >> >
>> >> > On Sat, Aug 15, 2020 at 01:51:11PM +0100, Marc Zyngier wrote:
>> >> > > Recent changes to the DT PCI bus parsing made it mandatory for
>> >> > > device tree nodes describing a PCI controller to have the
>> >> > > 'device_type = "pci"' property for the node to be matched.
>> >> > >
>> >> > > Although this follows the letter of the specification, it
>> >> > > breaks existing device-trees that have been working fine
>> >> > > for years.  Rockchip rk3399-based systems are a prime example
>> >> > > of such collateral damage, and have stopped discovering their
>> >> > > PCI bus.
>> >> > >
>> >> > > In order to paper over the blunder, let's add a workaround
>> >> > > to the pcie-rockchip driver, adding the missing property when
>> >> > > none is found at boot time. A warning will hopefully nudge the
>> >> > > user into updating their DT to a fixed version if they can, but
>> >> > > the insentive is obviously pretty small.
>> >> >
>> >> > s/insentive/incentive/ (Lorenzo or I can fix this up)
>> >> >
>> >> > > Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
>> >> > > Suggested-by: Roh Herring <robh+dt@kernel.org>
>> >> >
>> >> > s/Roh/Rob/ (similarly)
>> >>
>> >> Clearly not my day when it comes to proofreading commit messages.
>> >> Thanks for pointing this out, and in advance for fixing it up.
>> >>
>> >> >
>> >> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
>> >> >
>> >> > This looks like a candidate for v5.9, since 2f96593ecc37 was merged
>> >> > during the v5.9 merge window, right?
>> >>
>> >> Absolutely.
>> >>
>> >> > I wonder how many other DTs are similarly broken?  Maybe Rob's DT
>> >> > checker has already looked?
>> >>
>> >> I've just managed to run the checker, which comes up with all kinds of
>> >> goodies. Apart from the above, it also spots the following:
>> >>
>> >> - arch/arm64/boot/dts/mediatek/mt7622.dtsi: Has a device_type property
>> >>   in its main PCIe node, but not in the child nodes. It isn't obvious
>> >>   to me whether that's a violation or not (the spec doesn't say
>> >>   whether the property should be set on a per-port basis). Rob?
>> >
>> > The rule is bridge nodes should have 'device_type = "pci"'. But what's
>> > needed to fix these cases is setting device_type where we are parsing
>> > ranges or dma-ranges which we're not doing on the child ndes.
>> > Otherwise, I don't think it matters in this case unless you have child
>> > (grandchild here) nodes for PCI devices. If you did have child nodes,
>> > the address translation was already broken before this change.
>> 
>> Fair enough.
>> 
>> >> - arch/arm64/boot/dts/qcom/msm8996.dtsi: Only one out of the three
>> >>   PCIe nodes has the device_type property, probably broken similarly
>> >>   to rk3399.
>> >
>> > The only upstream board is DB820c, so probably not as wide an impact...
>> >
>> > There are also 92 (lots of duplicates due to multiple boards) more
>> > cases in arch/arm/. A log is here[1].
>> 
>> Mostly Broadcom stuff, apparently. I'll see if I can have a stab
>> at it (although someone will have to test it).
>> 
>> >
>> >> I could move the workaround to drivers/pci/of.c, and have it called
>> >> from the individual drivers. I don't have the HW to test those though.
>> >>
>> >> Thoughts?
>> >
>> > I think we should go with my other suggestion of looking at the node
>> > name. Looks like just checking 'pcie' is enough. We can skip 'pci' as
>> > I don't see any cases.
>> 
>> I really dislike it.
>> 
>> Once we put this node name matching in, there is no incentive for
>> people to write their DT correctly at all. It also sound pretty
>> fragile (what if the PCIe node is named something else?).
> 
> That would require 2 wrongs. Both missing device_type and wrong node
> name. You could still warn if we matched on node name.

OK. So how about something like this?

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 590493e04b01..a7a6ee599b14 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -134,9 +134,13 @@ static int of_bus_pci_match(struct device_node *np)
   	 * "pciex" is PCI Express
  	 * "vci" is for the /chaos bridge on 1st-gen PCI powermacs
  	 * "ht" is hypertransport
+	 *
+	 * If none of the device_type match, and that the node name is
+	 * "pcie", accept the device as PCI (with a warning).
  	 */
  	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
-		of_node_is_type(np, "vci") || of_node_is_type(np, "ht");
+		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
+		WARN_ON_ONCE(of_node_name_eq(np, "pcie"));
  }

  static void of_bus_pci_count_cells(struct device_node *np,

It should address all the drivers in one go, and yet tell users
that something is amiss.

         M.
-- 
Jazz is not dead. It just smells funny...
