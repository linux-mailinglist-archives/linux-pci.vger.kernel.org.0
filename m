Return-Path: <linux-pci+bounces-13275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C8597B919
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 10:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E561C225D2
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 08:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F75192B93;
	Wed, 18 Sep 2024 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Vfl2Xgjq"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BBA172BD6;
	Wed, 18 Sep 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647194; cv=none; b=uGiSNDtGO9nj2CxY4EC6/ymrJqXBcntmJRk0QceLMqyT97QdI7hYstlYGyTxLA5scIMXEK05bbJZJtbRAiDZrjXI5IEiFUPZixLfrzXIlZV7SzkpB3q6bPD+D/ibOiL5DR+wTrOQ5yjtbFzVGcuyZN33b3cuz5fzBH0XR19KQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647194; c=relaxed/simple;
	bh=urRbQVTN6uGyFkVSFS3UAjiGPLlmo39F+4ctM836QqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNxHMuHbx+Zo7uAv8vFk5iye4A1pj5drnTGTHK9Y0Eiif3mfeFtsqJLB0S/c9ayylA8S5oeO7UCG+BlDy12+66v34hwWxpHSnPwqKXo1Q8rrcPngQ4bcJGltqSVNc1C6yA1hTzNaZqvwp7oGD2yYoj9jwCCAL0lHuKYuExB+VDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Vfl2Xgjq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726647191;
	bh=urRbQVTN6uGyFkVSFS3UAjiGPLlmo39F+4ctM836QqI=;
	h=From:To:Cc:Subject:Date:From;
	b=Vfl2XgjqdNY53zrFS3PsAnHQlo0rdiw3Zj331BMvPvn4RcQ90NVIhcdyni6PL8jRX
	 vrH0T7qt6+EJbL6bK5Wk/Mz5xr5IYiD7+p0SrrUcwnEIjzw44Ke3bUEnuDI/B1+kOV
	 19cFMot5RIPvW2Nv1tBTBgWoBOgnmy+P6ivbNV/99A8qt5RKfWFdMf34qAX895fB6a
	 /lsmeAUrxIeO629MiTMzxXp6n7btc8aUEMTL2y9JAVaixNhvyiODrgBIc28iDquqaJ
	 bG7FfbKZ+pM3aLQelfq8ja9y2rFWVVg9/pnoMgdzKXaDYCDUjEdLlf8YxzLaiobz34
	 9W+hQ143gH5vA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F2C117E0FE0;
	Wed, 18 Sep 2024 10:13:10 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	fshao@chromium.org
Subject: [PATCH v3 0/2] PCI: mediatek-gen3: Support limiting link speed and width
Date: Wed, 18 Sep 2024 10:13:05 +0200
Message-ID: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
 - Addressed comments from Fei Shao's review on v2

Changes in v2:
 - Rebased on next-20240917

This series adds support for limiting the PCI-Express link speed
(or PCIe gen restriction) and link width (number of lanes) in the
pcie-mediatek-gen3 driver.

The maximum supported pcie gen is read from the controller itself,
so defining a max gen through platform data for each SoC is avoided.

Both are done by adding support for the standard devicetree properties
`max-link-speed` and `num-lanes`.

Please note that changing the bindings is not required, as those do
already allow specifying those properties for this controller.

AngeloGioacchino Del Regno (2):
  PCI: mediatek-gen3: Add support for setting max-link-speed limit
  PCI: mediatek-gen3: Add support for restricting link width

 drivers/pci/controller/pcie-mediatek-gen3.c | 75 ++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

-- 
2.46.0


