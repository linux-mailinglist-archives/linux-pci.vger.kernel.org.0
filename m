Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4801325FDA2
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgIGPxC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 11:53:02 -0400
Received: from foss.arm.com ([217.140.110.172]:37668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbgIGOvt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 10:51:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D5D31B;
        Mon,  7 Sep 2020 07:51:22 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55E53F73C;
        Mon,  7 Sep 2020 07:51:20 -0700 (PDT)
Date:   Mon, 7 Sep 2020 15:51:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH 0/2] r8a7742 add PCIe node
Message-ID: <20200907145115.GA10138@e121166-lin.cambridge.arm.com>
References: <20200810174156.30880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810174156.30880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 10, 2020 at 06:41:54PM +0100, Lad Prabhakar wrote:
> Hi All,
> 
> This patch set adds PCIe instance to r8a7742 Soc dtsi.
> patches apply on-top of [1] + [2]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/
>     renesas-devel.git/log/?h=renesas-arm-dt-for-v5.10
> [2] https://patchwork.kernel.org/project/linux-renesas-soc/
>     list/?series=330277
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (2):
>   dt-bindings: PCI: rcar: Add device tree support for r8a7742
>   ARM: dts: r8a7742: Add PCIe Controller device node
> 
>  .../devicetree/bindings/pci/rcar-pci.txt      |  3 +-
>  arch/arm/boot/dts/r8a7742.dtsi                | 35 +++++++++++++++++++
>  2 files changed, 37 insertions(+), 1 deletion(-)

I took patch (1) in pci/rcar, thanks.

Lorenzo
