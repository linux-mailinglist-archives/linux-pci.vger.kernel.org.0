Return-Path: <linux-pci+bounces-13512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D1985782
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 13:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2678C1F21622
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793484A2C;
	Wed, 25 Sep 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="egzyZVwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4A16F84F
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262091; cv=none; b=qQPFVX2PXWTPhLhpSuCmO33QxpW8kmThwZbpfgkYCVeDUrpU9nZXL94FXp0/ulJWIYVvDUXUXDDinqowMamlG2SEkqP9Syrg5yJR4OGwflIsmcSwzsEtDzUjqXxa4xw9uu8BIueWJbktLdb26ZdbDLx1Re4pwRESdU5CAL6RnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262091; c=relaxed/simple;
	bh=+3/SKikLppL1Xr/573aId+sPOU3wtbF6dELTbzD1gOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me/lWgBljkr4MgcrhCrtjt+heSHwIxrQDkDWaqhfuZYuPs7wZVCcNnQE2M9RLrgnOd+FOjmSLiGJnJcZ0QmK8N6g6oQyyJZsMxjd40t0aSC4XB9zElT4v5EUiRaf1GsuiD+ZSc7wsUftqLE9iyiOL0/Px4dYwsnPON4qYQkHsuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=egzyZVwq; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db54269325so4998529a12.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727262089; x=1727866889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2iSmOLo812yFnIR5Nq9UtGPT6s6P+lL9nzScHALAHw=;
        b=egzyZVwqOkwi/ivmnoBzfJifRF0T0lRi6juIqGxyrzxLintHifE5+nvGlVWXQVINDK
         bkNBeLyqYBbLQcxgMitmwSteOI5Hz6C6hurqEV5cJ/uzaVZdpgmaT3p8rQWIL5ga9zvo
         m6415LrXULxN28R3R6g1aNTCTISFuFelyZ1Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262089; x=1727866889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2iSmOLo812yFnIR5Nq9UtGPT6s6P+lL9nzScHALAHw=;
        b=elJ7qOfbK3UezfN1aPAp59sShBMS5JJsxaYPmwQZz+gQjrFzwXalQAzXvE0USJlJk9
         +aWsX7pe4by/bNklj9Yo1LDNsEkTImmTWogm0zHqt7haaN7kEd9FS9WRJHuXhd7RxsAw
         Dnxpt5nWzpZpN5Quys7XphEA0xe1tA5shE6XEpB6ibLpH0Zi0YakGqPXYXaPR8DnZSwK
         3WIlk/xcFo0DGXeNgAGzPYshZBjLPWbV1rcbEwqQogTOrCTa0cdqMJeMbCCUOWoHwuvZ
         LYsSdMgIqf8GrpUrJd3OW1gBp90lj5auowj1LkIGgoZMYgg7cGq5WSf1DNYu+kv9hi2r
         U5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1CZAPpxwb+HdE8Yeva8crNEGG0eHVBB+AAE0RlwguRt8GxdkH5Ydsg3zvNkxQKnMzSbRy4IjlKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91z9mCI7VQGaincgZEZb/zRudcrkrZxeCr8SFhneZl+sJkpF6
	NVvrKDBqQyUoFPYzZa/SOIzGN+rzTiO+rULAIy1yHibFzRDCO2oSXhWbUBZsaw==
X-Google-Smtp-Source: AGHT+IEDiU9yG0J24zu6lnu25+9BPDQ5H9Y9675km39iDIf0qssdZRYcfe9ubry0OUwppyeNUeL9pA==
X-Received: by 2002:a05:6a21:e8c:b0:1cf:1b7d:8481 with SMTP id adf61e73a8af0-1d4d4b9bb7amr2971899637.32.1727262088709;
        Wed, 25 Sep 2024 04:01:28 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:2b86:78b6:8ebc:e17a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73085sm2570298a12.59.2024.09.25.04.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:01:28 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: PCI: mediatek-gen3: Allow exact number of clocks only
Date: Wed, 25 Sep 2024 18:57:46 +0800
Message-ID: <20240925110044.3678055-3-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925110044.3678055-1-fshao@chromium.org>
References: <20240925110044.3678055-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In MediaTek PCIe gen3 bindings, "clocks" accepts a range of 1-6 clocks
across all SoCs. But in practice, each SoC requires a particular number
of clocks as defined in "clock-names", and the length of "clocks" and
"clock-names" can be inconsistent with current bindings.

For example:
- MT8188, MT8192 and MT8195 all require 6 clocks, while the bindings
  accept 4-6 clocks.
- MT7986 requires 4 clocks, while the bindings accept 4-6 clocks.

Update minItems and maxItems properties for individual SoCs as needed to
only accept the correct number of clocks.

Fixes: c6abd0eadec6 ("dt-bindings: PCI: mediatek-gen3: Add support for Airoha EN7581")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 898c1be2d6a4..f05aab2b1add 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -149,7 +149,7 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
+          minItems: 6
 
         clock-names:
           items:
@@ -178,7 +178,7 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
+          minItems: 6
 
         clock-names:
           items:
@@ -207,6 +207,7 @@ allOf:
       properties:
         clocks:
           minItems: 4
+          maxItems: 4
 
         clock-names:
           items:
-- 
2.46.0.792.g87dc391469-goog


