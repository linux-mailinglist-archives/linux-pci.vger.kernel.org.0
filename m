Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E128642604
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 10:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiLEJqd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 04:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiLEJqb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 04:46:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1982319284;
        Mon,  5 Dec 2022 01:46:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6761760FFB;
        Mon,  5 Dec 2022 09:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6519C433C1;
        Mon,  5 Dec 2022 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670233588;
        bh=vlbWmQAQsqVoCP5/iGG9T+Mh7FPLIm+omDon8p2JA10=;
        h=From:To:Cc:Subject:Date:From;
        b=bMM7gHLW3WMCRoSscjKR3d5B7dFagYLse28B06cubnjjcjtgrJoAZ+mozdLgS7ydy
         y5ZCvY/WCTD6z2bVf0C1W9CFnw59bAxUF9kadLyEG+2HzQMm5/HYH7bd49MnBMdfKR
         1tUBwdYYB96V8fKRqnLE7PL+41HSeabo+7seDSyYP7esxY81ZbM7zLbDny4pH5HZk+
         y4KdxMaWjF2YIU0+lVh1Z5UVdSsnd8Fuh68iEMqfXaZyaga+vK/ZDp5V+38ankjxya
         +YoHo9+l/4aIqIJhEV6dNz+CPgjzQen0DRn7EjrZWkEWWpqeZOc7B23iJdH0Z7M/0F
         talFkUPKSoOlQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p283U-0003MH-Im; Mon, 05 Dec 2022 10:46:33 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: PCI: qcom: Allow 'dma-coherent' property
Date:   Mon,  5 Dec 2022 10:45:30 +0100
Message-Id: <20221205094530.12883-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Devices on some PCIe buses may be cache coherent and must be marked as
such in the devicetree to avoid data corruption.

This is specifically needed on recent Qualcomm platforms like SC8280XP.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Lorenzo, the corresponding SC8280XP DT fix is heading for 6.2 so it
would be nice if this one could be merged for 6.2-rc1 (or -rc2) as well
to avoid the corresponding DT validation warnings.

Johan


 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 2f851c804bb0..a5859bb3dc28 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -62,6 +62,8 @@ properties:
     minItems: 3
     maxItems: 13
 
+  dma-coherent: true
+
   interconnects:
     maxItems: 2
 
-- 
2.37.4

