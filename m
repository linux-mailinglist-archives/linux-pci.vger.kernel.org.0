Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5E2EBF3F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 14:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbhAFN4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 08:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAFN4u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2021 08:56:50 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6656C06134D;
        Wed,  6 Jan 2021 05:56:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id 6so5140111ejz.5;
        Wed, 06 Jan 2021 05:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8x/QpDCOUcMRuqo00P8LxlArLustwPLlO30ZOy3cg0=;
        b=HrsqvrMkSiNlal5pnhXdSHTDUyklbYpc96+CDKtUTuxGtALOkaGFkcaL569bP/4IZX
         7TJEckWk8JvkWrFjbFW6QryzGSJyzFOynxHuzpOklkS6J4Ml4YkYMYOFBGzHUjT6w5Ab
         Fd/j1eOkAKwDBBUKl08n3Ml+WhqSHcr142PQA4nPvTpHuOGNvf2Ls2eWPlaXR/cVM0cl
         pE9TJC4HiEfeHvI8db7MAXONW7hGc5hRUN72dv919vtfGAX83CzVKcoC6qL6oYyeX9hs
         /m9Xb4dpmYO+ThCqGAkZ8ft6fCRlf076VhbcAWmUfKbliaYis+UeWl7WaJOZJhzO8MB7
         5qQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8x/QpDCOUcMRuqo00P8LxlArLustwPLlO30ZOy3cg0=;
        b=HdBrXsDYwtJRe07iW6hSh7ai8rT68bMomWBKBufVGGwNf4ESSaucl0lr/pTBVQh66p
         Fl7uDTCCe7qOhpfqBHph142gb+6iPg07P4pRx3y0z2EoGaJ54ZvehBrD00WeXigxXQAW
         RfJxMzybwk9PybpHxEyS0x9eLbNW0WKYOwlX2znriH1tE1TY5WeyXbDMM9oK4PdjxCA3
         vgf8hsb/0w6MzENqdNy6B637R09qyNDo/FSYcvZDgv2hkkq2yNYG3ksNL4MYPghXs9tr
         vps8tM7QPcMdOzWt6dOig4AYPmCFZ9fT+XXbctrrmrYGSEwju//manZZm6buBxJO/d4M
         IJJw==
X-Gm-Message-State: AOAM533yhDvdQfhyhkZwaVryH2EQq/brEckpt5dAnCwbJxaK00TxsM+e
        nBbdClnDaykUk38QmcpkCTo=
X-Google-Smtp-Source: ABdhPJzAguu+fAPoftCt0iGkrQ7CsjxmqlmnyPNRllt6NGxY3xB/MWJfDtyYRzkuM1M8IcgGpNr5eQ==
X-Received: by 2002:a17:906:1796:: with SMTP id t22mr2815872eje.372.1609941368582;
        Wed, 06 Jan 2021 05:56:08 -0800 (PST)
Received: from localhost.localdomain (p200300f13711ec00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3711:ec00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id pg9sm1282862ejb.102.2021.01.06.05.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:56:08 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     lorenzo.pieralisi@arm.com, robh@kernel.org,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] PCI: dwc/intel-gw: Fix enabling the legacy PCI interrupt lines
Date:   Wed,  6 Jan 2021 14:55:40 +0100
Message-Id: <20210106135540.48420-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The legacy PCI interrupt lines need to be enabled using PCIE_APP_IRNEN
bits 13 (INTA), 14 (INTB), 15 (INTC) and 16 (INTD). The old code however
was taking (for example) "13" as raw value instead of taking BIT(13).
Define the legacy PCI interrupt bits using the BIT() macro and then use
these in PCIE_APP_IRN_INT.

Fixes: ed22aaaede44 ("PCI: dwc: intel: PCIe RC controller driver")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 0cedd1f95f37..ae96bfbb6c83 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -39,6 +39,10 @@
 #define PCIE_APP_IRN_PM_TO_ACK		BIT(9)
 #define PCIE_APP_IRN_LINK_AUTO_BW_STAT	BIT(11)
 #define PCIE_APP_IRN_BW_MGT		BIT(12)
+#define PCIE_APP_IRN_INTA		BIT(13)
+#define PCIE_APP_IRN_INTB		BIT(14)
+#define PCIE_APP_IRN_INTC		BIT(15)
+#define PCIE_APP_IRN_INTD		BIT(16)
 #define PCIE_APP_IRN_MSG_LTR		BIT(18)
 #define PCIE_APP_IRN_SYS_ERR_RC		BIT(29)
 #define PCIE_APP_INTX_OFST		12
@@ -48,10 +52,8 @@
 	PCIE_APP_IRN_RX_VDM_MSG | PCIE_APP_IRN_SYS_ERR_RC | \
 	PCIE_APP_IRN_PM_TO_ACK | PCIE_APP_IRN_MSG_LTR | \
 	PCIE_APP_IRN_BW_MGT | PCIE_APP_IRN_LINK_AUTO_BW_STAT | \
-	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTA) | \
-	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTB) | \
-	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTC) | \
-	(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTD))
+	PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
+	PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
 
 #define BUS_IATU_OFFSET			SZ_256M
 #define RESET_INTERVAL_MS		100
-- 
2.30.0

