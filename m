Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6F33B7C42
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 05:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhF3DuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 23:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhF3Dt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 23:49:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05266C0617AF
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 20:47:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l11so865388pji.5
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 20:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBGbqvseaowVXgAUsLtxjTmL1uju2aQqqvQPrdOEUMI=;
        b=Q/gTFSEluhO6QXeK/1FsEs1PAmQsPz/TTQ+TAR15JWVVbrLncIiHkHVSVc1VvMVUy9
         Ia7PnNfLP/FPYsFJkH9sAyKnOHaf70a6llcftOMIfZ2oZvfjIS1OdPCK0qreFCBz+t0O
         zWX6G4ZGOsrtLZzS/t+eBBllUTiUYbAJWqD7wBCnC89QUvfAyQPdBu2jbK7VWjFtVz+u
         FqFXs6HqWC9fNf8VHjm5TRtAAxh17kJoixKbMezAG0SAMrQOFoReBpkg7HckGO5wbftV
         +gJSWLFP7zBGTtBsFgE+9nnwfxsZLeiAGKJIU20pWafLbP3g5Exdti6jdb4WL+No23YI
         dWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBGbqvseaowVXgAUsLtxjTmL1uju2aQqqvQPrdOEUMI=;
        b=ClHi6luuZVeDBqiH+otZ2VdsCPi+CRkJr/BOW8a7KqlUKdEV+ue3Yz054vwwbXA8iJ
         97nB0722lYf9Qtka4U+X+lAnsHh3ryJ6UOSJn+T1kichMnteMMI/1Ekutlrv+LAxhoZS
         GlNTzU44oykMRdvxqed+Jb9yTvf1xwuY1T4YKIERnFa5OepPcDqmH4/iWIg7in2weP44
         04SOZSJRNI16OqWHB9mcif5nBQ7c5LWOLtxBNsWN0TUp80d4nqYXSvP9d/a3Yk8UtJIk
         8YK9hcln6YrpDHh7Qxb3e5nztirCCN44U9KxsUECguk/JnujEuy0cq57H9qkswZzECPI
         eTJg==
X-Gm-Message-State: AOAM532dqxIU+cvbmv50l8c5eCb1DyPhUH4kN+mB6Ut4GxY8zz/hipxH
        zvfi4DGiPDyGt1Dm3aH0RJe4
X-Google-Smtp-Source: ABdhPJyAKgHoWXBDNFabsNgroJMyKN5RUxpqpSla4hAP9CGFJEal/o480FHJYK+Hbrord/Q4/dMxjQ==
X-Received: by 2002:a17:90a:4cc2:: with SMTP id k60mr36993659pjh.83.1625024848491;
        Tue, 29 Jun 2021 20:47:28 -0700 (PDT)
Received: from localhost.localdomain ([120.138.13.102])
        by smtp.gmail.com with ESMTPSA id j15sm19565081pfh.194.2021.06.29.20.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 20:47:28 -0700 (PDT)
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
Subject: [PATCH v5 3/3] MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
Date:   Wed, 30 Jun 2021 09:16:53 +0530
Message-Id: <20210630034653.10260-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210630034653.10260-1-manivannan.sadhasivam@linaro.org>
References: <20210630034653.10260-1-manivannan.sadhasivam@linaro.org>
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

