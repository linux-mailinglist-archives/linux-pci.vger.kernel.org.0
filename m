Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA492E7FF4
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 13:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgLaMiZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Dec 2020 07:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgLaMiY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Dec 2020 07:38:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E3C061799
        for <linux-pci@vger.kernel.org>; Thu, 31 Dec 2020 04:37:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o19so43877061lfo.1
        for <linux-pci@vger.kernel.org>; Thu, 31 Dec 2020 04:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HaBccR5ybXZm1ZGk3nqecCV5+MAmIR/4lQjnxQMdJM8=;
        b=sj9tK+BSzEiPT+hgbEfxVpk7REc70wu2vhzVW6DjAgjnTCokycgncsXUKIGA/SrQz6
         LlOdEryv0OeEnv58xeehdYfE9j0t3ibQSmiX8nvmQk9n5iL/n000BsID6ovh84Oe6rVM
         B3asbJ1/Cyi2L1iiFYptK8ubQ8Vxv388s67PqGWGgg51cb5WRkPQ0D63w2jpiT3tRiFU
         afDgurc0h0FvLY5t+WD+OJA0JWtF/uKGhIwo3SucNExXptCK37LEqSIRh/jQgZ76t8R5
         H2EC6Y3tVl/WIH9IwMp9ct1EL+oNg/C33vpMtzHTeuoSQRBhM4VygJ7HTQzfQfm8CmeA
         h+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HaBccR5ybXZm1ZGk3nqecCV5+MAmIR/4lQjnxQMdJM8=;
        b=nc+27G+Hms6hZ/6yCCp/FZoNwdC4qjWiIoZeJbU/MX38vBZfYtG1mRIboEnOj444SH
         YilxcGM9p0yYXjPGYIMnon4+4ywIy/aU66Jt0SX8hycmmn12NKSG/TYAefiBB4D5aP3u
         5LsVgvzmmLPW39txXnl03UaOmTjYBffSbmd45kgx2sCT3QPnH5u0wgOL9BabWzQg51Cn
         6Rsv3nG23qRMrkoYQeE0LTxLHLDTNNYgmuUodRkGZXYrIc6PFCWLZ1HY+zucocetGZqn
         uO/GfmEcuE/k2Rs9/b0GeXmNszsmILMlVzAZIy90QGYTdsMiMwmOhp8EpuLArnyTovtg
         7Rsg==
X-Gm-Message-State: AOAM531zynsAQzwPVkVHClGLltBLsgB/y/YeQyEwpujv+ar3E6R+Z8be
        kM73xdnIhxsTd9bb7OnbgPUe0Q==
X-Google-Smtp-Source: ABdhPJwI51BmEs3qGI8FDNKF5ss/e87Y6rR+GVHAxagEmJYMv7AInbAEgW3EW5XY/9nwPGuqTdzbMg==
X-Received: by 2002:a2e:9153:: with SMTP id q19mr27384001ljg.173.1609418262800;
        Thu, 31 Dec 2020 04:37:42 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.115])
        by smtp.gmail.com with ESMTPSA id o11sm6228624lfi.267.2020.12.31.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 04:37:42 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: pci: qcom: Document ddrss_sf_tbu clock for sm8250
Date:   Thu, 31 Dec 2020 15:37:30 +0300
Message-Id: <20201231123731.651908-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231123731.651908-1-dmitry.baryshkov@linaro.org>
References: <20201231123731.651908-1-dmitry.baryshkov@linaro.org>
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

