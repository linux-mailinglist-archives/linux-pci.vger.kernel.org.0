Return-Path: <linux-pci+bounces-27044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C97AA48D4
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371BA3A78FC
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 10:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EEC25C711;
	Wed, 30 Apr 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FmUjbCUe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99325D8E1
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009201; cv=none; b=R4b4X0Y5uRjgLg7khmq4Qu0xW98aS0Ce/+DtGNFpCOCI/aqQwChcuCeldqzgy1pyecZnG682oodW+QcCZGv3OBDbLDi2uFavlAFh8wOtJqypNm/ZWkqj5k3kbzr1WtMROc9uMdPOvWPsj6erru/cCROULXOXfItzHxQA+GOxAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009201; c=relaxed/simple;
	bh=/qb3LqOk0CPpYt1EbGZXh/Cw0pmf2cmac/XhDTHJc/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLGTeECjUxDWWm21M38BS1lTP0UbryU0pLJ4Y4z6ZXsfrZvhk+MDXmFrFU1kggOhUR0rdfQt17FH12DH/8grcHAwmhOfF7/29i5kf74GHgDBkXAUzTz1IiyN4ZpWZvRamyD+yQFTUMFsAMnMOZulzaqzxHBtqL0l0XljLd/g61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FmUjbCUe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac29fd22163so1062751666b.3
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746009198; x=1746613998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/1UiigIwXR8rjSUy1c3Sx5vxGn2/huSophWGwjW0Zc=;
        b=FmUjbCUel/sDyoT96HiYbVfnZDo+v2BW0CCcZWw0bXzJ++Q4SVcTJ49ikGG0R++cfq
         aXg03AGEJAXs54SuWkde7nF8hOWT036NHNkkwZyQsmFXJJLUa13uq3yJbgxKKdfn/axD
         oS2YzykAKuXhdWJixjv+yoMhJcDe+ZMoicXN3L0MfJ6CaV5RkevYwhMZSzU2eEK8xjBz
         BSp8I4HfY6DB/hd0OxI22CAhdUvJZKRe0xh3HFZm1j4vSWyszzyczuAsbnvBEbr1EbaP
         0GkgnSQ1h6N0FyWhYWwsBoKgXXTSv41dldS8FRWOFIUv5RkGduvGzmRT1Jx6Y3LR4/br
         7QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746009198; x=1746613998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/1UiigIwXR8rjSUy1c3Sx5vxGn2/huSophWGwjW0Zc=;
        b=H+0AtWzyZtL2ZPw6tkSKQH3H0ub9zA+msZICt1joRJwEY+wC/uiSnGPQr6YbdpDsOb
         0LR8yn1N9bFBJtw4TpG3FvV6cRLWVCU0yQ1wvba0VbnorV0fZm4CmpDThULFm2a+C8WZ
         TaEbh+wm33pJXlqM6uaD0IuJuACQsmA9ADOzy+JERcNCYxVqQhanUcUKO3XCd5moQ8JE
         x07Mv8zl9URUFCi4QEqY6Wj/YXC1Q+Vw1FPzWdsxLmUsJwW8RJUwkkOA1EA9FByT+y7z
         sJs0IvWIAikdvFZYJiDNsmTWRXMyiFO+R2C18nIOpGweeuNgtMQ23gpO0kgRIQVMug7V
         uCcg==
X-Forwarded-Encrypted: i=1; AJvYcCVo5ol2QS/Fbs86hgvYbb/njn1l5XDB5k42UVhTzlYhgW1bXeOhXdOIiH4MfCauTGCvaL8rItHLW5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtUIRoQ4ABoDnRXYtS3BDSWjjhq3F4CzjqArVDm8SLYJAxltM
	9zUvyiIsR0cSW3MQqq7v7opQU+nX1OX8VOLnutPmyB2yuZ4yOxgQYGtQfbkxnts=
X-Gm-Gg: ASbGncu3zlILzbdAB96oYEF1pHegFno2298aLhr7PHbaTmzRFEMxZ/VmkazH2xtO2XR
	Fpwip12OqO9HlMC7HTrLFOoXiQu5V5BNSY7CjmqcR6imHtCL/+5pLWpoAosCs4TvmVL1fB2w6lY
	qtsdiQ4oXWz470e0rYtrs5p3yG6/dA++NqlfBZvWR4R2tUnB6bLKjNgJ2W1FbJCzJlhKvvYMBTh
	qrBleTOmMxENj34c7SrNoIBauBm5EoVJC/5HeCoG2c0m8zV4ordIltM9gONK6tg7Ku129xKN/OH
	0+YgdTtTDu3Y0ZKZ1PKBEwsnnAeApxES2ou4AnneumzIwutjZQK0qviaTLcgeoEYrGP79vo=
X-Google-Smtp-Source: AGHT+IHBcCruFD2Sx7wtL0cb9Uodi9fNatKRjptTZekaQF3eLuwGTgjpuo5/jbKcvNzZcB+Y1bBY1g==
X-Received: by 2002:a17:907:3ea2:b0:ace:da39:7170 with SMTP id a640c23a62f3a-acedc768b2fmr307149666b.55.1746009197623;
        Wed, 30 Apr 2025 03:33:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed6af86sm909390366b.133.2025.04.30.03.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 03:33:16 -0700 (PDT)
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
Subject: [PATCH 8/8] arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
Date: Wed, 30 Apr 2025 13:32:36 +0300
Message-ID: <20250430103236.3511989-9-claudiu.beznea.uj@bp.renesas.com>
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

Enable PCIe for the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a92c4122a8b9..b36a96777018 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -226,6 +226,7 @@ CONFIG_PCIE_MEDIATEK_GEN3=m
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
+CONFIG_PCIE_RENESAS_RZG3S_HOST=m
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_IMX6_HOST=y
-- 
2.43.0


