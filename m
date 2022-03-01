Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC704C8515
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 08:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiCAH1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 02:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiCAH1A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 02:27:00 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AFC7D019
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 23:26:06 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e2so369207pls.10
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 23:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zqsit+rOnmNUmUZtDFG33t7bXRXpX6/2jlTb49W6F6M=;
        b=XVXq1CqUkOy0IauKoQqHPRVEBDOmFxsVbMCBCVSpMUTt/yZvXTvQxvbCz/HG/S69Q/
         wwMTH65MgQohU0oNjMp1FnEuFWHDW0eNfoeN3aIk21r8FZZvrnMZU//LlIUHMSbXKQDV
         xDysHZftETGFVUFXS1OM7O/KKHFvWR9OwxjevkL2Lyqk73wHDTEMpnESbRXR1H13n1pY
         zGk9G7XmiL1/nZE9ftRRcXSO9iq59bDQ+t6lJgfF36nSB8zPuKUAXjFqJKRrytvXmrGh
         QxrstRz0p2xzoJ4kZhByWVGjC04ReqyaWLmtX7/DAoPEPYWh3zcZets17Ryd5ZMR8C+K
         YIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zqsit+rOnmNUmUZtDFG33t7bXRXpX6/2jlTb49W6F6M=;
        b=wCb4OL+pkcLs4so5a7ZZQW1cWv3JTyl3c4H3FMr4jdaiNvWGOeLRqRsMB275YxoISy
         pgmDwTbeSyf2z1utR10d50E9NNg13zsldADKado5zdFAhOg4c9+wGVoz8ez7ynFdPosS
         EAgR+o1oEKfm6BCYdBg+thMg2f5hIFX3dlYza6J/CbuoQzT2Vh7sKWtgYn9Se/Y64PZF
         n+HJH4o1LrvuX8rcSt3QoS1fTA3/p2czDGaxmi8Or5G2UD9+FxfrVzyKxDigPi4+hhHd
         tS63uOULxyirOvDi/NEkA3LinoLUPcU2tPqpAfer99It+yHSQoay0IMENPnsCOYPlOHX
         L3cQ==
X-Gm-Message-State: AOAM532eM4VCUtMz5OEFYpaSuU5SYBspHuW8eEKcXoJOyqAD+1UqIiYG
        Ex4PZqFvWAJq0Z4o6iASzv0vQ+HoEKOFOA==
X-Google-Smtp-Source: ABdhPJzJGVeQhFZly8+WyH4nDCQf2KMJMEKARcT98uKhQvoA/Cu0zleaoxSFfcjFu38e5cJcnQ9oig==
X-Received: by 2002:a17:90a:dd46:b0:1b8:8:7303 with SMTP id u6-20020a17090add4600b001b800087303mr20399140pjv.197.1646119566426;
        Mon, 28 Feb 2022 23:26:06 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id m6-20020a62f206000000b004e152bc0527sm15680445pfh.153.2022.02.28.23.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:26:05 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 7/7] arm64: dts: qcom: sa8155: Enable pcie nodes
Date:   Tue,  1 Mar 2022 12:55:11 +0530
Message-Id: <20220301072511.117818-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
References: <20220301072511.117818-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SA8155p ADP board supports the PCIe0 controller
in the RC mode (only). So add the support for
the same.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 8756c2b25c7e..3f6b3ee404f5 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -387,9 +387,51 @@ &usb_2_qmpphy {
 	vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
 };
 
+&pcie0 {
+	status = "okay";
+};
+
+&pcie0_phy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l18c_0p88>;
+	vdda-pll-supply = <&vreg_l8c_1p2>;
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l18c_0p88>;
+	vdda-pll-supply = <&vreg_l8c_1p2>;
+};
+
 &tlmm {
 	gpio-reserved-ranges = <0 4>;
 
+	bt_en_default: bt_en_default {
+		mux {
+			pins = "gpio172";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio172";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
+
+	wlan_en_default: wlan_en_default {
+		mux {
+			pins = "gpio169";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio169";
+			drive-strength = <16>;
+			output-high;
+			bias-pull-up;
+		};
+	};
+
 	usb2phy_ac_en1_default: usb2phy_ac_en1_default {
 		mux {
 			pins = "gpio113";
-- 
2.35.1

