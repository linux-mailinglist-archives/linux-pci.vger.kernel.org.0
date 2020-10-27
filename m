Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0818E29BF1D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 18:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814982AbgJ0RBD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 13:01:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43789 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1814977AbgJ0RBB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 13:01:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id r10so1129474pgb.10
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 10:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bnf/sDW9eWFD4ivwYAY59qhXKkgEzsER/rycx34AMMs=;
        b=PB5k0bv6HN4dhEqOCMk7AFo/AuT3HEdF8kikIhIr29seCDl/P4o1nHZm0I/J2EuhAw
         l5/iluB9lxX5ZDiC7fmQc5Hy6UYLsybhMfa31l2FUg7PJaO7/ZuJbmbGgG+tw8sqorfE
         oKjTA/cCXAuBp3SVtBXe+rHPCXizkn4AzjjprUOpQf89TNNxsEn2+GGzyEEBz2qYdRvb
         qn1BFD1SZIZGmTx2OTQLfT9r6A2x0AoymUrwxHIGgEKA82vO8IdZjdJxtIlxMkOddkHi
         CthMZ2CzY6XHclgwzbtK0k1+0f6u8zO/6LrarDAY3GqT6DL0uBzZsWLduDSNLoqvhioz
         hhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bnf/sDW9eWFD4ivwYAY59qhXKkgEzsER/rycx34AMMs=;
        b=tkFL1jIN3ZrpdwfrnbIiUuRkzJZqAN+ZrWKNwtVEgz2oI7bARSD69MC82Kgl1sSklI
         o6KEYIhGhCK8Ta9uUD3bcxhw4Hn2WZ5QYdjvIJhHdffSF6UlPnviLPXaGGaXgipK6Tns
         gwYi5bIm2fIpKUIFFKhgZG/qNwMqH7tFEb6exi9nwlj+dr0gC9d42D5RAkDfVxKtpu88
         9eGSkoVErN9VAJjiEWpLnlJOpEXtSMEhsov2Kvwusb/fVIVC1Sd4w2Wj4OjsSSdTI7Za
         qacLmwzG2zcMxQ3T4fxDmRt8nymtz0vhIF/N8txl8kuXZLuWYB/wUY5ofXJPE6an4s+A
         4Phg==
X-Gm-Message-State: AOAM531DVH0Rv915PIsVfUNU2C7mTjEr9dt+8EBiaFtH2j+gayXgTHCp
        2sFvMJTBIDPA65G0L6j7Y6hJ
X-Google-Smtp-Source: ABdhPJx3cOfqk/XdTQmKMt+/AzGsm/mm2ybtBTZnTvdnybUrYVJbipJqvc270cFoNlNOqCDXj5178g==
X-Received: by 2002:aa7:9424:0:b029:15d:5340:83b0 with SMTP id y4-20020aa794240000b029015d534083b0mr2529299pfo.73.1603818059906;
        Tue, 27 Oct 2020 10:00:59 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id x26sm2845206pfn.178.2020.10.27.10.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:00:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        truong@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 3/5] dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
Date:   Tue, 27 Oct 2020 22:30:31 +0530
Message-Id: <20201027170033.8475-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
References: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the PCIe DT bindings for SM8250 SoC. The PCIe IP is similar to
the one used on SDM845, hence just add the compatible along with the
optional "atu" register region.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
2.17.1

