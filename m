Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F75474E5B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhLNW7K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbhLNW7K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:59:10 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46EDC061747
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:59:09 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id k23so30622777lje.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIA3ifLQZgBvpxUOMDtRJH8f89HJ9IrhQ5upk51MF9Q=;
        b=Hbk81jbBWzzZySvKhC2/9pPEMJi0e0d5HTobngzvbXKIhB6NXmauh4Wgij1d+aLaeL
         k9qn/bxmtzqbSz6+tngDb1kexxJ6bXiNmJ4ao6ZxGih3nHjrENR98B6DDx1GOJuzvPcq
         76yP+xijpmyLSP68BC4VZ38vDVriAd9/58rPlSP0ZXYHvJbw6UnZ3sIZE6cnlr13dRfF
         AbHoBLETCChx8NbRdOltD7QPXsNraFJxFCGGJgeKW1ZY50xQI41sYlZKLbmq5k327+59
         Yhgj8a9pQ6LB8WwONBvDLec2jJQy9+CEmJaM/ZicTnQ/YrnogAnaqlhSeBgaoAwjGt9O
         uBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIA3ifLQZgBvpxUOMDtRJH8f89HJ9IrhQ5upk51MF9Q=;
        b=xLx54vN3ziuEzGRKaEaMUA+DuxUlLoCYmkgX78gBvVmrACQeu90JK/YKYcCikMBDaU
         WloDGvXZBhYCcJngvUENoWfrX5LFoNtGbqrHZwfP/r+Qz5rNLtzAGW6Uxc6UtWS7exiI
         wR2JsYWphlU4qEy88nAoftIZyarzL+vzr+ynTZPEisn/FMkif+830nuEsiwpSuPnY5qw
         tWzYUa4OtqUB2Q+XH2QpZC9ccFzxhrOwwr2XrF8vviaWW5Ur4lmcKmem7NsMPKBUPyRU
         P8TALmjUeD+/vLWW5NCGoYkB5T4lFDmu555dCmuQi83cR6SNQopN6OWTic6pHLhQXAkJ
         S06Q==
X-Gm-Message-State: AOAM532Qibs5ey29ma6QINBqClToMDeFEpB4RgaAeVFiXQ/efMvQqRVB
        X7LqIZcqtjyzHZi+bDgw1Lo6zQ==
X-Google-Smtp-Source: ABdhPJyccFBgO1amcfDH5C00rIP1MKZeIJ1ovoQM577J+Iu6wGkMn8SG3pvsIUlqNJHgJ2nor2iYjw==
X-Received: by 2002:a2e:94e:: with SMTP id 75mr7375813ljj.494.1639522748100;
        Tue, 14 Dec 2021 14:59:08 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t10sm45115lja.105.2021.12.14.14.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:59:07 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v4 09/10] arm64: dts: qcom: sm8450-qrd: enable PCIe0 PHY device
Date:   Wed, 15 Dec 2021 01:58:45 +0300
Message-Id: <20211214225846.2043361-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
References: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe0 PHY on the SM8450 QRD device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index cd74b97b9018..e02d3c86e365 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -346,10 +346,20 @@ vreg_l6e_1p2: ldo6 {
 	};
 };
 
+&pcie0_phy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l5b_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
 
+&qupv3_id_1 {
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <28 4>, <36 4>;
 };
-- 
2.33.0

