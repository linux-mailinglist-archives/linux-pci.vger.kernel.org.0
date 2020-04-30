Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1751BF33A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 10:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgD3Ins (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 04:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726780AbgD3Inr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 04:43:47 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24BEC035494;
        Thu, 30 Apr 2020 01:43:47 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id e18so1100052oot.9;
        Thu, 30 Apr 2020 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJfi8YEQRUQ7Nx9/zDtTwBKV3TKprwuNVW7KwyjiUoc=;
        b=e7I7Q+7VKNBFCc1ou225/A0eOoID6/aWYUAFnRX/+iDZKw7DSHwIPwW1x5AgKniBbb
         jjiRPiLT0bfCFJCEIeXzYQaLiByhMHFrojdlukrxCxJHfJvRxD2JLRwY0Kw4GcWzKgpv
         KyJIdFjDrHQsaWD3gm7ISrflX9rpalM8JsR1CWNzYHpTtOI+KW0+JOQR8C+opcFQXjF6
         S/c6OobDxj2DTU96pUr/bL0pQIjEijtQXxGdF8RHIG5kuPZ4fALdJeOBf6CUQYRwB8+l
         wjZc0cjh7D9rXMdwkVPY5DweLztFSz83g67f1JnSombDq/ads5UK12j7sNeq5Hwuqqsr
         8JFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJfi8YEQRUQ7Nx9/zDtTwBKV3TKprwuNVW7KwyjiUoc=;
        b=NuS8gXY6Li3+V9zsGtYMZSi0op4nTQ3hhTh3r5PBBGB4EtnQdrM3zmJpZwRGgtWmgP
         7a/F/kxZthf//VK22wKK9N16gDDHIQPi5pckcuERksfL52liYnBTbvQP3FOYcL+nsnI/
         4j7A3QMyJtOf7AcOIiyHhZ/da2bzjzCXKnRYCc9osLxsphTdzq/1oCj3O7uCr1161wUl
         ZAeJDOyjFwvZZ2LavCLHOI8MfD503/hsaeVJbU3yc4XgQ+GnISlojgAWGgOoOm/JB/Gp
         Ama9YJg43e/HB54dRwS+KUtH3PfVPDk7y3+DJaqelRt9MZREMMONI1Qgpc9cvOmdZs3Z
         g+Zw==
X-Gm-Message-State: AGi0PuYJDnujA47fVGTS/G9mR8GRcoY4kybaRf1h+rl5u+gXiUk0HsMa
        C7LeYLKxRuYagRr+vT3GhHIUher0iStZtTp5XEk=
X-Google-Smtp-Source: APiQypLSZyNqZBc6As1bQvkl0M72z9Bu+wI/WiD4xkyor99UzGV3HeSXzgXCRuS0Ua8uSVnQTYGN2BiezF0okRKwwuY=
X-Received: by 2002:a4a:a209:: with SMTP id m9mr1879725ool.62.1588236226990;
 Thu, 30 Apr 2020 01:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 30 Apr 2020 09:43:20 +0100
Message-ID: <CA+V-a8u1rEF1DMAVkZ1=-d_MjLa_49X2Nny_VaEN0Y398GOJhw@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] Add endpoint driver for R-Car PCIe controller
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Thu, Apr 23, 2020 at 7:23 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Hi All,
>
> This patch series adds support for endpoint driver for R-Car PCIe controller on
> R-Car/RZ-G2x SoC's, this also extends the epf framework to handle multiple windows
> supported by the controller for mapping PCI address locally.
>
> Note:
> The cadence/rockchip/designware endpoint drivers are build tested only.
>
> Changes for v9 (Re-spun this series as there were minimal changes requested):
> * Rebased patches on top of v5.7.rc1
> * Replaced mdelay(1) with usleep_range(1000, 1001) in rcar_pcie_ep_assert_intx()
> * Added a check for max_functions read from DT to restrict with
>   RCAR_EPC_MAX_FUNCTIONS
> * Replaced MSICAP0_MMENUM with MSICAP0_MMESE
> * Retry ioremap for other windows on failure in pci_epc_mem_alloc_addr()
> * Fixed looping for number windows in pci_epc_mem_exit()
> * Set maximum to 1 for max-functions in DT binding (I have restored the acks
>   from  Rob and Shimoda-san)
> * Sorted the entry in MAINTAINERS
>
> Changes for v8:
> * Dropped adding R8A774C0 (0x002d) pci-id in pci_ids.h
> * Fixed typo in commit message for patch 2/8
> * Reworded commit message for patch 5/8 as suggested by Bjorn
> * Split up patch to add pci_epc_mem_init() interface to add page_size argument
>   as suggested by Bjorn.
>
> Changes for v7:
> * Fixed review comments pointed by Shimoda-san
>   1] Made DT bindings dual licensed, added Shimoda-san as maintainer and fixed
>      the example as its built with #{address,size}-cells = <1>. I have still
>      restored the Ack from Rob and Shimoda-san with these changes.
>   2] Split up the patches so that they can be picked up by respective subsystem
>      patches 1/4-9/11 are now part of this series.
>   3] Dropped altering a comment in pci-epc.h
>   4] Used a local variable align_size in pci_epc_mem_alloc_addr() so that size
>      variable doesn't get overwritten in the loop.
>   5] Replaced i-=1 with i--
>   6] Replaced rcar with R-Car in patch subject and description.
>   7] Set MACCTLR in init() callback
>
> Changes for v6:
> 1] Rebased patches on endpoint branch of https://git.kernel.org/pub/
>    scm/linux/kernel/git/lpieralisi/pci.git/
> 2] Fixed review comments from Shimoda-san
>    a] Made sure defconfig changes were in separate patch
>    b] Created rcar_pcie_host/rcar_pcie_ep structures
>    c] Added pci-id for R8A774C0
>    d] Added entry in MAINTAINERS for dt-binding
>    e] Dropped unnecessary braces
> 3] Added support for msi.
>
> Changes for v5:
> 1] Rebased patches on next branch of https://git.kernel.org/pub/scm/
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
> Lad Prabhakar (8):
>   PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
>   PCI: rcar: Move shareable code to a common file
>   PCI: rcar: Fix calculating mask for PCIEPAMR register
>   PCI: endpoint: Pass page size as argument to pci_epc_mem_init()
>   PCI: endpoint: Add support to handle multiple base for mapping
>     outbound memory
Could you please do the needy for the above two patches, so that this
can be picked up by Lorenzo.

