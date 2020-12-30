Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB72E7841
	for <lists+linux-pci@lfdr.de>; Wed, 30 Dec 2020 12:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgL3LzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Dec 2020 06:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL3LzB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2020 06:55:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D3C06179E
        for <linux-pci@vger.kernel.org>; Wed, 30 Dec 2020 03:54:21 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o19so37181177lfo.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Dec 2020 03:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HaBccR5ybXZm1ZGk3nqecCV5+MAmIR/4lQjnxQMdJM8=;
        b=SBK5iVE67Nalk6ZLr+Pis73kf+jH6CqYLNsRHK5Wo5tRfHTfLPz/S9JquiIMIGUyhb
         nIh3GEWjeL2ZylKshSCCe+oLdIETwxdO9zcTu5B42AfZ/BOrowoCThcNyM616tjdw+oM
         nP0l+z/C3tWKSqc/xnLH9tzfWUYtHcAHOYpCOXbejIPscwLXUG8WGn/tpCEoNamScYlD
         Qmfa8jOC/+6xsVCXLmsdIShuGXRpQLOpcTHo0flKaogZJxgc6vXpfmwc2weunSJWSJfh
         VrGHpzZMk0tgfFwD1Xq7UXh7Uy3Md8/2O0OouL1CfqYJgTGNAlewuBy5tofkyvCZCjkC
         +MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HaBccR5ybXZm1ZGk3nqecCV5+MAmIR/4lQjnxQMdJM8=;
        b=o+w+SVLLPQVA7cwQBNtlNIpaccOcMjEruEY3R6696U3nnViE3NLjcwzG4zrOcAXDjr
         01fei+oDtLJD44ETq9kHKlEUnhSR2V8CPYhSBYdg0aFj4HvhySxkDAXGBbvtB1xzNQSY
         zC1gCnMA+6PR6Vp8+Nftbf4vBWWUyZX/ncU+HotEAliUrJtcE9UpnhCEBoWo8LOD3d6k
         m+fDt8NBuMJwe7czuwtTH2ni3+48bKeGYVenxi0POhTFqrNTmkrrMrB3OYERr3dJQuKG
         lxGLjNVNseDO6Xi7ZWrLyKcg21IcbTii0LqXDqV/VZGNnL97citvRY4EwNN7VhZf6/28
         vxuQ==
X-Gm-Message-State: AOAM5320b1HTi7aJr+y7Lx/Fm4epeYpMyLBU61W6L7wZkSHPIrdmo/xb
        81KRq8NE43FsZQiZeTMVPuh47w==
X-Google-Smtp-Source: ABdhPJwYVB/HQllDCUVNbSy6DeVCOtVK/GJWkCopdFnd92pw6sC+c+WsYr9X0wodjPhNNmhXf+egpg==
X-Received: by 2002:a19:2d5a:: with SMTP id t26mr24132861lft.241.1609329259725;
        Wed, 30 Dec 2020 03:54:19 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.115])
        by smtp.gmail.com with ESMTPSA id a8sm5931484lfo.206.2020.12.30.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 03:54:19 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: pci: qcom: Document ddrss_sf_tbu clock for sm8250
Date:   Wed, 30 Dec 2020 14:54:07 +0300
Message-Id: <20201230115408.492565-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230115408.492565-1-dmitry.baryshkov@linaro.org>
References: <20201230115408.492565-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On SM8250 additional clock is required for PCIe devices to access NOC.
Document this clock in devicetree bindings.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 458168247ccc ("dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC")
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

