Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2487011E5BD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 15:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfLMOjm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 09:39:42 -0500
Received: from foss.arm.com ([217.140.110.172]:33340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfLMOjm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 09:39:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03CA31435;
        Fri, 13 Dec 2019 06:39:41 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 808A73F52E;
        Fri, 13 Dec 2019 06:39:39 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:39:36 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pcie: Add quirk for the Arm Neoverse N1SDP platform
Message-ID: <20191213143936.2160dd9d@donnerap.cambridge.arm.com>
In-Reply-To: <20191212210723.GJ24359@e119886-lin.cambridge.arm.com>
References: <20191209160638.141431-1-andre.przywara@arm.com>
        <20191210144115.GA94877@google.com>
        <20191212210723.GJ24359@e119886-lin.cambridge.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 12 Dec 2019 21:07:24 +0000
Andrew Murray <andrew.murray@arm.com> wrote:

Hi,

> On Tue, Dec 10, 2019 at 08:41:15AM -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 09, 2019 at 04:06:38PM +0000, Andre Przywara wrote:  

[ ... ]

> > Even ECAM compliance is not really minor -- if this controller were
> > fully compliant with the spec, you would need ZERO Linux changes to
> > support it.  Every quirk like this means additional maintenance
> > burden, and it's not just a one-time thing.  It means old kernels that
> > *should* "just work" on your system will not work unless somebody
> > backports the quirk.  
> 
> With regards to URs resulting in unwanted aborts or similar - this seems
> to be a very common theme amongst ARM PCI controller drivers. For example
> both ARM32 imx6 and ARM32 keystone have fault handlers to handle an abort
> and fabricate a 0xffffffff read value.
> 
> The ARM32 rcar driver, whilst it doesn't appear to produce an abort, does
> read the PCI_STATUS register after making a config read to determine if
> any aborts have happened - in which case it reports
> PCIBIOS_DEVICE_NOT_FOUND.
> 
> And as recently reported [1], the rockchip driver also appears to produce
> aborts.
> 
> I suspect that this ARM64 controller driver won't be the last either. Thus
> any solution here may form the basis of copy-cat solutions for subsequent
> controllers.

Well, I think Bjorn is aware of them, but was actually hoping that those broken controllers would go away at some point ;-)
And just to make this clear: I would categorise this issue as an integration bug, which just can't be fixed in hardware or firmware easily. It was never meant to be this way. So I am not sure we should promote generic solutions here.

> From my understanding of the issues, the ARM64 serrors are imprecise and
> as a result there isn't a sensible way of using them to determine that a
> read is a UR. So where there are no other solutions to suppress the
> generation of an abort by the controller, the only solutions that seem to
> exist are 1) pre-scan the devices in firmware and only talk to those devices
> in Linux - a safe option but limiting - perhaps with side effects for CRS
> and 2) the approach rcar takes in using the PCI_STATUS register - though
> you'd end up having to mask the serror (PSTATE.A) for a limited period of
> time - a risky option (you'll miss real serrors) - but with no side effects.
> 
> (I don't know if option 2 is feasible in this case by the way).

Interesting, we might evaluate this, but mostly out of curiosity or for debugging. I don't think it's really a better option.
If there is a safe way of making this work in the majority of cases, that should be the way to go. Setting PSTATE.A sounds quite wacky to me.

Thanks,
Andre.

> [1] https://lore.kernel.org/linux-pci/2a381384-9d47-a7e2-679c-780950cd862d@rock-chips.com/2-0001-WFT-PCI-rockchip-play-game-with-unsupported-request-.patch
> 
> Thanks,
> 
> Andrew Murray
> 
> >   
> > > This allows the Arm Neoverse N1SDP board to boot Linux without crashing
> > > and to access *any* devices (there are no platform devices except UART).  

