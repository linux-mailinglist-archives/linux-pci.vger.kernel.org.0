Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AEA2F900D
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jan 2021 02:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbhAQBbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jan 2021 20:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbhAQBbb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jan 2021 20:31:31 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9010DC061573
        for <linux-pci@vger.kernel.org>; Sat, 16 Jan 2021 17:30:50 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e7so14532539ljg.10
        for <linux-pci@vger.kernel.org>; Sat, 16 Jan 2021 17:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tf8Myeu0NiVasaQllGDJf9giDfGqj4Lr7pfXB9rMYOo=;
        b=bzh8H1o7OvBYKYZ+AUzTP0kObTcxG67VlE7t4IciX+DNMBw4buWt3PpsPy1ugyWDaU
         G1wR+AlNBL0CF7lNBdmJXw/zmskc4d7AXi6To71O2waK/ssnMrChLVK38rLhLUbiLPG/
         cFbShffgA1YjuObRsbST9vvpUo4+EOfo8hj9jiJQOmvrI7DWda4L73e8iICl+Zb21gc2
         hg4MxgiS2KrgK/P1qtQa2S0VJpt7pA9NPtzVEn/PXacjwb3OyRAXJdM7uZ0Vgi63zacs
         oyoI47DhDpTp+FcPPyVEbP19sGpGjarR+Gwh8noKBuqGO9mZcXzjP947q5v6A/YMdQvq
         Cybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tf8Myeu0NiVasaQllGDJf9giDfGqj4Lr7pfXB9rMYOo=;
        b=KWjL3+psBWIdbdGg8GX/489EP8e7MCTNdkJLGwRhS4b1U8C+SpUtlTEtZTWmKKfA4B
         FwhIOF7a8N22GCZQtBl+uUJMQcRKobdhkyafftMckWaEVqY5AhNs3Dm2oq8wNQpMAKgi
         AdHVMF7jA/TIYtLPHXAiVmJ7cJTZQi/2/T2/8jyIc/NE6sFjOcX8xJIeyLx9g5lXfZaf
         XulVb0VZLBxE1TJSLOFjAf2WdYKH82g3oVi2FerhwEVSyDVO10jCAcwW+VLs7sE+AJX/
         RmFBxaA7QgUC6nDUedeEebEP94ikdJAkwhysmV/xoXcuKW1kQVnbWxPZXHKgwN1VStnu
         17Ng==
X-Gm-Message-State: AOAM532uNtJHdxXM/nrYdPd6PYfN7cDZtVOWhA+kvb1LOpI59374eD/3
        aU544S9FweYtTN5qZ9YfsFrReg==
X-Google-Smtp-Source: ABdhPJzCDmMat/1UUigYllAFwd42mjPpe1qj4SNZ/2UrU65qWRdj9vEqkxPR4+SWN10VoNs9u+OiXQ==
X-Received: by 2002:a2e:9654:: with SMTP id z20mr8451972ljh.54.1610847047709;
        Sat, 16 Jan 2021 17:30:47 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.101])
        by smtp.gmail.com with ESMTPSA id m13sm1260909ljo.121.2021.01.16.17.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 17:30:47 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: pci: qcom: Document ddrss_sf_tbu clock for sm8250
Date:   Sun, 17 Jan 2021 04:30:43 +0300
Message-Id: <20210117013044.441700-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On SM8250 additional clock is required for PCIe devices to access NOC.
Document this requirement in devicetree bindings.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 458168247ccc ("dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC")
---
 .../devicetree/bindings/pci/qcom,pcie.txt       | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 3b55310390a0..0da458a051b6 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -132,8 +132,20 @@
 			- "master_bus"	AXI Master clock
 			- "slave_bus"	AXI Slave clock
 
--clock-names:
-	Usage: required for sdm845 and sm8250
+- clock-names:
+	Usage: required for sdm845
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "aux"		Auxiliary clock
+			- "cfg"		Configuration clock
+			- "bus_master"	Master AXI clock
+			- "bus_slave"	Slave AXI clock
+			- "slave_q2a"	Slave Q2A clock
+			- "tbu"		PCIe TBU clock
+			- "pipe"	PIPE clock
+
+- clock-names:
+	Usage: required for sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "aux"		Auxiliary clock
@@ -142,6 +154,7 @@
 			- "bus_slave"	Slave AXI clock
 			- "slave_q2a"	Slave Q2A clock
 			- "tbu"		PCIe TBU clock
+			- "ddrss_sf_tbu" PCIe SF TBU clock
 			- "pipe"	PIPE clock
 
 - resets:
-- 
2.29.2

