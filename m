Return-Path: <linux-pci+bounces-42841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91048CAFF92
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 13:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC023089E11
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36369328B4F;
	Tue,  9 Dec 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="iO/oDqYq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F1322753
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765284691; cv=none; b=HwB6VyY5SdC/QIutOjtaDHjr+pXs/2q+8nkS03JTCxoGtQfFxANuwpaEDDQhO7RVbLYxG1TVTjmhb0BTCu/3+nAmKrgzoqGXy+YcHlTnT57J8DXy6dmpgL/PjrpDH1lZGlcHf7yV0Fzf+ktj+xOdsmQt61tl3+p8dNn0R3s5WiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765284691; c=relaxed/simple;
	bh=rsEY48Dl/2+LgFdb6mNeb12u/2T0T6uiLHgrX5UTqI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afEDVuA/0rAGxXTf6dhu+lUlLiPGEGJWGA4Nf2ZPe+bALF3VVfyeQVq2XPONg3MEMbrujHsQ4+hjqXTxmeU/qBJlEqk3Dcop3nvxGF/wZ77jUCejhZ54iIgKVLmNVnjw5rwij0Pm9iyrnWR8EDPpBt5dow2vvNYB+cmGtlaif+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=iO/oDqYq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so43698005e9.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 04:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765284686; x=1765889486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=afXJUoTdYBs1G9U5HKpUIzH+QZ9Duh8PFbcc6QIvflU=;
        b=iO/oDqYqhhAG9IXf99wgmpBmjhxB5Y2/hZo43+LLXUCHdxA7VnSPMJlSk+Si6ey3ui
         IY9OULVtQxazpKQod7prUMhABEAb46zCNdTEZOfP/V6nnxaIoK3Nx2JO2uRm7sya5Xjf
         h4x7fjBq+BOkq8ZXgseJaOf86XbUaFGaoIoF7djj4Gx0uglYjiWnqTUgEswL2yDUMBi2
         kdp/6H79NBir2b+e852KzJAKpLoYxMHiCY3HKEvhMYzbL8PGpMhdOHgopylIf0LHSdyK
         DfhsrVlamJ5IciRrxuVr68FmEHAUjllCTbAKM9qwWaTw7HPTQrq6WFwQ8i6Bq/spwVwr
         JDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765284686; x=1765889486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afXJUoTdYBs1G9U5HKpUIzH+QZ9Duh8PFbcc6QIvflU=;
        b=ocy8or5rIl1tTqQ13lMKutFp/QN9biZxO8WcVPrafc5iHtZgBe2HHPHkoZS2dmSByX
         +AcSKsV/Ui6XpzHY//3zze/LRJJbOaP4wymuTDUNZb18JBz8b/jYdNM0cF/nbjToLMWe
         yvFL6dvJjQDNeeUFhOrqOhvrEo9MMVRjnRICPo3EW93R690bPnKnv9NF2Wt0Mh+6jyE4
         /Ysvl465G5FhMzZU74Tlam20kSqn2UPljga0YPTLMVPenBfWbP+kAVDEEEWwQmW3nKYn
         dyXwf6EbjJdqoB3IIaG5iOnbm/HJkShsdq2jxT+fN/6qIPXW2eiKYORItk58ZrljRbpb
         N8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCQdARIiwQtZhfs1A6sduqkF0Sa7h8G3t+CoYU+hJRu8rlH0DDkIsOH2LODbYnRBMqX4948nLUScw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfnUcyrGhhXTv/VS78R3i+vFBZx7ucs7xM/97vDLhL7DtrZoEf
	9WEqN1mTrs69RXntRZIEOo/cst581KVj0Fau50Mw1pA4J2bUTNbo7Wp1h0QVoP8RcB4=
X-Gm-Gg: AY/fxX51PL2mGVVwN/atgk4Or1O/toWnYI/IRcOZw5A6CEjPePnHTTPmAyfaor3Yjs5
	q1vqcGN3F0vky4cNFnowCY8zCWkICe78eezKl+Pp9rHwtuSaCB5g9fvSnjuUwH7IfPrm8P/AwFv
	zM2Rri1ziLz2xtDJoWQOQ/NVt+tOPPMqxRWGykGH/0kO9p9Q5+qdhU2k1ZIqenfK+KxZ12lR6/0
	EAp7onNqaSgKspkJKjESZpLmRB+SxffB+8yLe8LgXdClSUBFVrAY5whYzI+NumJ3jKc+0m9qMkx
	00yNHuslvnyzFGgzHExgjLVTJNzMNgAv281IhoRYQ2uSDwjFydrp4EMr7Km8dCLO+sy7s+vwHJL
	/ZrLg2R9pj7vqGZ/kiPbZn/DU2gHzMA9q496toOUog+kUO3ZC+vSoVLf05ec6GQYze1XvI+fGxM
	QG0EOy7o50IHURmyO6fMRDaOXPvJTGgUuBbx9QKKmT
X-Google-Smtp-Source: AGHT+IEWm1fY2QNsyJPNRyYQ1RZn1PbKph777Yy+bUxaq8uTmjsapUHrutErncCjUEmcZYh3TuKrvA==
X-Received: by 2002:a5d:5f88:0:b0:426:eef2:fa86 with SMTP id ffacd0b85a97d-42f89f0b1f2mr12787199f8f.11.1765284686271;
        Tue, 09 Dec 2025 04:51:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm31678042f8f.42.2025.12.09.04.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 04:51:25 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] PCI: rzg3s-host: Fix compilation warning
Date: Tue,  9 Dec 2025 14:51:22 +0200
Message-ID: <20251209125122.304129-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Fix "bitmap is used uninitialized" compilation warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202512070218.XVMUQCl7-lkp@intel.com
Closes: https://lore.kernel.org/all/202512061812.Xbqmd2Gn-lkp@intel.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 667e6d629474..83ec66a70823 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -479,7 +479,7 @@ static void rzg3s_pcie_intx_irq_handler(struct irq_desc *desc)
 static irqreturn_t rzg3s_pcie_msi_irq(int irq, void *data)
 {
 	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
-	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR);
+	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR) = {0};
 	struct rzg3s_pcie_host *host = data;
 	struct rzg3s_pcie_msi *msi = &host->msi;
 	unsigned long bit;
-- 
2.43.0


