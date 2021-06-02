Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAEB398905
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 14:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFBMKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 08:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhFBMJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 08:09:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F8C06175F
        for <linux-pci@vger.kernel.org>; Wed,  2 Jun 2021 05:08:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u18so1992887pfk.11
        for <linux-pci@vger.kernel.org>; Wed, 02 Jun 2021 05:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBGbqvseaowVXgAUsLtxjTmL1uju2aQqqvQPrdOEUMI=;
        b=U8QQYLoVQWfXm7ph3TUJQFSPSRUlnkFLfpTG1uiMC+3DmiAvS+jUSZKDOY7JF3ys5G
         nVOXni7qaFoZjGQjYDZnkgl5IRoTEFgYei2iTY0sxaaeiwwI3rWYb2A3hDQ8BGaOA0DN
         lgVg4WnNEAMV8w1mcKxU/EiaTcW44FjT4+j5FlEyiFhw6yIVgUrB+5quVAVTRyW/qJYe
         0EimozaRkfYEzpcbCECq5uL2w/GzKrpiH6mluJ9592AEsR/59Pl5BarUVx/4mMKbH77p
         O1Wwq7HyLo6z1WhFhK42TQlOhsLTlIyl2imXsuzrE3d0sOeUtbztBF9+y2rcDZsLYiva
         C/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBGbqvseaowVXgAUsLtxjTmL1uju2aQqqvQPrdOEUMI=;
        b=VZQ+UyKKBHRr36kdRuBAvaZELCssSrusAixPgg45tGZrfZAYMH0mnE/gRKwsEhvxUT
         S7Rm5s+d3GtBN+oepmcSOlLUBisNxb668Ct2J5bupv7p9h6u94lJo5OGu8bhQobXCuMe
         8JEXzqmPYqFkyt0IFsFn06K9uQ9WfCpIaXWUJgg/m7dwV7R3UBtd0RX9gjC5XIt4+yuK
         1fpcZqywCX5Vy6mtpMHohAqf5XBBAYCn/EpDCl/RjQUiV5CZYtdn7HB7F66HjElBdsnX
         um6yh47t8/+HLekRvVuTAHoNIXw+MFOifckxVMp3CBFo5FCx+Rs8p3Y77AaBkXrY8xcu
         ZzWA==
X-Gm-Message-State: AOAM530AAojfpS7H+AlrNCr47uY3UrNto547YeMbfQw5jfjioLgp+UHD
        lgx45pM40dDiBHaXZwk+E65q
X-Google-Smtp-Source: ABdhPJzK6qVIv0AA6Q+Pl7nNOsUF54kF/f8AEiphPhvhy2+JO6Z4wcPrEuqMwA+RgX6ubuipCmbLjw==
X-Received: by 2002:a63:dc4e:: with SMTP id f14mr32920465pgj.378.1622635694375;
        Wed, 02 Jun 2021 05:08:14 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.54])
        by smtp.gmail.com with ESMTPSA id h18sm12502907pgl.87.2021.06.02.05.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:08:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
Date:   Wed,  2 Jun 2021 17:37:52 +0530
Message-Id: <20210602120752.46154-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602120752.46154-1-manivannan.sadhasivam@linaro.org>
References: <20210602120752.46154-1-manivannan.sadhasivam@linaro.org>
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

