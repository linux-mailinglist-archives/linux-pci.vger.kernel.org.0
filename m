Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425C326C88C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgIPSwn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbgIPSJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 14:09:11 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31936C014B4B
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 06:20:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s14so1466772pju.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5s2OUZCDflGBpNiiMYF8VZ/rpqqREpl6Irg9+FFR3Vk=;
        b=NqUX4p6KC31mjYjb6a8ZPzh9HBzezca3cbhSrtPnPidF4/1VgpVRZbRoEMicyqBiLe
         WwfFpdYzyw7CJ0GQAnw+UtsBuD0hRHu/r0MAumZDaHnN3SsGdf/65DmO3Kx5f4uqHmqB
         BPOmscD+r9Q+h+7S7soPOA2abpGYq7IrKjvPK7zKORUyeT4U7IzC0xI7C+mBuG6/w4k/
         OoWEvRft34YvhW0ND3CUlWmbO0bqybDvJfVCaTQnxWgS4uVk0hN1VWD7QFLAoppZ50DW
         s5yrg60hPTgEZb3dvj3UcgvZHMOf7QY8LNQAAp2PTwQLU3fXMuIdfLYDe86uwQzVpHBF
         IqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5s2OUZCDflGBpNiiMYF8VZ/rpqqREpl6Irg9+FFR3Vk=;
        b=IkpPMF2BUgR95ADK2F8UOCrRA0KHi7FS5WVzQo7+wEgvtVrQXyjVuRk99fGetY6KkA
         WFxTvwgpI8fJDzoSt4HpDK2pXTakk3SCi+GKcWTreGxIZAo/GPZo7KFAurShW/oOTcHO
         yAw3Lkjk5ODC6GMxxQyhTTG+dEPmbFY8EDu5NdymL4JVcFw09taLe9HKPa5+34JQLW2o
         ThhKSW4nXEYJbeFUoY2wbhPF2Rq7d8aFtQkJ06eTWsML3CsCncQI6T0pLRWPz6NQjXvN
         xeygajlcTk9/Vxl0mh1spt/pjx9ntgahJVMP/6/pf4sVKH+SK3wbigujD+QiKSH5JKXz
         9LeQ==
X-Gm-Message-State: AOAM532aWpY2qymLQonrk7m4ACMm/Ea+Iw5Z1Vj1YsBqwl8BDx+oVUA0
        nor57QDgWysLjzcz3uMAMc++
X-Google-Smtp-Source: ABdhPJy1z8xlfaGfrcZD+FaGvKIz4VnlQLUuanzk8reyCEFaiGaGiagYH1ormqbFWxVH+F83rlwkew==
X-Received: by 2002:a17:902:b192:b029:d0:cbe1:e7a1 with SMTP id s18-20020a170902b192b02900d0cbe1e7a1mr23946966plr.18.1600262434531;
        Wed, 16 Sep 2020 06:20:34 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id e123sm17615726pfh.167.2020.09.16.06.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:20:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
Date:   Wed, 16 Sep 2020 18:49:58 +0530
Message-Id: <20200916132000.1850-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
References: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the PCIe DT bindings for SM8250 SoC. The PCIe IP is similar to
the one used on SDM845, hence just add the compatible.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 02bc81bb8b2d..7fc328c54c39 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -13,6 +13,7 @@
 			- "qcom,pcie-ipq8074" for ipq8074
 			- "qcom,pcie-qcs404" for qcs404
 			- "qcom,pcie-sdm845" for sdm845
+			- "qcom,pcie-sm8250" for sm8250
 
 - reg:
 	Usage: required
@@ -131,7 +132,7 @@
 			- "slave_bus"	AXI Slave clock
 
 -clock-names:
-	Usage: required for sdm845
+	Usage: required for sdm845 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "aux"		Auxiliary clock
@@ -206,7 +207,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sdm845
+	Usage: required for sdm845 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.17.1

