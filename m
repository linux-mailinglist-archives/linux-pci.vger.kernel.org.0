Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BB15FBA9F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 20:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJKSmY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJKSmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 14:42:21 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7501780EBC;
        Tue, 11 Oct 2022 11:42:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m6so3984324qkm.4;
        Tue, 11 Oct 2022 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yC68PwSujcmdozdXRLObvH5ia1utZiSGZZx8tkWQRwM=;
        b=BM856Tof1maVbKADbUoeep+v/Kh8Xs4qIGjPkd1Sxt3W/8Y6ieF7VVHMspdh6BFj6G
         iXG0PCB0OrR+maaj9i05cbmgMrUiZ2Yv2KMwekF2Xr7SwJ5Xu5raHGepeHyp3GCCYAiZ
         PWgBi8HaDT6cWz1658v8xfGY8Yw//RrgNDoOwgB5eTmtFhNiN91sht2mLWf1qJ6CNpOy
         daMwLlGgcLOAw6XYIgAZZ+bdCx0AruOla8hAtt/N/HLDEEzgvtt58sv1osYo5Jr2k04o
         C9MHMrsCz4sa5JnMTMiDonVFbcyD/IdAgZGUBbqxwwMljnoY1n6cUvkpvp6ZEZb1uXmz
         1Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yC68PwSujcmdozdXRLObvH5ia1utZiSGZZx8tkWQRwM=;
        b=W3ch532dbW7gvOat49fUBvAaMocoXh13fwPRSMOrNeAqqx10XR9q3Qb0EVUZ5bU+s9
         6gu0zVBf+XZmuRHsy5PEl1ebvCqWyLZktQOygaofFDpbT4+rc0pn7j4IPIZusel5Vgje
         aZ+eOpVApWdWKeB2qcQklLADuRWDbDeXG3pRPYC2OVTLmalcypGHHvU1PNGgrnrUpjQ1
         VtWwJWAjEPh0/MJ0QprwAwyzTrU7Le1y8nqWgaWMgUYq6y5I3twuUI/xapnoq0Lf8VAF
         zGohM1Nh4LpPMJ6W19qKNMMHu5Bv48YoYpR27HE+rfPEws4mtnMOVDJpPoeL/FI/n1cd
         DcVQ==
X-Gm-Message-State: ACrzQf0p4+WOTU2SquNikBtYneK3ygLpAKBFodYthcePXcDmusRxqVAk
        TUY0mybqmZ4CT3R4x1uq1xU5u8gUqYY=
X-Google-Smtp-Source: AMsMyM4Vf6sWyq8Gx07MlfotRqmjQhuQIEe0h6hqEI4mPD99OXt3GmtehfAZuvdtbMJqLkVQo7HZWw==
X-Received: by 2002:a05:620a:12fb:b0:6ee:79f2:3716 with SMTP id f27-20020a05620a12fb00b006ee79f23716mr3676940qkl.348.1665513738030;
        Tue, 11 Oct 2022 11:42:18 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id fc8-20020a05622a488800b003938a65479bsm10961732qtb.10.2022.10.11.11.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:42:17 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/5] PCI: brcmstb: Replace status loops with read_poll_timeout_atomic()
Date:   Tue, 11 Oct 2022 14:42:08 -0400
Message-Id: <20221011184211.18128-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011184211.18128-1-jim2101024@gmail.com>
References: <20221011184211.18128-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It would be nice to replace the PCIe link-up loop as well but
there are too many uses of this that do not poll (and the
read_poll_timeout uses "timeout==0" to loop forever).

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 39b545713ba0..c7210cec1f58 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
@@ -302,42 +303,34 @@ static u32 brcm_pcie_mdio_form_pkt(int port, int regad, int cmd)
 /* negative return value indicates error */
 static int brcm_pcie_mdio_read(void __iomem *base, u8 port, u8 regad, u32 *val)
 {
-	int tries;
 	u32 data;
+	int err;
 
 	writel(brcm_pcie_mdio_form_pkt(port, regad, MDIO_CMD_READ),
 		   base + PCIE_RC_DL_MDIO_ADDR);
 	readl(base + PCIE_RC_DL_MDIO_ADDR);
-
-	data = readl(base + PCIE_RC_DL_MDIO_RD_DATA);
-	for (tries = 0; !MDIO_RD_DONE(data) && tries < 10; tries++) {
-		udelay(10);
-		data = readl(base + PCIE_RC_DL_MDIO_RD_DATA);
-	}
-
+	err = readl_poll_timeout_atomic(base + PCIE_RC_DL_MDIO_RD_DATA, data,
+					MDIO_RD_DONE(data), 10, 100);
 	*val = FIELD_GET(MDIO_DATA_MASK, data);
-	return MDIO_RD_DONE(data) ? 0 : -EIO;
+
+	return err;
 }
 
 /* negative return value indicates error */
 static int brcm_pcie_mdio_write(void __iomem *base, u8 port,
 				u8 regad, u16 wrdata)
 {
-	int tries;
 	u32 data;
+	int err;
 
 	writel(brcm_pcie_mdio_form_pkt(port, regad, MDIO_CMD_WRITE),
 		   base + PCIE_RC_DL_MDIO_ADDR);
 	readl(base + PCIE_RC_DL_MDIO_ADDR);
 	writel(MDIO_DATA_DONE_MASK | wrdata, base + PCIE_RC_DL_MDIO_WR_DATA);
 
-	data = readl(base + PCIE_RC_DL_MDIO_WR_DATA);
-	for (tries = 0; !MDIO_WT_DONE(data) && tries < 10; tries++) {
-		udelay(10);
-		data = readl(base + PCIE_RC_DL_MDIO_WR_DATA);
-	}
-
-	return MDIO_WT_DONE(data) ? 0 : -EIO;
+	err = readw_poll_timeout_atomic(base + PCIE_RC_DL_MDIO_WR_DATA, data,
+					MDIO_WT_DONE(data), 10, 100);
+	return err;
 }
 
 /*
-- 
2.17.1

