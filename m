Return-Path: <linux-pci+bounces-36996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC7EBA093D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6014E60D1
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B85B3054D8;
	Thu, 25 Sep 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRgbaoiE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BE21E091
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817428; cv=none; b=CXa9rbjprCLR1AHeM7s4Gikwe2JOnt8I9r09eFRc7c020rskMHs6jAsN26k2OrlefBApdHY6FLq+RgTBE2ghUOFmCqio2Q5r8xqiQu1AFXcvwAc8vMLmNK4zhum88Gr5QuX/MGt/buNNG4J2nAd4Us2BDJk/NSOBOyCI+BWJc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817428; c=relaxed/simple;
	bh=gOo1rVsZR6VdqU5z395vlT+SO32oa08uQ/tUj6wgFd4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TDi1O7/DWy7ExtzZF2075kPs7VYdJ+YyMHn0Eq+s3uaJvA5+NkMYU6LYSGrgznsoiY1/QqMMoilVWqchGxGLKT/KGD3U/OIS+m8M4HfA7SFoROCsWDNGLni+KEP16Tr1SHQS95Uy05UJgap+2NLsyEIFZlmSNKOiWd9quZM3Kps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRgbaoiE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee130237a8so914367f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817425; x=1759422225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTyvmotOb0/PgMOHsXh4gvDuOiENNfX5B0XL/LoNWUk=;
        b=QRgbaoiEXx7xp7ZNWhKTDtac8hbujoKZUQ2SfmHyvK19p/gId2x095Eyjh9baRHkWR
         44Xli413yV5yhmVER/RqnMGDb4RQ8EwxqUGrVq1sIWQ0WMFYAVDonhrCKenFS97Wq5k8
         lwH2Ss46HmdcdxmTooGgvJVZYMH8XO2nFmFRr8V6DozhaD2po4XhWGPvFGpK0gFYaHNN
         BrMhdXO88rRbnbEXOfKLzB5snUpUER38cQr4Q0zeyA81+uAsCBr35wIL0MUAoBserXlA
         c/TutBxD3gNAMvj1Uq7FeZEwc6eJ2N1i51DNY5nIcy7POL2uxAhOekqGf11V6yBeaSPv
         g3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817425; x=1759422225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTyvmotOb0/PgMOHsXh4gvDuOiENNfX5B0XL/LoNWUk=;
        b=LkWbbe5jlCSpNZT7xTZ46wj1JndXyyhMzlbM6g6CD9RxNYPx7kj1ZFCtaCobbKB+i1
         zKN/xsXbD+ThYHa8zUE8GBtrrU07JZQTHCt0ZhcSR43gvS/sKEhe6dxyLyjyPv5gSWU5
         UXRGNwSdCEjW8QLH8Hfg67FBvCx3OqB/zb1MN7fL++t9ZO+IrgezRKI+LmcpiHJmxrqu
         0MNsJjn/IH53xNJJPMiOnc6GAafV82yTmisBS7ynufuyTfPfwO+/9R2Wm+JLkU8eZHxG
         63gEd3IZatAMQZrk5kkdnzkhL5o8LY/1yubwhXsu544AeNKmQ10FSmJdDMOIWithVURe
         arDA==
X-Forwarded-Encrypted: i=1; AJvYcCULwF62DJKazze8KJNLrJARvopjcIMAwZeKX+90xPlRU5n/tXR2zEaDYzxc19cEOZGL6s2VTIXz/TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbxW/2zrod51+vz+ngSR6tQWmGo9+lBTHWkptLh+e/nVRqpYvD
	RpHczbyiQ7gAWWQ+othlRMoIrYszJ9brtOL4GP6uuznyhmFsJnUAej/q
X-Gm-Gg: ASbGnctl1LfuzPsYwacwWf+/0QrWi5cuahoFngVtspzy+Pzis7Nc+eQn/H8fA+7DRv6
	GOHajuEAgnmHiS+qHhvMSMI7nSp++URzpXoNoC+dngrnIkX/vMmhfSnw1SDxkrdlDIW/RLwBe3B
	34RjxXqq/A76lCX3Wpg58Pj8LPPqtnImeMJ9Y5tjBxXoWkg6u4XfvwK4h+KZsMdA5hHUriU48Bd
	QgqNSUVb4L4Uy7VmZCgnom3aVbfcTUtt0wxUqh9z6gUa3B+CHsT5Cvijn963s1FISku/hg1DS3D
	92qJu9LqiishvpFOuPqh4kIwshdevJRb6Mf2M849xr/DTELoW0NZ8R21+knmfp8p9J+Q2hp/gVW
	b7VCudMksMLTP7lCCLy/qG2Qh6fVEZ0lqzc+nuONFeD8Rs+xQVNk8f1m34dx9VZUkjTl9eAE=
X-Google-Smtp-Source: AGHT+IG8wt7D2RVybhrtsXF08OvAI7r2C+qCPryu+R0Ya0aCRRAJKGzbWS2JdRSo8S3uobYjXYxcdw==
X-Received: by 2002:a05:6000:655:b0:40f:288e:996f with SMTP id ffacd0b85a97d-40f288e9f05mr2728379f8f.63.1758817425041;
        Thu, 25 Sep 2025 09:23:45 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fb985e080sm3534819f8f.24.2025.09.25.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:23:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v3 0/4] PCI: mediatek: add support AN7583 + YAML rework
Date: Thu, 25 Sep 2025 18:23:14 +0200
Message-ID: <20250925162332.9794-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This little series convert the PCIe GEN2 Documentation to YAML schema
and adds support for Airoha AN7583 GEN2 PCIe Controller.

Changes v3:
- Rework patch 1 to drop syscon compatible
Changes v2:
- Add cover letter
- Describe skip_pcie_rstb variable
- Fix hifsys schema (missing syscon)
- Address comments on the YAML schema for PCIe GEN2
- Keep alphabetical order for AN7583

Christian Marangi (4):
  ARM: dts: mediatek: drop wrong syscon hifsys compatible for
    MT2701/7623
  dt-bindings: PCI: mediatek: Convert to YAML schema
  dt-bindings: PCI: mediatek: Add support for Airoha AN7583
  PCI: mediatek: add support for Airoha AN7583 SoC

 .../bindings/pci/mediatek-pcie-mt7623.yaml    | 173 ++++++
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ----------
 .../bindings/pci/mediatek-pcie.yaml           | 514 ++++++++++++++++++
 arch/arm/boot/dts/mediatek/mt2701.dtsi        |   2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi        |   3 +-
 drivers/pci/controller/pcie-mediatek.c        |  85 ++-
 6 files changed, 752 insertions(+), 314 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml

-- 
2.51.0


