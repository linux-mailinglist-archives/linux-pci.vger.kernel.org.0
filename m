Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17326DF07C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjDLJee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 05:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDLJed (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 05:34:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAF490
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 02:34:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54ee12aa4b5so112255987b3.4
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681292071; x=1683884071;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XXrY+88/qpDMfyRoUypnAqs2C5fQRNIfOwP/pzZA4NY=;
        b=QU5NqCtV5OjmMJI+OPnWdgMJz9AQSpVorJrOF8/C71fRPP5pM3ILcKmEJLngJrDwa4
         A+GsZItusJVI50m0ou8NLSW68dg44vWNAlY/RPuyCVKD0hMIGRf9Ad/iHegN5BpwB5M6
         i0txi60uTwZYH/ez0iGQRAYy+XredvADGAM+vXqsUCrcCe/ZO1vOmwhE1vu9H9AElw8r
         oWJCTVeIKi3DzMTTg0PM8kU4pk5YYUFRXsv+39jcFnPigxTegXlSRJ8SC0jZldNi1s9n
         J3aLLWrWjN8w/UvG2zxi8h8CSUtdIYlcBT5LuBWE/IKQcf3sYaOl7w48exgd2TOH1/4E
         +GeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681292071; x=1683884071;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXrY+88/qpDMfyRoUypnAqs2C5fQRNIfOwP/pzZA4NY=;
        b=rl3gDiYij+gJCulQwS5tK6xxtm+6c6lar+wuAu7f9rWqvUQNsncu45xa8Zers5cfVk
         +C/+qi1RLITVIIftA5uJUbeWJcitRu6NHEY82Q2p/JivEZcFeEB4+L7IgHVrhQslnswd
         m+gfJIlTqkPA/ORQ5Sw5UVn8eqEOCcJg5hsW9WAvf4jNX4KXzTtLXBrmOb8ll6ikyAbp
         xKoKAsjUAjfSug6Mdq4pjlnMZVOgtHun2ON13oWnecfuuN31MlcrEUCZB2q9nBAJV4Xk
         aMwoRP/PYa1T4xcrn9EbYFoS/FtRCGUfOlBVHP6702n5WHEwshj63/+B8RXNlCXT80PU
         aRLw==
X-Gm-Message-State: AAQBX9e4D8ziNAN394e0vos0uH2+/s8prTbF0gb3OLcIl5tWU4Yn4dLv
        z10IZGq+P4KZrPnauRF9BB84l2uYSRBCkzsxgxDPUMTxqz4biV0csee6jpSv8/pzz+ANZ+MllGM
        /zfqtgbSo+TqB77dVx+0o42c=
X-Google-Smtp-Source: AKy350ZRkaFDNeBZD7HdE3CDPSM2DK+hW9zhFGSaHM4CkdWVS719+OORhaFoJitVu+Ig8CqYXHYwPHq1A1QMPNJauw==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:cf48:0:b0:b8f:47c4:58ed with SMTP
 id f69-20020a25cf48000000b00b8f47c458edmr367727ybg.9.1681292071686; Wed, 12
 Apr 2023 02:34:31 -0700 (PDT)
Date:   Wed, 12 Apr 2023 15:04:25 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230412093425.3659088-1-ajayagarwal@google.com>
Subject: [PATCH v4] PCI: dwc: Wait for link up only if link is started
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>,
        William McVicker <willmcvicker@google.com>
Cc:     linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In dw_pcie_host_init() regardless of whether the link has been
started or not, the code waits for the link to come up. Even in
cases where start_link() is not defined the code ends up spinning
in a loop for 1 second. Since in some systems dw_pcie_host_init()
gets called during probe, this one second loop for each pcie
interface instance ends up extending the boot time.

Wait for the link up in only if the start_link() is defined.

Signed-off-by: Sajid Dalvi <sdalvi@google.com>
Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v3:
- Run dw_pcie_start_link() only if link is not already up

Changelog since v2:
- Wait for the link up if start_link() is really defined.
- Print the link status if the link is up on init.

 .../pci/controller/dwc/pcie-designware-host.c | 13 ++++++++----
 drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9952057c8819..cf61733bf78d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -485,14 +485,19 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_remove_edma;
 
-	if (!dw_pcie_link_up(pci)) {
+	if (dw_pcie_link_up(pci)) {
+		dw_pcie_print_link_status(pci);
+	} else {
 		ret = dw_pcie_start_link(pci);
 		if (ret)
 			goto err_remove_edma;
-	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+		if (pci->ops && pci->ops->start_link) {
+			ret = dw_pcie_wait_for_link(pci);
+			if (ret)
+				goto err_stop_link;
+		}
+	}
 
 	bridge->sysdata = pp;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 53a16b8b6ac2..03748a8dffd3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -644,9 +644,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
-int dw_pcie_wait_for_link(struct dw_pcie *pci)
+void dw_pcie_print_link_status(struct dw_pcie *pci)
 {
 	u32 offset, val;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+
+	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
+		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
+		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+}
+
+int dw_pcie_wait_for_link(struct dw_pcie *pci)
+{
 	int retries;
 
 	/* Check if the link is up or not */
@@ -662,12 +673,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
-
-	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
-		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
-		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+	dw_pcie_print_link_status(pci);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce075cc..615660640801 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -429,6 +429,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
+void dw_pcie_print_link_status(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
-- 
2.40.0.577.gac1e443424-goog

