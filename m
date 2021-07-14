Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863AE3C804C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 10:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbhGNIgl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 04:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbhGNIgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 04:36:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F10C061764
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 01:33:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id jx7-20020a17090b46c7b02901757deaf2c8so982073pjb.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBGbqvseaowVXgAUsLtxjTmL1uju2aQqqvQPrdOEUMI=;
        b=DJ9YnE3ngEe0jYQuWtwKj6BzT1epPGW0zyW78ZbCveShTZTUHkL/JiQP9S6bzo8F8F
         l3paefGgmM9pRe5VtkkRq+WeH7yGtHUihQ0DsOtD1TwMVV0fdr92lRnSgTk1ySg6TuXA
         Fzk+wh2ARsgs/b/dkmLIeNHk7sU+KLvZzM2oHC05J0oDHNC4I9dppJ0FjIw757H7JiwK
         nXVqD+jZ2zq16S9diEyUYkwx0/MCtzlVoOUQLcmbXGoaaQFXb7fC12Hgmxk4cZjqrRlM
         WrNJzOwc0/VkCV6CYJtEU/4gBDZPIKMo7GC1bBaS7EqQuXtUiN+aaPbQQwpFsHeQaTT1
         W7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBGbqvseaowVXgAUsLtxjTmL1uju2aQqqvQPrdOEUMI=;
        b=cyvqe/dUQirVj1Rv9eVNQWm36iqKHoSloTsplzS7x6rKlc/yEPPjm5JOfNsUMv9Ay/
         AmtFuiN8f9tWKrl/pco3mLAk53Zan+Skqe8YuzxUwiX9T4kW8cVRl7bo9edWDAFPXrjP
         d6iDaGSjfAxhtgkNqRATtt4rdOKZwNNRewy+VsXRYGpltTQXhuJcKDBnapDCckazD+N8
         /8HzdwmDGI99MW03J3fULSGz1ikJn03Jp8+gee5+FQjME64rWHJm/IyDA85QOmdpikyu
         ZkzPOlGCwu+GNYDvs+57F7BPA3wDg6/0psQQaDZO9Y+K8C0Zr1CB8buDZGJDMCz8SdMQ
         NjxA==
X-Gm-Message-State: AOAM533bm46ZijFoAuH6Ionq0RNq+qs29uVDJtMoYHJ56aDDFfjRmOWj
        hRUBdpYzTRRMTE/ZjeOIPSOK
X-Google-Smtp-Source: ABdhPJxVPTaoeeFm4HleyI7+aCvHDOhg5OcAq43DlRs3qQUlyHhh3E3vCjq9zoPN+9VtgoXRvcvR/g==
X-Received: by 2002:a17:90a:5907:: with SMTP id k7mr8764652pji.196.1626251629553;
        Wed, 14 Jul 2021 01:33:49 -0700 (PDT)
Received: from localhost.localdomain ([120.138.13.241])
        by smtp.gmail.com with ESMTPSA id p40sm1774446pfw.79.2021.07.14.01.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:33:49 -0700 (PDT)
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
Subject: [PATCH v6 3/3] MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
Date:   Wed, 14 Jul 2021 14:03:16 +0530
Message-Id: <20210714083316.7835-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714083316.7835-1-manivannan.sadhasivam@linaro.org>
References: <20210714083316.7835-1-manivannan.sadhasivam@linaro.org>
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

