Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755A248432E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 15:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiADOSF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 09:18:05 -0500
Received: from foss.arm.com ([217.140.110.172]:59790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbiADOSF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jan 2022 09:18:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8E93ED1;
        Tue,  4 Jan 2022 06:18:04 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E671C3F774;
        Tue,  4 Jan 2022 06:18:02 -0800 (PST)
Date:   Tue, 4 Jan 2022 14:17:52 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>, bhelgaas@google.com
Cc:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v10 0/7] PCI: brcmstb: root port turns on sub-device power
Message-ID: <20220104141742.GA27804@lpieralisi>
References: <20211209211407.8102-1-jim2101024@gmail.com>
 <YbOf836C58fUSmCO@robh.at.kernel.org>
 <d659ec6c-ddf8-87b9-ebf1-b32c3730d038@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d659ec6c-ddf8-87b9-ebf1-b32c3730d038@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 10, 2021 at 12:31:10PM -0800, Florian Fainelli wrote:
> On 12/10/21 10:44 AM, Rob Herring wrote:
> > On Thu, Dec 09, 2021 at 04:13:58PM -0500, Jim Quinlan wrote:
> >> v10 -- Bindings commit example: in comment, refer to bridge under
> >>        controller node as a root port. (Pali)
> >>     -- Bindings commit example: remove three properties that are not
> >>        appropriate for a PCIe endpoint node. (Rob)
> >>
> >> v9  -- Simplify where this mechanism works: instead of looking for
> >>        regulators below every bridge, just look for them at the
> >>        bridge under the root bus (root port).  Now there is no
> >>        modification of portdrv_{pci,core}.c in this submission.
> >>     -- Although Pali is working on support for probing native
> >>        PCIe controller drivers, this work may take some time to
> >>        implement and it still might not be able to accomodate
> >>        our driver's requirements (e.g. vreg suspend/resume control).
> >>     -- Move regulator suspend/resume control to Brcm RC driver.  It
> >>        must reside there because (a) in order to know when to
> >>        initiate linkup during resume and (b) to turn on the
> >>        regulators before any config-space accesses occur.
> > 
> > You now have a mixture of 'generic' add/remove_bus hooks and the host 
> > controller suspend/resume managing the regulators. I think long term, 
> > the portdrv is going to be the right place for all of this with some 
> > interface defined for link control. So I think this solution moves 
> > sideways rather than towards anything common.
> > 
> > Unfortunately, the only leverage maintainers have to get folks to care 
> > about any refactoring is to reject features. We're lucky to find anyone 
> > to test refactoring when posted if done independently. There's a long 
> > list of commits of PCI hosts that I've broken to prove that. So it's 
> > up to Lorenzo and Bjorn on what they want to do here.
> 
> After version 10, it would seem pretty clear that we are still very much
> committed to and interested in getting that set merged and do it the
> most acceptable way possible. Common code with a single user is always a
> little bit of a grey area to me as it tends to be developed to cater for
> the specific needs of that single user, so the entire common aspect is
> debatable. I suppose as long as we have the binding right, the code can
> change at will.
> 
> Not trying to coerce Bjorn and Lorenzo into accepting these patches if
> they don't feel comfortable, but what about getting it included so we
> can sort of move on from that topic for a little bit (as we have other
> PCIe changes coming in, supporting additional chips etc.) and we work
> with Pali on a common solution and ensure it works on our pcie-brcmstb.c
> based devices? We are not going to vanish and not come back looking at this.

Sorry for being late on reviewing this set. I agree with both of you.

I don't think Bjorn had a chance to have a look at patch (4) now I am
delegating it to him; I am not very keen on adding functionality to PCI
core where it is still a question whether it can be reused by other
drivers (forgive me if I missed some details on previous review
versions).

Is it possible to keep patch (4) brcmstb specific (ie keep the code
out of PCI core for now), we then merge this series and help Pali
implement a generic version based on Rob's suggestion ?

Just let me know please, thanks.

Lorenzo
