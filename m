Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85A3363B88
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 08:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhDSGgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 02:36:10 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:37136 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhDSGgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 02:36:10 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 13J6ZIHa030286; Mon, 19 Apr 2021 15:35:18 +0900
X-Iguazu-Qid: 34tr9jB2dgCsPBSbHj
X-Iguazu-QSIG: v=2; s=0; t=1618814117; q=34tr9jB2dgCsPBSbHj; m=KAQgw1k5Yh2trgm8JKJC2ZRyPU6Q5anXfHj5orjLd+g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 13J6ZGJZ005389
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 15:35:17 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id C50F51000B9;
        Mon, 19 Apr 2021 15:35:16 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 13J6ZGjr018183;
        Mon, 19 Apr 2021 15:35:16 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2 3/3] MAINTAINERS: Add entries for Toshiba Visconti PCIe controller
Date:   Mon, 19 Apr 2021 15:35:13 +0900
X-TSB-HOP: ON
Message-Id: <20210419063513.1947003-4-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210419063513.1947003-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210419063513.1947003-1-nobuhiro1.iwamatsu@toshiba.co.jp>
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

