Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B582A2D1F4B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 01:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgLHArn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 19:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbgLHArm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 19:47:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F564C0611CC
        for <linux-pci@vger.kernel.org>; Mon,  7 Dec 2020 16:46:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id a9so20758532lfh.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Dec 2020 16:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1u2DTU35s5v+QWW65SOSmEBZUXo9vu5arDprO0wJOA=;
        b=dcQseYuw7NM3r+BpBn+94yioXxvgEj7JjteLVNUbY4ju4Nj1OcmD8P0o36iAIVeeEP
         QMUSqLLUqPAD4O22umC6HWafugMbpJNrebl3/H/PJtw08jkrp2jQBPn7E10cD2ewDU1p
         W/eY+lERpIDQ6CEAUsdmRxjQlAuKg5hrTZ5FMVL6B+EPP4bm1WmMZz94ramYuFsIxgDB
         cDYn2sZTfjxqhGxsniUDBZJjcrJezPPeRNVS5wYl7X1CD91dmtKhcTFKj6nZBb+C17b3
         cY30nZ31+oPNBC3xuJrHgKML//5uZAvwn0tM5MrENT8qfzwgmfbVh6F24PLwKGa2u5QD
         YHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1u2DTU35s5v+QWW65SOSmEBZUXo9vu5arDprO0wJOA=;
        b=J94+tPO9snSOE465FwC0jyPJYbvFOkiboSbC4utZSEV/z3GYE1+nhxwTTCg4UvmkJh
         SKc2KCWOlgh+YdDPm/Qa4agbgckqQ7naiP2PXzjmT7U8hf9Fe0egZrZaHdxM1sbaXDNY
         6JAIC0t9XpoP3ohTVugARcddqrMjtNoXLcwsfQ800+MKYyRA5qXEYVs+rwjpuPdDTAao
         ePiZ5xe/w7z2QDjgw26uxNWlJFqfvK3fhOPbdDttP2xE9HZwk3ipvJoNGvJ75/8iWIbN
         H+MS851LfaT3qpsX17+DK0LJD7WfwKOkLrBaeMIWrzHNVurlIiKTP2rLuRTMigD6CpKm
         fpww==
X-Gm-Message-State: AOAM532dhEAOtgsB/3PX4DuELJey9C1VZXSlEN4FurStXodNflne4XuO
        NaPoOp2OX/Gcnz/IyWMsvqVxTw==
X-Google-Smtp-Source: ABdhPJwaTOpDQ7/S3gKxSJua9cBbl4t8nVqLhDrZe1Ov3wtb/BRHF3LA6qT8PFrsj/wxI53HmhkBvg==
X-Received: by 2002:ac2:5a47:: with SMTP id r7mr8683699lfn.525.1607388383609;
        Mon, 07 Dec 2020 16:46:23 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.229.141])
        by smtp.gmail.com with ESMTPSA id d3sm3028229lfj.206.2020.12.07.16.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:46:23 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sm8250: add ddrss_sf_tbu clock to PCIe device nodes
Date:   Tue,  8 Dec 2020 03:46:13 +0300
Message-Id: <20201208004613.1472278-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208004613.1472278-1-dmitry.baryshkov@linaro.org>
References: <20201208004613.1472278-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On SM8250 additional clock is required for PCIe devices to access NOC.
Add this clock to PCIe devices nodes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index deed186b1a84..4a6e11e78b35 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1345,14 +1345,16 @@ pcie0: pci@1c00000 {
 				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
 				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
 				      "slave_q2a",
-				      "tbu";
+				      "tbu",
+				      "ddrss_sf_tbu";
 
 			iommus = <&apps_smmu 0x1c00 0x7f>;
 			iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
@@ -1437,7 +1439,8 @@ pcie1: pci@1c08000 {
 				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
 				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
 				 <&gcc GCC_PCIE_WIGIG_CLKREF_EN>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
@@ -1445,7 +1448,8 @@ pcie1: pci@1c08000 {
 				      "bus_slave",
 				      "slave_q2a",
 				      "ref",
-				      "tbu";
+				      "tbu",
+				      "ddrss_sf_tbu";
 
 			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
@@ -1535,7 +1539,8 @@ pcie2: pci@1c10000 {
 				 <&gcc GCC_PCIE_2_SLV_AXI_CLK>,
 				 <&gcc GCC_PCIE_2_SLV_Q2A_AXI_CLK>,
 				 <&gcc GCC_PCIE_MDM_CLKREF_EN>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
@@ -1543,7 +1548,8 @@ pcie2: pci@1c10000 {
 				      "bus_slave",
 				      "slave_q2a",
 				      "ref",
-				      "tbu";
+				      "tbu",
+				      "ddrss_sf_tbu";
 
 			assigned-clocks = <&gcc GCC_PCIE_2_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
-- 
2.29.2

