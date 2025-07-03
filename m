Return-Path: <linux-pci+bounces-31385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4730AAF734D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 14:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0D018914CC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97B2E542A;
	Thu,  3 Jul 2025 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nC0IqfHU"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258722E4278;
	Thu,  3 Jul 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544534; cv=none; b=hqmirUsH2+djCeHM0yNEq7cFgP3rOku3Rx4zylMG0iTLZYIeuBjlSpjzqz8K2daN9phQ1gLtEVUjiRMbeAPkejRNgbIH5dSQtL2yF/Ab5vwRRqWnJYdZx23Am/mJ6nQCg98+QYCWsuC733g+cHjCfUzt+1T1Ai0i6eEQNSjlLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544534; c=relaxed/simple;
	bh=kaTHkQ9BvDf7ruSvyJH0uvXewC0X/FMNr21hBYYZKWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIVijLXIT/AljCQlB72eJOF6JTtlBa3S2VMZKVXF720pavETwDPEVpwGgz+hNTaIqQFhBDewkgdxFvoYPcq/t+lC+mDXTjvGKqlHmWUkqs7YPuGVTH0NefwwXbYTqsKe00v2qJWpUKwidOZWy352cHwHpaMkNhHVOFvYz3A89MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nC0IqfHU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751544531;
	bh=kaTHkQ9BvDf7ruSvyJH0uvXewC0X/FMNr21hBYYZKWk=;
	h=From:To:Cc:Subject:Date:From;
	b=nC0IqfHUyWu8VgCSceBYs/tyGuoWlBwhCNE3BPpAidWAf3zeQaKYCqhW+oMTJwgtr
	 CMkSN6SSMXhFSvJgoGvLkLxGND1+r8HKFsm/FeQ55eFm0VzRVfUDK0yVMh19sJKFiH
	 0cIh+iuJlpcVowJx5ElRj82pXogcEAqNvjWHhlFqsXc4F2ksYLVggOvXTn/vhUWtVq
	 0CmWObY6yPTHMAPJGP47AMvrqp2dsZz0irrnsMFKhuiCDdgH249pz7pic5Mp9sR9Fi
	 on8rIcteRcsUxhZ9lVgiPwZjxebtTQmvjWKbl84QKKY7QGAU4dINBbhuu2PXgvRroT
	 156/LgUvGHRxw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8001217E0939;
	Thu,  3 Jul 2025 14:08:50 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jianjun.wang@mediatek.com
Cc: ryder.lee@mediatek.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 0/3] mediatek-gen3: Add support for MT8196/MT6991
Date: Thu,  3 Jul 2025 14:08:44 +0200
Message-ID: <20250703120847.121826-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - bindings: Removed useless minItems in reset
 - bindings: Defined reset-names items

This series adds (at least partial) support for the MediaTek MT8196
Chromebook SoC and for the MT6991 Dimensity 9400 Smartphone SoC's
PCI-Express controller.

Some strange PEXTP settings were omitted, as the intention is to find
a way to set those bits *outside* of the PCI-Express driver itself as
the downstream implementation is using ugly syscons to make the PCIe
controller driver to change bits inside of a clock controller.

In the meanwhile, this is a set of clean changes that are required for
the controller inside those SoCs in *any* case; further development
will occur, with high hopes to find a solution outside of this driver.

AngeloGioacchino Del Regno (3):
  PCI: mediatek-gen3: Implement sys clock ready time setting
  dt-bindings: PCI: mediatek-gen3: Add support for MT6991/MT8196
  PCI: mediatek-gen3: Add support for MediaTek MT8196 SoC

 .../bindings/pci/mediatek-pcie-gen3.yaml      | 35 +++++++++++++++++++
 drivers/pci/controller/pcie-mediatek-gen3.c   | 24 +++++++++++++
 2 files changed, 59 insertions(+)

-- 
2.49.0


