Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62954247F93
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 09:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHRHf7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 03:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgHRHf5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 03:35:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 012B72075E;
        Tue, 18 Aug 2020 07:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597736157;
        bh=FSflGG563MojbZsMsPV+BFtE2GMuiClJfxAeRJzUuWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rzu34fbstVr+KAaOvT8HP8j/3BLkFv/Vcs1C9A+4dmJ2xFWgth4FGUk5mmHVXSYOE
         IyB2jD+s7MusjkMTmGFNXJlUWzvvDYMvKu9a6UniNFZmoBC9cUy5JJANjpChQdNS2s
         6v3G/H+ZOKigLTAyGj5YBosyb5j25OJ8syXNsmjg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k7w9z-003pem-8P; Tue, 18 Aug 2020 08:35:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Aug 2020 08:35:55 +0100
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
In-Reply-To: <CAL_Jsq+fDNa60+6+s9MwVjUFUPAuc43+uMx4Fm2nZhUgrV7LEg@mail.gmail.com>
References: <20200815125112.462652-2-maz@kernel.org>
 <20200815232228.GA1325245@bjorn-Precision-5520>
 <87pn7qnabq.wl-maz@kernel.org>
 <CAL_Jsq+fDNa60+6+s9MwVjUFUPAuc43+uMx4Fm2nZhUgrV7LEg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <e2cde177e82fbdf158732ad73ccdc6c5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: robh@kernel.org, helgaas@kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, heiko@sntech.de, shawn.lin@rock-chips.com, bhelgaas@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-08-17 17:12, Rob Herring wrote:
> On Sun, Aug 16, 2020 at 4:40 AM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On Sun, 16 Aug 2020 00:22:28 +0100,
>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>> >
>> > On Sat, Aug 15, 2020 at 01:51:11PM +0100, Marc Zyngier wrote:
>> > > Recent changes to the DT PCI bus parsing made it mandatory for
>> > > device tree nodes describing a PCI controller to have the
>> > > 'device_type = "pci"' property for the node to be matched.
>> > >
>> > > Although this follows the letter of the specification, it
>> > > breaks existing device-trees that have been working fine
>> > > for years.  Rockchip rk3399-based systems are a prime example
>> > > of such collateral damage, and have stopped discovering their
>> > > PCI bus.
>> > >
>> > > In order to paper over the blunder, let's add a workaround
>> > > to the pcie-rockchip driver, adding the missing property when
>> > > none is found at boot time. A warning will hopefully nudge the
>> > > user into updating their DT to a fixed version if they can, but
>> > > the insentive is obviously pretty small.
>> >
>> > s/insentive/incentive/ (Lorenzo or I can fix this up)
>> >
>> > > Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
>> > > Suggested-by: Roh Herring <robh+dt@kernel.org>
>> >
>> > s/Roh/Rob/ (similarly)
>> 
>> Clearly not my day when it comes to proofreading commit messages.
>> Thanks for pointing this out, and in advance for fixing it up.
>> 
>> >
>> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
>> >
>> > This looks like a candidate for v5.9, since 2f96593ecc37 was merged
>> > during the v5.9 merge window, right?
>> 
>> Absolutely.
>> 
>> > I wonder how many other DTs are similarly broken?  Maybe Rob's DT
>> > checker has already looked?
>> 
>> I've just managed to run the checker, which comes up with all kinds of
>> goodies. Apart from the above, it also spots the following:
>> 
>> - arch/arm64/boot/dts/mediatek/mt7622.dtsi: Has a device_type property
>>   in its main PCIe node, but not in the child nodes. It isn't obvious
>>   to me whether that's a violation or not (the spec doesn't say
>>   whether the property should be set on a per-port basis). Rob?
> 
> The rule is bridge nodes should have 'device_type = "pci"'. But what's
> needed to fix these cases is setting device_type where we are parsing
> ranges or dma-ranges which we're not doing on the child ndes.
> Otherwise, I don't think it matters in this case unless you have child
> (grandchild here) nodes for PCI devices. If you did have child nodes,
> the address translation was already broken before this change.

Fair enough.

>> - arch/arm64/boot/dts/qcom/msm8996.dtsi: Only one out of the three
>>   PCIe nodes has the device_type property, probably broken similarly
>>   to rk3399.
> 
> The only upstream board is DB820c, so probably not as wide an impact...
> 
> There are also 92 (lots of duplicates due to multiple boards) more
> cases in arch/arm/. A log is here[1].

Mostly Broadcom stuff, apparently. I'll see if I can have a stab
at it (although someone will have to test it).

> 
>> I could move the workaround to drivers/pci/of.c, and have it called
>> from the individual drivers. I don't have the HW to test those though.
>> 
>> Thoughts?
> 
> I think we should go with my other suggestion of looking at the node
> name. Looks like just checking 'pcie' is enough. We can skip 'pci' as
> I don't see any cases.

I really dislike it.

Once we put this node name matching in, there is no incentive for
people to write their DT correctly at all. It also sound pretty
fragile (what if the PCIe node is named something else?).

My preference goes towards having point fixes in the affected drivers,
clearly showing that this is addressing a firmware bug.

         M.
-- 
Jazz is not dead. It just smells funny...
