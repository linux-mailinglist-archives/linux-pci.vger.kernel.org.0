Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF99630E35
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 12:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKSLIp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Nov 2022 06:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiKSLIn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2022 06:08:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4F5252A4
        for <linux-pci@vger.kernel.org>; Sat, 19 Nov 2022 03:08:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g2so9406005wrv.6
        for <linux-pci@vger.kernel.org>; Sat, 19 Nov 2022 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mwc2nZmOxR46PpqTa0Wdw8DF8tzISe7sp5iKA4EB2J8=;
        b=OVmFLi78detzrXGBBhHWl/eb+OxJya5hgYKcjbM586UsZ5DdhwA1KO5SW28pIcEmWH
         6cH53gBhnaNx/c3bhnh/KtEfoFrennkIUnSKayBLV1oCpNVQ2nU3OmM1bvE+mBLDF2tW
         Iym6WV9HMSZy23K7UoGnVzcuM/xkcR05EcEj3raQvjlq4fwM/htJ62MPVpzKtgpa4Zzz
         NEb0GcRoSExhgy/mlZB1fhpwiUWrCObdixgscLfMBcesEY9VC3hDe0RrwFojzzqRCEqP
         JZFDwn6JPoEP9/Q1DTVmH0g2Ht1t8Qpq9NbEgkt5bIVmywQ7lEbR3h3THQp3yhaOPVtP
         sAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwc2nZmOxR46PpqTa0Wdw8DF8tzISe7sp5iKA4EB2J8=;
        b=KnnaFcngLSoNo9X1z30rdxoNE82vAhL4Sh9Vk7E5j6fxkbhwKHBMPhVsQ1FS7uOAEA
         9Jlbve3jAtnxqePqyuhk0MUr6NSFUScMxzeNlrm0F1ahjmrMzt604nubvj7hE+1gl+/B
         cQCgmGc1OSYV8k2Qlx5SlBExUdGVVQLpI3KNEegv+HecyEaCmF6EyBHxeYtHm5sRtmJ5
         LLhgUzIYxCJ0Hhuvp8zL34pyhHA1/5stEFLwPCucFJ5cpvYk8nGmoPDsFq4p2N1nSSSp
         3J1PZwdSHEXoH5cAI3v9krJp24BtOFujiStaN8GyGH66fL6+C5vQDv6GMw16csxwcQ5v
         0LUw==
X-Gm-Message-State: ANoB5pnlj2JXWVu5YBvA2QPCnd5o1xAAOolyC9QclZLGlvzkGsuVSYzd
        d7/UkBB/aLn2yJypHR0XMjFCkrRBZK+ktg==
X-Google-Smtp-Source: AA0mqf671UTmglD0sHOCFtTUDaaQj4gtSYc30QmDyC7vBssOTd7DVv/g/8MKe4bYOrcxT9y5pSqTWA==
X-Received: by 2002:adf:efd2:0:b0:236:e5a2:4f66 with SMTP id i18-20020adfefd2000000b00236e5a24f66mr291903wrp.357.1668856119372;
        Sat, 19 Nov 2022 03:08:39 -0800 (PST)
Received: from localhost.localdomain (188.red-88-10-59.dynamicip.rima-tde.net. [88.10.59.188])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb12000000b002365730eae8sm5875436wrr.55.2022.11.19.03.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 03:08:38 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, bhelgaas@google.com, kw@linux.com,
        robh@kernel.org, lpieralisi@kernel.org
Subject: [PATCH] PCI: mt7621: increase PERST_DELAY_MS
Date:   Sat, 19 Nov 2022 12:08:37 +0100
Message-Id: <20221119110837.2419466-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some devices using this SoC and PCI's like ZBT WE1326 and Netgear R6220 need
more time to get the PCI ports properly working after reset. Hence, increase
PERST_DELAY_MS definition used for this purpose from 100 ms to 500 ms to get
into confiable boots and working PCI for these devices.

Fixes: 475fe234bdfd ("staging: mt7621-pci: change value for 'PERST_DELAY_MS'")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 4bd1abf26008..438889045fa6 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -60,7 +60,7 @@
 #define PCIE_PORT_LINKUP		BIT(0)
 #define PCIE_PORT_CNT			3
 
-#define PERST_DELAY_MS			100
+#define PERST_DELAY_MS			500
 
 /**
  * struct mt7621_pcie_port - PCIe port information
-- 
2.25.1

