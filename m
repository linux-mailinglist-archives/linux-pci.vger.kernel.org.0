Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39999184B7E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 16:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCMPrK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 11:47:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43883 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCMPrK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Mar 2020 11:47:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id a6so10507271otb.10;
        Fri, 13 Mar 2020 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2F6bNMNbjYMOmG6AT0+6XH/uYDDsMXrJ7rvJH7Wv54=;
        b=gAIDs6WqqY4C6m2b5QdZWRTmIT3xf9Ik6Np8m+/Z/J5ikCql9gM3IwFQvuOl178Nzr
         3IZ3HkdzXqzSrRImXqzs86OwH+pAqPX8nDIT3mW1Ilmq8XWcuyISAxCtav2E5OxoXkJd
         a2/19fycsXGRTcGjxcuP0a4HCJbtcxuT8E/3Qd61YjhSuJj8H7bt5BJQisMoSsu6OF3r
         8isHVQs3wlSr7wkc0M+N89U79Mnd2s08qw4ocvTBql6Eg+sDcwjF1Pu6TDMJAIo8zT6Y
         gfs62X7oCtBvDY2WKFVGT1I4sbyDSbi3FtifMvad/OCwI0ELcGXTZnGrLvH6ugFlEC4R
         c8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2F6bNMNbjYMOmG6AT0+6XH/uYDDsMXrJ7rvJH7Wv54=;
        b=XVE0VxwrCVLEO5V98fKz8acmFiGv/jUojnE2W++fOjpwFofD87GyP01HwEhGJ/j/vV
         NSQ92Bc3uFZBDBmw79VNs321qnswRbVk9pjaWHHZWQBsGSVhVlLUT312SGFLQ0Bsbp8E
         CEmm2f12k95wtqVAN5jBDSf7rAAzMtGprx3O/eZDgLzh/n3EKHlK6X4kkOhjgVbL9vAw
         N+hepm5fDcpOZ9JhNixxOF2XEv3tbUuxknh3PaaYbMA5TLQZzv1spsyRY0lqJVAxkX8d
         hjEqvZLbi8XCNvwNudE2cIdyM7imThEvEsH83z9yqARld5Zlf8rQjsJPosBN8UdJ1Pi7
         eYEw==
X-Gm-Message-State: ANhLgQ3TP83z58uukKKZiBgiYo8b/71g979ylFZ5hsJ/lwMLQShyJE52
        MlR+Y6ZO1GpjHT46BshifjfcsbLgkXA+ZvDoEUM=
X-Google-Smtp-Source: ADFU+vu760GpCPmD7yZUXlIQeGa3R1i+fs+y1tbGVZM1WMb4f80I+07TGxLiEF8SFrU09Xrxz1LyHjcMcOFDGWeTS2I=
X-Received: by 2002:a05:6830:20c9:: with SMTP id z9mr11632227otq.44.1584114429233;
 Fri, 13 Mar 2020 08:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 13 Mar 2020 15:46:42 +0000
Message-ID: <CA+V-a8vchrpa-1N1J+yVdo6-3zouOHX6=G4epWm68yirPirzag@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add support for PCIe controller to work in
 endpoint mode on R-Car SoCs
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn/Kishon,

On Fri, Feb 28, 2020 at 3:41 PM Lad Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> This patch series adds support for PCIe controller on rcar to work in
> endpoint mode, this also extends the epf framework to handle base region
> for mapping PCI address locally.
>
> Note:
> The cadence/rockchip/designware endpoint drivers are build tested only.
>
> Changes for v5:
> 1] Rebased the patches on next branch of https://git.kernel.org/pub/scm/
>    linux/kernel/git/helgaas/pci.git
> 2] Fixed review comments reported by Kishon while fetching the matching
>    window in function pci_epc_get_matching_window()
> 3] Fixed review comments reported by Bjorn
>    a] Split patch up first patch so that its easier to review and incremental
>    b] Fixed typos
> 4] Included Reviewed tag from Rob for the dt-binding patch
> 5] Fixed issue reported by Nathan for assigning variable to itself
>
> Changes for v4:
> 1] Fixed dtb_check error reported by Rob
> 2] Fixed review comments reported by Kishon
>    a] Dropped pci_epc_find_best_fit_window()
>    b] Fixed initializing mem ptr in __pci_epc_mem_init()
>    c] Dropped map_size from pci_epc_mem_window structure
>
> Changes for v3:
> 1] Fixed review comments from Bjorn and Kishon.
> 3] Converted to DT schema
>
> Changes for v2:
> 1] Fixed review comments from Biju for dt-bindings to include an example
>    for a tested platform.
> 2] Fixed review comments from Kishon to extend the features of outbound
>    regions in epf framework.
> 3] Added support to parse outbound-ranges in OF.
>
> Lad Prabhakar (7):
>   PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
>   PCI: rcar: Move shareable code to a common file
>   PCI: rcar: Fix calculating mask for PCIEPAMR register
>   PCI: endpoint: Add support to handle multiple base for mapping
>     outbound memory
>   dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
>     controller
>   PCI: rcar: Add support for rcar PCIe controller in endpoint mode
>   misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller
>
Gentle ping.

Cheers,
--Prabhakar Lad

>  .../devicetree/bindings/pci/rcar-pci-ep.yaml       |   76 ++
>  arch/arm64/configs/defconfig                       |    2 +-
>  drivers/misc/pci_endpoint_test.c                   |    3 +
>  drivers/pci/controller/Kconfig                     |   15 +-
>  drivers/pci/controller/Makefile                    |    3 +-
>  drivers/pci/controller/cadence/pcie-cadence-ep.c   |    7 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c    |   29 +-
>  drivers/pci/controller/pcie-rcar-ep.c              |  490 ++++++++
>  drivers/pci/controller/pcie-rcar-host.c            | 1053 +++++++++++++++++
>  drivers/pci/controller/pcie-rcar.c                 | 1229 +-------------------
>  drivers/pci/controller/pcie-rcar.h                 |  129 ++
>  drivers/pci/controller/pcie-rockchip-ep.c          |    7 +-
>  drivers/pci/endpoint/pci-epc-mem.c                 |  167 ++-
>  include/linux/pci-epc.h                            |   39 +-
>  14 files changed, 1985 insertions(+), 1264 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
>  create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
>  create mode 100644 drivers/pci/controller/pcie-rcar-host.c
>  create mode 100644 drivers/pci/controller/pcie-rcar.h
>
> --
> 2.7.4
>
