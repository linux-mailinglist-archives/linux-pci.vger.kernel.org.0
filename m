Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7066B1A3D7B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 02:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgDJAry (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 20:47:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43119 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgDJArx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 20:47:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id p6so519050edu.10;
        Thu, 09 Apr 2020 17:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7akJQeZgBAyvPhH/ChJKlP3JYPIrxMAGcuficQZtxY=;
        b=iesyHr/hnvI62Ueqr1Zv1c7YEhMlo24XbPFHaXZ0BayN5Lx8TPOkxfj1b2NeKaO55Y
         Eh1Jz9v/+GVO0TtkxoF19Kf9MkYEtSv7yI2Dku7cALzGaP7qpPVhrveu/VVr2qrO/2Yn
         mkpzOJo5JHYel/0KxdPpUfh+f3A7repRDnJyuATFVvFJE/OFJdVayvc5EaHbiTH5r85N
         4MctnmC+wsVJblh6KMRqsC5MnzXrkPmF12N2q649moDDmhSe4TQQJItoMp7q7hGZvRrw
         VeBGT9qghaOJNFALVeGBNhRDUJZH7xk+oAwKAMyuF9sdxu4qV8+BOhCwbHN347nZsdDp
         muBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7akJQeZgBAyvPhH/ChJKlP3JYPIrxMAGcuficQZtxY=;
        b=JTNpQujHOkblHT8zQJf3tJY3rTc6zSx+jjUi+h/mLAFmf9uvHeny/+DoG3BILLAAKv
         vCJ9rFXc9FjyK6bY5OCsRPis2rW8+b8SsbJEyuhEVN95YVuarTYNL3sw4M7SJkF5NJFe
         crImWMyiFZR9RnFxkJKyLn+PveBmMpVttSHIAlvXL9Nd9mt16N3eE/dqfK0sBUDDvAmD
         Gelq+tHz9C+syQPDvm0JzDy2klcfpT3hpvwSULjggH3dV9LKSB3VtmiJgsJmd9/+9ANJ
         73up99L5LGhEsTXBmVG3nuFPR1U/4Ut9wpjtbSB0XaQVkNyrvLdqQZClOjD3yQFfL0Y0
         DJCA==
X-Gm-Message-State: AGi0PuZm5JB2MpTOgl3JHU7gQUZHQmjXkafun3AfKMfJwqIJ4/oKocn6
        nQ19ojL5wlcRzF4yBvnmgY1MnjKCg3yGCZVd
X-Google-Smtp-Source: APiQypLsY/OE3plQ2JuqYCxhA/x+TXFMmkcH/bNCsm1jD7QvwkDIAIyneK4Vg11GYlMqsLFqQoiJ6A==
X-Received: by 2002:a17:906:af81:: with SMTP id mj1mr1529524ejb.99.1586479671240;
        Thu, 09 Apr 2020 17:47:51 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host117-205-dynamic.180-80-r.retail.telecomitalia.it. [80.180.205.117])
        by smtp.googlemail.com with ESMTPSA id z16sm30523edm.52.2020.04.09.17.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:47:50 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drivers: pci: dwc: pci-imx6: update binding to generic name
Date:   Fri, 10 Apr 2020 02:47:36 +0200
Message-Id: <20200410004738.19668-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200410004738.19668-1-ansuelsmth@gmail.com>
References: <20200410004738.19668-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename specific bindings to generic name.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index acfbd34032a8..4ac140e007b4 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1146,28 +1146,28 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* Grab PCIe PHY Tx Settings */
-	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
+	if (of_property_read_u32(node, "tx-deemph-gen1",
 				 &imx6_pcie->tx_deemph_gen1))
 		imx6_pcie->tx_deemph_gen1 = 0;
 
-	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-3p5db",
+	if (of_property_read_u32(node, "tx-deemph-gen2-3p5db",
 				 &imx6_pcie->tx_deemph_gen2_3p5db))
 		imx6_pcie->tx_deemph_gen2_3p5db = 0;
 
-	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-6db",
+	if (of_property_read_u32(node, "tx-deemph-gen2-6db",
 				 &imx6_pcie->tx_deemph_gen2_6db))
 		imx6_pcie->tx_deemph_gen2_6db = 20;
 
-	if (of_property_read_u32(node, "fsl,tx-swing-full",
+	if (of_property_read_u32(node, "tx-swing-full",
 				 &imx6_pcie->tx_swing_full))
 		imx6_pcie->tx_swing_full = 127;
 
-	if (of_property_read_u32(node, "fsl,tx-swing-low",
+	if (of_property_read_u32(node, "tx-swing-low",
 				 &imx6_pcie->tx_swing_low))
 		imx6_pcie->tx_swing_low = 127;
 
 	/* Limit link speed */
-	ret = of_property_read_u32(node, "fsl,max-link-speed",
+	ret = of_property_read_u32(node, "max-link-speed",
 				   &imx6_pcie->link_gen);
 	if (ret)
 		imx6_pcie->link_gen = 1;
-- 
2.25.1

