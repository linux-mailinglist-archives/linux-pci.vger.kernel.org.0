Return-Path: <linux-pci+bounces-27039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5984BAA489A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DE71C05E7C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E7325B1F6;
	Wed, 30 Apr 2025 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ar3MVEeq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F0258CE4
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009190; cv=none; b=KOWcc9735m9w87kpUFJ/z3JIFvsEr3EAmyxOedPBPH9g46C939ohT+Sho0rP04e1RDeHyHPOJRFjQq2X9AgjMai3wkXZwBA+2PJR/OguyATHygeCPo8a04zEqERQggoT7ZjFz4XY+JhcIrL8KRc9m8jQWhsnPEcAVjGiAp4AqWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009190; c=relaxed/simple;
	bh=qqyemasPL6QK59u6QUV4f+mqdNA0WLZoLI0hQaQeRAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baSTLhCkD++ZYe7oIVXYoVP8fy5RAKpxhJEt6MS13JXHNXlRs4K0JNF0DphJN0bc9KBmm2OOU9pBYmN37fzsVN1E1D7DS63Sy5bM1V6v1EXR220VgnMr9rp2j2aKski1hfM1CSwRsH5apYIDq5SVSBj1jzQpgsNajG1XtHrXD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ar3MVEeq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so11241634a12.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746009186; x=1746613986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfTKPxq4bZ4SwTcRdBqaDniN3wi53FAiqmOye0MFIKo=;
        b=Ar3MVEeq032Zsp2bufQHkoUShr0l2ARJ00SAzEmIxHbLo7ufXPfuT/OFIyzkjbHwB/
         8arCjpcysqoHLbdlRHedX1yniC1MAit4Iy61zTfmmZIb+kRzpr8Gju7toflkHnFr1ioC
         siWYCQ7rnG5t6S8fJNXn53WYfeM8Jajveq9c3o8JcD4mWeHHkhgGrC2or5IaW0li0pjb
         hQ8/Q+5xVz3yBufrns5L+OAr58s1kdAwnTkENCcBrjWv/mVla3y3YaM8xCkveG4/NgR0
         t0ZdJ2jKLabmgUxRK/h0CmhiiZUcPWCiKG0rNW70CTFT5I1NCixAVa5hpm1Ud+BC8XFI
         u4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746009186; x=1746613986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfTKPxq4bZ4SwTcRdBqaDniN3wi53FAiqmOye0MFIKo=;
        b=mZ2ArYNzZwpylIViKang5v2fFtC2OgYtpTjUioMo92MeBk62jcAV+StSqoxTQ3UkLD
         HfMfXvimk+aR6IYzgqNO+mfTAjZ8V617Z3snQcicKXkwBN4hUIjS4YpRMQx0OkGDPEt8
         bLs7QEFGv3BylBzIme9TDiO2eo/5cmGBhCXB42UC1pKW5agf0Rs5tc6TkdIW/yEJefqa
         icEdYpNVu51AfWFkZm9IqKzIHBi5BfUQKC1V25iFlpxRlpizpFJ90Teb/MBPFRzWQIKY
         FtW3DoelSz0Sf2UeFiAlZFVfQOZbkq3H3bwSReInKjM0hmxY4ln3edTuj076g+AxgVvI
         SO+g==
X-Forwarded-Encrypted: i=1; AJvYcCVuFwlQilDrp7SY0pA7Bk2g7ieHuOpHTltnAjZknkTKoyifhxplAXgHCMSAknuitHcIvS91HJvbSA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8Ud/dhk99P3QTSqUdt95zRlWgrhrmTcOOYaNyeeOcJfGImw0
	WQrrLrZA1q6L9j69TQFhi2TgYMelYj14E1DtWr/YzurdCbpfxUiiSOwxCIo9iHA=
X-Gm-Gg: ASbGnctF4FEB0CY6Cn+jVVdTvCeBk9w4bhO7yCQXldioz1TnF1ftEx2hWdrG5glYOR4
	GisOoKaASlo0ujLFlQjfMSwwkFVSqm1QXAu23UOF5tCMAuOhVEva8EKMIi4bLBPloXfMbaLQGnZ
	/+PPpVMIDC5tBfsb+vYiGs9+rFGaz3SvzQJmBlZLHNiogb+gco59Kckg4z6pnUKlVxWxK/zjIPD
	xgBIAAyrAL89IsoUjIf0KkbPLeUPIpeXjNnlNetFjxb4v9h4NTwJyM2sXd8o3aZsQbTKRCli5Xb
	hN7p7VQ1mRKnPK9z2YTnpiYmph1R9D5pKYGh0TvHa0vX3d+gtj9+mfq4ssJrDk/StE7IHn2dv89
	3nNLmlQ==
X-Google-Smtp-Source: AGHT+IEEfl+k3BC6Us3G4LOLDc9wt5JbZ4OiyNOr1AeXljqq4kLkSZXbAFThitp0f3NmQGw8dzbixw==
X-Received: by 2002:a17:907:1c94:b0:ac7:1600:ea81 with SMTP id a640c23a62f3a-acee2600a17mr193116866b.49.1746009186334;
        Wed, 30 Apr 2025 03:33:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed6af86sm909390366b.133.2025.04.30.03.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 03:33:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	saravanak@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 3/8] of/irq: Export of_irq_count()
Date: Wed, 30 Apr 2025 13:32:31 +0300
Message-ID: <20250430103236.3511989-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430103236.3511989-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250430103236.3511989-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Export of_irq_count() to be able to use it in modules.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index f8ad79b9b1c9..5adda1dac3cf 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -519,6 +519,7 @@ int of_irq_count(struct device_node *dev)
 
 	return nr;
 }
+EXPORT_SYMBOL_GPL(of_irq_count);
 
 /**
  * of_irq_to_resource_table - Fill in resource table with node's IRQ info
-- 
2.43.0


