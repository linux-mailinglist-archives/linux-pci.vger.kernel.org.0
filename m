Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A268D10521F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 13:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUMQt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 07:16:49 -0500
Received: from foss.arm.com ([217.140.110.172]:55370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKUMQt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 07:16:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92903328;
        Thu, 21 Nov 2019 04:16:48 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8133F703;
        Thu, 21 Nov 2019 04:16:47 -0800 (PST)
Date:   Thu, 21 Nov 2019 12:16:46 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, maz@kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        mbrugger@suse.com, phil@raspberrypi.org, jeremy.linton@arm.com,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/6] PCI: brcmstb: add Broadcom STB PCIe host
 controller driver
Message-ID: <20191121121646.GX43905@e119886-lin.cambridge.arm.com>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
 <20191112155926.16476-5-nsaenzjulienne@suse.de>
 <20191119162502.GS43905@e119886-lin.cambridge.arm.com>
 <8b5ea071-d7a1-ea31-c7fe-3b4585d9cc36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b5ea071-d7a1-ea31-c7fe-3b4585d9cc36@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 10:34:59AM -0800, Florian Fainelli wrote:
> On 11/19/19 8:25 AM, Andrew Murray wrote:
> > On Tue, Nov 12, 2019 at 04:59:23PM +0100, Nicolas Saenz Julienne wrote:
> >> From: Jim Quinlan <james.quinlan@broadcom.com>
> >>
> >> This commit adds the basic Broadcom STB PCIe controller.  Missing is the
> >> ability to process MSI. This functionality is added in a subsequent
> >> commit.
> >>
> >> The PCIe block contains an MDIO interface.  This is a local interface
> >> only accessible by the PCIe controller.  It cannot be used or shared
> >> by any other HW.  As such, the small amount of code for this
> >> controller is included in this driver as there is little upside to put
> >> it elsewhere.
> > 
> > This commit message hasn't changed, despite earlier feedback.
> 
> Please strip out large parts of the original patch that you are not
> quoting for future responses.
> 
> [snip]
> 
> > 
> > I'd rather see use of the pcie_cfg_data structure removed from this series.
> > 
> > I've seen the comments in the previous thread [1], and I understand that
> > the intention is that this driver will eventually be used for other SOCs.
> > 
> > However this indirection isn't needed *now* and it makes reviewing this
> > patch more difficult. If and when a later series is made to cover other
> > SOCs - then I'd expect that series to find a way to apply this indirection.
> 
> I am not completely sold on the difficulty to review given that the
> indirection is in place for only 3 registers which are used in only 3
> functions:
> 
> brcm_pcie_bridge_sw_init_set()
> brcm_pcie_perst_set()
> brcm_pcie_map_conf()
> 
> but if you think that is a deal breaker, then, okay, let's get rid of it
> and we will add it back for other STB SoCs in the future.

It's also about the context - This driver already has lots of indirection, lots
of macros, lots of defines, etc. And in that context this pcie_cfg_data adds
even more. It all adds to the complexity of understanding what the driver is
doing. Indirection often adds value - but I don't yet see that here.

I'd like to see it removed.

> 
> > 
> > And if that later series is more difficult to review because of the newly
> > added indirection, then I'd expect an early patch of that series to apply
> > the indirection in a single patch - which would be easy to review.
> > 
> > The other risk of such premature changes like this is that when you come
> > to adding other SOCs, you may then discover that there were shortcomings
> > in the way you've approached it here.
> 
> 2711 is the latest SoC that has actually been supported by this driver,

I appreciate that this is frustrating - taking a complete driver that supports
lots of platforms and then stripping it down for review one platform at a time.
It also means removing all the indirection and abstraction that will likely
later be required. Only to have to add it back in on the second platform.

But those subsequent patches aren't available for review, we don't know if
they will make it into the kernel or how long that will take. And we don't
want to be left with maintaining a Pi only driver that has lots of unnecessary
code that it is more difficult to understand than it needs to be.

> every other ones that this driver will support in the future has been in
> production for years and all the quirks/subtleties are known. This means
> that 2711 was added while fitting in the existing abstraction and
> Nicholas took out every other chip to leave 2711 only.

I'm not referring to the quirks in the hardware - it may be that when you
update this driver to add another SoC (on the list) - others reviewers
may not agree with the method of abstraction, or find some issue with it.
Yet until the abstraction can be reviewed in the context of support for the
next SoC it's hard to tell.

Thanks,

Andrew Murray

> -- 
> Florian
