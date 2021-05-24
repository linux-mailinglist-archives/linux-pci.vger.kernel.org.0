Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844E938E103
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 08:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhEXGcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 02:32:07 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:46948 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhEXGcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 02:32:05 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 14O6UDBJ009721; Mon, 24 May 2021 15:30:13 +0900
X-Iguazu-Qid: 34tIXnnNddYkzF7sEm
X-Iguazu-QSIG: v=2; s=0; t=1621837813; q=34tIXnnNddYkzF7sEm; m=xZHZPoA0ARf0g+io4wqMi8YnfY/XDXj5beruXLUL6Is=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1510) id 14O6UCZD024734
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 May 2021 15:30:12 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 235A1100085;
        Mon, 24 May 2021 15:30:12 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 14O6UBRw006942;
        Mon, 24 May 2021 15:30:11 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v3 3/3] MAINTAINERS: Add entries for Toshiba Visconti PCIe controller
Date:   Mon, 24 May 2021 15:30:04 +0900
X-TSB-HOP: ON
Message-Id: <20210524063004.132043-4-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524063004.132043-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210524063004.132043-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add entries for Toshiba Visconti PCIe controller binding and driver.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..8554e02de0cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2663,11 +2663,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
 F:	Documentation/devicetree/bindings/arm/toshiba.yaml
 F:	Documentation/devicetree/bindings/net/toshiba,visconti-dwmac.yaml
 F:	Documentation/devicetree/bindings/gpio/toshiba,gpio-visconti.yaml
+F:	Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
 F:	Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
 F:	arch/arm64/boot/dts/toshiba/
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
 F:	drivers/gpio/gpio-visconti.c
+F:	drivers/pci/controller/dwc/pcie-visconti.c
 F:	drivers/pinctrl/visconti/
 F:	drivers/watchdog/visconti_wdt.c
 N:	visconti
-- 
2.31.1

