Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE85FAB6
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2019 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfGDPO1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jul 2019 11:14:27 -0400
Received: from foss.arm.com ([217.140.110.172]:43758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfGDPO1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jul 2019 11:14:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74D9A2B;
        Thu,  4 Jul 2019 08:14:26 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E2FD3F703;
        Thu,  4 Jul 2019 08:14:25 -0700 (PDT)
Date:   Thu, 4 Jul 2019 16:14:20 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, treding@nvidia.com, swarren@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: tegra: Enable Relaxed Ordering only for Tegra20
 & Tegra30
Message-ID: <20190704151420.GA23921@e121166-lin.cambridge.arm.com>
References: <20190701110942.24305-1-vidyas@nvidia.com>
 <20190703161922.GA22679@e121166-lin.cambridge.arm.com>
 <be78c2c4-90bf-3c63-ace5-546e490c732c@nvidia.com>
 <20190704125547.GA17653@e121166-lin.cambridge.arm.com>
 <18fb7688-7c65-334f-8178-cc325b4a0e5b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18fb7688-7c65-334f-8178-cc325b4a0e5b@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 04, 2019 at 08:34:01PM +0530, Vidya Sagar wrote:
> On 7/4/2019 6:25 PM, Lorenzo Pieralisi wrote:
> > On Wed, Jul 03, 2019 at 10:20:23PM +0530, Vidya Sagar wrote:
> > > On 7/3/2019 10:09 PM, Lorenzo Pieralisi wrote:
> > > > On Mon, Jul 01, 2019 at 04:39:42PM +0530, Vidya Sagar wrote:
> > > > > Currently Relaxed Ordering bit in the configuration space is enabled for
> > > > > all devices, but, as per the Technical Reference Manual of Tegra20 which is
> > > > 
> > > > What devices ?
> > > All PCIe devices, because, current quirk uses PCI_ANY_ID for both Vendor-ID
> > > and Device-ID and that makes it applicable for all PCIe devices.
> > 
> > And this is true regardless of whether the PCI tegra controller is
> > *the* actual controller in the system, aka as long as the Tegra driver
> > is compiled in, relaxed ordering is forced for any PCIe device.
> > 
> > This is gross and I do believe the fix should be propagated back to
> > the commit that introduced it, it should have never been implemented
> > like this.
> Agree.
> This was there in the very first commit of this driver i.e.
> 77ffc1465cec32489889d6bc9c288b7b0d2ce9fb which added this driver for
> Tegra20 as arch/arm/mach-tegra/pcie.c Since there was no device-tree
> concept back then, could it be the case that this quirk comes into
> picture *only* if kernel is built for Tegra20 and not otherwise? Even
> then, I agree that using PCI_ANY_ID is quite wild way of applying a
> quirk.

This is an unadulterated mess. AFAICS, this quirk forces Relaxed
Ordering on any PCIe device on *any* ARM64 platform - DT and ACPI alike.

I will add a Fixes: tag and you must ensure this is backported,
I am not happy at all about this.

Lorenzo

> > > > > available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
> > > > > in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
> > > > > its root ports to avoid deadlock in hardware. The same is applicable for
> > > > > Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
> > > > > but the same should not be extended to root ports of other Tegra SoCs or
> > > > > other hosts.
> > > > 
> > > > Should not or must not ? What does this sentence mean ?
> > > I think it is 'must not' here. Since the hardware deadlock issue is not present
> > > in any other root ports other than Tegra20 and Tegra30, this quirk must not be
> > > extended to any other root ports.
> > > 
> > > > 
> > > > Can we try to be more precise please ?
> > > > 
> > > > As I said before the commit log must be clear to anyone reading it
> > > > even if he has no background information.
> > > Would the following work?
> > > 
> > > Currently Relaxed Ordering bit in the configuration space is enabled
> > > for all PCIe devices as the quirk uses PCI_ANY_ID for both Vendor-ID
> > > and Device-ID, but, as per the Technical Reference Manual of Tegra20
> > > which is available at
> > > https://developer.nvidia.com/embedded/downloads#?search=tegra%202 in
> > > Sec 34.1, it is mentioned that Relexed Ordering bit needs to be
> > > enabled in its root ports to avoid deadlock in hardware. The same is
> > > applicable for Tegra30 as well though it is not explicitly mentioned
> > > in Tegra30 TRM document, but the same must not be extended to root
> > > ports of other Tegra SoCs or other hosts as the same issue doesn't
> > > exist there.
> > 
> > More or less, I will tweak it myself. Regardless the way it is
> > handled at the moment is really really not acceptable, one more
> > reason why this patch should be backported IMO.
> > 
> > Lorenzo
> > 
> > > > Lorenzo
> > > > 
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > ---
> > > > > V2:
> > > > > * Modified commit message to include reference to Tegra20 TRM document.
> > > > > 
> > > > >    drivers/pci/controller/pci-tegra.c | 7 +++++--
> > > > >    1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> > > > > index 9cc03a2549c0..241760aa15bd 100644
> > > > > --- a/drivers/pci/controller/pci-tegra.c
> > > > > +++ b/drivers/pci/controller/pci-tegra.c
> > > > > @@ -787,12 +787,15 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
> > > > >    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_class);
> > > > >    DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_class);
> > > > > -/* Tegra PCIE requires relaxed ordering */
> > > > > +/* Tegra20 and Tegra30 PCIE requires relaxed ordering */
> > > > >    static void tegra_pcie_relax_enable(struct pci_dev *dev)
> > > > >    {
> > > > >    	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
> > > > >    }
> > > > > -DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
> > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_relax_enable);
> > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_relax_enable);
> > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_relax_enable);
> > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_relax_enable);
> > > > >    static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
> > > > >    {
> > > > > -- 
> > > > > 2.17.1
> > > > > 
> > > 
> 
