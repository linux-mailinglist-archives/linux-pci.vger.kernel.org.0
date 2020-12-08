Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC282D2A7F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 13:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgLHMPh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 07:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgLHMPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 07:15:37 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F9EC0617A7
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 04:14:21 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id p4so7858293pfg.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Dec 2020 04:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9A4Sk5yzGnBoQXxaXJoojpAXbsWlJ4ueKRiORr8CZ8=;
        b=aU8AQYyD9RlPyxeHX6sgagW//rSkG7w1RQCw673Z1Tll3iiS2a2GLSf5h/966ARWwK
         lphXxY8mh5nUNB5m0sXrPINeGZHWzrkSSqIma0f6l4hOd5WrutDCb+FgXUvyzg94fl/Q
         o9+Qy0iUY5lbddogvn6ASwtVVwzCADyX3lZUKfdHQQr2NqpDJHFOfg3ssBLKUvwq4/MA
         sTBJeSEZ2coF9SOa1tCwFBaPMHadib/sS4Kym+Ctru+ZLzdTHlFIzIJrj70UWkWZor7Q
         Qp4fm4yzKw9g5yoRAFAJ3CdCRzov0lgDyC4ytc5C1B/7EGAFPNTh2t7fy9XS+l0rx8xt
         byLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9A4Sk5yzGnBoQXxaXJoojpAXbsWlJ4ueKRiORr8CZ8=;
        b=BLJmZnu+U2mKCZ6nqjDg2joZzDETn/eSpNnnDlh12hxy+1XoCMgIJtT16Nor/A9+6C
         pWK8EXNKOj+XIj9xJomoChxinAO956pkD9ucs88i/BaVEIptzKPZ0Dvkp9qI+Wk7R0rE
         IqqzTzZVXtI/+Rd7t7T2eOSZTsYSgfSyT/BPEJaLPi/UT/SR7lWpGviWoVpyLzX0GFNo
         gV95g0JkXHwMn4iwWEJ4p55qGd3+zyb5aoALz0w4Z/cm3HQGwDDqBuwFrg5cPMp+i+Ta
         6q10eW8YDqGZ0zwwZD0PphOHHF7MXu+KD0Nrflq65op6gvUUqzy/oodP82Kjv5TQd4+9
         XxMA==
X-Gm-Message-State: AOAM532Sl9YL9XO9TQ+JFtWK6eKBIw6gjFRBTEQ1RnNeXhOLiDXAHD6p
        lZy3aWAdKWFKvLDKWfXlJz9l
X-Google-Smtp-Source: ABdhPJzfEn8S2FLIVfChKZcdxVrn/YiQ8yFchnbdWGpGFxo88xa206tKhhjsVfkXH/fr2sHJPtdj3g==
X-Received: by 2002:a63:40e:: with SMTP id 14mr15489937pge.420.1607429661277;
        Tue, 08 Dec 2020 04:14:21 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id v3sm3489889pjn.7.2020.12.08.04.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 04:14:20 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To:     lorenzo.pieralisi@arm.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        devicetree@vger.kernel.org, truong@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/3] dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
Date:   Tue,  8 Dec 2020 17:44:00 +0530
Message-Id: <20201208121402.178011-2-mani@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208121402.178011-1-mani@kernel.org>
References: <20201208121402.178011-1-mani@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Document the PCIe DT bindings for SM8250 SoC. The PCIe IP is similar to
the one used on SDM845, hence just add the compatible along with the
optional "atu" register region.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 02bc81bb8b2d..3b55310390a0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -13,6 +13,7 @@
 			- "qcom,pcie-ipq8074" for ipq8074
 			- "qcom,pcie-qcs404" for qcs404
 			- "qcom,pcie-sdm845" for sdm845
+			- "qcom,pcie-sm8250" for sm8250
 
 - reg:
 	Usage: required
@@ -27,6 +28,7 @@
 			- "dbi"	   DesignWare PCIe registers
 			- "elbi"   External local bus interface registers
 			- "config" PCIe configuration space
+			- "atu"    ATU address space (optional)
 
 - device_type:
 	Usage: required
@@ -131,7 +133,7 @@
 			- "slave_bus"	AXI Slave clock
 
 -clock-names:
-	Usage: required for sdm845
+	Usage: required for sdm845 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "aux"		Auxiliary clock
@@ -206,7 +208,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sdm845
+	Usage: required for sdm845 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.25.1

