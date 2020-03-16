Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF2186ABE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 13:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgCPMTF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 08:19:05 -0400
Received: from foss.arm.com ([217.140.110.172]:47258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730902AbgCPMTF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 08:19:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACEBA30E;
        Mon, 16 Mar 2020 05:19:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8C83F52E;
        Mon, 16 Mar 2020 05:19:01 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:18:59 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 0/7] Add support for PCIe controller to work in
 endpoint mode on R-Car SoCs
Message-ID: <20200316121859.GB5043@e121166-lin.cambridge.arm.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8vchrpa-1N1J+yVdo6-3zouOHX6=G4epWm68yirPirzag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8vchrpa-1N1J+yVdo6-3zouOHX6=G4epWm68yirPirzag@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 13, 2020 at 03:46:42PM +0000, Lad, Prabhakar wrote:
> Hi Bjorn/Kishon,
> 
> On Fri, Feb 28, 2020 at 3:41 PM Lad Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > This patch series adds support for PCIe controller on rcar to work in
> > endpoint mode, this also extends the epf framework to handle base region
> > for mapping PCI address locally.
> >
> > Note:
> > The cadence/rockchip/designware endpoint drivers are build tested only.
> >
> > Changes for v5:
> > 1] Rebased the patches on next branch of https://git.kernel.org/pub/scm/
> >    linux/kernel/git/helgaas/pci.git
> > 2] Fixed review comments reported by Kishon while fetching the matching
> >    window in function pci_epc_get_matching_window()
> > 3] Fixed review comments reported by Bjorn
> >    a] Split patch up first patch so that its easier to review and incremental
> >    b] Fixed typos
> > 4] Included Reviewed tag from Rob for the dt-binding patch
> > 5] Fixed issue reported by Nathan for assigning variable to itself
> >
> > Changes for v4:
> > 1] Fixed dtb_check error reported by Rob
> > 2] Fixed review comments reported by Kishon
> >    a] Dropped pci_epc_find_best_fit_window()
> >    b] Fixed initializing mem ptr in __pci_epc_mem_init()
> >    c] Dropped map_size from pci_epc_mem_window structure
> >
> > Changes for v3:
> > 1] Fixed review comments from Bjorn and Kishon.
> > 3] Converted to DT schema
> >
> > Changes for v2:
> > 1] Fixed review comments from Biju for dt-bindings to include an example
> >    for a tested platform.
> > 2] Fixed review comments from Kishon to extend the features of outbound
> >    regions in epf framework.
> > 3] Added support to parse outbound-ranges in OF.
> >
> > Lad Prabhakar (7):
> >   PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
> >   PCI: rcar: Move shareable code to a common file
> >   PCI: rcar: Fix calculating mask for PCIEPAMR register
> >   PCI: endpoint: Add support to handle multiple base for mapping
> >     outbound memory
> >   dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
> >     controller
> >   PCI: rcar: Add support for rcar PCIe controller in endpoint mode
> >   misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller
> >
> Gentle ping.

You should ask the R-CAR maintainers first to have a look at your
code and ACK accordingly.

Lorenzo
