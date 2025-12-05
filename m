Return-Path: <linux-pci+bounces-42692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAF6CA75CB
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 12:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 194AA30F03CA
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 11:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847E2324B2D;
	Fri,  5 Dec 2025 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="iSk9jrzZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B6A2E542B
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764933898; cv=none; b=Jfoh++V7pO1oux5XyTy5C9cZBpx9VY1sjy02fd/c48XrO5sijTbKxH+6C0cfZHZ18Iu6L8yb2Rof5eSOM73Eu+b3lCy75fwoCw4cP+utf75ioVWxlZy2O2aEhyLP585NA7Pcoc1QxIGWmzgwF8U+4l16PUHR/2Q1h9swXbb7QYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764933898; c=relaxed/simple;
	bh=yXDHBdRoGAl/Lik64O/+XKd3nzF1HfA3V+zbN3Pg1M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifnGHjkQbwpcEe4zysmM1Qa7li1DDlf3i5PQzL6R/rx0oeCAN9YiMEFkc7RTAFhyPr0+21J1Wve0UHuo1nkV6jMkPfaFw+ZPHXIITn8IrJEdz7O3NcarYNOdpOJZm7abxTltmYkK3EboMONUhqhrJ9ImEcUdIKVPq6T3BRKFzfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=iSk9jrzZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso25690425e9.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 03:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764933893; x=1765538693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRqsUnacrK/b4CLNtcV+2F3iQRZrhWyy78U5Brb/9/E=;
        b=iSk9jrzZh+pq+LkKpyYVmVtQGZU6Ub1HZAI3EWVn4Q3GahpkWMUuo2xZKFLIJCcAZ7
         urSiEmRqHTqqnVk1G23PSaejIcVX0t75eoivmy1QC1Wh4H68iWQ41lhDwsA7OvRXeNYJ
         X1CkeEtEfcDnidowGuPVT5foESTxS4HUMg+BMjQOz52HFSotpn/i+Rkpkmx98MuTjyul
         Jd4FU0i55LipibCpEg2prDXSwcCwHfPZp0GKs6sn04mFmeTa0qLKDb5GcVX50e3E3M17
         M10+zQ1Rz9kE3DUL4JFQ6L6Cp7xlyY/HFUmIkKaW62jpP3ekJ/nSCBRpU3hZ/Re4nTt7
         mN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764933893; x=1765538693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRqsUnacrK/b4CLNtcV+2F3iQRZrhWyy78U5Brb/9/E=;
        b=sYfIESW65XmPocQxWgGNaDTc2mOcH8c4GRSetcvL3V/YxT1e+eT04C23KgocVXg2yT
         4yi0DzkGqIguoyb2z2CMTdqb+MhdYtogZvyppDdQ/v6cgj1G6zSXRqGP5cZN9M7GMQU8
         3EijuohBmDmVIHZ34gusnc1VSw5w/uCjcMPLTf2K/4LaHdfbvl+0IrN11gOoS0y7NQWp
         3ePn2pom/7vo5GL9Oi+sLcl5cV+8QCb4Rb5IosVXwpQrbytSOF3LY6tCIfi9263Jbt6s
         jv5GV8Z+jEsnya0cpgI3jYnyqtQaAgt1xxo/Vtfswp6M/TLSpWeStFRHDW8ViCw3zyn8
         TXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUMQHWo+E6lD4pMoqTBaDNvllvWsKIV/k2B/Xb+jTj3lhowtnWiC38f+gmvcGnjd5Kkqx5Ibk3VpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUHZnX9LMZ1Lr4GoJyh7bZb3Fy9wxD01feUK7HM0+9RTC2fFAj
	+no8oPNWxhgJGMQ5akUzAroqB/Sdu5mwqAUNzeCefxDnsFQW5FpIE1MXrMhTMazKeKQ=
