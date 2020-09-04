Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6BA25D6A4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgIDKkL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 06:40:11 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:60430 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729584AbgIDKkG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 06:40:06 -0400
X-IronPort-AV: E=Sophos;i="5.76,389,1592838000"; 
   d="scan'208";a="56169404"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Sep 2020 19:39:56 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 26DBB40061A2;
        Fri,  4 Sep 2020 19:39:52 +0900 (JST)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH 0/3] Add PCIe EP to RZ/G2H
Date:   Fri,  4 Sep 2020 11:38:48 +0100
Message-Id: <20200904103851.3946-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

This patch series adds PCIe EP support to R8A774E1 SoC.

patch 2/3 applies on top of [1] and patch 3/3 is dependent
on series [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/
    renesas-devel.git/log/?h=renesas-arm-dt-for-v5.10
[2] https://patchwork.kernel.org/project/linux-pci/list/
    ?series=332849&submitter=&state=&q=&archive=&delegate=

Cheers,
Prabhakar


Lad Prabhakar (3):
  dt-bindings: pci: rcar-pci-ep: Document r8a774e1
  arm64: dts: renesas: r8a774e1: Add PCIe EP nodes
  misc: pci_endpoint_test: Add Device ID for RZ/G2H PCIe controller

 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  1 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi     | 38 +++++++++++++++++++
 drivers/misc/pci_endpoint_test.c              |  2 +
 3 files changed, 41 insertions(+)

-- 
2.17.1

