Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175274710C3
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 03:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241304AbhLKCVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 21:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbhLKCVs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 21:21:48 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E057C061A32
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:18:12 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b1so21093773lfs.13
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIA3ifLQZgBvpxUOMDtRJH8f89HJ9IrhQ5upk51MF9Q=;
        b=k2qpxdE2OMMOv6ocUNsnnFKDOqrMJlOKX5S6n0Qw7NiCewLJyFBmyS5Mr7ChuOPGmC
         Ylo444iRwOhMfTtimPr/kMsb4ZjxDvsavoiD73BQi72Lf1J452hxe8CG9TD+JNqlJuzy
         aboGC+ryaXDvwj4VFi48iU/KyDVWRM5XEoMMbdiGsibQ71q9eK69R7f2oSmR5O5kqbGG
         ydQHg11abk5t+uBwIcQRY38fdel7SXRqda7IOXGd4nhvln3M8FnaGwqndLfY6kI7xYJB
         gguY0IgjkbzzhhNO0ns3wdK+DL+t29+PY+BuE1SAoG1/PyTRJ02840jwusgfRc6PgFp1
         0GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIA3ifLQZgBvpxUOMDtRJH8f89HJ9IrhQ5upk51MF9Q=;
        b=d8FTO19hpEzGYBwcJWTMBZPEk3xSLK73pWNMetzSJX489iEhvjoJ/xdMMKh1zjWDUD
         M0pvWG0oCH/IdwkcVAHmMSVntzs291lYGgqd/TmHyHi9YNUzwwNXJSCU6+gg/YSzsSQF
         9fsEE3m+p9ggZp9x8jzYJjB6B6FMMDa3SIG+aCeFMu/9z2YZl5ulODChhtHH25Fq9nIZ
         AHa7U3tISZIO5Iq4Z+6FQ4ANssWNDBT1MSKSpqofe9D0G9WQt6rmLtcs9xk+qh8z2Fk0
         tp5wWzgUM1RszCna+knArISNcMX/UUYkPCHNV3CYPeNkOWonGTyZNtJFTH3bs18RUUaX
         qn0A==
X-Gm-Message-State: AOAM5316ANFmENadWAmwYl0gg+/fpWwbbLGy1UqRnMniAWaDgRzHrNjH
        zrdqTVlC4ynZ7mOoLi4INUwwbQ==
X-Google-Smtp-Source: ABdhPJyl6riVetPDvIzw6COhpZVX6yX0MUh2ufbEMZiGVLCmPODcTZn5tWjgT61b4v+IAhsxAZ2Lzw==
X-Received: by 2002:ac2:5932:: with SMTP id v18mr15876461lfi.611.1639189090536;
        Fri, 10 Dec 2021 18:18:10 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y7sm504663lfj.90.2021.12.10.18.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:18:10 -0800 (PST)
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
Subject: [PATCH v3 09/10] arm64: dts: qcom: sm8450-qrd: enable PCIe0 PHY device
Date:   Sat, 11 Dec 2021 05:17:57 +0300
Message-Id: <20211211021758.1712299-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211211021758.1712299-1-dmitry.baryshkov@linaro.org>
References: <20211211021758.1712299-1-dmitry.baryshkov@linaro.org>
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

