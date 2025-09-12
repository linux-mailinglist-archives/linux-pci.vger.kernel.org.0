Return-Path: <linux-pci+bounces-36019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A89AB54DB6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9628DAA4A92
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7B230E853;
	Fri, 12 Sep 2025 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UuT9PLWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CF3093CE
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679903; cv=none; b=JOhadp6BH72lNyUfV8rwGy27iTAMgJNGgpodU3ps6LrwIRYjgY0Wm9JAHbQNDq1ze8v+IQ197ZLkqp4/3nIj9HeZSL/NIatQfmKqMjItDEW/4TCvfxpCjqybJmwhR3DBT8eOnH9kz8NwHnrbtyb84HjJZCqOtyJQ3hvdBkiLdFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679903; c=relaxed/simple;
	bh=rlU12FG+4sUq0XnXmaxg6zY2V7ONJn4T+IfJgTnkVPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/f4yF3vpTv1egT7JRt623r0y+0Qj2ePPgllWa2YBBuAFefiRKphGy/BOfFu2w9TtEtYf5zZ4hbFtL0MyLcNZ+GNUPdBvVtjmFsYOxqyYk7bPxYenjpRcdTbqX3V9saZulrJSGHdIfdFJh8RA2PYbTJ6lra428cv2J0GPTOHzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UuT9PLWb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e2055ce973so1041853f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757679900; x=1758284700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md5nkDmRRh2gMN/cfSkiCbamlknh5oiGopcdy0QJF8Y=;
        b=UuT9PLWb2lfWbAIh0WkT7qwgzoW0KT8KC3XMLU9NE5FRaozLRPm4CS8L6q7a35uSL9
         49+DAdxtYhNJIrCiw6sz3BYnCMkDSu0MIquWtcQAyeAOnLMJF+LNcb0dvIgsKZpYhXs9
         5oq1c5B8AZL9zrdbYBR21Q/Bn9wbOSsKvzA1WbREOC5qmtIDZ3eHZslt/6rKxr9Htf4i
         g7JJrb3SosqooP9y2AuPB+hZdsII1wlGE7kHcYf25imF9A1TmriSUzDLPyC6GDLCKGu6
         8jQbaSkmnJCymmITs7rPIi9serU0ipAcFhuoSMuSm2EKES7uZKHNzpd2e+Y8WVA77jtZ
         hAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679900; x=1758284700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md5nkDmRRh2gMN/cfSkiCbamlknh5oiGopcdy0QJF8Y=;
        b=MadZn4UAswO3JGcuNBbqxvDGnvX34sZnFRrloJt3uJ+QzTOCzaxtNtsKoJTaFnTafk
         ITcqtk1cYIpf2rxb0blzdFGzRb7zeVZJtV8qHpV6xIPX4ChzMlSjEV0xQq0XTiXb/+Vb
         Y/KGfe5qb4ECVs8AgdwYGxRaUM2B/gbbAjKmywi+R5WVsAukOO6o7Iz9e7nsBSviT8+x
         oha0klRbL6zUtHdXRdrUG0Z24XDkB+nOUCVlpHzyd0JjBHRakvuKOmfVYY8n5Q2+eqHq
         XDP4129m6XtEw/Gv0vv7ZS8S/yfTY/a8rEKJlSjScIFcaQA/p2TBm8lPC2qF2sGVG5+a
         /R0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwdaH0gD4AZROZaN2vWwK5tHqZoHlt84ai2QyyDuoRUGJmQiyA55Wu9Q7u66OPdvLOenkARbX+TOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLFbPzFKAlTcy204Lpa7uKaVtAYLeL0Pz0Vps7k5KpKmAR9xR
	SpVUHVzWk9QvwS7kiZZ+htd+XijIRuwzLZrqAi+IYMuoyyLQco8XiUSoqXtCs03aA9w=
X-Gm-Gg: ASbGncv+17PGbuoFuyFg5DfRyx3NDNp/g10uFDntNARs/RYs2/AEelxGUiVh8VKYyei
	sDoLiuWTBJeIzXyuuW7HSK4CZUf8cNtjhBMreys1CiXqIEusmqOaMsE/a3f7Fd2pdci5jJNe8qV
	NvjzEncUROupdCFnMHtMSd2Ze7P9Y3bTsZcEzoT9AOgIOr7DgftXQiBH+G64Q/KVJvyvsOSr0nZ
	BnnQlskklvLBnResqi8Cm2rkHWMWU6GXQBZiyp6NzTV8fjJKSXWLuuJR5uYUDoskAhEE+qO4MFa
	sNS+a56xblhNH9o909wL3Z1r6iUYExVLoMxBwBJiSmK5VTWzrm1F9bPd+Pw4wZ3ZqF2uurBXFdo
	mHlo8iCOifryqSyta91qp+eMRbPSz0zTQzCcmRrXRXxdY1WdAV+DP
X-Google-Smtp-Source: AGHT+IFeFgkWbvNLPP6zQb3x+mqbY/nkKchmA7T4My9baxdYYpQETFEEocYlizuFZpzNAgPRzsrfUw==
X-Received: by 2002:a05:6000:240b:b0:3e7:6457:ca85 with SMTP id ffacd0b85a97d-3e765781280mr3017656f8f.5.1757679899686;
        Fri, 12 Sep 2025 05:24:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607770c2sm6320091f8f.8.2025.09.12.05.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:24:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 6/6] arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
Date: Fri, 12 Sep 2025 15:24:44 +0300
Message-ID: <20250912122444.3870284-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable PCIe for the Renesas RZ/G3S SoC.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- made it builtin

Changes in v3:
- collected tags

Changes in v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5dcf36e99cd2..ca731843a9ba 100644
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


