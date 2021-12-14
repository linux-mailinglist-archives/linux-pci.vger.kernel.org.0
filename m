Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203D4474E42
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 23:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhLNW65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 17:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhLNW64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 17:58:56 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6741DC06173F
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:58:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id l22so39636939lfg.7
        for <linux-pci@vger.kernel.org>; Tue, 14 Dec 2021 14:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGQ7+P7dGN15uBsAWu8DCnSdKjv7k9ltm1L6whtQ6u8=;
        b=RRxSNtHhs2h3wp7qIAKQ3zxUzizk+I+E0TjmDd6EtkvKbSPPWEi7gKOcHB3Kxnmubz
         VVvSUcgF9b6wgdM1HhQ6IDR8p0dT8L1vo17KkEf8hUgVgrLxc+JbpByv3QyRSCaKmErp
         gPc6YaQI7quu9S6cTZCpYIiebSvLRP/TJkHhhBmojPIqQNtZbcgEZhqWzVvwA0tq2uRx
         +ubUoqtOne5kAIrBQqmOmA3NKGw8b+SBSIUHEfvcl946P9f0qWcZTZrXuUxN24A/syHm
         HKppZgiUKyz9y819UCoQlP9NpWN6QUhPB4UcaLpazYWgViXNnKbpRNVkkvCtYHUeFdfS
         wg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGQ7+P7dGN15uBsAWu8DCnSdKjv7k9ltm1L6whtQ6u8=;
        b=ASCVJtJZrzV31BTbi08wPHBvzvec5DFGdBxfo1lbeumbjYeFgMFr9t1dth9t8lTiwp
         5ZSJVAMhk/qrMq6w1jEzPBnrmad/Xk+UTY9S08yKHF60ubrtdl/buTaTRdlqBh9j2pAc
         EIAirUZr5MxxWK9Mn8WmZPY/64eJngB+GJbOW+qiYSWwYkYR32GnSJxCq8W0VGzyMfdA
         05xzdmxkJik04Fpyr3TCgBLGH29p//dIy4V8yKVobNapeuEBtX4+tDn/tFG0GNmzEBsd
         jDnZJrCaQsUkEgrRRwHMNx/HqzcUaBkeyu0dfu1Dw03Fndx79tB2AWFQ+RDluBA5h7ul
         N/Iw==
X-Gm-Message-State: AOAM533EKL377SWACNitRFLrhHs/VCdPMj5HvqTDLLin6dG4ct4RpEyW
        u2sun+YJgVWYGYAL36RR9zBAqw==
X-Google-Smtp-Source: ABdhPJyLa5EOR0wZYtd8iRnp3X/AWeUMxNAFBSBKd1LQjDKqVnpH0D6R4/HiG/ELQX3uIFtEg8ZBoQ==
X-Received: by 2002:a05:6512:3b2a:: with SMTP id f42mr7229730lfv.282.1639522734665;
        Tue, 14 Dec 2021 14:58:54 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t10sm45115lja.105.2021.12.14.14.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:58:54 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 01/10] dt-bindings: pci: qcom: Document PCIe bindings for SM8450
Date:   Wed, 15 Dec 2021 01:58:37 +0300
Message-Id: <20211214225846.2043361-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
References: <20211214225846.2043361-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the PCIe DT bindings for SM8450 SoC.The PCIe IP is similar
to the one used on SM8250. Add the compatible for SM8450.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt     | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index a0ae024c2d0c..73bc763c5009 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -15,6 +15,7 @@
 			- "qcom,pcie-sc8180x" for sc8180x
 			- "qcom,pcie-sdm845" for sdm845
 			- "qcom,pcie-sm8250" for sm8250
+			- "qcom,pcie-sm8450" for sm8450
 			- "qcom,pcie-ipq6018" for ipq6018
 
 - reg:
@@ -169,6 +170,24 @@
 			- "ddrss_sf_tbu" PCIe SF TBU clock
 			- "pipe"	PIPE clock
 
+- clock-names:
+	Usage: required for sm8450
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "aux"         Auxiliary clock
+			- "cfg"         Configuration clock
+			- "bus_master"  Master AXI clock
+			- "bus_slave"   Slave AXI clock
+			- "slave_q2a"   Slave Q2A clock
+			- "tbu"         PCIe TBU clock
+			- "ddrss_sf_tbu" PCIe SF TBU clock
+			- "pipe"        PIPE clock
+			- "pipe_mux"    PIPE MUX
+			- "phy_pipe"    PIPE output clock
+			- "ref"         REFERENCE clock
+			- "aggre0"	Aggre NoC PCIe0 AXI clock
+			- "aggre1"	Aggre NoC PCIe1 AXI clock
+
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -246,7 +265,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sc8180x, sdm845 and sm8250
+	Usage: required for sc8180x, sdm845, sm8250 and sm8450
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.33.0

