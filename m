Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CD1356209
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 05:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344456AbhDGDm3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 23:42:29 -0400
Received: from mo-csw-fb1516.securemx.jp ([210.130.202.172]:58482 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbhDGDm2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 23:42:28 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1516) id 1373JBaq009742; Wed, 7 Apr 2021 12:19:11 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1373IlOm011940; Wed, 7 Apr 2021 12:18:47 +0900
X-Iguazu-Qid: 34tKBH9CWNuW27lu1p
X-Iguazu-QSIG: v=2; s=0; t=1617765527; q=34tKBH9CWNuW27lu1p; m=4Rk8Yy35/YxTcI9zmUL2k/6IE3AVe3IiJbKViOaxY6I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1512) id 1373IjQZ007437
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 7 Apr 2021 12:18:46 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id A1F7F1000C7;
        Wed,  7 Apr 2021 12:18:45 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 1373Ij3f001364;
        Wed, 7 Apr 2021 12:18:45 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 3/3] MAINTAINERS: Add entries for Toshiba Visconti PCIe controller
Date:   Wed,  7 Apr 2021 12:18:39 +0900
X-TSB-HOP: ON
Message-Id: <20210407031839.386088-4-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210407031839.386088-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210407031839.386088-1-nobuhiro1.iwamatsu@toshiba.co.jp>
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
index 8a154939ae27..3e5187c5b8d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2621,11 +2621,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
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
2.30.0.rc2

