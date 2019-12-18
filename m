Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B8112445E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 11:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRKWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 05:22:08 -0500
Received: from foss.arm.com ([217.140.110.172]:40620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfLRKWI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Dec 2019 05:22:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A5FC30E;
        Wed, 18 Dec 2019 02:22:07 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F01C93F6CF;
        Wed, 18 Dec 2019 02:22:05 -0800 (PST)
Date:   Wed, 18 Dec 2019 10:22:03 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jon Masters <jcm@jonmasters.org>
Cc:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pcie: Add quirk for the Arm Neoverse N1SDP platform
Message-ID: <20191218102203.4078b011@donnerap.cambridge.arm.com>
In-Reply-To: <dacfd8bf-0f68-f2af-9238-4b0fadfbdfe3@jonmasters.org>
References: <20191209160638.141431-1-andre.przywara@arm.com>
        <20191209162645.GA7489@willie-the-truck>
        <dacfd8bf-0f68-f2af-9238-4b0fadfbdfe3@jonmasters.org>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 17 Dec 2019 21:21:17 -0500
Jon Masters <jcm@jonmasters.org> wrote:

Hi Jon,

> On 12/9/19 11:26 AM, Will Deacon wrote:
> > On Mon, Dec 09, 2019 at 04:06:38PM +0000, Andre Przywara wrote:  
> >> From: Deepak Pandey <Deepak.Pandey@arm.com>
> >>
> >> The Arm N1SDP SoC suffers from some PCIe integration issues, most
> >> prominently config space accesses to not existing BDFs being answered
> >> with a bus abort, resulting in an SError.  
> > 
> > "Do as I say, not as I do"?  
> 
> In my former role I asked nicely that these patches not be posted 
> upstream, but I see that they ended up being posted anyway. Hacking up 
> upstream Linux to cover for the fact that a (reference) platform is 
> non-standard is not only not good form but it actively harms the community.

Please keep in mind that this platform was designed to be standards compliant, it is just due to an integration problem that this is not the case with this silicon. So we end up with the usual hardware errata, which the kernel can fix up. I agree it's not nice, and I also want it fixed in hardware, but I guess that's the usual software guy's pipe dream.

> You'll have people consume this platform and not realize that it's 
> broken, IP won't get fixed, and generally it'll be a mess.

I don't see how yet another ACPI quirk in the ACPI quirk framework(!) will make a mess.
Actually the rest of the system is standards compliant (it even uses ACPI from the very beginning ;-), so it's just this problem that prevents us from using the system in the proper, standards compliant way. Effectively we are back to the embedded times with compiling your own kernel and somehow getting a root filesystem on the hard drive.
If there would be mainline kernel support, all of this would go away and would could use standard distro installers (given they backport the patch).

> Yes, it's 
> unfortunate, but so was taping out that platform without working PCI. We 
> all know what should have happened, and what the right move ahead is.

That may come as a surprise to some, but Arm Ltd. is actually not really in the business of *producing silicon*, so a respin of the chip was and is not an option. I too wish it would be different, but that's how it is.

Cheers,
Andre.
