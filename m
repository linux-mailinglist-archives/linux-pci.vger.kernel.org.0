Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7F761F7AD
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 16:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiKGPb7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 10:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiKGPb7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 10:31:59 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFFE1F2FB;
        Mon,  7 Nov 2022 07:31:57 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so10114410pjs.4;
        Mon, 07 Nov 2022 07:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xe7Vf2fqmhjfKJbAENjC282hA0fF9hfDgyTK1BSujFM=;
        b=Fr1d+LDHwevMeyCpAaZMAQA0nOzCctwpC44IJanDyPOeP/1jasRetxNDorlo9j7TgZ
         6hfhveZRk7O0o3+65DTj5BLCPE/O6tG97G/vt4BFWOJwECH7VbJBD5beIJiorbXiBIP1
         8CYSFIq6K8/q1aQsLaHYJwhRLcheHbHRFOG9z3RM1VWYKDuf3mBLoegyg9rQjcankFTL
         0ZDK7GtY9XOgzp3ZDMiaIwl5ViUXhW5K4zn1vP/cJVe0UilbBOKRd8MWIuKyNFX55oqR
         LV6IuUFxp/mQyfwmppSTbybh+fQmoCTZQG6K9sOF1arOLVNCp7OJcEUKSCubVIImDNwM
         1zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xe7Vf2fqmhjfKJbAENjC282hA0fF9hfDgyTK1BSujFM=;
        b=ViL0/27HP/evwfDxsuTx550W272K3ynDwGBze2VOkZZeLo8eE/cJ2zp+V/bJNOdUr3
         PmBWmfx6TBgL599wjPtuUK/j32VKUKIMlVHbavW8+S61AuixydzMxUsLV36ROM2d2Ybb
         GMcAZ8X77qLDskYBaftFKpgDIXru31sjqiJ9SirZjrvlgu3PdHhZWIvALMm0PwtFH9bd
         vN+3bwu0h7CO7N1fYgYJrjNM2NgsHn4oLmqTSXirPNRSq74nlrWUPDJKUDg+ftU0q/2G
         i93au46InPFQX0zOdrEJ1DyduP+KB75YLHigi1i7MCetQVDbg6nUR0xY3rEFXvRrCXHu
         0TWQ==
X-Gm-Message-State: ACrzQf2xWAo1E9BGCywBKJoHNj3LSNMgB8lh5RJr8jlVyiQ+tiDv2jbT
        9YgUzZOvyxe6A71QLobkekOme6n5OIntdQ==
X-Google-Smtp-Source: AMsMyM76YngygHaPtJLkp0nl39HicmW2EAkqC2cac5M+80l1HPl93v9HBRoJvkwmFywH0B2I/w47gA==
X-Received: by 2002:a17:90b:3c0c:b0:216:ab4c:5bfc with SMTP id pb12-20020a17090b3c0c00b00216ab4c5bfcmr20368718pjb.135.1667835117396;
        Mon, 07 Nov 2022 07:31:57 -0800 (PST)
Received: from junjun.localdomain ([113.140.248.157])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b00180a7ff78ccsm5139343plg.126.2022.11.07.07.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:31:56 -0800 (PST)
From:   JunDong Song <jundongsong1@gmail.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org
Cc:     robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        JunDong Song <jundongsong1@gmail.com>
Subject: [PATCH 1/2] PCI: dwc-host: Add a warning to prevent invalid values
Date:   Mon,  7 Nov 2022 23:31:07 +0800
Message-Id: <20221107153108.5770-1-jundongsong1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_pci_get_max_link_speed() may return a negative value,
causing the controller to not set the speed correctly.
Add a warning in case the driver engineer misses it.

Signed-off-by: JunDong Song <jundongsong1@gmail.com>
---

When I use the pcie dwc driver, the controller speed is abnormal,
but it has not been detected because of the @max-link-speed error,
so I think I need to return an error or warning here.

Thanks.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 83ddb1902..573342601 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -739,8 +739,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -ENOMEM;
 	ep->outbound_addr = addr;
 
-	if (pci->link_gen < 1)
+	if (pci->link_gen < 1) {
 		pci->link_gen = of_pci_get_max_link_speed(np);
+		if (unlikely(pci->link_gen < 0))
+			dev_warn(dev, "Failed to get max link speed\n");
+	}
 
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
-- 
2.25.1

