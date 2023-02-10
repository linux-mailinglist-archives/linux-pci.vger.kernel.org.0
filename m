Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDFC69238E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 17:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjBJQoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 11:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjBJQoR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 11:44:17 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754AE212A9;
        Fri, 10 Feb 2023 08:44:16 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id p24-20020a056830131800b0068d4b30536aso1687563otq.9;
        Fri, 10 Feb 2023 08:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1p0XOr+4ghGyvYRD6ntCMDoZebCtt1fvqKIgO3rBgI=;
        b=o1YwOMP3FYQ317ssGGMJ0vf2/7+FMyh61bushlhROaGckuJW/TZWjHYbU5DDVoiL7s
         kODrsRli1XiPXpj/YAykJg5PP1f1m+LvyV/ESV25UQrAPHCQpfhqzwVflEkQyzCoZc4u
         UNsTQ0H2VKKlEPTp0AXFmDTLoETvo89IVbNZ7xgbHL9ubtWEceuQf5xnvfsZ89/dnA0y
         cS0V6A0+R0aY4FzWDkkx0/ZYleQ82XLjGp2WqDy7YoJNeEqFlNkygkbIhh2Io6s4aSI/
         +mTVJ/jYKTKGYs1ieSquLsQH3tllYdCwenGOW6gy3MIBl80AkqQmM1IpoW0faPZ+HpRF
         E1Tw==
X-Gm-Message-State: AO0yUKXuc1h2hEEw7NlwUEIifg7UdHGUV/milKOjpCJFzKTlih4GVaI+
        K7ikH80+knWrLPtPZ6nLrH/p12nWkw==
X-Google-Smtp-Source: AK7set98Wh8wdxKdVz1l88+RQI6D7E1VmuZjsSixf+tLzOvSHhqFNtg3Fdxf1XyxQL2sfRtUMEq51g==
X-Received: by 2002:a9d:2c5:0:b0:685:e5d3:63c5 with SMTP id 63-20020a9d02c5000000b00685e5d363c5mr9458814otl.12.1676047455679;
        Fri, 10 Feb 2023 08:44:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n14-20020a9d64ce000000b0066b9a6bf3bcsm2156896otl.12.2023.02.10.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:44:15 -0800 (PST)
Received: (nullmailer pid 2687907 invoked by uid 1000);
        Fri, 10 Feb 2023 16:44:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Liu Peibao <liupeibao@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Honor firmware's device disabled status
Date:   Fri, 10 Feb 2023 10:43:51 -0600
Message-Id: <20230210164351.2687475-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If a device has a firmware node (DT/ACPI), and the device is marked
disabled, that is currently ignored. Add a check for this condition
and bail out creating the pci_dev.

This assumes the config space for the device can still be accessed
because they already have by this point in order to identify the device.

Cc: Liu Peibao <liupeibao@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please test if this works for Loongson.
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1779582fb500..b1d80c1d7a69 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1841,6 +1841,8 @@ int pci_setup_device(struct pci_dev *dev)
 
 	pci_set_of_node(dev);
 	pci_set_acpi_fwnode(dev);
+	if (dev->dev.fwnode && !fwnode_device_is_available(dev->dev.fwnode))
+		return -ENODEV;
 
 	pci_dev_assign_slot(dev);
 
-- 
2.39.1

