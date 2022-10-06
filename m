Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2555F70E5
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 00:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiJFWDo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 18:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiJFWDn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 18:03:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E9F1142FA;
        Thu,  6 Oct 2022 15:03:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so7553531eja.6;
        Thu, 06 Oct 2022 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BLYOB0a4x/X6dZd/1nZQ9gYDvNArvXo1VpvInak5Wn0=;
        b=J4Fk509zYUCWEF0CVRUktZHIEROIeoftJ9eHsCOkYd0x+SncnK69V4ioM0JGD4lCzJ
         Ae4ZX1XFbfVnSOohDaWUIEEaY4nipt4B1IeCvvqQ5c+UNx9mKwU29CD5Tdkhtv5yKN/I
         F1gs28aafnlENHgK8qWBn6ShaEinoKdmX/6K6HPYVFcbpwgQNGNsNEGnJRgtPXmWslkV
         2cTKm/taL3/41xJRbCWrXHqa8TfF/EVVNzpd2gCqSb0axeNULSFLyZ6P0Ptrb7NbBfzj
         FqC2WI6CKNhOohrYgxKPfqJlrE21aCONGbWW2tKtj98jr9yEUGrsj57PULP1lDCiSKT/
         oi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLYOB0a4x/X6dZd/1nZQ9gYDvNArvXo1VpvInak5Wn0=;
        b=4IMLyy66q8agtIfftuRq1540Y3Je2pYiEK+Oy6jld94jTH0IZQvEZhoIHK4sHmum3O
         BWZCGcKX8IBCKSuIpj9VeMRhmxpSpI2sKNnlLzPNTW8tAiGyWMabVwSBOychJkWFYIFX
         16L2RVQrCroQjePEDB1IdAY2tdzc/yXsHAuwim+nDGcnrHwzu+UMw7zF0X5D2mrbATSy
         CYaXY/iuGBs0eqz5fRureAHHeOE4aIb4KLnVnoqTPxfcn9TXeIWaZRbMyfTL5UPIfXMu
         3B4Lw/fWen/1flPMiFrLJ1ywoOYIy5WWGU/iRrf6rXhvKop7cR9RItRz/EpFr4Op9WAA
         MYhw==
X-Gm-Message-State: ACrzQf1CJpdvrz/c4twxa5Np/gWtXm5w586fwKSwbh9k+gSDN8itW1R7
        2WZkkJT0RL0oAxKh0+b7wUZJbO7gA04=
X-Google-Smtp-Source: AMsMyM6xoPk32OflUxBn5euuJgnfF6SFYRYD2jnSaALoGLTWmUzpuPDH50kZ5SrEKJiGZtp1Cxzn0w==
X-Received: by 2002:a17:907:7f93:b0:787:7fbc:8081 with SMTP id qk19-20020a1709077f9300b007877fbc8081mr1615376ejc.543.1665093818210;
        Thu, 06 Oct 2022 15:03:38 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090631ce00b0078246b1360fsm241484ejf.131.2022.10.06.15.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 15:03:37 -0700 (PDT)
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
Subject: [PATCH v1 3/5] PCI: brcmstb: Replace status loops with read_poll_timeout_atomic()
Date:   Thu,  6 Oct 2022 18:03:19 -0400
Message-Id: <20221006220322.33000-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006220322.33000-1-jim2101024@gmail.com>
References: <20221006220322.33000-1-jim2101024@gmail.com>
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

