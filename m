Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD66418D749
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCTSfO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37987 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCTSfN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id h5so8305505edn.5;
        Fri, 20 Mar 2020 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRo9nDnkvpVgGMO52y9SDq2QLhuKK/RpwLheS8dxEdo=;
        b=KXlg6pGGu7+fH+4J6SwTdmp3qRTOwbLeFyRc9llXU6NFZtCXG6y1ZL9UP42MReM4hK
         Gn/CMltyY5HsmEeAnqsYpo9Ip2LyDJJQEBBQAMVbxRKt4I97B6B57gFesIt5eNQ61w00
         AkUauYmKgMfzt26t/5/AZ9GRZ/FbOTwD1W3YC5JuyxHuPhR11Y/NZRp6eFldsyERVl+7
         hwsGD/XchuHDwV/bjzdD/Rfc0QAfnrY5MEqIK2hsPk3FNC14QwvYigVo3uGexIeceUkc
         8uEeuY3QTRDvx1me//9PydnQaziaISGFo1jvXtIstLEbQmrFJGhjecRBlSEGWIhnYvLD
         MLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRo9nDnkvpVgGMO52y9SDq2QLhuKK/RpwLheS8dxEdo=;
        b=kAt7wOm9tsUCIE5axI+IDHX9uPGQmisaO06YdOkJxlK2Ikt7wOuEjQvrheb7Zi1dk4
         Pn6CGyd0WwR2XPIgoquOZisBblf2fm7iH3C8dmT2XlBmKP7H56iOE1fP7yUwMvbu1WDg
         xiKbn9ty+DB5iJ9WDg6XeMEnqJXQVqUAgOuCcT593ewZCPSHmJn4NgNH5FW9su5sU34C
         1zWnbM9SUPVwsCbTLxR+HMfWECj2KZbhivpKQhW0KrYf8dwlYhY0wNW2ATktOuI1KTyg
         oYW9aQLIbP4mR4s3cA4lm3qHSP3BIPV2D2l5p5ppDnG/x+srthHEhMBdZjLZDizY8GTL
         d4oQ==
X-Gm-Message-State: ANhLgQ2KJ8lZhl79TvAmgjgASL8mGl3ugGrPEgkYnQFL/rmF20lqRSPL
        5ISeAxxlNy9qbaNNB7QnJGA=
X-Google-Smtp-Source: ADFU+vvNTp8sqzvhS1hnXVHuvIPBtK5wJsYEAeb0/JoRA6lZ9eu2HocXv6m9ZSeJEMfzrbSHH628gw==
X-Received: by 2002:a50:a9a6:: with SMTP id n35mr671753edc.57.1584729310266;
        Fri, 20 Mar 2020 11:35:10 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:09 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
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
Subject: [PATCH 03/12] pcie: qcom: change duplicate pci reset to phy reset
Date:   Fri, 20 Mar 2020 19:34:45 +0100
Message-Id: <20200320183455.21311-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Abhishek Sahu <absahu@codeaurora.org>

The deinit issues reset_control_assert for pci twice and
does not contain phy reset.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index f958c535de6e..1fcc7fed8443 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -284,7 +284,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 	reset_control_assert(res->axi_reset);
 	reset_control_assert(res->ahb_reset);
 	reset_control_assert(res->por_reset);
-	reset_control_assert(res->pci_reset);
+	reset_control_assert(res->phy_reset);
 	clk_disable_unprepare(res->iface_clk);
 	clk_disable_unprepare(res->core_clk);
 	clk_disable_unprepare(res->phy_clk);
-- 
2.25.1

