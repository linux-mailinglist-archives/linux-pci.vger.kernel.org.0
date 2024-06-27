Return-Path: <linux-pci+bounces-9351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030F691A12F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 10:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0914285507
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8186EB56;
	Thu, 27 Jun 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuzT0Kor"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22CF4D8C8;
	Thu, 27 Jun 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475976; cv=none; b=HhRnY+9HamZ4f+9hLdI0JKszfgnmRxPbO1aOvJFNE4BH5Pt9+TunfvIWqJODhg6FdFoiUz9CKuyyKXGw0jwEyLy3UE7mN8c0yvyt+TJ5yOJTJJP8Fj0cH7xjBfSgH1vjujQ9jLWTffWwNjQcDM/eJpb4nZDh9ODlt2Ygxhobb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475976; c=relaxed/simple;
	bh=amUTYbcz2Egm/QZ6bc3w45w4qx9G/lTJ+yraUnLwzCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZnEksUONMSnLnqyxNclCHyD5hZ61oba5eG85bIw55UWpCvs0dlJOnYmxOGONAMMFX76xLBKPD8U3bzmRMpUFY7OStp34K5N1EM7EYjVIWy+8HJArhRWll5bzPJ/CMiIJZKWvj5dmuCykZi9d9BaU9CEbkNzeFKEQZ+/NBjOFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuzT0Kor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BDDC2BBFC;
	Thu, 27 Jun 2024 08:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719475976;
	bh=amUTYbcz2Egm/QZ6bc3w45w4qx9G/lTJ+yraUnLwzCA=;
	h=From:To:Cc:Subject:Date:From;
	b=XuzT0KorWcHa0DrTvhfubLEJ7/cSfgzFRxsHSk3Iu4zDuijlZ5iExFu0k0fmFbN6Q
	 CBlZquTI16hu0vh8w9Yowvx1YmCCPMD8W2q2LBMPaLCaJOANPhbg3RhYh/+/C5/slP
	 wWUrFo0uXnFXfqzoJm9T+Q573l+ldWdXeHRJDbybJIA2pz38/B4xcOxDsKQpX8woH+
	 uQRcbq15Ey71a9sxXg7pMw+VSdNyyyHUzqAxMP6fnoV7L/HDhMXumpYHRO9ULUJ6Gf
	 qE2po5Qb7QlRADYyZSwUurmHwDJ46NnTOtSEN7Q1zRNR1XABpEZmj3jmb07P9qh/r9
	 raUO31zezUkxA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	dd@embedd.com,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v2 0/4] Add Airoha EN7581 PCIe support
Date: Thu, 27 Jun 2024 10:12:10 +0200
Message-ID: <cover.1719475568.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for EN7581 SoC to mediatek-gen3 PCIe driver

Changes since v1:
- remove register magic values
- remove delay magic values
- cosmetics
- fix dts binding for clock/reset

Lorenzo Bianconi (4):
  dt-bindings: PCI: mediatek-gen3: add support for Airoha EN7581
  PCI: mediatek-gen3: Add mtk_gen3_pcie_pdata data structure
  PCI: mediatek-gen3: Rely on reset_bulk APIs for PHY reset lines
  PCI: mediatek-gen3: Add Airoha EN7581 support

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  68 +++++++-
 drivers/pci/controller/Kconfig                |   2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c   | 163 ++++++++++++++++--
 3 files changed, 212 insertions(+), 21 deletions(-)

-- 
2.45.2


