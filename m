Return-Path: <linux-pci+bounces-13681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B4A98BB17
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 13:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F7B1C23517
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0E61C1755;
	Tue,  1 Oct 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="haHPx4e4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046C1C172C
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782278; cv=none; b=ewAmZVloT9yheKwAmCkBA8P5tY5d3dSQdUapz2Qo+Nx9XRnAPDmFxepEkb4TOxelb6s1YljqKMb/KE5opDv+TgPyZzKADmZbEcGodWkJ+naOu0C70bXz6UUL5DgG+P99F8oVMTGs4msnJJUR9vnrwNJiSiFGcyQ3vU1YkKZdbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782278; c=relaxed/simple;
	bh=xNq7dd0QQAzKdyjPQjXshn7HgVAnKT5ZeUNDrPDm3cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzOls/lc/BOCzatYXnMDHoL9Xaz6NUULK5DZvmEFAV0mI1QJAaowBgY+gC2JXV4tIjALaEl9yDTTvvUbQRs5In2sb8vWvdxQTzFmmnf/dIdwAwGKeqz2KNj0JlUNSIhV0eoyASFAdWGUNSmjFcJha4ho/zXO4pLO++0ihkMj2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=haHPx4e4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718816be6cbso4592354b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 04:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727782276; x=1728387076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkw5ZjTULYmnDhqzTqOvsBoCEBWuQcvkFtFk7rwLDX0=;
        b=haHPx4e4tas7WGpON8puSDU2FPzsO3z3it630Ua8bijGgwqhy/pADeyjvipMyU45LG
         eNswpYijDBDST0fQ0P5HsH3UW9xhcotGUHgt74OLkguH9neX7dQgRnUVcjJqntLfDnBH
         bSv63yKLr/fOuKzql9vAEzjg8CkZL7e8Mxc30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782276; x=1728387076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dkw5ZjTULYmnDhqzTqOvsBoCEBWuQcvkFtFk7rwLDX0=;
        b=nqc2tsUDEAd3uvNMrU/mBh8rEVTyT9zTpaKqxzbBehwoyJnGMqqsUfFFWHW+vVVIhn
         gWBPz/N4C2VKkznEmVxFoGV9zSdbewBpOCiIm2BHJPoEXxwQZRIUB012l+euO8pVIUAJ
         75803ma/hK87V5xxzUzNcEvhYnk8pyuwrgwFRBJpoXF2IuOmXiPcsvWKrWhP8THbcd1+
         +1NI7riFw0YtqzU9hWDv6j7db0qU6W3HEEtcXBYkvOgenEPj8f5959Bqhm63jDXEr2F/
         9mWaqZSvu2glt6PaKweUmCZzWvvWnpez9wNs9DYzbtp9bKU/vX1YP/zgUjxF1fc4sy58
         DDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5l7AkWxNzwhX1p8LZ288hfPBR0Ps9JFdv3Qi1y7hsEEt+MvZEY9ACbCu3cfCX+p8aXGR5W8UDy40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwooAvKZCG0Le2ZMZI1wNAiUCD7tANekCmmOZKWDxzCSdRfp/NY
	h2FXwSyQE0gSccnaQmW4sbWqqa2oa8Q/eAgQidQQiNGPRzJeu7l6ffTOXgrPKg==
X-Google-Smtp-Source: AGHT+IEFyHAzeCxiNj5YqUp1sXh7ztXqQKl/I/N9BtpUPW8sRSj4zlFPq+dVnC9EwBiPLWiMyOrcxA==
X-Received: by 2002:a05:6a21:3305:b0:1cf:2513:8a01 with SMTP id adf61e73a8af0-1d4fa6cfb88mr19356853637.26.1727782276389;
        Tue, 01 Oct 2024 04:31:16 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e044:f156:126b:d5c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b63d9sm7810646b3a.52.2024.10.01.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:31:15 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Bin Liu <bin.liu@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabien Parent <fparent@baylibre.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	MandyJH Liu <mandyjh.liu@mediatek.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Xia Jiang <xia.jiang@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 0/8] MT8188 DT and binding fixes
Date: Tue,  1 Oct 2024 19:27:18 +0800
Message-ID: <20241001113052.3124869-1-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is split from a previous series[*] to focus on few fixes and
improvements around MediaTek MT8188 device tree and associated bindings,
and addressed comments and carried tags from the previous series.

[*]: https://lore.kernel.org/all/20240909111535.528624-1-fshao@chromium.org/
[v1]: https://lore.kernel.org/all/20240925110044.3678055-1-fshao@chromium.org/

Regards,
Fei

Changes in v2:
- new patch to MediaTek jpeg and vcodec bindings
- new patch to move MT8188 SPI NOR cell properties
- revise commit message of vdec power domain changes

Fei Shao (8):
  dt-bindings: power: mediatek: Add another nested power-domain layer
  dt-bindings: PCI: mediatek-gen3: Allow exact number of clocks only
  dt-bindings: media: mediatek,jpeg: Relax IOMMU max item count
  dt-bindings: media: mediatek,vcodec: Revise description
  arm64: dts: mediatek: mt8188: Add missing dma-ranges to soc node
  arm64: dts: mediatek: mt8188: Update vppsys node names to syscon
  arm64: dts: mediatek: mt8188: Move vdec1 power domain under vdec0
  arm64: dts: mediatek: mt8188: Move SPI NOR *-cells properties

 .../media/mediatek,vcodec-subdev-decoder.yaml | 100 +++++++++++-------
 .../bindings/media/mediatek-jpeg-decoder.yaml |   3 +-
 .../bindings/media/mediatek-jpeg-encoder.yaml |   2 +-
 .../bindings/pci/mediatek-pcie-gen3.yaml      |   5 +-
 .../power/mediatek,power-controller.yaml      |   4 +
 arch/arm64/boot/dts/mediatek/mt8188-evb.dts   |   2 -
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      |  33 +++---
 7 files changed, 88 insertions(+), 61 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


