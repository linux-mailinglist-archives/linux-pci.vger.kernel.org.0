Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA553D232E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 14:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhGVLcv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 07:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhGVLcq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jul 2021 07:32:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9153BC061796
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 05:13:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a17-20020a17090abe11b0290173ce472b8aso4002880pjs.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBGbqvseaowVXgAUsLtxjTmL1uju2aQqqvQPrdOEUMI=;
        b=MffmZA+8W2f1Kokpv98SrCuZFW73UW9/NaYK5d2w4ctJvjr1dWlq9TaYgmYcgQUVm3
         QV9cuUTVVRPEWozlvoeC64n1bJd5iDR5pCn+gvyALQnuTeYHEL7NhgcUzhr+5Ms0CS8f
         aeHozzPsJFagR8Pv9X3NwflkAGYzVHmUbRZMy1OVLQXdHkcpnVakDoh+G705Kj1Znjwc
         Uy9hQtDu+wdistUWq3yPvLF2pQAQIT2cYFB7paOAPUASV5owCY0RzT2VBAzCtdYX3S09
         fJuxczjKvkgUvlB60+nTWMCymb7QRxz36uaD3Lb/N56uLJmHQm/vGi/m/UIcDsYbj3AM
         7QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBGbqvseaowVXgAUsLtxjTmL1uju2aQqqvQPrdOEUMI=;
        b=lzFKd5dJqXEwecZKThKbvRGgvOYADQmpry8QTFgS268PX4i1vA/7o88xVXRYzJnCV5
         5bY616rjUnWMFlXmipkQD0AV5sf/PZiGUM2IboBbNVUeBDVQ+2r6L0Sbwdj7RlupmL0v
         C8B53Q+IMdqZiZBAbUK4S77mheyGqDXEaZrtmQZitjiEGj6K4W95MDKIViRzs9K9P6wj
         uvJ7CJO+TQAdNXVg3GPEgjJl060hKg04QSXH10MLCGYYzNqK9elo/SzDyzcNv8aXrXSn
         vU6YUGKVyF8OYImJE0tfcmiTOQ8EqXLE+6RfV2qNuSeoONeZ0+59O0F7zyw6j28LRMYt
         VIlw==
X-Gm-Message-State: AOAM5304JVNPhpaBZsgZEwuOtQWQXiZtzacI5WrZmGmQ6WKFcLap+DK2
        62w5usWuF97+1JnEdhbvhHlw
X-Google-Smtp-Source: ABdhPJy/TPnXiFxfi1X0TTMzUVAeJN+6AbjyH2Yboi4ozzviDpf017R9CALoCl8Mt1zWU1qbuEDcrg==
X-Received: by 2002:a63:2b91:: with SMTP id r139mr40459040pgr.242.1626955996137;
        Thu, 22 Jul 2021 05:13:16 -0700 (PDT)
Received: from localhost.localdomain ([120.138.13.30])
        by smtp.gmail.com with ESMTPSA id cp6sm2913846pjb.17.2021.07.22.05.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:13:15 -0700 (PDT)
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
Subject: [PATCH v7 3/3] MAINTAINERS: Add entry for Qualcomm PCIe Endpoint driver and binding
Date:   Thu, 22 Jul 2021 17:42:42 +0530
Message-Id: <20210722121242.47838-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
References: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
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

