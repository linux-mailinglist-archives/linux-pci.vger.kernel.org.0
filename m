Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011BF62966F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 11:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiKOKy7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 05:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiKOKyW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 05:54:22 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A4F20367
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 02:52:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so13466217pjd.4
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 02:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RP4BxD3LcEMiCEy87lCVjDgMJn3TYXKFnYzLCRW3wiY=;
        b=IJ4Bfl3Ic0R9F7NKaOn60R7B+5s+ShesYv0m9LcSc+i39GDJ8PPRd58JF1mloBNSyK
         qAlDTiTxh9sPWA62dShSondxxKoFFNoujxOYUf46SBhr97QS7d7H+pPlso+74KmlUu3s
         r5HtStJTw8OXqnYqxWcU26qwhRwzfXxBf2D5DUdoGjQD/Ci7OAyQ9MLikSHWqqfrBa4H
         SXbVP5bp6nj99388eJ7IaX6/nfyMT/NXk2R9LetI/v5HJuP7ivYItB2xs2KqV4S3++/G
         tvh34eiOXUgXN/8+NgDt9b9+r9CR46SUiIuW0CElZjosTy4YQlDroksvCZcNQlsklQDV
         7P9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RP4BxD3LcEMiCEy87lCVjDgMJn3TYXKFnYzLCRW3wiY=;
        b=lub4u1emwVl2uuOzlM+1uJSnZ55uzxbPUOnVhVqYKLenkzAfife6P97eaN2fftQQa6
         T9jc7x0I8JD1birT0+2V6oEpUj+ZbLq6tXyJYJHgWDni+klS3x//6qMa0Vlr3adV1h3a
         sKJHpKTrejYXFOkExxlnRyEIpyotaKovHcJkE8KYbKqoExISHaEVLgUaeW2hC2mhNlzX
         eAXQHhhPU64axIyO0YkSHdhxME+lQWhyCvuJSnuCkWrhWcPhLqLCYwvlXTHa2DMnfjwe
         Vv6FKWn+0EHh6bm2wVrtLSgzUeR2aGkFXZ1UTWasTPGfb8XiL4AA89DTL0Nw4Aon4qmz
         diyQ==
X-Gm-Message-State: ANoB5pnxozbDrQfnUm7Lxb7UfEce20icKMx6C4NVOJ7HMCOKQdyfOmLF
        MPUrmozawqwcWA060quUo8g=
X-Google-Smtp-Source: AA0mqf5MYZlEEW1TUq8REr4v+qERbdZlPzhTJGN+9k5FIYw6o+XNBtikIIjV778soz+R0S2sL64gEw==
X-Received: by 2002:a17:902:820b:b0:176:cf64:2f39 with SMTP id x11-20020a170902820b00b00176cf642f39mr3482321pln.93.1668509569446;
        Tue, 15 Nov 2022 02:52:49 -0800 (PST)
Received: from localhost.localdomain ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id e24-20020a63f558000000b00470275c8d6dsm7325129pgk.10.2022.11.15.02.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:52:49 -0800 (PST)
From:   Albert Zhou <albert.zhou.50@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de,
        mika.westerberg@linux.intel.com
Subject: [PATCH v3 1/2] pci: hotplug: add dependency info to Kconfig
Date:   Tue, 15 Nov 2022 21:52:39 +1100
Message-Id: <20221115105240.32638-2-albert.zhou.50@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115105240.32638-1-albert.zhou.50@gmail.com>
References: <20221115105240.32638-1-albert.zhou.50@gmail.com>
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

Thunderbolt/USB4 PCIe tunneling require the Hotplug feature. This is now
recorded in the help message for HOTPLUG_PCI. Further, HOTPLUG_PCI is
defaulted to Y if USB4 is selected.

Signed-off-by: Albert Zhou <albert.zhou.50@gmail.com>
---
 drivers/pci/hotplug/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 840a84bb5ee2..0b396a09ae15 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -6,10 +6,12 @@
 menuconfig HOTPLUG_PCI
 	bool "Support for PCI Hotplug"
 	depends on PCI && SYSFS
+	default y if USB4
 	help
 	  Say Y here if you have a motherboard with a PCI Hotplug controller.
 	  This allows you to add and remove PCI cards while the machine is
-	  powered up and running.
+	  powered up and running. Thunderbolt/USB4 PCIe tunneling needs Native
+	  PCIe Hotplug to be enabled. PCIe Hotplug depends on PCI Hotplug.
 
 	  When in doubt, say N.
 

base-commit: e01d50cbd6eece456843717a566a34e8b926cf0c
-- 
2.34.1

