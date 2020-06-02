Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6601EBAF9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFBLyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 07:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFBLy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 07:54:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B607C061A0E;
        Tue,  2 Jun 2020 04:54:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c71so2622066wmd.5;
        Tue, 02 Jun 2020 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/L0NRU1j/c6I13faHhGrI6qUdNFYftXq3aP75qQONs=;
        b=H5iPQh7P5hbp3kjJ/ZsGNjlnY9VHbU2mRjDwUmIDxFc943pGU5IpOfFXdQUReTCFL5
         Q3v/lJt9hhNAgpSqw6Nb8nnhV8lz8i61rAHRBK9FLVWui7IaCM6W1ccn+X/Nds70uvhQ
         PxpSa8lty0pnFoIo+4HA6JZK9ZyuM/cA1Wgulrz+ncMC+dIBToCoFh83blqsNstcjRde
         R8a/sOW8L2bsDnqurBRISTK+dLhLC7+ttQArO15xrzp1dszvdF0T6E141u7XaxV5O+SO
         ZLisW3l94GHdRrgmSCap3uzygJKTAKvBN1GYAe//R9Pff3seY6cVh/qpb/1c2zoPlN9O
         9Ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/L0NRU1j/c6I13faHhGrI6qUdNFYftXq3aP75qQONs=;
        b=g+IvGfnS8LjWQm0O+QjX0o0+RYUpeyp0FJVyy51ZOUzmfjwICnMd62q9+mRZXnvDRp
         3uke//dq/LAEC9atyIBpkYXC09++005tWwu//NvzzezXDRXW388MrGnR4Q/Na8tnxfdE
         WIV0YBWit53/sLu/GvKRrru4La9n0xw1lWGAwUwSqiY8uiEy3iWGXBU4Zkr4pAriAsED
         3+cXmA0Vu70LA2d3dymAmnsT2n12B/Aw5WZIMcKMqy02pNGID2ipAA1NHcb1rFUylaNR
         Bs3RbNRwWXTf0MiN1NqGyMTVxy+ZhhePHUi8htGj6aEE4xyJemfsIYM1KHDjIzNmbOFr
         RGLA==
X-Gm-Message-State: AOAM532Hz+4Ntnp3YT1czsF2dKJfp5q0VtpkNAMa0XBCbvLlPXzo2ZZv
        D0fxDJb38SMKwlE/QKwaYng=
X-Google-Smtp-Source: ABdhPJxQZlzTjxZlSO06cWa2BcZm5j8JiMMqRfavfmoJaaQ99uKt+xUFJroxOnoTFPx+OfwUVCXHSA==
X-Received: by 2002:a05:600c:4410:: with SMTP id u16mr3788930wmn.88.1591098865243;
        Tue, 02 Jun 2020 04:54:25 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.googlemail.com with ESMTPSA id b18sm3273777wrn.88.2020.06.02.04.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 04:54:24 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/11] dt-bindings: PCI: qcom: Add missing clks
Date:   Tue,  2 Jun 2020 13:53:43 +0200
Message-Id: <20200602115353.20143-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602115353.20143-1-ansuelsmth@gmail.com>
References: <20200602115353.20143-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document missing clks used in ipq8064 SoC.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 981b4de12807..becdbdc0fffa 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -90,6 +90,8 @@
 	Definition: Should contain the following entries
 			- "core"	Clocks the pcie hw block
 			- "phy"		Clocks the pcie PHY block
+			- "aux" 	Clocks the pcie AUX block
+			- "ref" 	Clocks the pcie ref block
 - clock-names:
 	Usage: required for apq8084/ipq4019
 	Value type: <stringlist>
@@ -277,8 +279,10 @@
 				<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 		clocks = <&gcc PCIE_A_CLK>,
 			 <&gcc PCIE_H_CLK>,
-			 <&gcc PCIE_PHY_CLK>;
-		clock-names = "core", "iface", "phy";
+			 <&gcc PCIE_PHY_CLK>,
+			 <&gcc PCIE_AUX_CLK>,
+			 <&gcc PCIE_ALT_REF_CLK>;
+		clock-names = "core", "iface", "phy", "aux", "ref";
 		resets = <&gcc PCIE_ACLK_RESET>,
 			 <&gcc PCIE_HCLK_RESET>,
 			 <&gcc PCIE_POR_RESET>,
-- 
2.25.1

