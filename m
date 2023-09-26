Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34607AF00C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 17:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjIZPye (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjIZPyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 11:54:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377B11D;
        Tue, 26 Sep 2023 08:54:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDDBC433C7;
        Tue, 26 Sep 2023 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695743664;
        bh=IisQzbKZxN86Cmpj6sgM5QxS9FVQkRRtLBZ6IuRw+iE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBBUB6Xznr6UTOr+mgpHWKwE9UZwVwuPbr1/gMfyB3NT5I0clLCHbaz8QPs6gPwwN
         SaAD4lmhJVbmQMwy78pk8h9sq+1kw/v3pnRVxgvCYTp9UQxDsrYkrGq/4FTUAmKYTe
         y5HgfwdLIhJIW37hs8697WdZ4FNNCb/i+DnSpQQU9TBbH0lqi7MMxaCck+rmD/E1GG
         Esq+PYlcyytwkFG54QUEBSBYrJGvE+ZYool3nzuca6gtZG7gLMkRyksJIXMEl51IYl
         URoV4RnSjRbNA60NGDJx//TFKX9ZGuXJVLNjlvNx0VjZFXan/rOmITY7tEi/tsJ1G2
         iyfFH7QtsMviA==
Received: (nullmailer pid 31938 invoked by uid 1000);
        Tue, 26 Sep 2023 15:54:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: PCI: brcm,iproc-pcie: Drop common pci-bus properties
Date:   Tue, 26 Sep 2023 10:53:41 -0500
Message-Id: <20230926155351.31117-2-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926155351.31117-1-robh@kernel.org>
References: <20230926155351.31117-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drop the unnecessary listing of properties already defined in
pci-bus.yaml. Unless there are additional constraints, it is not
necessary.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/brcm,iproc-pcie.yaml  | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
index 0cb5bd6cffa1..6730d68fedc7 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
@@ -34,13 +34,6 @@ properties:
     description: >
        Base address and length of the PCIe controller I/O register space
 
-  interrupt-map: true
-
-  interrupt-map-mask: true
-
-  "#interrupt-cells":
-    const: 1
-
   ranges:
     minItems: 1
     maxItems: 2
@@ -54,16 +47,8 @@ properties:
     items:
       - const: pcie-phy
 
-  bus-range: true
-
   dma-coherent: true
 
-  "#address-cells": true
-
-  "#size-cells": true
-
-  device_type: true
-
   brcm,pcie-ob:
     type: boolean
     description: >
-- 
2.40.1