X-Gm-Gg: ASbGnct1p+qoOKjremP4OBpYlEt1SjTiZRNZkhYxomT4RGMoGJOFScOJdHZH4oINhDT
	lotDsjJsFTYAVmwSFGJyeVQdWLraHbE0BlMce8n+LrMHobEV98VyGTS2Kf50KfSbij800arGyTw
	HjqQk7b6JnsfGez7C4rHdJ7xd0JAwfVA5Ae9nxtgiQBfyDw4XoP+qkIptq7TjXMCzHElL4bRXku
	QfHkmUsvLX424HbrCpYoTjOACB/Sb4xMueeYR1Kon1a7hs2tp8YE6IzgxGBHX/5lkPnH/cMpy5m
	3b5Ji54LPxE20WVAS13V71Q7oFrqo7/yOOOQ3M3JYqltMgFmejQokpN2KN879L4qFAUizPjqj4N
	Zld9zDZfmE7NXXncXztUOgnaUu0puARImuLALCymuy52p1iee8iYaufjEgRt5zkxtONDUiJydnq
	RKk4AOzC6MpB2x2K8EfKacyMod8GQPsf3R+tM6pcr+
X-Google-Smtp-Source: AGHT+IGNPaOKQjtNRIfHe4xo0LVR3XMZOvMh77LGhEZJMBYv1zVxkBTDPCRNimBT4GTuJOHZUss4tA==
X-Received: by 2002:a05:600c:4e89:b0:477:b642:9dbf with SMTP id 5b1f17b1804b1-4792af48329mr99647305e9.32.1764933893004;
        Fri, 05 Dec 2025 03:24:53 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310a6d9dsm78176435e9.2.2025.12.05.03.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 03:24:52 -0800 (PST)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 2/2] PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS
Date: Fri,  5 Dec 2025 13:24:43 +0200
Message-ID: <20251205112443.1408518-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205112443.1408518-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251205112443.1408518-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS registers are of the R/W1C
type. According to the RZ/G3S HW Manual, Rev. 1.10, chapter 34.2.1
Register Type, R/W1C register bits are cleared to 0b by writing 1b, while
writing 0b has no effect. Therefore, there is no need to take a lock
around writes to these registers.

Drop the locking.

Along with this, add a note about the R/W1C register type to the register
offset definitions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 547cbe676a25..d08a63d89452 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -73,6 +73,7 @@
 #define RZG3S_PCI_PINTRCVIE_INTX(i)		BIT(i)
 #define RZG3S_PCI_PINTRCVIE_MSI			BIT(4)
 
+/* Register is R/W1C, it doesn't require locking. */
 #define RZG3S_PCI_PINTRCVIS			0x114
 #define RZG3S_PCI_PINTRCVIS_INTX(i)		BIT(i)
 #define RZG3S_PCI_PINTRCVIS_MSI			BIT(4)
@@ -114,6 +115,8 @@
 #define RZG3S_PCI_MSIRE_ENA			BIT(0)
 
 #define RZG3S_PCI_MSIRM(id)			(0x608 + (id) * 0x10)
+
+/* Register is R/W1C, it doesn't require locking. */
 #define RZG3S_PCI_MSIRS(id)			(0x60c + (id) * 0x10)
 
 #define RZG3S_PCI_AWBASEL(id)			(0x1000 + (id) * 0x20)
@@ -507,8 +510,6 @@ static void rzg3s_pcie_msi_irq_ack(struct irq_data *d)
 	u8 reg_bit = d->hwirq % RZG3S_PCI_MSI_INT_PER_REG;
 	u8 reg_id = d->hwirq / RZG3S_PCI_MSI_INT_PER_REG;
 
-	guard(raw_spinlock_irqsave)(&host->hw_lock);
-
 	writel_relaxed(BIT(reg_bit), host->axi + RZG3S_PCI_MSIRS(reg_id));
 }
 
@@ -840,8 +841,6 @@ static void rzg3s_pcie_intx_irq_ack(struct irq_data *d)
 {
 	struct rzg3s_pcie_host *host = irq_data_get_irq_chip_data(d);
 
-	guard(raw_spinlock_irqsave)(&host->hw_lock);
-
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
 			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq),
 			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq));
-- 
2.43.0


