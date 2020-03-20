Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C837D18D735
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCTSfh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44498 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTSfh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id z3so8266993edq.11;
        Fri, 20 Mar 2020 11:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1yA09A2jj2GJ7mf6EWjnGj5car0+pFadneU5DRW1E0=;
        b=A91sMfRkl42TkFSWs9Q9IhP6ewbRQpGP3zvAHs4ixj8O0VAlwGf2XdqjxNkda42p+F
         rE1DdJYbgM+bE/7PhlMb0i8QNf6tNtciczvIyl6A7MvXq2tplBeeOIREacm5BF8C0Fw7
         y9sLTfP6+k64lr6KcJIL291+2IO2htWpdYT/FRFBPULP7rUPSY7Xs/lPWCzsVEW5Mlsj
         yowqy//ObW7xPUz+y9oVin5RzgtlFn/PydNjEYt5Z8Em8x0mS+PiZ8NOY0CpQQH9Cr+W
         z4WnBLD8zAVDMWGGwLcnVIUyI8ISCr4mR0xjG5JGN4/hmdWAYWZWBu4vEvL2hovawwHJ
         akjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1yA09A2jj2GJ7mf6EWjnGj5car0+pFadneU5DRW1E0=;
        b=U9kpaTOT0dc+MqPSsaRRcXngU1pgfjRXjlPnaOpCFyJ6HrvN+RZ004oNvipAZsFZk8
         REIluxWus3h7k+hPtYUwyB2BXUlCTvfmBlNefd/+OUP9XaH0NagLhoeDPG8bGXrF5nh0
         KYyHVzKUe8iYbhLAeLo5rEICQ6CR56WEjScZpHYILavL3sY/6FkOnXJeFRbgzZPawmJJ
         6+e5TkANcd9QPWvYtVdHoU4DsbmyNMHY/hNfMV0FjKGw4HxVUNGieTBuEwdQCO6on3/0
         /wvNFZbFaaNjEky5F6tKdfFOpid1o9cTLbpIOyfBw7EqRscBbXGPHYNiv/cPk+TkMmsm
         QXfg==
X-Gm-Message-State: ANhLgQ3S0AIrlaJi6aF6H29dbzdW/yxNYJmVrVhgu0hoRYsQRtB6B1A3
        hc+n2XcJzDi20biyTqbkhYo=
X-Google-Smtp-Source: ADFU+vtC/hTDKXr5YBXEcAwc7n8EoSk1Q/19B2vYXfusmIsN1j9VwEZgjYrCe4aSdRDu42y4EE82hw==
X-Received: by 2002:aa7:d9d8:: with SMTP id v24mr3531315eds.386.1584729334422;
        Fri, 20 Mar 2020 11:35:34 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:33 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Sriram Palanisamy <gpalan@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] pcie: qcom: Set PCIE MRRS and MPS to 256B
Date:   Fri, 20 Mar 2020 19:34:54 +0100
Message-Id: <20200320183455.21311-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sriram Palanisamy <gpalan@codeaurora.org>

Set Max Read Request Size and Max Payload Size to 256 bytes,
per chip team recommendation.

Signed-off-by: Gokul Sriram Palanisamy <gpalan@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 03130a3206b4..ad437c6f49a0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -125,6 +125,14 @@
 
 #define PCIE20_LNK_CONTROL2_LINK_STATUS2        0xA0
 
+#define __set(v, a, b)	(((v) << (b)) & GENMASK(a, b))
+#define __mask(a, b)	(((1 << ((a) + 1)) - 1) & ~((1 << (b)) - 1))
+#define PCIE20_DEV_CAS			0x78
+#define PCIE20_MRRS_MASK		__mask(14, 12)
+#define PCIE20_MRRS(x)			__set(x, 14, 12)
+#define PCIE20_MPS_MASK			__mask(7, 5)
+#define PCIE20_MPS(x)			__set(x, 7, 5)
+
 #define DEVICE_TYPE_RC				0x4
 
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
@@ -1595,6 +1603,35 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void qcom_pcie_fixup_final(struct pci_dev *pcidev)
+{
+	int cap, err;
+	u16 ctl, reg_val;
+
+	cap = pci_pcie_cap(pcidev);
+	if (!cap)
+		return;
+
+	err = pci_read_config_word(pcidev, cap + PCI_EXP_DEVCTL, &ctl);
+
+	if (err)
+		return;
+
+	reg_val = ctl;
+
+	if (((reg_val & PCIE20_MRRS_MASK) >> 12) > 1)
+		reg_val = (reg_val & ~(PCIE20_MRRS_MASK)) | PCIE20_MRRS(0x1);
+
+	if (((ctl & PCIE20_MPS_MASK) >> 5) > 1)
+		reg_val = (reg_val & ~(PCIE20_MPS_MASK)) | PCIE20_MPS(0x1);
+
+	err = pci_write_config_word(pcidev, cap + PCI_EXP_DEVCTL, reg_val);
+
+	if (err)
+		dev_err(&pcidev->dev, "pcie config write failed %d\n", err);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, qcom_pcie_fixup_final);
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
-- 
2.25.1

