Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2641F244E01
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 19:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgHNRbr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 13:31:47 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:58950 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728346AbgHNRbq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2020 13:31:46 -0400
X-IronPort-AV: E=Sophos;i="5.76,313,1592838000"; 
   d="scan'208";a="54383282"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Aug 2020 02:31:44 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B7E5F40061B7;
        Sat, 15 Aug 2020 02:31:40 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 0/5] Add PCIe EP nodes on RZ/G2[EMN]
Date:   Fri, 14 Aug 2020 18:30:32 +0100
Message-Id: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

This patch series adds support for PCIe EP nodes to Renesas r8a774a1,
r8a774b1 and r8a774c0 SoC's.

Patches are based on top of [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/
    pci.git/log/?h=next

Cheers,
Prabhakar

Lad Prabhakar (5):
  dt-bindings: pci: rcar-pci-ep: Document r8a774a1 and r8a774b1
  misc: pci_endpoint_test: Add Device ID for RZ/G2M and RZ/G2N PCIe
    controllers
  arm64: dts: renesas: r8a774a1: Add PCIe EP nodes
  arm64: dts: renesas: r8a774b1: Add PCIe EP nodes
  arm64: dts: renesas: r8a774c0: Add PCIe EP node

 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  7 +++-
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi     | 38 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi     | 38 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi     | 19 ++++++++++
 drivers/misc/pci_endpoint_test.c              |  7 +++-
 5 files changed, 105 insertions(+), 4 deletions(-)

-- 
2.17.1

