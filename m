Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E104D11D844
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 22:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfLLVH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 16:07:28 -0500
Received: from foss.arm.com ([217.140.110.172]:60840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730742AbfLLVH2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Dec 2019 16:07:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BD2A328;
        Thu, 12 Dec 2019 13:07:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87EB43F718;
        Thu, 12 Dec 2019 13:07:26 -0800 (PST)
Date:   Thu, 12 Dec 2019 21:07:24 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pcie: Add quirk for the Arm Neoverse N1SDP platform
Message-ID: <20191212210723.GJ24359@e119886-lin.cambridge.arm.com>
References: <20191209160638.141431-1-andre.przywara@arm.com>
 <20191210144115.GA94877@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210144115.GA94877@google.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 10, 2019 at 08:41:15AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 09, 2019 at 04:06:38PM +0000, Andre Przywara wrote:
> > From: Deepak Pandey <Deepak.Pandey@arm.com>
> > 
> > The Arm N1SDP SoC suffers from some PCIe integration issues, most
> > prominently config space accesses to not existing BDFs being answered
> > with a bus abort, resulting in an SError.
> 
> Can we tease this apart a little more?  Linux doesn't program all the
> bits that control error signaling, so even on hardware that works
> perfectly, much of this behavior is determined by what firmware did.
> I wonder if Linux could be more careful about this.
> 
> "Bus abort" is not a term used in PCIe.  IIUC, a config read to a
> device that doesn't exist should terminate with an Unsupported Request
> completion, e.g., see the implementation note in PCIe r5.0 sec 2.3.1.
> 
> The UR should be an uncorrectable non-fatal error (Table 6-5), and
> Figures 6-2 and 6-3 show how it should be handled and when it should
> be signaled as a system error.  In case you don't have a copy of the
> spec, I extracted those two figures and put them at [1].
> 
> Can you collect "lspci -vvxxx" output to see if we can correlate it
> with those figures and the behavior you see?
> 
> [1] https://drive.google.com/file/d/1ihhdQvr0a7ZEJG-3gPddw1Tq7cTFAsah/view?usp=sharing
> 
> > To mitigate this, the firmware scans the bus before boot (catching the
> > SErrors) and creates a table with valid BDFs, which acts as a filter for
> > Linux' config space accesses.
> > 
> > Add code consulting the table as an ACPI PCIe quirk, also register the
> > corresponding device tree based description of the host controller.
> > Also fix the other two minor issues on the way, namely not being fully
> > ECAM compliant and config space accesses being restricted to 32-bit
> > accesses only.
> 
> As I'm sure you've noticed, controllers that support only 32-bit
> config writes are not spec compliant and devices may not work
> correctly.  The comment in pci_generic_config_write32() explains why.
> 
> You may not trip over this problem frequently, but I wouldn't call it
> a "minor" issue because when you *do* trip over it, you have no
> indication that a register was corrupted.
> 
> Even ECAM compliance is not really minor -- if this controller were
> fully compliant with the spec, you would need ZERO Linux changes to
> support it.  Every quirk like this means additional maintenance
> burden, and it's not just a one-time thing.  It means old kernels that
> *should* "just work" on your system will not work unless somebody
> backports the quirk.

With regards to URs resulting in unwanted aborts or similar - this seems
to be a very common theme amongst ARM PCI controller drivers. For example
both ARM32 imx6 and ARM32 keystone have fault handlers to handle an abort
and fabricate a 0xffffffff read value.

The ARM32 rcar driver, whilst it doesn't appear to produce an abort, does
read the PCI_STATUS register after making a config read to determine if
any aborts have happened - in which case it reports
PCIBIOS_DEVICE_NOT_FOUND.

And as recently reported [1], the rockchip driver also appears to produce
aborts.

I suspect that this ARM64 controller driver won't be the last either. Thus
any solution here may form the basis of copy-cat solutions for subsequent
controllers.

From my understanding of the issues, the ARM64 serrors are imprecise and
as a result there isn't a sensible way of using them to determine that a
read is a UR. So where there are no other solutions to suppress the
generation of an abort by the controller, the only solutions that seem to
exist are 1) pre-scan the devices in firmware and only talk to those devices
in Linux - a safe option but limiting - perhaps with side effects for CRS
and 2) the approach rcar takes in using the PCI_STATUS register - though
you'd end up having to mask the serror (PSTATE.A) for a limited period of
time - a risky option (you'll miss real serrors) - but with no side effects.

(I don't know if option 2 is feasible in this case by the way).

[1] https://lore.kernel.org/linux-pci/2a381384-9d47-a7e2-679c-780950cd862d@rock-chips.com/2-0001-WFT-PCI-rockchip-play-game-with-unsupported-request-.patch

Thanks,

Andrew Murray

> 
> > This allows the Arm Neoverse N1SDP board to boot Linux without crashing
> > and to access *any* devices (there are no platform devices except UART).
