Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74084CAFE5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 21:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbiCBUc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 15:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243923AbiCBUcY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 15:32:24 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84598CE939
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 12:31:36 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e2so2569419pls.10
        for <linux-pci@vger.kernel.org>; Wed, 02 Mar 2022 12:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aVyDbY8mWFDs86ZSUd7TuJOdBkBFLjs80gN0LS4pVY=;
        b=Tl7NEZvhUZpdTwcmNe+f/k3vBpnZvUbtaafcgnb2OUtQN33/NOBKA/oOQ83psaAVPk
         ggqvLNZym/zESiPo+8EUetAQy/d9qUY7s2BiZt0LZkm0sKEeA5/D8/HwZvEckCcIEdrY
         OQanc3Gn4bz62tkHmduupGz7wi+r28JZYuSuoQBa2yQRigViwFSMqIzy7JDPEbcoOms8
         7eO7Nrxq3LZKUCFVQjdIrgMFoRgJQRgcTujW9CfhQ5Z4NZRH9Ylgnl8iamL1PuTHzPXz
         iNpAIRTpPJKf57odccoTGvQgJMBzIzUUxAFP8IDV5dBcD90xXnj2fDLHZ1bq8MQvAzRK
         Kjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aVyDbY8mWFDs86ZSUd7TuJOdBkBFLjs80gN0LS4pVY=;
        b=sU1/D91yVjLf1KzOQNdkynRO+ltI+0cXXYPPj4uHQerfeQ8b7VR07b+7DZFXaTI9gV
         +wJMf9xqtDIoVATOYV6GIEwfhyW+JiCsyhlwpaay4DKkz6MIHjw4LYZCX3Y7sfkybABd
         mKKEdB0CJ97BoKhZwXN5p+x2OTG/sQa6x+wSM1V6po0UjLsMuR9m83V0RQdKAExGa2cO
         qoniAWmsI1mO9lkuGFTinB/egg5jgKJn3gDbxEIzhUu2VpAZAQUHEGXvCdEozASgnUIj
         msuFHrAq9ZOBgJY6VKiyN8GAGZAWsRXpA7M7BDK9wQ7ZRhM/5FAxZj+5Ds2Ip34qNW/v
         1Ulg==
X-Gm-Message-State: AOAM531uv7NQlezfwmjIsyzwjP+5nsHRlg1DQ5VEhutSrwd7BweXoCRU
        7qaq+jaq1JowyYUxwUNiU7vfow==
X-Google-Smtp-Source: ABdhPJxMxp1gqbVtF9DFn3Tc3YJZqRD1Zo0skonvDO+wrA4GxmhhC4lZ0Rzrnob3c5L5q3wx3aE5MQ==
X-Received: by 2002:a17:90b:f8a:b0:1be:dccd:e4f7 with SMTP id ft10-20020a17090b0f8a00b001bedccde4f7mr1627856pjb.92.1646253096058;
        Wed, 02 Mar 2022 12:31:36 -0800 (PST)
Received: from localhost.localdomain ([182.64.85.91])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090aa58100b001bcb7bad374sm5963410pjq.17.2022.03.02.12.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:31:35 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        lorenzo.pieralisi@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 7/7] arm64: dts: qcom: sa8155: Enable PCIe nodes
Date:   Thu,  3 Mar 2022 02:00:45 +0530
Message-Id: <20220302203045.184500-8-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302203045.184500-1-bhupesh.sharma@linaro.org>
References: <20220302203045.184500-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SA8155p ADP board supports the PCIe0 controller in the RC
mode (only). So add the support for the same.

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

