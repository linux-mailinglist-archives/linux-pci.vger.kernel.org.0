Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7366127E06C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 07:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgI3FgM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 01:36:12 -0400
Received: from mx.socionext.com ([202.248.49.38]:57175 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgI3FgL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 01:36:11 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Sep 2020 14:36:10 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id C2B9160060;
        Wed, 30 Sep 2020 14:36:10 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Sep 2020 14:36:10 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 604661A0509;
        Wed, 30 Sep 2020 14:36:10 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 1/4] dt-bindings: PCI: uniphier: Add iATU register description
Date:   Wed, 30 Sep 2020 14:36:04 +0900
Message-Id: <1601444167-11316-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1601444167-11316-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the dt-bindings, "atu" reg-names is required to get the register space
for iATU in Synopsys DWC version 4.80 or later.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/uniphier-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
index 1fa2c59..c4b7381 100644
--- a/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/uniphier-pcie.txt
@@ -16,6 +16,7 @@ Required properties:
     "dbi"    - controller configuration registers
     "link"   - SoC-specific glue layer registers
     "config" - PCIe configuration space
+    "atu"    - iATU registers for DWC version 4.80 or later
 - clocks: A phandle to the clock gate for PCIe glue layer including
 	the host controller.
 - resets: A phandle to the reset line for PCIe glue layer including
-- 
2.7.4

