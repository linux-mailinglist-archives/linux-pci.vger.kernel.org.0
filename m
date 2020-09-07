Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2078C25F958
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 13:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIGLZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 07:25:39 -0400
Received: from foss.arm.com ([217.140.110.172]:33210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbgIGLZ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 07:25:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81E7B11D4;
        Mon,  7 Sep 2020 04:25:23 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86AD33F66E;
        Mon,  7 Sep 2020 04:25:21 -0700 (PDT)
Date:   Mon, 7 Sep 2020 12:25:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 0/3] Add PCIe EP to RZ/G2H
Message-ID: <20200907112519.GB7573@e121166-lin.cambridge.arm.com>
References: <20200904103851.3946-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904103851.3946-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 11:38:48AM +0100, Lad Prabhakar wrote:
> Hi All,
> 
> This patch series adds PCIe EP support to R8A774E1 SoC.
> 
> patch 2/3 applies on top of [1] and patch 3/3 is dependent
> on series [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/
>     renesas-devel.git/log/?h=renesas-arm-dt-for-v5.10
> [2] https://patchwork.kernel.org/project/linux-pci/list/
>     ?series=332849&submitter=&state=&q=&archive=&delegate=
> 
> Cheers,
> Prabhakar
> 
> 
> Lad Prabhakar (3):
>   dt-bindings: pci: rcar-pci-ep: Document r8a774e1
>   arm64: dts: renesas: r8a774e1: Add PCIe EP nodes
>   misc: pci_endpoint_test: Add Device ID for RZ/G2H PCIe controller
> 
>  .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  1 +
>  arch/arm64/boot/dts/renesas/r8a774e1.dtsi     | 38 +++++++++++++++++++
>  drivers/misc/pci_endpoint_test.c              |  2 +
>  3 files changed, 41 insertions(+)

Took patches (1) and (3) in pci/rcar, thanks.

Lorenzo
