Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679436C78F8
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 08:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCXHhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Mar 2023 03:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjCXHhv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Mar 2023 03:37:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247866EB9;
        Fri, 24 Mar 2023 00:37:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso375020wmq.5;
        Fri, 24 Mar 2023 00:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679643456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJmKfkhoV+V4SFhX9hDUQTlwZmKjpqjw1YRy4Ou6WZ0=;
        b=RjShvpwr2C45GPd94vR2akVmE72d2oLkw8bm6G94a02m9hH0ZwTd8p6EqL3KS0+zIi
         HnvqK6eKws6c2My8kFCPf/upKDx0xeQ1fwRm6gOPLEggtH37PS0c7DVZCFGs+WpZUNjK
         dkBCn8gTeWwostQANfdXVTzuHiEDNxbfx5VkbQ2e/U7HMT2o+Rx1TKVGhuCzT5Nkmxqu
         mswNnBxxDW0HfPlJ3SHMIpXEpuxVGNIrg9+atLy1cNGAzvjVTq2ZmcpgV7bCxjlRcxV+
         uzUEtYAXC9UDh2EEY2acZovXnz9YECI1qDRW73dCZNnKJ+gTVaW4ORKWqUEvMAouT6xB
         hnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJmKfkhoV+V4SFhX9hDUQTlwZmKjpqjw1YRy4Ou6WZ0=;
        b=wX5xL2dgJeenJY9EGZGD0X5MARZ3li2g5l0cNAP+h8qAf38/DX4StfeUBf3I9O/NjN
         jvfLySRnTcgX/MjMy6kyOZAI6vZZZiuLbiYQzRJ1ghaDYH+cZbuQCSUCwy0EFk7QdeiX
         cy0U6kaGzW8paQjibKYHZnpSQTpx9Hzb6FqkyCS99cj2EZzm2INdlVZzAA16M1UCDA5f
         zUZ9WSas4+k+atBfKcVeUSj6SuOtsfS7S9xuGrLz3uy2rem9x8CszRm5BFMsT8YTz053
         rAdSAZ+LaA4TjmoIeeRDx3NwYMg03X4o7ycmrG19kJa/K8fAuOD6kWdXit3Ym4stLUQR
         Gk9Q==
X-Gm-Message-State: AO0yUKXn/81MHDZz3IYzkOSKY/VkCTOSNXCAs4blcvOSbd2AlNnQjprN
        MGaVJX/lgDE70C9VNGQ2oZp1RHDRzjs=
X-Google-Smtp-Source: AK7set8zVM63m7MmSs58aMKX1+4OZpbipEqpSeY3p+gKtWlnlkACRhP6pnw2wMDeE6hHocPS3G6YJg==
X-Received: by 2002:a7b:c448:0:b0:3ef:294c:de50 with SMTP id l8-20020a7bc448000000b003ef294cde50mr1304127wmi.29.1679643455817;
        Fri, 24 Mar 2023 00:37:35 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c4f8d00b003b47b80cec3sm4189595wmq.42.2023.03.24.00.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:37:35 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     lpieralisi@kernel.org, bhelgaas@google.com, robh@kernel.org,
        matthias.bgg@gmail.com, kw@linux.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mt7621: Use dev_info for PCIe no card plugged on port trace
Date:   Fri, 24 Mar 2023 08:37:33 +0100
Message-Id: <20230324073733.1596231-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When there is no card plugged on PCIe port a trace that says the port will
be disabled appears. This is expected behaviour but currently is using
'dev_err' for doing that. Since this is not an error at all, change the
trace to use 'dev_info' instead.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 63a5f4463a9f..a445ec314375 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -378,8 +378,8 @@ static int mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
 		u32 slot = port->slot;
 
 		if (!mt7621_pcie_port_is_linkup(port)) {
-			dev_err(dev, "pcie%d no card, disable it (RST & CLK)\n",
-				slot);
+			dev_info(dev, "pcie%d no card, disable it (RST & CLK)\n",
+				 slot);
 			mt7621_control_assert(port);
 			port->enabled = false;
 			num_disabled++;
-- 
2.25.1

