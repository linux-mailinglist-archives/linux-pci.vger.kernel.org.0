Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17D06BE7DC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 12:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCQLTw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 07:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQLTv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 07:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D06A1DD;
        Fri, 17 Mar 2023 04:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7149662274;
        Fri, 17 Mar 2023 11:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F67C433EF;
        Fri, 17 Mar 2023 11:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679051974;
        bh=TgGenglMBJsZz/UjVeph1z0OkJF0UrTBZQRCyEkEbdg=;
        h=From:To:Cc:Subject:Date:From;
        b=XGAL9TIzOpKDjj8PZfSD95gW0GjJPdjr/uLBV4jxUr8hfVEManEGuWIpylfMBtTXp
         7Q4/hEiABHwnfRg0VD8q+B+SxFG/+KCA2ohnL7an+sz2pEuWJg+8iZMiFRJBj5wQ0v
         ns4O172/8qcFdygR4V2wkTrhZVnlG8r7QuEdTAShB1XYdvxLH6yQEMxYj3jn5TpGoi
         krFiogBmdC1VVgTVa/woEoLQuP42ykActPXmojatxkFW+cm4SlFxli1AgngyxfEAHR
         puIOsya/WNemTVEdKepft+JioP3qKgh0LC/c2/MsCso8w9tsyVaiMKJwe63YbLxVIs
         Y89hyraNXBUiw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pd88c-0002N4-44; Fri, 17 Mar 2023 12:20:46 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: PCI: Fix unit address of example root port
Date:   Fri, 17 Mar 2023 12:20:19 +0100
Message-Id: <20230317112019.9090-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Fix the unit address of the example root port which is identical to the
device number (i.e. 1).

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/pci.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 6a8f2874a24d..8b7c52436558 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -76,7 +76,7 @@ Example:
 pcie@10000000 {
 	compatible = "pci-host-ecam-generic";
 	...
-	pcie@0008 {
+	pcie@1 {
 		/* Root port 00:01.0 is external-facing */
 		reg = <0x00000800 0 0 0 0>;
 		external-facing;
-- 
2.39.2

