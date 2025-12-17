Return-Path: <linux-pci+bounces-43166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D780DCC746E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 12:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BBF63043065
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FBD343D9D;
	Wed, 17 Dec 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="n3JLNqqS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D033F8D6
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970120; cv=none; b=aJsQ6SnSTD5XJUaucdmebd8D7yyu4iIGTwOrdpCI7oXJTjBr8WRqoa8T2IOuo9PPTlL8mM2hv327TUNeeerMELg5kcgAa5K7XqUlIwJ0BzFwtmjbUDPZz0RaYRE4R6+RA7anLhHSEUtaxo5NKuhTOYJxl+0A4DLrH1fX1LWnjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970120; c=relaxed/simple;
	bh=5Y4gPMP27s7n7uex8rzUJRSTf0es0tnb6FP6Q/Ep6Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwfI3JMnDczps3EF6SNti6Hj0CjidnU45Fw3+IRTi7matEqbpm2Hkrru7ZXMMpRZBGQOJSjs5d0MdHbLH4H/gp6fd+/1Uw4GAPx2Ti1OXcH+iMEOJvia3QzIMz5BPtw7DG2CxOWBhjDTZPwzzyIgz2Emf4eGntyHCJJsjGuTQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=n3JLNqqS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b73161849e1so1314925566b.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 03:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765970116; x=1766574916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00dbsnXRQYzCZ5pFyuIk2+EAhQKdp0t5ldMAnwaQRhc=;
        b=n3JLNqqSJ5puozmVrWhnOC/Z5rNt3FsMREzb/Y9ZGFy60YQpsTO+nybUy9lVinyKtp
         6FbaoVctiff3+n15bvQek9yResIohz5bwVW3mJk7DzH6qiQFuNx5VAJpAeuMi4iINiPa
         EaJBz2I788OdlJfsyrJazWVxXSIDhwQmv+G0+BXmQbDWDY3rjiE/tPM3/AGYhJFLGtZ0
         UU+B3kq6X6eMNvY3UWcSIhN+XQo/RdEjgn4RpdR7Ki1X8afLo3qIe0STognWP2b/eE54
         P0NtyGB654uzL38WnscllzERaqqENT8EVflJO5uhT+1szWaCYnuE3w0U5gMSHLhaxqMx
         5F7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970116; x=1766574916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=00dbsnXRQYzCZ5pFyuIk2+EAhQKdp0t5ldMAnwaQRhc=;
        b=bU8rC1qVa3Yza2IEP43dhCL7ahgA5oF2f6gWz8kb5oBnrEXaDHvRTPj6lfHS8iMTnI
         SXSY7JZLMUIzLfC8nhh1TmT/PaK9bp7ncrxlNtlxpE9tg+nXYvtrbf811BdEjqTDAtnL
         Egtuc95iyfdzqd+lCDEcfshqfe7Znfd3BP7kvAzHXJdpE2eBegvtt8XyFvGnlLncthvc
         Gl1lOYJChE/z4UrzY22qWzP6MkM7Cou6yflVmkY74yYZnSoJVE/EszAxg5PEEdaAlG5n
         id6gSfHjxHRYgTzSoPyBG4r4Qh7qKsHSMVUgJLncS0IWf7YPZRIgw7khjmldb38HwP0U
         398g==
X-Forwarded-Encrypted: i=1; AJvYcCVNJk4ypwp+ydmOx76XrfJDSdvSMtazfZjYeoHKW9Q5GoZGeOLOXATxgdoXtWAQP1Ap2M7DwxtUFp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOHSlVLu7b76lqAJaEYxXRzWQFM4hijATJ+FG/ROBlla9zgV1A
	I5ByYZBKDG/AvE8BxXbHGdxIVVmlOIUSbcJ0NDAAEg46IrNxkPj5htyiBv5K1kEQGu8=
X-Gm-Gg: AY/fxX4+vfKu8IKFPVYyOBFTc4n0wmvYLihoCLabMyx4fFDV//BewgsG+rNfGkPS7SG
	OseeOD9AddkyAijArte2XcVd97I1+xrcgRHvj5yb5+do6I3aKHSMADRWMYN8gyvMyY2uHH+949n
	gu1inDaMnIDdcCeXEG204TxCQuAKEDwgrLW5kvJxjkwcOMcj9aK1C/0OtsQfKMsdWACl7HuZjta
	2+urQU5nrtD/z051gUKhYgzXNlKeAOBKx+B7I/VIzlINNkQoE9egqv2t/83FKoZbjAzxtwOW4PF
	xAKiHXvWoXD09D4f6PB6Ht+FtSrMgVhKGGl9SlHCqjCbTDUa9ZnxYDIXZVBjEVh/qjSyeJoQ66T
	iZT5le5Obfl8aDP1SKAXhi/NJcJJptaHxwMDz+nUGjkOUQpM+eZjW0DDnithdieHdWnXi7RofDg
	2zX4FazlngHG0Vx9UyLKepaXofvrEXoVhvvRkv6G+4
X-Google-Smtp-Source: AGHT+IHwzhERrnuAvF/Lpiw/TJhnaVT5ourcEf1VWmOhh5lv6gcjnMP/YqOoOAUxckSeF3VPI0b24w==
X-Received: by 2002:a17:907:94c6:b0:b76:5143:edea with SMTP id a640c23a62f3a-b7d238baa48mr1792946466b.30.1765970116315;
        Wed, 17 Dec 2025 03:15:16 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e817csm1933465066b.19.2025.12.17.03.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:15:15 -0800 (PST)
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
Subject: [PATCH v2 2/2] PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and RZG3S_PCI_PINTRCVIS
Date: Wed, 17 Dec 2025 13:15:10 +0200
Message-ID: <20251217111510.138848-3-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v2:
- none

 drivers/pci/controller/pcie-rzg3s-host.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index ae6d9c7dc2c1..5aa58638903f 100644
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


