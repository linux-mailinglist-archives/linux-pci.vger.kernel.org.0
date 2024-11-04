Return-Path: <linux-pci+bounces-15942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E189BB3DB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 12:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6750284426
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A544B1B4F2A;
	Mon,  4 Nov 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yu8sAZ/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC718A6B5;
	Mon,  4 Nov 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721014; cv=none; b=r/XB/02BxZvDDO88kYvnnjALDGRcYKXusolDKrtTsabNQ1bcSlI/OnaACZO+Y+ASR/gakkUG3Ybrqnw/CJdA7bZSlzOBhRlSp8RNccTsG3wAKMdzUiItbLb7fzGrrkYLI7CNu53xIG04S7H6x74N4HREQQPaW8p2vEG1kk4uZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721014; c=relaxed/simple;
	bh=NVLDLCUn6vtNrbakwRfGhEiyOqXaZBqsTk7KGrsU+G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgHJB9zZh+4jGFoodiMHxV8rtpi5zT68nQ+hyyv7cVY38TN0TltrM+UtxzTKzqI0DCyBPlI/tFcbnXsW5EIPO4hjRBe6pfEnwEO8JAXslXjlqUlwtTVeuNpXOL2Mgbdh2HJveUZKvGYLPootciNBmyBeFhmms3WZE26ZWIbPNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yu8sAZ/Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730721011;
	bh=NVLDLCUn6vtNrbakwRfGhEiyOqXaZBqsTk7KGrsU+G4=;
	h=From:To:Cc:Subject:Date:From;
	b=Yu8sAZ/YAdECQFEgrNFIRo8ZUsoPMuFnf+BY9tor4FYPgwdsS1gZYuqKhi9Bcqhnb
	 i0bbHP2jinI1ahF9FSi9weQGZ9Zb6jw+R0/ISAGyHR7ve2vLH6WGEZglqhxbP/Jng3
	 IP3dO+bXxt+br6rq4MpXbQ+FeUdGqL26nGK81TA6BnpnpLjcme4QZeyv27T35O9lG6
	 l/Ap/5rD0OhFc49rHyofKU6W5J22AtkI7yTkDdphqhH7r7627ixvJYAYTEDMih/7NS
	 hqZ/qckbUnQfNn1JfHAuCxgCZEegyG6H4EUe2AiACsmyCQlm3uytkHK1ueg1pNeu6f
	 oPNB/Uk2keI3Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7AD2C17E360A;
	Mon,  4 Nov 2024 12:50:10 +0100 (CET)
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
Subject: [PATCH v4 0/2] PCI: mediatek-gen3: Support limiting link speed and width
Date: Mon,  4 Nov 2024 12:49:33 +0100
Message-ID: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
 - Addressed comments from Jianjun Wang's review on v3

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
2.46.1


