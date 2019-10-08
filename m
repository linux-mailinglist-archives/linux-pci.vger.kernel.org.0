Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F1CFABA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfJHM6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 08:58:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37996 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfJHM6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2019 08:58:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so3025283wmi.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Oct 2019 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=GfvsO4/d+Aty+AebeEsW364ybAjW+zeAPcXCiQNi3OY=;
        b=au8NF5xYwMDXKLOX11L7FwEpPZ4rNyVtbiLvU9GJnkTZiesvqWaTqlfaUzrc5+jmld
         GCjNf3/+0KqE2CLGxVJ6PmRWNLTBcDm+BWd3oBmLpcLwYbLtqRcy+FWlcWlSbskjy5Qk
         PDC08Tw0s01bDJBUZ4H+glTABJshk5jt67rD0Fiue4l5TXj5oLQZz6nxlpPe6vz/BZhM
         GtWLYQaSrwaSY3fEw26Gd/0mLfYEN6NqNt8a1kYowZf0tmsgxwbY9Y+WvInlZJoPqX90
         bKmtHLcA+4O7SBbMUeItG4uzgDxQh9aT57Af4d6j4mOteBTGqFILqYgAtUr2hILfh0OH
         P8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=GfvsO4/d+Aty+AebeEsW364ybAjW+zeAPcXCiQNi3OY=;
        b=HYXUfePWbJvUbZAi5NsVJ398y8cKWpTpmsYZYE+gwLCy8+9brTVR2XdSXYelXWWUwM
         W+nsHNvCyZKi5yiM878jC3uAOBJUkVoqyffMneC3XwFoTw3BfY+Xq39OLZpPbBBb5pYy
         1A0ZN7if3m6c1Th2XjVh3vC4tye8v1l435Tzvz230YqP0NhiCapkFi1eghDdMtd/qP1a
         k1VNN8tdGN924HQv/w/acv+bqUp0Fa1T2QY3vd8NAb56nlHwI4UvEDMAu29EG8Pe3LeM
         31j9uGkn3a8GURAaCJs3Dr39ouMNGYdUd5/w3jPG5fwO/4HGQF76QGCvVjZGd/BvBItm
         dgKw==
X-Gm-Message-State: APjAAAWJXKm/UBrYnhW8d9UokMx4GS3eLMr/GFRVweQhHVV2dO6iHxoT
        O8pCEbiToQArxocQy5C4kqgCyw==
X-Google-Smtp-Source: APXvYqyUkyISrmPHLuIc2O+EbAY+OLrIiU8zAiKT75g9GvR8x7VgypYedDmDUurWq68iYpkzqCbrmw==
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr3422779wmc.36.1570539520447;
        Tue, 08 Oct 2019 05:58:40 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id o4sm38444938wre.91.2019.10.08.05.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 05:58:39 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kuldeep Dave <kuldeep.dave@xilinx.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for Microblaze
Date:   Tue,  8 Oct 2019 14:58:35 +0200
Message-Id: <b5959a9f6bfa65f0ae1a6a184e1b09dcec8e8f15.1570539512.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuldeep Dave <kuldeep.dave@xilinx.com>

Add Microblaze as an arch that supports PCI_MSI_IRQ_DOMAIN and add
generation of msi.h in the Microblaze arch.

The same change has been done by commit 251a44888183
("riscv: include generic support for MSI irqdomains")
and by commit 2a9af0273c1c
("PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for RISC-V").

Signed-off-by: Kuldeep Dave <kuldeep.dave@xilinx.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Squash patches together https://lkml.org/lkml/2019/10/8/277
  https://lkml.org/lkml/2019/10/8/283

Please take it directly via pci tree.
---
 arch/microblaze/include/asm/Kbuild | 1 +
 drivers/pci/Kconfig                | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index e5c9170a07fc..83417105c00a 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -25,6 +25,7 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += mmiowb.h
+generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
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

