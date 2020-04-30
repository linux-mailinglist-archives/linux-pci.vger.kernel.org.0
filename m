Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8BA1C0A03
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 00:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgD3WG6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 18:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgD3WG4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 18:06:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1EAC035494;
        Thu, 30 Apr 2020 15:06:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q8so6016743eja.2;
        Thu, 30 Apr 2020 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1PEB75T9vhNli8IGbA8jki4mGo4pTtbkW42Phxv8eA=;
        b=msohcg/+zvVBWBp/LV/9TYGzKCx1tBKTA3R8ykh2656KuiULAoYBq/qDQWNyhp7bUB
         vnKvsVh3EYMDBjtiVoXT20Qhqvq9OadqGjNJTqJqUPc4dpp9qUs5C/CSCeSs6C56gjGv
         g22quSEm9H3XO/Bq6DKicQF30fbP700QU60s7m0LKlPYw6J7q9sAzocqqPi47QDTLHq7
         e+1bcU68cj6yWpQMSZBfRvVBqx/yPPhG0hjzgDJZyuzy1unoKkidIdl6XwZGvMvZWeTE
         kT2mB+eguVoUmDll/o3IOK0VN0eMfEHMKnIEkQJTnnsIBLZ6Yi+MJl9e4E6WllD2bcaQ
         uRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1PEB75T9vhNli8IGbA8jki4mGo4pTtbkW42Phxv8eA=;
        b=FWaYOYcVrnjDKCbpyIs2CZMi5BmrYTdjJKPn1xrGJhX2UDK3a83qjinIW+mbSjqFs7
         GOHJZy8e7yKtrJfq+bczpFyd3BXCvQp1/cF0AuEirFQ5FF000QTkFcaUe7AJnFrjIY1Y
         ZMUuohlzsK4cFHLV2hhLG19zDTq74XmzncgFtVHUYDviImrM05uuIUkKJ76EitpnWl95
         +8w44zDbWvPB+RZA0ez8GWkS77oBx9BNk4Yx/cUdOEC7M7EBf2BqXgbmvzeWF9GlQgkU
         gZMlQGni8opMmrDEhTHU60R4fwZGXxo0QDJ0DXdIFHE0dlwrBduhbAZmdC1pq+wWRwPK
         TRxQ==
X-Gm-Message-State: AGi0PubemePKCcSzq4ihBIp+xUgBClP6YndZZTM+/IDuiRGyCc3u6mm0
        2X5ndtd4B5Fh1sUz7caarqI=
X-Google-Smtp-Source: APiQypKuDx3EydaEc0EcG2mW6wzDegIebMGM0I462nb1cc/jtaFvAb/PfwIeFV24N7HZ4h6JEs6Plg==
X-Received: by 2002:a17:906:4dc8:: with SMTP id f8mr573477ejw.23.1588284415074;
        Thu, 30 Apr 2020 15:06:55 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([79.37.253.240])
        by smtp.googlemail.com with ESMTPSA id t17sm54185edq.88.2020.04.30.15.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 15:06:54 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
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
Subject: [PATCH v3 08/11] devicetree: bindings: pci: document PARF params bindings
Date:   Fri,  1 May 2020 00:06:15 +0200
Message-Id: <20200430220619.3169-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200430220619.3169-1-ansuelsmth@gmail.com>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is now supported the editing of Tx De-Emphasis, Tx Swing and
Rx equalization params on ipq8064. Document this new optional params.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/pci/qcom,pcie.txt     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 6efcef040741..8cc5aea8a1da 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -254,6 +254,42 @@
 			- "perst-gpios"	PCIe endpoint reset signal line
 			- "wake-gpios"	PCIe endpoint wake signal line
 
+- qcom,tx-deemph-gen1:
+	Usage: optional (available for ipq/apq8064)
+	Value type: <u32>
+	Definition: Gen1 De-emphasis value.
+		    For ipq806x should be set to 24.
+
+- qcom,tx-deemph-gen2-3p5db:
+	Usage: optional (available for ipq/apq8064)
+	Value type: <u32>
+	Definition: Gen2 (3.5db) De-emphasis value.
+		    For ipq806x should be set to 24.
+
+- qcom,tx-deemph-gen2-6db:
+	Usage: optional (available for ipq/apq8064)
+	Value type: <u32>
+	Definition: Gen2 (6db) De-emphasis value.
+		    For ipq806x should be set to 34.
+
+- qcom,tx-swing-full:
+	Usage: optional (available for ipq/apq8064)
+	Value type: <u32>
+	Definition: TX launch amplitude swing_full value.
+		    For ipq806x should be set to 120.
+
+- qcom,tx-swing-low:
+	Usage: optional (available for ipq/apq8064)
+	Value type: <u32>
+	Definition: TX launch amplitude swing_low value.
+		    For ipq806x should be set to 120.
+
+- qcom,rx0-eq:
+	Usage: optional (available for ipq/apq8064)
+	Value type: <u32>
+	Definition: RX0 equalization value.
+		    For ipq806x should be set to 4.
+
 * Example for ipq/apq8064
 	pcie@1b500000 {
 		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
-- 
2.25.1

