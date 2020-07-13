Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7977021D6DE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgGMNXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbgGMNXL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:11 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D95C061755;
        Mon, 13 Jul 2020 06:23:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lx13so17143288ejb.4;
        Mon, 13 Jul 2020 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xcKDUJtN8KnVp8SK38Ke0hkXpSNLE2nTiZgewkHzMQw=;
        b=SaNGQfLVx6RqUWzELxm9T+H6i+YLj/d/wFalPHk2qzqpsLYUvY6xsqG5ifZyl5xXoy
         RHUOs4DoBmK3mHxWhLxDqNqNcjjm0z46C6vabdJ9p+CfmRYhNpygqvBxUrO9ijIBAPac
         6uNj3/qTGxTkv7CXIbf6eBF8B1utWOoErQZBM29hcjWAi4iFZiS2GfpT+wGthIaS/jb6
         NJmNbiBWqExF7WlkzgTsOwl1n12faQczUqZrcILxAoxtlcnHL2LXFmvUpVSnj3Rs8YYg
         VlJVRb227P01Gzajwxc0dSRkTqJuEYitM47cU1sN5shRZIY4d89mqXpxqaUuH80isD47
         U27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xcKDUJtN8KnVp8SK38Ke0hkXpSNLE2nTiZgewkHzMQw=;
        b=O6nmdgYU3mE4j8gg0cMLs3soRWuj6MM38/q6cFmNnySAC2PF8fj5tQvNTyk3MTGsXp
         IBjGGcE/td0WLO116j3gYBKTGeuftt+JoeKw8UfsC7Rx51pySMHNFgH97yDZhsUcgGG6
         zx7/2RoT+zLPuUDtJQiYqQfHO8HxTg4n2bs0nHoL1ZDDFsFUmGFNg3VFSxZzmyAe3AYx
         Ksy29J/Qu439kThq34mDuXxlB5LIn9Z7NzUiEz+oxAp4duqWLuA4yrUbT7n/nYG1JYtH
         t/chrHeV6wDy5ZaS0DQPce3xUHIZ+YWBb4k/0tPhOWHm2VQYm3KbZDdEUzdbdwZubSsL
         mbJw==
X-Gm-Message-State: AOAM5331FTwRJjtuKbtRNIbWw+GnQ10gw5IuFMYInwz/ay+VNSRSsZ/O
        huUyzQkbREA260nih0F62sg=
X-Google-Smtp-Source: ABdhPJwsSYVM2+fMyxzB9eGDOoH0392buOi9pzjJVv96vP3BQvWvgtw4YTkrbkHgyoMZV9LLvQIslw==
X-Received: by 2002:a17:906:f53:: with SMTP id h19mr71419486ejj.491.1594646589588;
        Mon, 13 Jul 2020 06:23:09 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:09 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [RFC PATCH 24/35] sh: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:36 +0200
Message-Id: <20200713122247.10985-25-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 arch/sh/drivers/pci/common.c        | 2 +-
 arch/sh/drivers/pci/ops-dreamcast.c | 4 ++--
 arch/sh/drivers/pci/ops-sh4.c       | 4 ++--
 arch/sh/drivers/pci/ops-sh7786.c    | 8 ++++----
 arch/sh/drivers/pci/pci.c           | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
index fe163ecd0719..ee27cdfd3e68 100644
--- a/arch/sh/drivers/pci/common.c
+++ b/arch/sh/drivers/pci/common.c
@@ -61,7 +61,7 @@ int __init pci_is_66mhz_capable(struct pci_channel *hose,
 			continue;
 		if (early_read_config_word(hose, top_bus, current_bus,
 					   pci_devfn, PCI_VENDOR_ID, &vid) !=
-		    PCIBIOS_SUCCESSFUL)
+		    0)
 			continue;
 		if (vid == 0xffff)
 			continue;
diff --git a/arch/sh/drivers/pci/ops-dreamcast.c b/arch/sh/drivers/pci/ops-dreamcast.c
index 517a8a9702f6..431cd006951f 100644
--- a/arch/sh/drivers/pci/ops-dreamcast.c
+++ b/arch/sh/drivers/pci/ops-dreamcast.c
@@ -56,7 +56,7 @@ static int gapspci_read(struct pci_bus *bus, unsigned int devfn, int where, int
 	case 4: *val = inl(GAPSPCI_BBA_CONFIG+where); break;
 	}
 
-        return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int gapspci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
@@ -70,7 +70,7 @@ static int gapspci_write(struct pci_bus *bus, unsigned int devfn, int where, int
 	case 4: outl((u32)val, GAPSPCI_BBA_CONFIG+where); break;
 	}
 
-        return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops gapspci_pci_ops = {
diff --git a/arch/sh/drivers/pci/ops-sh4.c b/arch/sh/drivers/pci/ops-sh4.c
index a205be3bfc4a..4d757e5f38c6 100644
--- a/arch/sh/drivers/pci/ops-sh4.c
+++ b/arch/sh/drivers/pci/ops-sh4.c
@@ -49,7 +49,7 @@ static int sh4_pci_read(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 /*
@@ -90,7 +90,7 @@ static int sh4_pci_write(struct pci_bus *bus, unsigned int devfn,
 
 	pci_write_reg(chan, data, SH4_PCIPDR);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops sh4_pci_ops = {
diff --git a/arch/sh/drivers/pci/ops-sh7786.c b/arch/sh/drivers/pci/ops-sh7786.c
index a10f9f4ebd7f..7c329e467360 100644
--- a/arch/sh/drivers/pci/ops-sh7786.c
+++ b/arch/sh/drivers/pci/ops-sh7786.c
@@ -52,7 +52,7 @@ static int sh7786_pcie_config_access(unsigned char access_type,
 			else
 				pci_write_reg(chan, *data, PCI_REG(reg));
 
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		} else if (dev > 1)
 			return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -83,7 +83,7 @@ static int sh7786_pcie_config_access(unsigned char access_type,
 	/* Disable the configuration access */
 	pci_write_reg(chan, 0, SH4A_PCIEPCTLR);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int sh7786_pcie_read(struct pci_bus *bus, unsigned int devfn,
@@ -101,7 +101,7 @@ static int sh7786_pcie_read(struct pci_bus *bus, unsigned int devfn,
 	raw_spin_lock_irqsave(&pci_config_lock, flags);
 	ret = sh7786_pcie_config_access(PCI_ACCESS_READ, bus,
 					devfn, where, &data);
-	if (ret != PCIBIOS_SUCCESSFUL) {
+	if (ret != 0) {
 		*val = 0xffffffff;
 		goto out;
 	}
@@ -137,7 +137,7 @@ static int sh7786_pcie_write(struct pci_bus *bus, unsigned int devfn,
 	raw_spin_lock_irqsave(&pci_config_lock, flags);
 	ret = sh7786_pcie_config_access(PCI_ACCESS_READ, bus,
 					devfn, where, &data);
-	if (ret != PCIBIOS_SUCCESSFUL)
+	if (ret != 0)
 		goto out;
 
 	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x "
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index c7784e156964..77130f035fdd 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -204,7 +204,7 @@ pcibios_bus_report_status_early(struct pci_channel *hose,
 			continue;
 		ret = early_read_config_word(hose, top_bus, current_bus,
 					     pci_devfn, PCI_STATUS, &status);
-		if (ret != PCIBIOS_SUCCESSFUL)
+		if (ret != 0)
 			continue;
 		if (status == 0xffff)
 			continue;
-- 
2.18.2

