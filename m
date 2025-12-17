Return-Path: <linux-pci+bounces-43165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6ECC745F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 12:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E57AB301DE0F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55D33D6CE;
	Wed, 17 Dec 2025 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l2bVoHxk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDD33B955
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970118; cv=none; b=IVlKYgfmL07tjrlEroP+Bc2HFSd2cTZyGjdHhWpNYhbnFmCTWee7jD7YlpuqPLkXpWxnKa0bSDAxa1kXIV84KGK4sHQDcszOmMNW2/uCue0JUEbbkBri2AY+Sp/36ss48pERX2qQuro9kjLuurl1hwM8I4n/IP03czXuxaaIwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970118; c=relaxed/simple;
	bh=tELzXXkk4oo6zBbXVS1TJTiw2ptFpzmnNZxBUTbCsk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw68lsMUUN7lQEq4czYsVQ2ewWbW0sgcq9LCYZ/62671wx2Rg8YrC8i1K7dcxu+1/qzbnCBCxcelPiX0uidRg0n8q6aTCZdPYuMQ44ONdoQArUGVxgxfMyaoAKBLrRwmFndHAk+Y7n7z2cZL+rC25YRrMXp6CK1RUwXvSziMfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=l2bVoHxk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b79e7112398so1101919366b.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 03:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765970115; x=1766574915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wDUddDoFILHwCBU7oSL38U5bGT7x1S1Cv5uHbCqjv8=;
        b=l2bVoHxkeH9M7i93YuQQe/CxE3jTKVqBPC/yaaRWqK44HCNB808mZ1ndAn8X0NcZpR
         DQHK4RvyDTKZvUiUKEAXkxdMZKwYZcTPs29YBsWi3YUH6QXJJdvOKLeXaGrEknVkMPJT
         Gx25BiInstmrpC/xiGKMnvIdGZHAKkkQlP1TABSvCtjullVwUj3GTWaGEwGrmFz/tLwR
         v5zpGM8jwqtLCcpP6YaBdv92cNbCRdKa4N4F4uVW6j3Upg9ypmudRK8zdDUP4HRgVHux
         hmgdyUZTCqiWXoCHP0DqvJwoo3RYZw2iE1cMYkp3D0L8osMk5dRVGHEcHBEshPadQCTV
         CNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970115; x=1766574915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5wDUddDoFILHwCBU7oSL38U5bGT7x1S1Cv5uHbCqjv8=;
        b=t8gj52bfGWQyWklxQ3ZHjaEwfoAOh8fv7phBG8Nzl98ukMjrrE+fDTtPa8kXSrFK9s
         1gAbvj8ulncuNgYu3zbrckmdphpHhxU+3Awe/PkjE4qbk/ieBje1EqdKEvnQI4KZliPG
         3kNpnLdpo0USza/jpCCzvSIaYgQ6QVL6HVJxHa6DRUjX4ryIKN7yTQxhYZlujN/P8n+9
         aTots5OSddAEHkZTI/k0oCNoFF4QqTLxMVaVPrdVSkSdvZpzbAytHPEJEp0QhMZvTEOw
         Tb81KyGNasYTDynchhd34aJOYOUo1Jowf0WEN+7X1yNI6Ham/KbS2Fuj0BZo5ltJvBjW
         3atA==
X-Forwarded-Encrypted: i=1; AJvYcCVq3GkEX+P8mEZsGIbrtkav176bggKkY6bNvB7T07TQ4mjl1kXB+w+RvLHS3cgvkNW/MW0G4UYPZDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywIsekA2iaF0mcMYuzx/O7Ar4SH7HYnTawxIQoLtVI2wPrGNFD
	ciUcKDwZzBQt5as/F2JGIsLT4Unqyj8PeeUtYJbq70K9G8Hq0fZzTMubAUcSaX3DvQo=
