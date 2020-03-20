Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B618D745
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCTSfw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:35:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36112 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgCTSfZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 14:35:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id b18so8338222edu.3;
        Fri, 20 Mar 2020 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d5Q+JvD546i1L7ti3v3OL3QeW2KwMU10K29j39zfoQo=;
        b=IvtmddBbqDS/zvg2gGsbe6VcQKjuOzlgmxrRbAinSOgLeRlIJM6xd3WiGtRDKiy3Kr
         tjjhTHgrjlw2JGOR5IItPneyx7DDyQxzkiMLi9O3jvxJgJACTnEtpkxxC4vnf3YR5kvj
         R3t7c6WtOvuVOTFi/GuuJTtoyTz5luCRxyt3GIAe6LDBwkCWKgCKsqpM/w3QWD5q81xO
         QF+mITnhdrUKandtBzat5xgbxMnWMb5O9eyOG/OsYWogpUv6anlCbLEt86Y4x3n9OHIq
         OjRbmPkwXyuxvhBRTb4ZzS+k6PocjJF2aw8gA/2VQblipJnGicascnbKGTuvZ5G4Izci
         uCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d5Q+JvD546i1L7ti3v3OL3QeW2KwMU10K29j39zfoQo=;
        b=gVMoi3Hfpl2s8EtaQ97eZSaj5CS/f+PmbUj1DA+vNWZxy47LjEf4tXDIwJ8qAXVxx4
         OObcVDgHQfSwrZZB8hHco1T6CRIjgnOaERIMq0jviZcwprmKBU9ScIQ33uBLOSdyj6gU
         8wg7z7ceU3G0B0LkvgcNqu6T0ta7T9Yvez/Vud5yhmI19ywUY0bdAcIZnAs9woDyYaxk
         OqvOzjU3mfDKiLkHkM5viGwlAy56dNgaKYzkKhMus+i6w6NrrC1Z+w5ZvH3I/XnLjkhh
         E0BX3Dh8Y4E5yJBG16KpAGn9kRje0rndiR4NOJ2aQSc5yxGwNcIttXChTaJGRD1iBRtW
         d8Ug==
X-Gm-Message-State: ANhLgQ2hBTofP/ofm+/s8muAJuaECofwuecYvKv2GMqfHs0EwEiZt8xK
        cqLwnl/OmYRqNwSR7mEa6eo=
X-Google-Smtp-Source: ADFU+vvesVNF75eHLQc3i/fSa0rd93YziTbREy00MG82rlkjGWnqTGXJ4apvXnbDRDbYAtDm+ZKyhw==
X-Received: by 2002:a50:cfc6:: with SMTP id i6mr9390937edk.314.1584729323621;
        Fri, 20 Mar 2020 11:35:23 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host203-232-dynamic.53-79-r.retail.telecomitalia.it. [79.53.232.203])
        by smtp.googlemail.com with ESMTPSA id y13sm172916eje.3.2020.03.20.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:22 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] devicetree: bindings: pci: add phy-tx0-term-offset to qcom,pcie
Date:   Fri, 20 Mar 2020 19:34:50 +0100
Message-Id: <20200320183455.21311-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document phy-tx0-term-offset propriety to qcom pcie driver

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 6efcef040741..8c1d014f37b0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -254,6 +254,12 @@
 			- "perst-gpios"	PCIe endpoint reset signal line
 			- "wake-gpios"	PCIe endpoint wake signal line
 
+- phy-tx0-term-offset:
+	Usage: optional
+	Value type: <u32>
+	Definition: If not defined is 0. In ipq806x is set to 7. In newer
+				revision (v2.0) the offset is zero.
+
 * Example for ipq/apq8064
 	pcie@1b500000 {
 		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
@@ -293,6 +299,7 @@
 		reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
 		pinctrl-0 = <&pcie_pins_default>;
 		pinctrl-names = "default";
+		phy-tx0-term-offset = <7>;
 	};
 
 * Example for apq8084
-- 
2.25.1

