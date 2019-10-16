Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E6CD8C5A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 11:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404046AbfJPJQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 05:16:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391680AbfJPJQR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 05:16:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36DE5142F;
        Wed, 16 Oct 2019 02:16:16 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 357283F6C4;
        Wed, 16 Oct 2019 02:16:14 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:16:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PAXB INTx support with proper model
Message-ID: <20191016091607.GA22848@e121166-lin.cambridge.arm.com>
References: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
 <107116f2-a5ff-c545-1864-eb5885c4c60e@gmail.com>
 <88449493-4a32-1eda-434d-317b149173eb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88449493-4a32-1eda-434d-317b149173eb@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 10:28:24AM -0700, Florian Fainelli wrote:
> On 9/4/19 10:16 AM, Florian Fainelli wrote:
> > On 8/28/19 1:54 AM, Srinath Mannam wrote:
> >> This patch series adds PCIe legacy interrupt (INTx) support to the iProc
> >> PCIe driver by modeling it with its own IRQ domain. All 4 interrupts INTA,
> >> INTB, INTC, INTD share the same interrupt line connected to the GIC
> >> in the system. This is now modeled by using its own IRQ domain.
> >>
> >> Also update all relevant devicetree files to adapt to the new model.
> >>
> >> This patch set is based on Linux-5.2-rc4.
> >>
> >> Changes from v1:
> >>   - Addressed Rob, Lorenzo, Arnd's comments
> >>     - Used child node for interrupt controller.
> >>   - Addressed Andy Shevchenko's comments
> >>     - Replaced while loop with do-while.
> > 
> > Lorenzo, Bjorn, if you are good with the binding and PCI host driver
> > changes, you can take patches 1-2 through your tree, and I will queue up
> > the others through the Broadcom ARM SoC pull requests. If not, please
> > feel free to add a:
> > 
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> I am starting to queue Device Tree patches for 5.5 and I need to know
> whether I should be picking up patches 2 through 6, or if you are going
> to do this, thank you.

I am going to do this but I have comments on the patches they will
have to be updated anyway.

Thanks and apologies for the delay.

Lorenzo

> >> Ray Jui (6):
> >>   dt-bindings: pci: Update iProc PCI binding for INTx support
> >>   PCI: iproc: Add INTx support with better modeling
> >>   arm: dts: Change PCIe INTx mapping for Cygnus
> >>   arm: dts: Change PCIe INTx mapping for NSP
> >>   arm: dts: Change PCIe INTx mapping for HR2
> >>   arm64: dts: Change PCIe INTx mapping for NS2
> >>
> >>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  48 ++++++++--
> >>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |  30 ++++++-
> >>  arch/arm/boot/dts/bcm-hr2.dtsi                     |  30 ++++++-
> >>  arch/arm/boot/dts/bcm-nsp.dtsi                     |  45 ++++++++--
> >>  arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  28 +++++-
> >>  drivers/pci/controller/pcie-iproc.c                | 100 ++++++++++++++++++++-
> >>  drivers/pci/controller/pcie-iproc.h                |   6 ++
> >>  7 files changed, 260 insertions(+), 27 deletions(-)
> >>
> > 
> > 
> 
> 
> -- 
> Florian
