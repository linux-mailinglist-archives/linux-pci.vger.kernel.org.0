Return-Path: <linux-pci+bounces-37191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79BBA90F0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 13:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BAB3C7935
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 11:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CDE30146A;
	Mon, 29 Sep 2025 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfdPqr0q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C02FC00E
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145898; cv=none; b=mMDYfcDfB4njxeEUNahzWYZxatho50An74UB0URbIWQ52tNIZ3ncnzMx2UL61xryZo413uMOtbPkKWg7PlGhj8Dty2IGtdogfwqiWe011AKbWOce0YjoUQPCsu6733NGYR23Zg6urwNX+wBOlT7HOW/mu6MRiSm6ehTM1P9/Il8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145898; c=relaxed/simple;
	bh=4y2av6tyjlgTbUkNyHSSuQdzatlOOOBYpolj3NH1Wy4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QJYoIopcZxtdIpfAiaIDzl3eyI/D84J8HnaGco3/X/gToXj9IRZhmqyRvB96mVIt4KuMfRXUoTJ3mJespDK/AtEgAZD9YcU68bVMiwa5oSaVczd4dG2eZUqcPVeFWYy2yge+0YIMn0KKata0P6N0Iyc73EbbOO5Honr/YxoCFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfdPqr0q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso29233775e9.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759145894; x=1759750694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRFGCABCLXwEyWrlsO0Qq+AzjRnRQjbLGashvrpUfXo=;
        b=YfdPqr0qs3D9rKucmAqN29w/CMVC1vWcIdLoSIEnziiBCmhG8N09CfUaJ4nEjd2o71
         1bKWK7ol0qPDGEE009pIf6s3ES54P/f+VhzYVnKgUKN9DkTEjeMZZn3xLdovyjpYBmGB
         P8F2kUdlAGgJ0rIieLqCq3qDp+xnHkhxWl/AnyhrnrEUbzIvK/2x8ozB5jtsb9Y2aoyR
         x2VqWMIF9U9i37vrOgeRgeQbwBfuvc4vpZRGeu0cNDv0HuByS841fLK6SH2yLF4p7sPB
         nSpGA6WuopVO0rApD+0r3teP9HEt5mCG9fnkfFc9oR5QdGm21zxLXo1nEjDmDrDMu4mQ
         CGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145894; x=1759750694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRFGCABCLXwEyWrlsO0Qq+AzjRnRQjbLGashvrpUfXo=;
        b=RN/agS9aCoLWiDKPn4cYxCTAEAhiYiwVtV5ff1GavoTz6ply7gi8ZHOTQp3/pzVblL
         ZqyU4Lb81k9zq+m9m9HHoNq7t20pA+aPox1sitDX6okafrzhI1rhO3Hz/aWa0A/Pg1X9
         lYedhD1SP7CkSRr1N48GfApydvPeYahGYFT2KjbGiA7z8cLNCR1uiOgIc2JMAIyA/m6Y
         xU3+zYYW3sr4XaLOssFfM0PMG6jHB/DRtdQa2fBK+0+uZwwDjGx09YB7Y6RMr4SjkmDW
         1hiLiLv5LHViLNyO9lz/UcNO+DNMaqSzw7OVL8ql+4Mjex+hMnieSwUY0I60tBFT6ggw
         KXBA==
X-Forwarded-Encrypted: i=1; AJvYcCX992CuLuxmvJ6Pctay809Q0iJ8o0Iioog2W4hnXfm6a2T8hmlmejGiKaqhMML34/mlC2Ka0eUpJ/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5VRBGd5It4VIaPVTu/6X+iFYgY1bd7jtFpl7loCsj0taZlGt+
	krWoVMfIVrBiDxGi7RxtE12wmq0WSwFoNfUpwpUdQXLBtUY33mrHPW9e
X-Gm-Gg: ASbGncuTVzfk+5G2z6tO4n2esyINJhw8q0a+J7QT/21ewXTaVIZn+v9+jTb5OiAHuUH
	2L4bvjiIPVqUHWThErAa5bJmW4GYtiNERbbsrrjQoBJ34MVIZmbstPdlkbBwYiK4z0P0Av2kSqQ
	huj9UjIg65lU7+NSx/CT0STVsBo75dqbpk085CLD+2q3nJFmPYbfiR/fgZPlzxxnQsu59r5qdJX
	tvpbVCmANHvbXK0t6orM803tTX5tc7Xctq3BtXdtBcRqDNvTt2ir950OX2kCUkdw/6UhQwMuR49
	Fhx6Yx0vXpdLLVnU8N1v8UrOEVlvl6s15tGE1Z6I9nLaTUTamB0stqqzYMI0HQZe4ya9vSCthe0
	S4yWEsb8xKu3JqPfFsNQH+yfqryYYmwmTryyqeuQ2LbDg2SqrjKkJL0ma0bpYfEFSDJKU7jquj7
	aYSgWBb1qdtprSLxk0
X-Google-Smtp-Source: AGHT+IGWicOdrTmQIVdHUSxqrzMHPdo3nASeyojQE1e0iNlPBEVxWIA083+LVJHlm20d4gbGv51hSg==
X-Received: by 2002:a05:600c:8289:b0:46e:4a2b:d351 with SMTP id 5b1f17b1804b1-46e4a2bd52amr57340655e9.28.1759145894386;
        Mon, 29 Sep 2025 04:38:14 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e56f53596sm9502465e9.7.2025.09.29.04.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:38:13 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/5] PCI: mediatek: add support AN7583 + YAML rework
Date: Mon, 29 Sep 2025 13:37:59 +0200
Message-ID: <20250929113806.2484-1-ansuelsmth@gmail.com>
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

Changes v4:
- Additional fix/improvement for YAML conversion
- Add review tag
- Fix wording on hifsys patch
- Rework PCI driver to flags and improve PBus logic
Changes v3:
- Rework patch 1 to drop syscon compatible
Changes v2:
- Add cover letter
- Describe skip_pcie_rstb variable
- Fix hifsys schema (missing syscon)
- Address comments on the YAML schema for PCIe GEN2
- Keep alphabetical order for AN7583

Christian Marangi (5):
  ARM: dts: mediatek: drop wrong syscon hifsys compatible for
    MT2701/7623
  dt-bindings: PCI: mediatek: Convert to YAML schema
  dt-bindings: PCI: mediatek: Add support for Airoha AN7583
  PCI: mediatek: convert bool to single flags entry and bitmap
  PCI: mediatek: add support for Airoha AN7583 SoC

 .../bindings/pci/mediatek-pcie-mt7623.yaml    | 164 +++++++
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ------------
 .../bindings/pci/mediatek-pcie.yaml           | 428 ++++++++++++++++++
 arch/arm/boot/dts/mediatek/mt2701.dtsi        |   2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi        |   3 +-
 drivers/pci/controller/pcie-mediatek.c        | 120 +++--
 6 files changed, 680 insertions(+), 326 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml

-- 
2.51.0


