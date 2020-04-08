Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB3B1A2599
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 17:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgDHPi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 11:38:58 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:22084 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729674AbgDHPi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2020 11:38:58 -0400
X-IronPort-AV: E=Sophos;i="5.72,359,1580742000"; 
   d="scan'208";a="43920588"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Apr 2020 00:38:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id DF4114004BDB;
        Thu,  9 Apr 2020 00:38:52 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-rockchip@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 8/8] MAINTAINERS: Add file patterns for rcar PCI device tree bindings
Date:   Wed,  8 Apr 2020 16:38:00 +0100
Message-Id: <1586360280-10956-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586360280-10956-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1586360280-10956-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add file pattern entry for rcar PCI devicetree binding, so that when
people run ./scripts/get_maintainer.pl the rcar PCI maintainers could also
be listed.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f0f2ee2af32..87df2d31a54b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12933,6 +12933,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/controller/*rcar*
+F:	Documentation/devicetree/bindings/pci/*rcar*
 
 PCI DRIVER FOR SAMSUNG EXYNOS
 M:	Jingoo Han <jingoohan1@gmail.com>
-- 
2.20.1

