Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CB9612580
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 23:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ2VN0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 17:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJ2VNY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 17:13:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3093DBF5
        for <linux-pci@vger.kernel.org>; Sat, 29 Oct 2022 14:13:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t4so467663lfp.2
        for <linux-pci@vger.kernel.org>; Sat, 29 Oct 2022 14:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGzWY9dQslOTaDVeaaodx13Gr+GUtkH/icX/AdfHUtw=;
        b=nfMfulGdopVScBdkEjHnHJmLbe/uHlh92wWxPjlO0HFAKQR/DeQ52qgsjVj+u4FSTg
         lYNruJt/uYXneEGKuBeMprrYM2WTEVGw85isBBTumIQSgO6RQRlORpFNd6KDuh1JZlET
         dUlKrf36YIEbuWxForsF5plvaQhOnKaNPl7PkDy7WFqsDBt/P9ErOkYEyp0r6tUVaUNX
         64Y/s4HNKzTWmePzmUJgozSH8q/kDdhY6tDYFCkj/SUas24XGJ6h+Edqxe2K4KR9oeqi
         t4YKZQfgTl637phISAxoahThELmjSH2FjZ0MmzH5BoTUhv3V/LSrfr8MUKZhh1nFIs6i
         da3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGzWY9dQslOTaDVeaaodx13Gr+GUtkH/icX/AdfHUtw=;
        b=Sh8GqttyEjgKex8+s29fR3Em5VxnTUsEn5h+tkOYd3/gba3eyP+fSN9H7pZJqlaCq2
         N2lCSFVoZ1RB2G99F0JtBUETB55HJuOJl4DTzBA4pYxsBmcjEW0ChzcIVSs3Z4g3dYcw
         iwHjOmpjKWZcaGrAIB4rm5sKxlQX6BufkOswiPk9BieZCKrNc4X9Uzd5izRZATCB3mVB
         a8CBhTVZmcp9JJ2hwD67l9ZmkHy+2r6lu7Sl2qax9r4ypHnJTosJ9nvvCLjtejubMaY/
         7BJLKxWENKm8thfsIkgHYlWBuuIDOyF6hzZ4XcAQiwxPB8fKHBCROUWe3B+KLY9ad+rL
         cDzA==
X-Gm-Message-State: ACrzQf2WjJe5TMvBWda+g9JwDCTJdnqX4t5rfCecslPXIzb+Devv9EvY
        DKQ/TppiC7sGQLOqfH1/Dm/GBg==
X-Google-Smtp-Source: AMsMyM4NQkhSWL6l/d/+2ulVs5Jcg+djF+hk7SG4JbzYOLfjNQmX32rzYNGth7Dxl+SBJNYtQENcBg==
X-Received: by 2002:a19:7518:0:b0:4a2:4593:6e14 with SMTP id y24-20020a197518000000b004a245936e14mr2177808lfe.82.1667078001573;
        Sat, 29 Oct 2022 14:13:21 -0700 (PDT)
Received: from localhost.localdomain ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id j14-20020a05651231ce00b004a480c8f770sm433508lfe.210.2022.10.29.14.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 14:13:21 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 7/7] arm64: dts: qcom: sm8350-hdk: enable PCIe devices
Date:   Sun, 30 Oct 2022 00:13:12 +0300
Message-Id: <20221029211312.929862-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
References: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe0 and PCIe1 hosts found on SM8350 HDK board.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 0fcf5bd88fc7..58a9dc7705a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -222,6 +222,22 @@ &mpss {
 	firmware-name = "qcom/sm8350/modem.mbn";
 };
 
+&pcie0 {
+	status = "okay";
+};
+
+&pcie0_phy {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie1_phy {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.35.1

