Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5E1283351
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 11:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJEJce (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 05:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgJEJcb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 05:32:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCA7C0613A7
        for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2020 02:32:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g18so3511395pgd.5
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2020 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ChHcHi6Ji1r+llty/7EuPk/EuojfII4VV6B3JIzI5g=;
        b=IMmJFZlZMNauoUwA97x41mJ25Tg2rWc0XRfHeKKxD2uCdoGfQJRHvMJuU7TR/qKP+a
         rtRSEXn8GCK/oZKn/mFkrlX5pwa1yJd4cBxiMJ/f5Mg3pdasJ1HUrvUoxab1rOVQW7f+
         Sv82vprlPG5lUew3vgriaoBsWKXBF8UV/jWrNR42C943l7VrinnNPCaW8OMcheyWr4eV
         MhE3L8cnNwm42ETC5ipAwrAYHtsTB9Cs1uXZOhJk1GQEbKcsqpSyybgEJZ7tUOHhC73O
         IGI1lPu0mPAKbdyEIzd+bOBtt2ZRmL2y2PNMGW6TWMH6fYh9NUfycAoQPdgRNKxOPaJH
         E4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ChHcHi6Ji1r+llty/7EuPk/EuojfII4VV6B3JIzI5g=;
        b=SYfYOqY1BqkOpFT9Eo2hEUswJa/zkLuC0rRqK3Fj0B8rAhSzASdGX1nOUVXD3vHzZ+
         JKtVE6ogO6q2ckT0qt7XkGyEOSLDFvscWd+3h2mNlWqq+XhEnzP4qOwI441uhCov+Nx+
         byCyXJDzi/2U4//e73QSxuRHPtu/akMmVQNifzZMZ9mzBYPoM+KxZQaxFh9guQIt8NUn
         7W+yqMHYODl1XPnYrEeqJm+Q1j+KM8F/2+MHAevp2Mr1NwKrqHJbLvb8/nPUSCBneDip
         xwiJu9JHslc15f6Gc6MbntQxX9f8a/++5q3KAZedK6DSj+QMDVAYmpIjDgCANGNdorwd
         uhow==
X-Gm-Message-State: AOAM5330xADhkNx6dAZYutysw0MrwNSc/bgZpG23lUu/ALaX6qIoF0DH
        Ggq5/n6N5P/sIkTXIB5RGeJe
X-Google-Smtp-Source: ABdhPJwRF6fvFfl+RkAIX8EGGlD5IQYL9bwGLdGAYu2IZQqC026RH22a0USbJiLcM8qn9ykXtQKf7Q==
X-Received: by 2002:a65:6685:: with SMTP id b5mr13769766pgw.385.1601890349715;
        Mon, 05 Oct 2020 02:32:29 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 124sm11298894pfd.132.2020.10.05.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:32:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 3/5] dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
Date:   Mon,  5 Oct 2020 15:01:50 +0530
Message-Id: <20201005093152.13489-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
References: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the PCIe DT bindings for SM8250 SoC. The PCIe IP is similar to
the one used on SDM845, hence just add the compatible along with the
optional "atu" register region.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 02bc81bb8b2d..3b55310390a0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -13,6 +13,7 @@
 			- "qcom,pcie-ipq8074" for ipq8074
 			- "qcom,pcie-qcs404" for qcs404
 			- "qcom,pcie-sdm845" for sdm845
+			- "qcom,pcie-sm8250" for sm8250
 
 - reg:
 	Usage: required
@@ -27,6 +28,7 @@
 			- "dbi"	   DesignWare PCIe registers
 			- "elbi"   External local bus interface registers
 			- "config" PCIe configuration space
+			- "atu"    ATU address space (optional)
 
 - device_type:
 	Usage: required
@@ -131,7 +133,7 @@
 			- "slave_bus"	AXI Slave clock
 
 -clock-names:
-	Usage: required for sdm845
+	Usage: required for sdm845 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "aux"		Auxiliary clock
@@ -206,7 +208,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sdm845
+	Usage: required for sdm845 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.17.1

