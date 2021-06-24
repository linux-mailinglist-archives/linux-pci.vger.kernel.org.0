Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC13B2893
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 09:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhFXH2e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 03:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhFXH2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 03:28:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46505C061768
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 00:26:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so2916795pjo.3
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 00:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBGbqvseaowVXgAUsLtxjTmL1uju2aQqqvQPrdOEUMI=;
        b=rfeNjALnsdRnocOgQep2/GLYnJGjRc1WjxIn1Xc02z4Wk6smdmyeDss8WDcsTLPIfL
         Myr57xBgLa0KylpBWSZXBKQVvSTRuJF8pJtWd2XRkxmzm9vJeAtYlRm/EeTI5kPejveX
         YUmv4GI8LCPqbS/zIX1fCe2IXo1MR4AnGEUJ4sE0B4PpSYs7LxofCZwig44hSKLNHUrB
         YB9EwLXewAx6BQYeCyyGZ9iNaihebdvwvtaEPErNYiZetLqJVFg1iKec/QT8bCUDEH0y
         2mhdXGndkdexIRV1t4Gcvyf0idaUv1OQWbAof50y9n5zh1BIxOdRpee3Ynzc4BU4JOh4
         o+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBGbqvseaowVXgAUsLtxjTmL1uju2aQqqvQPrdOEUMI=;
        b=aoVEHrEtahFEyrkha+kWyEPjOTTNbEFtqZ95ka0OYu63/RLxxdkTLI6dhjW7PAlxvV
         VyOAElbPetacVcyijejs1h3ru2+qW0ha3uROJ3p+f/30O+YdsPPSf0Qa5odbceNdVAoM
         M47oEIo/Y9X9IRwpSjJqro9/oxqq3Xm8lgmpdmMh04QO7MmuJKel/erDK/F1V2TS8TcG
         mionv8/KEir1mTg5B0GktLUJjLPQnzizr19LBsJ+4oO81nVF4t312Pnf35sYXSnSjnHJ
         eMhwPQOpB73lLMpOBuyPuhfsoMj3DG3nwWuzav9EcAe59rOdsz2zWjPWbe/qlA9LqKZN
         ozZw==
X-Gm-Message-State: AOAM531nChSiS8y8ZAEqWZO9RB/87D1oNBnCAg2dY5BcIBgQ+82T8Bg3
        11x1GOUEAEuahEGKo9tiexop
X-Google-Smtp-Source: ABdhPJzs3r+zSCr6iGhCazDTh+Irhpi94KXfvEQ6RKy0/fdm/RMDCeFfNHrtUd2/lxyVGF9iNc+faA==
X-Received: by 2002:a17:902:a981:b029:116:a139:6054 with SMTP id bh1-20020a170902a981b0290116a1396054mr3143757plb.60.1624519568820;
        Thu, 24 Jun 2021 00:26:08 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.173])
        by smtp.gmail.com with ESMTPSA id g13sm1923802pfv.65.2021.06.24.00.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 00:26:08 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, smohanad@codeaurora.org,
        bjorn.andersson@linaro.org, sallenki@codeaurora.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 3/3] MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
Date:   Thu, 24 Jun 2021 12:55:34 +0530
Message-Id: <20210624072534.21191-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624072534.21191-1-manivannan.sadhasivam@linaro.org>
References: <20210624072534.21191-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add MAINTAINERS entry for Qualcomm PCIe Endpoint driver and its
devicetree binding. While at it, let's also fix the PCIE RC entry to
cover only the RC driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..cdd370138b9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14254,7 +14254,15 @@ M:	Stanimir Varbanov <svarbanov@mm-sol.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-F:	drivers/pci/controller/dwc/*qcom*
+F:	drivers/pci/controller/dwc/pcie-qcom.c
+
+PCIE ENDPOINT DRIVER FOR QUALCOMM
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+F:	drivers/pci/controller/dwc/pcie-qcom-ep.c
 
 PCIE DRIVER FOR ROCKCHIP
 M:	Shawn Lin <shawn.lin@rock-chips.com>
-- 
2.25.1

