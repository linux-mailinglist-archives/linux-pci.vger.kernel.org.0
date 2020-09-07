Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4A25F75D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 12:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgIGKJI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 06:09:08 -0400
Received: from foss.arm.com ([217.140.110.172]:59534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbgIGKJH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 06:09:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F4FA30E;
        Mon,  7 Sep 2020 03:09:06 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9312B3F66E;
        Mon,  7 Sep 2020 03:09:04 -0700 (PDT)
Date:   Mon, 7 Sep 2020 11:09:02 +0100
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
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 0/5] Add PCIe EP nodes on RZ/G2[EMN]
Message-ID: <20200907100902.GF6428@e121166-lin.cambridge.arm.com>
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 14, 2020 at 06:30:32PM +0100, Lad Prabhakar wrote:
> Hi All,
> 
> This patch series adds support for PCIe EP nodes to Renesas r8a774a1,
> r8a774b1 and r8a774c0 SoC's.
> 
> Patches are based on top of [1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/
>     pci.git/log/?h=next
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (5):
>   dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1
>   misc: pci_endpoint_test: Add Device ID for RZ/G2M and RZ/G2N PCIe
>     controllers
>   arm64: dts: renesas: r8a774a1: Add PCIe EP nodes
>   arm64: dts: renesas: r8a774b1: Add PCIe EP nodes
>   arm64: dts: renesas: r8a774c0: Add PCIe EP node
> 
>  .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  7 +++-
>  arch/arm64/boot/dts/renesas/r8a774a1.dtsi     | 38 +++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r8a774b1.dtsi     | 38 +++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r8a774c0.dtsi     | 19 ++++++++++
>  drivers/misc/pci_endpoint_test.c              |  7 +++-
>  5 files changed, 105 insertions(+), 4 deletions(-)

I can take the first two patches but the dts changes should be routed
and posted to arm-soc.

Lorenzo
