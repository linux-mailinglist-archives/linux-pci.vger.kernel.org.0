Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90E10A059
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 15:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfKZOdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 09:33:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45561 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZOdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2019 09:33:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id 14so16768741oir.12;
        Tue, 26 Nov 2019 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Ke9S+LOVhCSYY/a2D7Vlzb4JuZDRi+EFqSopQYxhvo=;
        b=nj3w38bZg0AIusIt49/mQa4MqrbC8q2I1Gu83u5RhH7p+9zwD+Obg3mc8Ug/E3RIb/
         +OpcBhlBKwiMWWTUHfcBQZyeyJz/QqfNgm/pXQV5UjZAycKx19JMKo1IcGDqKLKpF6bB
         No4+dTgPNLBOUdswSF4JHl4Dco+G6DFR8+iujV3/usRywxvytpKcvu7kIqJoKLvNd29Z
         Yi8AevjDxVXldLY7R688l+AMMCXFEMYWdSEr/v/cJg5qcQnIrNOGWI2F/Fm8A+qDaACI
         ixM6YFWfxrFm2YmbDY5ct9hWCQlaGsMP5kzcnfllU6KHNE9RUkUrY0KoD6Qlxu31qLVC
         zO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ke9S+LOVhCSYY/a2D7Vlzb4JuZDRi+EFqSopQYxhvo=;
        b=t+Pm9UxCF1utiCD68wr5AjTUy4s72vesd+rqnTYY2/1d7lnvLhasJIuQ298ciRQqMj
         VzCx19k6V5I6gvOS/KIwO9mEysB4VGJXcGi9Ckx8dvBWekrSwydQ8A0SPxkFfvMCdjiq
         hqe1BaCoFoo7f13fW2r8U7LZhSw6Vp8ArhSUe0jmY9AAhrqeEKOxnYn5UOgxviOVJ3oc
         S6UD7UZ28GZl4ONb3BKpCJgs6pPXEAVVKwrqvljEjNm3UhXB9wXexfLTDg7b0opFTX/S
         nDmKouqmLuDeJ35btOtqylvomtVnZhWu33IIJI3kvpiBr1ZCiZKtHJ3W9BcnhonjkD1U
         aVAg==
X-Gm-Message-State: APjAAAU9HOGJE0SyJhRBMaOIt4y3Iqoe+svXRQCXz9zi9R95GlX3ZF99
        zYDC7WOb6rWbtgFuR2SAQC1PMUtZ+2oVxGysENo=
X-Google-Smtp-Source: APXvYqwdIx5fvcr/2eqn6PfsjTtnTEUauTJoJlXG+zzhycInNXig/nGBmY7EZu2DrNnThSLkOUcAJwQqVld3E5i8yP8=
X-Received: by 2002:a05:6808:906:: with SMTP id w6mr3714280oih.162.1574778831671;
 Tue, 26 Nov 2019 06:33:51 -0800 (PST)
MIME-Version: 1.0
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 26 Nov 2019 14:33:25 +0000
Message-ID: <CA+V-a8tVK7oUYggTb5Vi3agMp4CH8gtiKDHet09DzE5-LAfiew@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add support for PCIe controller to work in endpoint
 mode on R-Car SoCs.
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn/Kishon,

Gentle ping for this patch set.

On Wed, Nov 6, 2019 at 7:36 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This patch series adds support for PCIe controller on rcar to work in endpoint mode,
> this also extends the epf framework to handle multiple outbound regions.
>
Cheers,
--Prabhakar Lad


