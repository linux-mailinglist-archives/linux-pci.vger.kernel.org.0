Return-Path: <linux-pci+bounces-37672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF48BC187B
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F303C791F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9A2E2F1F;
	Tue,  7 Oct 2025 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kWLdZvJr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0602E2644
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844248; cv=none; b=DdGB8c/5LyoIYilqdx3Lcm+vbZBJFlDaSmBXOoTum2JG6wWZ9tiyrwcDiOCtpTc3Ejm7QkL0rHB0OY2556YnxwG04jx749WhF2q18yKgVIoINkzgpu2CkPjsof/fUgVTibJO/ddLJt0zkR43hVb5diEv+FqUPwuhTGwjjAt7YbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844248; c=relaxed/simple;
	bh=SlrBBpX7XFA4K8jiRjYNYq/rnOvVx1EIF4UCFXLAU9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbrfxDE4pI33/jlPgjYmR05LNF2LvVd+2QGhd8KnvV2Ws4qcG/+Tnw2aYlRSmuSCtert7Lm+5ryoC2wNlvu+RAL9D3Ya1Edbe4yZu2cxPA0oO8T/SFAqWjdkRyew17vFbqnSPMvLholp4hesAmppRGAo9jmXHZw9Byrr8UKv8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kWLdZvJr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso54502035e9.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759844245; x=1760449045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXLUY6O3ALE+kss75XVolMctp4DQQxT3EVfm+7GyHeg=;
        b=kWLdZvJruCwqnhmr0yLlSWfi24iPBQFtfWCtg6QHt94afuaIkbCPzycj06r3p6+ct/
         ymo40DMkFSjS+ljpcZOLWx9swxyO2pvg7K/0iZrQr4vaphyMiZTdat3ZurIUrAgbbpqp
         UwVAAukZdwRhna6JQPsds8vjKPV2/ji3stMa4anS6c+7uPlgCHF9/DjUld0ZS5T2IwHt
         jmDTdCmv5lUM7cgYxNjZW84eXTLYyHqLzQtU2y5DO/aZMVd2xCAJWS+x3erqHCfobRhT
         OyZMjtvnWn6NnTsNN/tYQHxIDCbTkmRIk76qOa1WATEBLgtFK3NHmcLJ6KNDxfnjd3Sn
         LliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844245; x=1760449045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXLUY6O3ALE+kss75XVolMctp4DQQxT3EVfm+7GyHeg=;
        b=e3Wj+nycnbOtdWi5uNPIrF9GPlh+zhoXZsQl1i0KKYGwrV1ZBK4aui5ofiv/mT4c09
         cZNPhVAiNP35byeeUgmVurnuJ4JVvz6C8kKl+QyGoQywZ4okgH674HVNWo4QklOTM88S
         i+4Zo+5g5uiBpUTThys4sDA/NULyYsSdjUQNNG3KVYU/7CZEYrlFGb8bKFyVtqff5iTA
         GHebxX8G9/emTn6ULATeaXdywsMgk99XTploBcC0es3yrXjo0OIL6jvb5Rh74wHy0tfv
         EBArz8+QIWzspQNdr5mZqPzQ6YgNWkXUVD65a27ZzUDN/F5joA3YbtmGclW28ZIgBCh8
         AY6g==
X-Forwarded-Encrypted: i=1; AJvYcCVJbKG1Fmly4NKaD/16w2PFImZUczwCRkoeFhi8VkPmfvEIYB/g5R95SqncSMrmKuEYSn3LcvfPSY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm3gTpp+Gqb2He3edzSTqTRV54iak+c8nx+dzTaGGuHErwHv3h
	7QelGz/RWcohiQBFe9swb5wA8KMtt514ByWip5ykDlAEAVzgqcF9/nMx7DDaJqLLIIg=
X-Gm-Gg: ASbGnctDuwXokLduT08FTnPcO0jg/ggsyf88DnLl7yE4IXBkljLqe0aGzuL/J4Ubfgb
	eNtKGDhD76bZI0ZufGBOF/tLZe1RnPq51N6/90UiHPJm3z1AxGmYp0dMEx+O38pOqEczHlCLPXB
	Sa6T+xigvdxoewEvYi9GsNCeUcrY5tighn9KKFbl/89vcG6mjiBikyRanf9DKxORUdQgEbwHO2a
	ik3CqA6SM54D+KgKhPiIl2lnqdtcyol+AIkCvu0dVKLCQpTBPlsEjEDlC3EvVpbu4708RtwHbie
	hhCyUu04zVId+H2eRLGce3AUV38j+tlAW/alZ7G4v9fJTLWIviyvOLT5+wSey0pMZtAAFQOKbqv
	3f1idwBQhVGS1NAxrD75acwcuP5JAbtHb
X-Google-Smtp-Source: AGHT+IFUMsIWmk0AdblJ1v0CAZflHye79n+otg2nhOCKiGVeiOkUM0AyVJvRyVI3KKsBIXxIN2lCmQ==
X-Received: by 2002:a05:600c:5406:b0:46e:47cc:a17e with SMTP id 5b1f17b1804b1-46e71101ae7mr95191315e9.1.1759844244701;
        Tue, 07 Oct 2025 06:37:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm272189625e9.4.2025.10.07.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 6/6] arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
Date: Tue,  7 Oct 2025 16:36:57 +0300
Message-ID: <20251007133657.390523-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable PCIe for the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- dropped Tb tag

Changes in v4:
- made it builtin

Changes in v3:
- collected tags

Changes in v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..54fd09317edf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -230,6 +230,7 @@ CONFIG_PCIE_MEDIATEK_GEN3=m
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
+CONFIG_PCIE_RENESAS_RZG3S_HOST=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_IMX6_HOST=y
-- 
2.43.0


