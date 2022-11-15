Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CBA629672
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 11:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiKOKzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 05:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiKOKyZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 05:54:25 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E6F286E7
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 02:52:52 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j12so12809617plj.5
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2022 02:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKnPzcX7JtEz9qtSfGJnTjOGFHdm/vK5OZxcuFWQzbI=;
        b=W8iXFihzzNJe5s9bJRaRSba84dOeRPMcmV0T/zv5jAjWk8vWdmorVZjLo0TIPj93Bv
         VjVtSlOxhPMzRFfEaeIKJQCqT+5dUL92706sbo95N4owJiL2RzsOy+IDonQyZXea2wWf
         o72kSpNyC77vFovQBfqNOGhtcDvvyaDhG7u3f+fh2P8L/+B67Kp+/lcuU8fYVl5+Cx3m
         pbchrUpqjfijoBqNBJyl858BX8fRRsYX9S9OUhKpnWZQ2h1mzyoUq+Q87QnLdA6UAkkh
         f9OBoqH8yg90ofcZqjTGRzdOSkpMHZN38AULCD7b4U4xYsDr0Va+g8E4ESPV7L2mk/Mb
         l+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKnPzcX7JtEz9qtSfGJnTjOGFHdm/vK5OZxcuFWQzbI=;
        b=QNZ9BbX+W4272aAnpgjppFvUymrNDPTe6N+aNb4E7NZIVtJ4rUks9fBHsvt6KQTTZN
         XF7jPVChwkjDryBnaeo04rVf/3N44tPSIU/BY+glr4Q16QtaUsTmBlwe5sLMD2x2LXmV
         qLNhmtXW8DbJ6+4lkZEOeOM4/orVF1W1YkHuZTQxoyfdbLkORhWa/ygyXrMbSMR2SPnI
         x5m5xN1rNAHjEkmtPRF7/0JFV0GwJEPbjunmCdNPRGjesy+AAdp5qka63Nsf7JHxWsV6
         kFLSV8obdLonll3yuwdSvc8676DiqW8h4+OOP9K1Xnoq2SH2M9Yh88doCXWOFt6hGkxM
         qZbw==
X-Gm-Message-State: ANoB5plf7RB+a6sBRaU2v+o4tzsQwNyhDJbrmDc7dlUe+WZrTdXYYNPD
        uHdEG3VA5vsgdEFt7EZaDI2K0lX6+6KSXQ==
X-Google-Smtp-Source: AA0mqf65OCo+MQzWvXThtTpgRg7FO6R3V9BCzT6sg3NUd4sPVzajfiplpzEFn+R4Ah7nGMVzFNocCw==
X-Received: by 2002:a17:90a:5883:b0:213:d66b:4973 with SMTP id j3-20020a17090a588300b00213d66b4973mr179564pji.85.1668509572388;
        Tue, 15 Nov 2022 02:52:52 -0800 (PST)
Received: from localhost.localdomain ([220.244.252.98])
        by smtp.gmail.com with ESMTPSA id e24-20020a63f558000000b00470275c8d6dsm7325129pgk.10.2022.11.15.02.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:52:52 -0800 (PST)
From:   Albert Zhou <albert.zhou.50@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de,
        mika.westerberg@linux.intel.com
Subject: [PATCH v3 2/2] pci: pcie: add dependency info to Kconfig
Date:   Tue, 15 Nov 2022 21:52:40 +1100
Message-Id: <20221115105240.32638-3-albert.zhou.50@gmail.com>
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
recorded in the help message for HOTPLUG_PCI_PCIE. Further, PCIEPORTBUS
and HOTPLUG_PCI_PCIE are defaulted to Y if USB4 is selected.

Signed-off-by: Albert Zhou <albert.zhou.50@gmail.com>
---
 drivers/pci/pcie/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 788ac8df3f9d..32cc9a31e228 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -4,20 +4,22 @@
 #
 config PCIEPORTBUS
 	bool "PCI Express Port Bus support"
+	default y if USB4
 	help
 	  This enables PCI Express Port Bus support. Users can then enable
 	  support for Native Hot-Plug, Advanced Error Reporting, Power
 	  Management Events, and Downstream Port Containment.
-
 #
 # Include service Kconfig here
 #
 config HOTPLUG_PCI_PCIE
 	bool "PCI Express Hotplug driver"
 	depends on HOTPLUG_PCI && PCIEPORTBUS
+	default y if USB4
 	help
 	  Say Y here if you have a motherboard that supports PCI Express Native
-	  Hotplug
+	  Hotplug. Thunderbolt/USB4 PCIe tunneling needs Native PCIe Hotplug to
+	  be enabled
 
 	  When in doubt, say N.
 
-- 
2.34.1

