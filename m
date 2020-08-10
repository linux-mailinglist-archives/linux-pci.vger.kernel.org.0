Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBE5240C36
	for <lists+linux-pci@lfdr.de>; Mon, 10 Aug 2020 19:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgHJRmP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Aug 2020 13:42:15 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:40294 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727841AbgHJRmP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2020 13:42:15 -0400
X-IronPort-AV: E=Sophos;i="5.75,458,1589209200"; 
   d="scan'208";a="54094692"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Aug 2020 02:42:13 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id D22BE40B1007;
        Tue, 11 Aug 2020 02:42:10 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: [PATCH 0/2] r8a7742 add PCIe node
Date:   Mon, 10 Aug 2020 18:41:54 +0100
Message-Id: <20200810174156.30880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

This patch set adds PCIe instance to r8a7742 Soc dtsi.
patches apply on-top of [1] + [2]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/
    renesas-devel.git/log/?h=renesas-arm-dt-for-v5.10
[2] https://patchwork.kernel.org/project/linux-renesas-soc/
    list/?series=330277

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: PCI: rcar: Add device tree support for r8a7742
  ARM: dts: r8a7742: Add PCIe Controller device node

 .../devicetree/bindings/pci/rcar-pci.txt      |  3 +-
 arch/arm/boot/dts/r8a7742.dtsi                | 35 +++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.17.1

