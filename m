Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D046A87A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 14:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfGPMM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 08:12:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36537 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPMM1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 08:12:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so19693460ljj.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2019 05:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WpX1xHyb2syB7DhAC+5bjPw/GOH9wgJliuRiFw0hY0I=;
        b=NetrjaIoumh15csBDlGHraxCNdt3b6E2HGD5UhZ1c28OE0ThHFFMydi0hkj0v/IsuY
         8UGcqISsrRh2DIMxe4CF+66Gv+CcYpG/8xXdHYzEbYGsTKMWwb6gVHALk5MmNYU2kN+J
         npiTwyiCvO+uOmfn/ZDo5sk9iXuIO6fpf0DiJfu7Gc1znSCkUXN+gh+u0ykfz8SJScYi
         ev5DM+8E16XqNqmPyN7cUgVffAyAI+KjDoHTvNky1NzcVmQVrEJQUcrT9XXtEFNeVAgp
         7OIz/Kggk4/sKXc5EQ6EM8TvXwNzpOBIjK47GEKB8zVxfoRBTDZZUsDfbwLvKRYyuQDA
         Llrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WpX1xHyb2syB7DhAC+5bjPw/GOH9wgJliuRiFw0hY0I=;
        b=ZbrcUs5/A485ht7A6Ak23E4fYbz/w+1kR2vg3OT0gGeM5YS13HCn/9gZVWXIlHzAjW
         REMGaKpLKuICtuyDXEQShfSP7J9Kr59SMxzRL/EXYYoCxZ1oZukWZcWUYa5bFq8nXZsd
         DuDu3+KDQjZ2zJgZRi2aA6HwcXdUCr+/fyHCU1DhBFV/PnQsIn7iF9vbzIf02e8ZbM6G
         FFBWDWxyjWSg2hA+3TH0i0Xz9ZxNdy/J2TNlYu3iCDssfqu0/SBcnh6EyUXeBU5yTlIG
         A5AjKZKaCXoM/Q7oO35bL2oqXjEE/oHy8LzHOwL8cnKQbVf0XJ9B5aYXTZuK6B/2rD53
         7rjg==
X-Gm-Message-State: APjAAAXLnDDWWrhBPGpS3g1Sb9oATSu2faWpuMVOvB1NsRj7QpcCBrU3
        TZqJP0NtFpDK7GLTtIP81p0=
X-Google-Smtp-Source: APXvYqxov8YbEH2Hj9OzytkWvkGe2wlhpFV9vYKxEBbvxMM3XkxRsv0rw+hl9A7CntUiKeWWdfwCxQ==
X-Received: by 2002:a2e:870f:: with SMTP id m15mr17402763lji.223.1563279145175;
        Tue, 16 Jul 2019 05:12:25 -0700 (PDT)
Received: from gilgamesh.semihalf.com (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id u9sm2818724lfb.38.2019.07.16.05.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 05:12:24 -0700 (PDT)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     thomas.petazzoni@bootlin.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [PATCH v2] PCI: aardvark: fix big endian support
Date:   Tue, 16 Jul 2019 14:12:07 +0200
Message-Id: <1563279127-30678-1-git-send-email-jaz@semihalf.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Initialise every not-byte wide fields of emulated pci bridge config
space with proper cpu_to_le* macro. This is required since the structure
describing config space of emulated bridge assumes little-endian
convention.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
v1->v2
- add missing cpu_to_le32 for class_revison assignment (issues found by
Thomas Petazzoni and also detected by Sparse tool).

 drivers/pci/controller/pci-aardvark.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 134e030..178e92f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -479,18 +479,20 @@ static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 {
 	struct pci_bridge_emul *bridge = &pcie->bridge;
 
-	bridge->conf.vendor = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff;
-	bridge->conf.device = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16;
+	bridge->conf.vendor =
+		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff);
+	bridge->conf.device =
+		cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16);
 	bridge->conf.class_revision =
-		advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff;
+		cpu_to_le32(advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff);
 
 	/* Support 32 bits I/O addressing */
 	bridge->conf.iobase = PCI_IO_RANGE_TYPE_32;
 	bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
 
 	/* Support 64 bits memory pref */
-	bridge->conf.pref_mem_base = PCI_PREF_RANGE_TYPE_64;
-	bridge->conf.pref_mem_limit = PCI_PREF_RANGE_TYPE_64;
+	bridge->conf.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
+	bridge->conf.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64);
 
 	/* Support interrupt A for MSI feature */
 	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
-- 
2.7.4