> Note:
> The cadence/rockchip/designware endpoint drivers are build tested only.
>
> Endpoint configuration:
> $ cd /sys/kernel/config/pci_ep
> $ mkdir functions/pci_epf_test/func1
> $ echo 0x1912 > functions/pci_epf_test/func1/vendorid
> $ echo 0x002d > functions/pci_epf_test/func1/deviceid
> $ echo 32 > functions/pci_epf_test/func1/msi_interrupts
> $ ln -s functions/pci_epf_test/func1/ controllers/fe000000.pcie_ep/
> $ echo 1 > controllers/fe000000.pcie_ep/start
>
> Host side results:
> lspci output:
> 01:00.0 Unassigned class [ff00]: Renesas Technology Corp. Device 002d
>         Flags: bus master, fast devsel, latency 0, IRQ 103
>         Memory at fe200200 (64-bit, non-prefetchable) [size=128]
>         Memory at fe200000 (64-bit, non-prefetchable) [size=256]
>         Memory at fe200100 (64-bit, non-prefetchable) [size=256]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>         Capabilities: [70] Express Endpoint, MSI 00
>         Capabilities: [100] Virtual Channel
>         Kernel driver in use: pci-endpoint-test
>
> pcitest results:
>
> BAR tests
>
> BAR0:           OKAY
> BAR1:           NOT OKAY
> BAR2:           OKAY
> BAR3:           NOT OKAY
> BAR4:           OKAY
> BAR5:           NOT OKAY
>
> Interrupt tests
>
> SET IRQ TYPE TO LEGACY:         OKAY
> LEGACY IRQ:     OKAY
> Read Tests
>
> SET IRQ TYPE TO LEGACY:         OKAY
> READ (      1 bytes):           OKAY
> READ (   1024 bytes):           OKAY
> READ (   1025 bytes):           OKAY
> READ (1024000 bytes):           OKAY
> READ (1024001 bytes):           OKAY
>
> Write Tests
>
> WRITE (      1 bytes):          OKAY
> WRITE (   1024 bytes):          OKAY
> WRITE (   1025 bytes):          OKAY
> WRITE (1024000 bytes):          OKAY
> WRITE (1024001 bytes):          OKAY
>
> Copy Tests
>
> COPY (      1 bytes):           OKAY
> COPY (   1024 bytes):           OKAY
> COPY (   1025 bytes):           OKAY
> COPY (1024000 bytes):           OKAY
> COPY (1024001 bytes):           OKAY
>
> BAR tests for 1/3/5 fail because its configured to use 64bit bars
>
> Lad, Prabhakar (5):
>   pci: pcie-rcar: preparation for adding endpoint support
>   pci: endpoint: add support to handle multiple base for mapping
>     outbound memory
>   PCI: rcar: Add R-Car PCIe endpoint device tree bindings
>   pci: rcar: add support for rcar pcie controller in endpoint mode
>   misc: pci_endpoint_test: add device-id for RZ/G2 pcie controller
>
>  .../devicetree/bindings/pci/rcar-pci-ep.txt   |   43 +
>  arch/arm64/configs/defconfig                  |    2 +-
>  arch/arm64/configs/renesas_defconfig          |    2 +-
>  drivers/misc/pci_endpoint_test.c              |    3 +
>  drivers/pci/controller/Kconfig                |   11 +-
>  drivers/pci/controller/Makefile               |    3 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |   30 +-
>  drivers/pci/controller/pcie-cadence-ep.c      |   11 +-
>  drivers/pci/controller/pcie-rcar-ep.c         |  483 +++++++
>  drivers/pci/controller/pcie-rcar-host.c       | 1058 ++++++++++++++
>  drivers/pci/controller/pcie-rcar.c            | 1231 +----------------
>  drivers/pci/controller/pcie-rcar.h            |  129 ++
>  drivers/pci/controller/pcie-rockchip-ep.c     |   13 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |   29 +-
>  drivers/pci/endpoint/pci-epc-core.c           |    7 +-
>  drivers/pci/endpoint/pci-epc-mem.c            |  189 ++-
>  include/linux/pci-epc.h                       |   43 +-
>  17 files changed, 2016 insertions(+), 1271 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
>  create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
>  create mode 100644 drivers/pci/controller/pcie-rcar-host.c
>  create mode 100644 drivers/pci/controller/pcie-rcar.h
>
> --
> 2.20.1
>
