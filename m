Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68FBFCF725
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfJHKj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 06:39:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41967 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbfJHKj1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2019 06:39:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so18794519wrm.8
        for <linux-pci@vger.kernel.org>; Tue, 08 Oct 2019 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Cwwrqaqfkc7a5d/MS5exo0NUOtyUn8PYYYF8oRW8wg4=;
        b=oYX641WFSw3a4b1+F8m3HlnUqFtfehAsO457JIH66/pubSKxy4wW78NtxaPt5V4w7c
         FwzgWzXm3bIcH/njrVzMzjRlr2doGQpG6m7GDizgHWmOaTMj+gA1ROr6vkU+XxgTm1al
         JimpQTTSBnizJNtRfv+7lAaqNsnJlihM8pXejNbm+uDhH9WC8jT+ydRP8JYjl5EKylUf
         O6vqo3iPgBUDcI6ek9Aad7zt0xl7j1tVlx3aSjpBdoWKxjxME5P/4J5+10A8IMqYQWCZ
         PGSkHGaZx90Lk7mZ/pff9L9PbQNmcHRX8rP0bQOALjlQ26VJNYWCKVuDYa+gGtSaMyjm
         K4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Cwwrqaqfkc7a5d/MS5exo0NUOtyUn8PYYYF8oRW8wg4=;
        b=F4d+RB7u1MUsgzkF7MkElLLK8FRZEnzF50VAJFyKIMTdxqbnWiSG6qs3vWo8Cns+UQ
         RUVnu4GKEvwhdmDwkcy88i8VbQkqDQUm1wXx0tMLbqkVX8FHXTSCyQFKiFrbQSXWaFV0
         ZlHzO9BFG9mdWPqGLe8BxjhWNwK7rTJchOXagaKv5pm2Wi/tIlNK6h9d6C+H77srYWZE
         hbJ2Xq0SfZGCrgRly8gj+go/itSjYezynKw0/lNdxXUxuN8XtNrVfqkcZz+stvPRi3Ss
         xI6VWmn/rVgt31A3iPVNCFtWfntGPsWiee7FTP6U7WujXRh7WTpVUeAmc7XcRHtIEvIr
         oVPw==
X-Gm-Message-State: APjAAAUXTeovEzwPZJAp1U+UzYGuMd94PCK+zkX/+88A5yAKEfFry4WF
        N+Mho4Hx6QzGfbQCBBrmvpxycQ==
X-Google-Smtp-Source: APXvYqyYdMtpc0TZmnqQyW6MCm46p59/czdxjZQ2PqQRtMenCNZMm9BnHBYtnUEPDnYi4OnP5dsHTA==
X-Received: by 2002:a5d:604e:: with SMTP id j14mr9588389wrt.119.1570531164832;
        Tue, 08 Oct 2019 03:39:24 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t17sm38269184wrp.72.2019.10.08.03.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 03:39:24 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kuldeep Dave <kuldeep.dave@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for Microblaze
Date:   Tue,  8 Oct 2019 12:39:22 +0200
Message-Id: <e0ead31283c74254e8c02c0e5e5123277ed1f927.1570531159.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuldeep Dave <kuldeep.dave@xilinx.com>

Add Microblaze as an arch that supports PCI_MSI_IRQ_DOMAIN.
Enabling msi.h generation is done by separate patch.

Similar change was done by commit 2a9af0273c1c
("PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for RISC-V")

Signed-off-by: Kuldeep Dave <kuldeep.dave@xilinx.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Arch part was sent here:
https://lkml.org/lkml/2019/10/8/277
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a304f5ea11b9..9d259372fbfd 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86 || RISCV
+	def_bool ARC || ARM || ARM64 || X86 || RISCV || MICROBLAZE
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
2.17.1

