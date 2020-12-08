Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EE02D1F43
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 01:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgLHArM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 19:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgLHArM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 19:47:12 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7A9C06138C
        for <linux-pci@vger.kernel.org>; Mon,  7 Dec 2020 16:46:22 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id h19so907203lfc.12
        for <linux-pci@vger.kernel.org>; Mon, 07 Dec 2020 16:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iMeYx3PuOFeT/ou7cP6t4OiaQH+OiI6hASKT4SyHXP4=;
        b=plXKbgH1XkCLdCGGiX1O46e+mERn8lchrvrv9dK3Sr9L4mOghPw5HhQz4rIoKSTLnp
         HxU9mdDKOZAIxt8F1nNvYFP7AT+4aXhBMrJWGJl7UI79BKrx/UquQ83wkYpFx1fKuscP
         LAJ4vVdSc8BMznhZpiofqLHte19wz4EJ3Nzl9wDFDpLMW63gLVLuHTDCdq0wmmw857s2
         ULxEEh1u3nZ5tkYQQas/vDC1g7AtbcNDQ/0RJ8BsJRBrKEYSC2ax65ka6DVZwopNdtyJ
         n3ZilaKXXuJxj4VsQBAsHp4fsrrOhBqMfF6MUhcl3CTkU9uEblsDfs4y8D9qCXbt8nxY
         jnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMeYx3PuOFeT/ou7cP6t4OiaQH+OiI6hASKT4SyHXP4=;
        b=WAbrjUvjI6uEr4zsYNnvC8a565R5YMOv/qLezOASXZogLK6tThznoB2mydJZS1tgKz
         bKxBm+MRpwAK7+BDZwKj+hYec9WSiaTn5AqSlEvnO5j0qRKyUU+B13PWm6ccAYA/6jEE
         nH52P87hRPBSHW/8SjtmESRV3F2k82DuTVhwPwcprBBFaUG2N2Gpw2RAHaqKvIo5FzB9
         CGgbGnMF4Y2DiGdGyc7VjuUj18Lzodt5GVA+qBy9FQ7kNihXui5DAti+voJBPcXbM7AP
         GWBy2QSZk1VfjEKC2CHYAqMZuXmo2r5oFgM5WFT2Chm+8hYd3BQvcFrScSu8jq5agCYY
         o3ng==
X-Gm-Message-State: AOAM530p9mQyzH8e3mNqy/5P+mTsjkDri2oi+nQJb18jA+L9xCleSY50
        2LlLnPa/MCBIcaAAkL8QPa7GNw==
X-Google-Smtp-Source: ABdhPJwbvUrdi5CDciG/D+wS0Nn+liIRxKlNfGmYY+fFeM4F89RLWMsV50NVfh/HO2J2V8kGqAafxw==
X-Received: by 2002:a05:6512:3690:: with SMTP id d16mr10009389lfs.321.1607388380637;
        Mon, 07 Dec 2020 16:46:20 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.229.141])
        by smtp.gmail.com with ESMTPSA id d3sm3028229lfj.206.2020.12.07.16.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:46:20 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: pci: qcom: Document ddrss_sf_tbu clock for sm8250
Date:   Tue,  8 Dec 2020 03:46:11 +0300
Message-Id: <20201208004613.1472278-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208004613.1472278-1-dmitry.baryshkov@linaro.org>
References: <20201208004613.1472278-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On SM8250 additional clock is required for PCIe devices to access NOC.
Document this clock in devicetree bindings.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 3b55310390a0..c87806f76a43 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -142,6 +142,7 @@
 			- "bus_slave"	Slave AXI clock
 			- "slave_q2a"	Slave Q2A clock
 			- "tbu"		PCIe TBU clock
+			- "ddrss_sf_tbu" PCIe SF TBU clock, required on sm8250
 			- "pipe"	PIPE clock
 
 - resets:
-- 
2.29.2

