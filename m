Return-Path: <linux-pci+bounces-27037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1D4AA48AD
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0AF3BC5AA
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB95246795;
	Wed, 30 Apr 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MmoMXDQp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF25F1EA7C4
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009185; cv=none; b=hcPkX4gHBED0RIScaQlXTqQ+nIZ2gGVAvMheDJKubTsVldwxfNvO8P1ssKK+3z8YaMMUT2JITgbJeDyDojgJtjbbPtfrm0mLU3NtNl2XCZK9GS+cAHlxv/7R9GlJ0hNIQrypbSX8oSjdH/zRlNwn/38PBc6VQwS8XSxmnm9BOcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009185; c=relaxed/simple;
	bh=VF5hE6k/MDcqLuREIWpFmNpYxebRlFOo17tVqVOfzy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOFzTULOYc5vD46x/aYelbbjc3+BBOMmT5dUYEeTjfYxUeP7SZO3tscd7oggkHNiX2oKtBNDvKwwA6AaK2AUl0rR0KmscAE6w3d5vdAdSCUMRmnB1YecQozU+XSglwGOt0Y1ZpwORyH7U+ne249ck3OCZO/uLwYNazgj+V1+h3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MmoMXDQp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1414062266b.2
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746009182; x=1746613982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nn4Lhwi6wj905Yh1K+BGwOU5DNtShR8+dwNym0HIX8=;
        b=MmoMXDQpSkwPOL1N3wM5PlpsTXW1hbo6pivRv85iro2MISs7YSPBZnNDrh8B5z/+dS
         ZEW5KB2ecmF6RlXa8qdhJup7dfwZT+OA7PhnEaieQ84nmcCux7bC88CF9m/ChaY/d+IY
         wNoHrsNgpdnStGgWXKKS9mRRWWR1aN6lEH8AMCpyUJJbChfkefqF8ESYkuKbkmh3qoKQ
         Ax3Ob8NTg+ELSoAxDd+cviyQcMup8UowetRfAMIfTbEjFAQKthUOwystrtGVNUYKnId8
         z2DVGvOnYK7Cq/y0fEGwUFZzJl2LzVfUefE8sq7QnMFCR10Upz0iWp14YRoodxND88A8
         crrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746009182; x=1746613982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nn4Lhwi6wj905Yh1K+BGwOU5DNtShR8+dwNym0HIX8=;
        b=hDODmwSC/9vNqKc3OeLQz9aMU3njRtuu1pfXI6ivYyrQGEMeQ0ZoeyhbRckpnp/AEZ
         5bF7YZb4pE3yzPcMTDPuXU0CYPndUdy3HrjhBC2WiqIUjmSnanSKBEZDiCLbdNr+rrPq
         sgFr+qNWbfwh5aspGmKt1nXSa3f6zumMThG5utEXEV1/Xjzw1AgHOQgtYnWgkfRjaM7N
         XpM4s+/D78oq48L0Ot0Ml+xifV3D6jwZRfmeNlUZO0h7D8P/CpXrgvgNm19+kA9lcam0
         27nAxLexCt8NwWpHOguW8Bll/SajWRkt3TMV9Cj+h0zcY7+QVL9fpo6XKgcr3POeq4jt
         5K6A==
X-Forwarded-Encrypted: i=1; AJvYcCVwsyme5tAVisUaMVy6kB9MtGZBXY0JoZwxRaJCTQ3v78/pOGcn8GNRfbZNBznKpOMWMRj5ya5vMI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsbHT1ysN0o2BDcn9l2ua/uXQxNRPRl7MhPB5vY6OiKYuVo8RN
	T0WSDYwdizeMV5ZorApz+q4sK57LTJ91SXjGYZWT79Op/THI+4ZDo1cvHSMFbwM=
X-Gm-Gg: ASbGncuc+wjuoY7USyIBTK0VaUSak6e1545YTctYtAPFDkptAtPXtIOQoMuoTRTIGR4
	jwRemhuDa8CRJ4VJC4w2oAbH1sWPrbDSTulzgP7leDBQ8HziDBQEOpUHf33PKJHivXpSHvuzBco
	s0+bvWLTuTojR1t8ruLkULGjtKwJwsUa0H370PiD62h2LD7nEaTrLARpiCUgecZRU3UTJGMBp+t
	PNaMi5vYMFPToE+KdahsUtM/OCdG/6poVvYBX7iT/Emk+7FFglAL6hUXE7ligOC2U0dm4SlKkaf
	IMJgn/nrFYXefebpXYAcNWEKX1mEKO0b/j/dLkfpbQjnBZr145CEId+XygkebyCQOdIFkks=
X-Google-Smtp-Source: AGHT+IH2N+37bdEAp6umDXJ/Tn+PS9iQBAS/tLfvtmUbmUfhbibyBqoqYkGkCT5w9FYdpi9e+fyJqg==
X-Received: by 2002:a17:906:c10d:b0:ace:6f8e:e857 with SMTP id a640c23a62f3a-acee1f240cfmr179989866b.0.1746009166269;
        Wed, 30 Apr 2025 03:32:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed6af86sm909390366b.133.2025.04.30.03.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 03:32:45 -0700 (PDT)
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
Subject: [PATCH 1/8] soc: renesas: r9a08g045-sysc: Add max reg offset
Date: Wed, 30 Apr 2025 13:32:29 +0300
Message-ID: <20250430103236.3511989-2-claudiu.beznea.uj@bp.renesas.com>
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

Add max register offset.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

This patch depends on https://lore.kernel.org/all/20250330214945.185725-2-john.madieu.xa@bp.renesas.com/


 drivers/soc/renesas/r9a08g045-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/renesas/r9a08g045-sysc.c b/drivers/soc/renesas/r9a08g045-sysc.c
index f4db1431e036..2eea95531290 100644
--- a/drivers/soc/renesas/r9a08g045-sysc.c
+++ b/drivers/soc/renesas/r9a08g045-sysc.c
@@ -20,4 +20,5 @@ static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initc
 
 const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
 	.soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
+	.max_register_offset = 0xe28,
 };
-- 
2.43.0


