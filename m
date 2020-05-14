Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3441D3E96
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 22:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgENUH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 16:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729341AbgENUHx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 16:07:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6771C061A0C;
        Thu, 14 May 2020 13:07:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h21so10085ejq.5;
        Thu, 14 May 2020 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIcmPOVlQLoKdIP9dCKqwaemztdzBXHNcMiHg1REgA4=;
        b=fpnP/Q+6nJy4o31mD5oIckEGU6bcxuOafcKJUfxs+glztuhCyDNVyJNeHRFYl0D8vW
         xJxRCaLCSrf/RnplWSn7mI/nKm/3tQVrfx89ZS1E0UoawN2DTOohbhAqPQ/vNIG6uz3j
         iJCRDHpRDRwniX1MBHZFLhVbq5al7Q7M4FsRUdvHp+PI6nCx6hgZvxffpZgxs9Qczi5Z
         rdMVADolFvtE7Frt4Y3ZpD4WD9BrW+rVjvvbX0FsM4O6zsTL/pA9vwHvIxVKt2KXuG58
         rjpSLWtesmc5ZElgXASXGneSatmoii1DNPnNSsVqNtrIyluqXGqWjI6BvtGTzyzPEtum
         JHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIcmPOVlQLoKdIP9dCKqwaemztdzBXHNcMiHg1REgA4=;
        b=X9C0KiXbRInVqUEITTPXLy41AkAogbXMl1CTJkc0a6/p+FWIXMhP12FR8QgxqT6GKG
         xu91JJspZ4FXfNt1mJII8htkai2ICgN9pr5SZRfP9g/4CJUZonems7QDzAywCD+DsKeL
         /HiZLxS7mUddmjZhrOQQK8gWqT9iwDB7Cr0TRRxNxMcrqHWeW2+8NdhWRAVSeLP7C0xY
         oLFbY+oxeAWaapF7ZQDmh4j3DyZQPSHM518CO65ProeP6WPWyXFFu7dyrtpmWMuNIsQ9
         YMjib29bKim338oVvQnvjH2ro8IOp0+wVdksai7CHaC+4TXPEhI39I5HNCo38+Vdd6At
         XnqQ==
X-Gm-Message-State: AOAM5330eHYkBq48FhPtfren9LOP5iSbx46DD/Mrcxsh8MWR086S+z7O
        5FFyETeguEnuH/58f0EXjJpQEaAjF4xK7rxB
X-Google-Smtp-Source: ABdhPJyRGO9wm+gCCe6mXjqsw7tu9oPDHpd/XeSCsaDTZNsLORKQAPSJOtvL3PxxwZHMu6nPpbBJdA==
X-Received: by 2002:a17:906:bb07:: with SMTP id jz7mr5347432ejb.317.1589486871352;
        Thu, 14 May 2020 13:07:51 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host122-89-dynamic.247-95-r.retail.telecomitalia.it. [95.247.89.122])
        by smtp.googlemail.com with ESMTPSA id bd10sm1472edb.10.2020.05.14.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:07:50 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/10] dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
Date:   Thu, 14 May 2020 22:07:10 +0200
Message-Id: <20200514200712.12232-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514200712.12232-1-ansuelsmth@gmail.com>
References: <20200514200712.12232-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document qcom,pcie-ipq8064-v2 needed to use different phy_tx0_term_offset.
In ipq8064 phy_tx0_term_offset is 7. In ipq8064 v2 other SoC it's set to 0
by default.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 6efcef040741..02bc81bb8b2d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -5,6 +5,7 @@
 	Value type: <stringlist>
 	Definition: Value should contain
 			- "qcom,pcie-ipq8064" for ipq8064
+			- "qcom,pcie-ipq8064-v2" for ipq8064 rev 2 or ipq8065
 			- "qcom,pcie-apq8064" for apq8064
 			- "qcom,pcie-apq8084" for apq8084
 			- "qcom,pcie-msm8996" for msm8996 or apq8096
-- 
2.25.1