Cheers,
--Prabhakar

>   dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
>     controller
>   PCI: rcar: Add endpoint mode support
>   MAINTAINERS: Add file patterns for rcar PCI device tree bindings
>
>  .../devicetree/bindings/pci/rcar-pci-ep.yaml  |   77 ++
>  MAINTAINERS                                   |    1 +
>  drivers/pci/controller/Kconfig                |   18 +
>  drivers/pci/controller/Makefile               |    3 +-
>  .../pci/controller/cadence/pcie-cadence-ep.c  |    2 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |   16 +-
>  drivers/pci/controller/pcie-rcar-ep.c         |  557 ++++++++
>  drivers/pci/controller/pcie-rcar-host.c       | 1065 +++++++++++++++
>  drivers/pci/controller/pcie-rcar.c            | 1206 +----------------
>  drivers/pci/controller/pcie-rcar.h            |  140 ++
>  drivers/pci/controller/pcie-rockchip-ep.c     |    2 +-
>  drivers/pci/endpoint/pci-epc-mem.c            |  204 ++-
>  include/linux/pci-epc.h                       |   38 +-
>  13 files changed, 2078 insertions(+), 1251 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
>  create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
>  create mode 100644 drivers/pci/controller/pcie-rcar-host.c
>  create mode 100644 drivers/pci/controller/pcie-rcar.h
>
> --
> 2.17.1
>
