Return-Path: <linux-pci+bounces-36808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0968B97741
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 22:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEE519C7975
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 20:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F378C30AAAF;
	Tue, 23 Sep 2025 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzkQmfUk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A0309F19
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658374; cv=none; b=a8GM7/Rtd5zdW6gIgy+A7qPLDxxdVPUWUnlfIchgcJnke7ssZxIRFtiD88+E+iu74V2f9kCLUA4tD0/91FbbP291lXS5q5YuTY9vqa1IB/kEoN/4yeemm4WU2hHINdsZ4/vPa4z26R+wzAm2hN89k6EiOthORFxBhSdynCeXT/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658374; c=relaxed/simple;
	bh=jVddi4NuKKwdCHNaUyrNV2CwAkuZZSN+ouVB+z9jMuI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dN67xms4uclkxb6pIQsvgE5FHjFMbu/z2I7AicEpBR1TYkxMjh5ofxDIBozfO/FxRuVxMZZBojdAjUT22gylBQSFQ/8pOOzq4mbHocrWncyTujPjQ7mYphoLABuu+Qx1aKwRNNoCaGXxYXN6T+X2ovGEhRPApjJOkFvGd0Jad4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzkQmfUk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e2562e8cbso5394495e9.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758658372; x=1759263172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ASptksIfZB8nhWx3+GWc5qI39yAJwjp71gTOqcHHO80=;
        b=WzkQmfUkRVtH3rrdaQqgfMbfNiaMJpPVRDuk2mSe0OEpn9pCaNkG2UhxI623wbdYly
         fE2I42oQZfO7tEBiNen+EI9Uyxe+M9YNIbT19ROjxvAvRghiy6Aov3EQSct8kau/4cFk
         LCEDXdQ483p4O69B2AMObQ3sCtW/4qo1N6S8abUBJlaZ1vzEZTrAtYzHx8M5Fq+OOAb6
         fjJIu0mCXwiAhzn7KQh8FO500NZWv92HCdha2BZk3kd2+mDOouGaZQyT5ghvSBEXKBJF
         dUv1QD1ZFOuQxpD2EGo//SmArHie0M4DArpKVzQafmPVWxTmwjp9bAFAayDagq6wIC5U
         8owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658372; x=1759263172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASptksIfZB8nhWx3+GWc5qI39yAJwjp71gTOqcHHO80=;
        b=XPA/FaCUzm/iIMedzsbtVyhrTE5+6O5EChmt74LvTVKCHFpYsjhMK0vzWBdoQ1UYsR
         E9PZUGOhFGr42SGEFVM/oOQjJ/JchwGgH66NWPp7sLCq1oFShYr2rVZi1A4nWtynjXUU
         FOUTVE8EqCl2T3606Ozh0xo+eLlawiY7nS2o5yBSg+KnT41FNwiFHKvDlhtH5DDx1Cck
         AqQR+aYswwzaVDTVM0U/EKHYXylq1Iwrz5pa7u0Q23ogeoYbzBsUQqUAj4ru4BCP9a4O
         6d1U4qGwWIbGJCLchYGNKhHN9hsg8Hr4QQLOxkPvf/XEu5MUV0bAyJElNmmD9W7/g/gH
         ex2w==
X-Forwarded-Encrypted: i=1; AJvYcCXfEqG7c2tajI0IpDq5E+8MJPkuuX1Hr5Pfcdx7XtA8OWLjZEXn3uGR1wrJfMuNgm/tJ+1aNhIrRJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqOg02W45YzpYu6R/0/5NGQhtN8GuDKb1pHH0n1aXQNG8Hbqy
	a4Gt8MHlP+PEkvDh/vcguemyHV4iqwEC2J+qBjduIZiSpMLqeSgUyY5m
X-Gm-Gg: ASbGncu7ItSSai0B2V9RB8vX7TowPRl/pY1zquAxTXjGofJ3ufYhW9rCHkMMzmnWFfx
	qS8+F3L9Kd/VHSNclPstRcDSjtKWntlwgy7Ck1Hux/5tfd/UQm8wFoSmm/H0c2f6iz5CHAwMxOi
	hFv/o0GdCtuShglZYuwVmpO4G57CenVc8auPsh+aX7uFhCHY1RZm99L+LMh7lxqg2L8SVe60era
	EufjmZdBOjsGmUQwCjJI76nc3ktD4orwYQSZ+XO3ArBd7eLPxIrEegzFE88mQPDlywNGlYKH/as
	Cd1TBAhFnv8ENBAdvrK40Lqp+BuG01w5fUY1m5plMiR5DT+foX0DDkI/pYFLGnvjztgqBPdZJtZ
	D1k0rYy7vvrc1x1J+kZsUCtFBsF91kP/rTOeG9bVFmE/G2l4gk1/aUdsO3DELMPKhWdIq9Uk=
X-Google-Smtp-Source: AGHT+IF016uYkkKzgv+AucFeGyavBjbQS4X5yFh1cvwLL0BVsVqxRwdjObESQ21BrceSWNy2CAZxPg==
X-Received: by 2002:a05:6000:21c8:b0:3fd:bf1d:15ac with SMTP id ffacd0b85a97d-405c6d11630mr2007870f8f.20.1758658371435;
        Tue, 23 Sep 2025 13:12:51 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee141e9cf7sm24889690f8f.12.2025.09.23.13.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:12:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 0/4] PCI: mediatek: add support AN7583 + YAML rework
Date: Tue, 23 Sep 2025 22:12:28 +0200
Message-ID: <20250923201244.952-1-ansuelsmth@gmail.com>
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

Changes v2:
- Add cover letter
- Describe skip_pcie_rstb variable
- Fix hifsys schema (missing syscon)
- Address comments on the YAML schema for PCIe GEN2
- Keep alphabetical order for AN7583

Christian Marangi (4):
  dt-bindings: clock: mediatek: Fix wrong compatible list for hifsys
    YAML
  dt-bindings: PCI: mediatek: Convert to YAML schema
  dt-bindings: PCI: mediatek: Add support for Airoha AN7583
  PCI: mediatek: add support for Airoha AN7583 SoC

 .../clock/mediatek,mt2701-hifsys.yaml         |   8 +-
 .../bindings/pci/mediatek-pcie-mt7623.yaml    | 173 ++++++
 .../devicetree/bindings/pci/mediatek-pcie.txt | 289 ----------
 .../bindings/pci/mediatek-pcie.yaml           | 514 ++++++++++++++++++
 drivers/pci/controller/pcie-mediatek.c        |  85 ++-
 5 files changed, 755 insertions(+), 314 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-mt7623.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml

-- 
2.51.0


