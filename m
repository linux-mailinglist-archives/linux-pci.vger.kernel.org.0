Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5EF4A9309
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 05:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356864AbiBDEZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 23:25:44 -0500
Received: from mx.socionext.com ([202.248.49.38]:58076 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbiBDEZo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 23:25:44 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Feb 2022 13:25:43 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 1CB842083C4C;
        Fri,  4 Feb 2022 13:25:43 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 4 Feb 2022 13:25:43 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 5F64EC1E22;
        Fri,  4 Feb 2022 13:25:42 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/3] PCI: Introduce UniPhier NX1 PCI endpoint controller support
Date:   Fri,  4 Feb 2022 13:25:36 +0900
Message-Id: <1643948739-14889-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series includes the patches to add basic support for the PCI endpoint
controller implemented in NX1 SoC.

Existing functions for Pro5 treat as "legacy" because the some registers
and initialization of NX1 is different from Pro5.

Changes since v1:
- Fix dt-bindings warnings

Kunihiko Hayashi (3):
  dt-bindings: PCI: uniphier-ep: Add bindings for NX1 SoC
  PCI: uniphier-ep: Add support for non-legacy SoC
  PCI: uniphier-ep: Add compatible string and SoC-dependent data for NX1
    SoC

 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  22 ++--
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      | 139 ++++++++++++++++++---
 2 files changed, 136 insertions(+), 25 deletions(-)

-- 
2.7.4

