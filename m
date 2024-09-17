Return-Path: <linux-pci+bounces-13256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905AE97AD9E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5432F2842D2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E8815958E;
	Tue, 17 Sep 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GMUa/pPX"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45807146A69;
	Tue, 17 Sep 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564300; cv=none; b=UnnF+IqFiWgZRIvmNNhojrOqod7e0eVYgVlF40RbxmoK/vX4L/TQKEUq+mc368czPfpBqqrQYX2HGbIK+QhUWGdAdcZ6MkA6AtTbdZ429zOrB1swgZbjFF8Rs0wuRIbeMyYJRlwWF89q7QLdsp/X3qy9nP2Z9qewDVt58Hj1KZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564300; c=relaxed/simple;
	bh=58lPaXcY3g+9HNzDYS6D7c9jH1qiDF3Ci+34DHi5/VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDtpFFM0q0fMJ6+Nx4DAidsbDyEwoFBWy3HWb1Zz3Jamjwyq085hoVR/Kmx4Q6tpcNiSKYd7+kzQahGaxZyjIU9K6THCu7VVk6KAKl/0BLRMp2YK/vqQq8baTgteBlMFMOU/EMsDDTm9QDhyIaHhsnL1/YJ013NU2KYVhi2IG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GMUa/pPX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726564296;
	bh=58lPaXcY3g+9HNzDYS6D7c9jH1qiDF3Ci+34DHi5/VE=;
	h=From:To:Cc:Subject:Date:From;
	b=GMUa/pPXwwgAJ5nhu3kpb/IFFI7eIclKibLfPmOyBaUkSuH5jecsvH1+6CCqTx8GB
	 iC5X6nZpS0r8/usRgxtpNN7B115yGu5NWt9JpEozbqhtpUswtUbVWWdTjd0+qg/IfN
	 TyjqwfiXoWuvpJpHUbdOfOSjAIB4aAOAW5N1uH4qHR6T7SnD81eD/hBaoZuHdkBSUH
	 olg7EEpN/Ajn4nMaeNuS++G5NCrvy/HE1BhxrU7mGLTmyHhkH7iQl2Jo9lEkXPHYop
	 fbhbiScF91DvpAWZj1UFFxUrMektIN5xiYneD0QZ6TwOCK7CfPZBYsJdBxsZ/TLzHD
	 5adlB7soSivPQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9268E17E1080;
	Tue, 17 Sep 2024 11:11:35 +0200 (CEST)
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
	kernel@collabora.com
Subject: [PATCH v2 0/2] PCI: mediatek-gen3: Support limiting link speed and width
Date: Tue, 17 Sep 2024 11:11:30 +0200
Message-ID: <20240917091132.286582-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


