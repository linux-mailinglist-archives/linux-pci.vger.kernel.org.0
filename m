Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032D12F4F2D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 16:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbhAMPuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 10:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbhAMPuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 10:50:22 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65D3C061795
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2021 07:49:41 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f17so3039405ljg.12
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2021 07:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tf8Myeu0NiVasaQllGDJf9giDfGqj4Lr7pfXB9rMYOo=;
        b=PRDeZ1RptrSpXSi/4MBnSFXHwVd7YllXBCGpSjrYsoEPi/7Y1o9rDiEcBGOnaad3qC
         inJ3BCtZLUH94jaYcI0DwaTN1abnmDWIBB+9wOAEGUVmY5WEj2ULLeje5SMF6daEqnfx
         K69thpcdN0DgbUsNVt5m+f29xH6SnIpZBveAl544A6TSoF5W9wGE3yCY2sFZlK5WZpv9
         dxkej9kNmX+E697tHWE5KFAHqdhXeOyRikkKysU5/ZzgcUdOYLGVkP2INN0A1oHr8KSn
         EDMT5A7+O5X8wCqviYkPE8VF1T/poNqnh3I9XVZ05CHV0wLObAGkRwYaqsYQR3dI1/Is
         9l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tf8Myeu0NiVasaQllGDJf9giDfGqj4Lr7pfXB9rMYOo=;
        b=hvnrqPVuG/CeYTBZcFmhGnbvJFpzU7LtgQESknq/og2dHGDwIvb3kLn4d5wsAHk34/
         DbtQslhSbPM6h9TT7skyT9qzNLPPt6pvsNYoble7mj0/AAVfunZMsEVw6d0uT1N1dw0S
         cKi/mw1npO91IAOMtkvUkJI1I4MxXIiMCAXsWcs7dzeccAWaArbVdk9Ku03u6Yvk/ObN
         ELmsBpda685ZVBp+83XKuamnk8Hj+ZwN6w557h1tNTXCbe+j/mmL0k7+lPvsAyBFlt/x
         fFSqn3ZucAxqdlhy4FL53SSmN/LSmxhRNPZDezbJJaUCj+WJRe+T74mFsZSP/5A5WJqG
         iP0A==
X-Gm-Message-State: AOAM53278MH6fHAgcXfWDTH25/A6vXld6zNicY61aCkaNAtX/WbVRCkk
        W9xQG4KCTKR+QLrbtwc1TNVEFQ==
X-Google-Smtp-Source: ABdhPJxcVYwr2caK/01FCNGWFwz/g53wUnVkIt8xCwISMJNVjJ7LFmOi0/4yN6qAq49u6sQTsMEHyQ==
X-Received: by 2002:a2e:b4a7:: with SMTP id q7mr1203647ljm.391.1610552980264;
        Wed, 13 Jan 2021 07:49:40 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.189])
        by smtp.gmail.com with ESMTPSA id g13sm246828lfb.43.2021.01.13.07.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:49:39 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: pci: qcom: Document ddrss_sf_tbu clock for sm8250
Date:   Wed, 13 Jan 2021 18:49:34 +0300
Message-Id: <20210113154935.3972869-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113154935.3972869-1-dmitry.baryshkov@linaro.org>
References: <20210113154935.3972869-1-dmitry.baryshkov@linaro.org>
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