X-Gm-Gg: AY/fxX7tBQ3weRwcqbwfjp938hEWCDtIo7V9inF9rQOHpwZqL3rBHgbZE4f7K8OaSKO
	4VKQOa1LIKRN8oOUozBYg+Q89Wo0+48Wn1Smql2j6+9GKLSs5Ilnm/g6JEXUn+iw8A6HmpOnuTI
	16DfdtsbUDlTBWISDun0SUTiIGw30+JMIa1abWT3s7HfZ0st8uuMu9f1yvyYkrjsDmGepPeLkxz
	sh128Sngx9GO4Iz0ahjtSXBqTDGedagBR/BAUO+HWdcrE1F7iw6rr28hnA1uR7AgqfvG6FdLRhw
	3tgZM9fIkx751lGb7ER9qxYh3dL3pENyCozHHtr18JWKvSRACbW0NH3x/u35j1rtyrhLgyLXvyX
	pK5OZn4exBzEsEmbhCnECnXLCNRygVTbNGSQX6EpuPdhxTJFVA2d0o/XTcFqUP0FJBPMtluBxFU
	F9bZvLeVnUwLhDZ+BDPYMXRrPx3SHroHmVvVegH3aIIWWjqzi12zQ=
X-Google-Smtp-Source: AGHT+IFn0YqbxgiZtiVRkJ+QtMmjGYmLvsJLkNrhsbqEX9TV5iWWuHuT6ttcHc//6S4/IzyW9RNJew==
X-Received: by 2002:a17:907:1ca1:b0:b73:75ea:febf with SMTP id a640c23a62f3a-b7d23a7581dmr1722711766b.55.1765970114962;
        Wed, 17 Dec 2025 03:15:14 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e817csm1933465066b.19.2025.12.17.03.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:15:14 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 1/2] PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
Date: Wed, 17 Dec 2025 13:15:09 +0200
Message-ID: <20251217111510.138848-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S host controller allows writing to read-only PCIe
configuration registers when the RZG3S_PCI_PERM_CFG_HWINIT_EN bit is set in
the RZG3S_PCI_PERM register. However, callers of struct pci_ops::write
expect the semantics defined by the PCIe specification, meaning that writes
to read-only registers must not be allowed.

The previous custom struct pci_ops::write implementation for the root bus
temporarily enabled write access before calling pci_generic_config_write().
This breaks the expected semantics.

Remove the custom implementation and simply use pci_generic_config_write().

Along with this change, the updates of the PCI_PRIMARY_BUS,
PCI_SECONDARY_BUS, and PCI_SUBORDINATE_BUS registers were moved so that
they no longer depends on the RZG3S_PCI_PERM_CFG_HWINIT_EN bit in the
RZG3S_PCI_PERM_CFG register, since these registers are R/W.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- added fixes tag

 drivers/pci/controller/pcie-rzg3s-host.c | 27 ++++--------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 83ec66a70823..ae6d9c7dc2c1 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -439,28 +439,9 @@ static void __iomem *rzg3s_pcie_root_map_bus(struct pci_bus *bus,
 	return host->pcie + where;
 }
 
-/* Serialized by 'pci_lock' */
-static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
-				 int where, int size, u32 val)
-{
-	struct rzg3s_pcie_host *host = bus->sysdata;
-	int ret;
-
-	/* Enable access control to the CFGU */
-	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
-		       host->axi + RZG3S_PCI_PERM);
-
-	ret = pci_generic_config_write(bus, devfn, where, size, val);
-
-	/* Disable access control to the CFGU */
-	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
-
-	return ret;
-}
-
 static struct pci_ops rzg3s_pcie_root_ops = {
 	.read		= pci_generic_config_read,
-	.write		= rzg3s_pcie_root_write,
+	.write		= pci_generic_config_write,
 	.map_bus	= rzg3s_pcie_root_map_bus,
 };
 
@@ -1065,14 +1046,14 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
 	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
 
+	/* Disable access control to the CFGU */
+	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
+
 	/* Update bus info */
 	writeb_relaxed(primary_bus, host->pcie + PCI_PRIMARY_BUS);
 	writeb_relaxed(secondary_bus, host->pcie + PCI_SECONDARY_BUS);
 	writeb_relaxed(subordinate_bus, host->pcie + PCI_SUBORDINATE_BUS);
 
-	/* Disable access control to the CFGU */
-	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
-
 	return 0;
 }
 
-- 
2.43.0


