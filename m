Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFB6547F4D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 08:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiFMGDw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiFMGDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 02:03:35 -0400
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6A710E3;
        Sun, 12 Jun 2022 23:03:00 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 6A54944052E;
        Mon, 13 Jun 2022 09:02:41 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1655100161;
        bh=18DYyj44zWX19FKEoi7n2ggbNmNvRoc33jDGgrFbP4c=;
        h=From:To:Cc:Subject:Date:From;
        b=dWjNBtcICNkQ9tMMvcQXrPwhAETpifWMQXrXXJIR+BqmEo0bUW0LvYy0gPtRxK93N
         6eMuC7ZhA3VjmPHYt2N0fjIgI22zsbVaewxk1zgJIJe2E1UOd1yZZ7usbg2uGQKoqM
         EzzvjNQu++Nal1220aHWMtojePc9z/z4TW8QBfXxNjT6tQ6j0xMRIXZ6Nt81UgTohL
         HFHv9t3ex7m0VSeQp97dNJbaoY7bFxOLGA/2g1K3xFlYnlpMZRI8NnaU1OHYj4NZ6f
         TIMfIeeQP6OmO3jCOjuh6/l9o5KWwGeDJ6JLwhhg8/Uolak+oBfsVAscoc6W+h5zQR
         Qf9fv5gPpZTsw==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] dt-bindings: PCI: qcom: fix description typo
Date:   Mon, 13 Jun 2022 09:02:38 +0300
Message-Id: <e08b53be6cdf8d94a5a002d5b74c8a884b2ff3c6.1655100158.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0b69b12b849e..c40ba753707c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Stanimir Varbanov <svarbanov@mm-sol.com>
 
 description: |
-  Qualcomm PCIe root complex controller is bansed on the Synopsys DesignWare
+  Qualcomm PCIe root complex controller is based on the Synopsys DesignWare
   PCIe IP.
 
 properties:
-- 
2.35.1

