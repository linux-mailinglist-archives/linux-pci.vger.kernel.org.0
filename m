Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B55557EEC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 17:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiFWPuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiFWPuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 11:50:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F0A42ECD;
        Thu, 23 Jun 2022 08:50:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e2so18227670edv.3;
        Thu, 23 Jun 2022 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgClSWW2UqCM8L/SNMSH4tsLKWBQL5Uplu6uX6hazwo=;
        b=HJ/+nOLoFC4nY0OQ9J5Em4y3LObFCogogj/14Snrk8UF8UKTcTQzCBHb44g3KVGAx1
         BLfH59z5Nk2sjZCkLjHOJPgc+A35XC+MR0jVzqqiJXw9uX0z5i4W7aATIXU9RrUXVNrL
         IvSdP2wul+YrShqT9H9xV2rDeyYL5vzuF15RMVbUMaPL8BDwBDG5Unk552Q8pN+9PwAt
         jX07qoTYKmBnPfdv3/OUxGLGTZSBTfRVa3fQGD1wxPc/A4ux5TKQUpJFa1att2piVRTA
         m3yZvNxM/2rWLFft16H6b/q7oLsyh7WdcNfdk6d4ZF35AMquVJXZvV39m0BtFE7Ol/rh
         k+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rgClSWW2UqCM8L/SNMSH4tsLKWBQL5Uplu6uX6hazwo=;
        b=HOxSfeFheqAGJRgqdEj8XtOwVNDjXNMB25FMJNu2lIXhRrhkKCSxI4ZbBwiZFCEj1I
         7Y59COx9sC0OeLEqqWwEC3hGABYTaOGAqCXZ1lpoCcGZw62ss8cSTqVnlV0HtJbtqfVN
         uNkiAisUQgqHiT5ytucGH6wazvWuABEeujC2VRbI5vCvixK+yHnnC/FL3M7xVMEie6BN
         RcqQIXv/W6Pv9JI2s/81cxIYrfm7+FCOO2gVoiQyrxVvrJnIjiQ0NE6sOKfkn/zxdCKf
         vq5u5cAuVBNbeDwqXnAgct0nf0E5JhQRovjPlRGrqvtSYpMMBa3lJccof2FYUn6maBGk
         t0KA==
X-Gm-Message-State: AJIora/5k3+18Kj/XL2SgkwZzZrqNgmRa6INC3prugShBogMN8AIxg0a
        mCp/AT1dAW/n5L4hd6v6IVw=
X-Google-Smtp-Source: AGRyM1vn+5/QLWJ2q7zv8Gv6/IkfqtYUe/3VBGN6KdRyBuc4WSuZOsHyB80t3Wr/UTHuetpaAIhpcQ==
X-Received: by 2002:a50:fe15:0:b0:435:9155:f83b with SMTP id f21-20020a50fe15000000b004359155f83bmr11490703edt.391.1655999407215;
        Thu, 23 Jun 2022 08:50:07 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-60.xnet.hr. [88.207.98.60])
        by smtp.googlemail.com with ESMTPSA id g13-20020a170906538d00b00722e1635531sm4846182ejo.193.2022.06.23.08.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:50:06 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 1/2] PCI: qcom: fix IPQ8074 Gen2 support
Date:   Thu, 23 Jun 2022 17:50:03 +0200
Message-Id: <20220623155004.688090-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the Gen2 port in IPQ8074 will cause the system to hang as its
using DBI registers in the .init and those are only accesible after
phy_power_on().

So solve this by splitting the DBI read/writes to .post_init.

Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v3:
* Make sure it applies onto 5.19-rc3
* Update the commit description to make it clear this only affects the
Gen2 port

Changes in v2:
* Rebase onto next-20220621
---
 drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a1f1aca2fb59..24708d5d817d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1061,9 +1061,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int i, ret;
-	u32 val;
 
 	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
 		ret = reset_control_assert(res->rst[i]);
@@ -1120,6 +1118,33 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 		goto err_clk_aux;
 	}
 
+	return 0;
+
+err_clk_aux:
+	clk_disable_unprepare(res->ahb_clk);
+err_clk_ahb:
+	clk_disable_unprepare(res->axi_s_clk);
+err_clk_axi_s:
+	clk_disable_unprepare(res->axi_m_clk);
+err_clk_axi_m:
+	clk_disable_unprepare(res->iface);
+err_clk_iface:
+	/*
+	 * Not checking for failure, will anyway return
+	 * the original failure in 'ret'.
+	 */
+	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
+		reset_control_assert(res->rst[i]);
+
+	return ret;
+}
+
+static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
 	writel(SLV_ADDR_SPACE_SZ,
 		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
 
@@ -1147,24 +1172,6 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 		PCI_EXP_DEVCTL2);
 
 	return 0;
-
-err_clk_aux:
-	clk_disable_unprepare(res->ahb_clk);
-err_clk_ahb:
-	clk_disable_unprepare(res->axi_s_clk);
-err_clk_axi_s:
-	clk_disable_unprepare(res->axi_m_clk);
-err_clk_axi_m:
-	clk_disable_unprepare(res->iface);
-err_clk_iface:
-	/*
-	 * Not checking for failure, will anyway return
-	 * the original failure in 'ret'.
-	 */
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
-		reset_control_assert(res->rst[i]);
-
-	return ret;
 }
 
 static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
@@ -1596,6 +1603,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
 static const struct qcom_pcie_ops ops_2_3_3 = {
 	.get_resources = qcom_pcie_get_resources_2_3_3,
 	.init = qcom_pcie_init_2_3_3,
+	.post_init = qcom_pcie_post_init_2_3_3,
 	.deinit = qcom_pcie_deinit_2_3_3,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
-- 
2.36.1

