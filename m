Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702171248C0
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 14:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLRNxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 08:53:07 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:51038 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbfLRNxH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 08:53:07 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihZl9-0001g7-Pf; Wed, 18 Dec 2019 14:53:03 +0100
To:     Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] pcie: Add quirk for the Arm Neoverse N1SDP platform
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Dec 2019 13:53:02 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Jon Masters <jcm@jonmasters.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
In-Reply-To: <20191218102203.4078b011@donnerap.cambridge.arm.com>
References: <20191209160638.141431-1-andre.przywara@arm.com>
 <20191209162645.GA7489@willie-the-truck>
 <dacfd8bf-0f68-f2af-9238-4b0fadfbdfe3@jonmasters.org>
 <20191218102203.4078b011@donnerap.cambridge.arm.com>
Message-ID: <68c0c1e31ce72ab26eab7f1b077a302c@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: andre.przywara@arm.com, jcm@jonmasters.org, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, andrew.murray@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-12-18 10:22, Andre Przywara wrote:
> On Tue, 17 Dec 2019 21:21:17 -0500
> Jon Masters <jcm@jonmasters.org> wrote:
>
> Hi Jon,
>
>> On 12/9/19 11:26 AM, Will Deacon wrote:
>> > On Mon, Dec 09, 2019 at 04:06:38PM +0000, Andre Przywara wrote:
>> >> From: Deepak Pandey <Deepak.Pandey@arm.com>
>> >>
>> >> The Arm N1SDP SoC suffers from some PCIe integration issues, most
>> >> prominently config space accesses to not existing BDFs being 
>> answered
>> >> with a bus abort, resulting in an SError.
>> >
>> > "Do as I say, not as I do"?
>>
>> In my former role I asked nicely that these patches not be posted
>> upstream, but I see that they ended up being posted anyway. Hacking 
>> up
>> upstream Linux to cover for the fact that a (reference) platform is
>> non-standard is not only not good form but it actively harms the 
>> community.
>
> Please keep in mind that this platform was designed to be standards
> compliant, it is just due to an integration problem that this is not
> the case with this silicon. So we end up with the usual hardware
> errata, which the kernel can fix up. I agree it's not nice, and I 
> also
> want it fixed in hardware, but I guess that's the usual software 
> guy's
> pipe dream.
>
>> You'll have people consume this platform and not realize that it's
>> broken, IP won't get fixed, and generally it'll be a mess.
>
> I don't see how yet another ACPI quirk in the ACPI quirk framework(!)
> will make a mess.
> Actually the rest of the system is standards compliant (it even uses
> ACPI from the very beginning ;-), so it's just this problem that
> prevents us from using the system in the proper, standards compliant
> way. Effectively we are back to the embedded times with compiling 
> your
> own kernel and somehow getting a root filesystem on the hard drive.
> If there would be mainline kernel support, all of this would go away
> and would could use standard distro installers (given they backport
> the patch).
>
>> Yes, it's
>> unfortunate, but so was taping out that platform without working 
>> PCI. We
>> all know what should have happened, and what the right move ahead 
>> is.
>
> That may come as a surprise to some, but Arm Ltd. is actually not
> really in the business of *producing silicon*, so a respin of the 
> chip
> was and is not an option. I too wish it would be different, but 
> that's
> how it is.

In all honesty, I really wonder why we are even having this discussion:

- The HW is unavailable to the mere mortal. And even most superheroes
   cannot get their hands on it

- Even with this terrible son of a hack, essential PCIe features cannot
   work (and yes, I do consider SR-IOV as an essential feature)

- If we take this hack and somehow get this thing to run with mainline,
   we will never be able to say "no" to this kind of unfinished,
   *prototype* implementations ever again

To sum it up: a hack that doesn't really work for a prototype that you
can't really buy? Why should we even care?

         M.
-- 
Jazz is not dead. It just smells funny...
