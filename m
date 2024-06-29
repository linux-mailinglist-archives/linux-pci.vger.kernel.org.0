Return-Path: <linux-pci+bounces-9444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D1D91CD72
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 15:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F1A281C7F
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E88060A;
	Sat, 29 Jun 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZwv03Ua"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00C1DA5F;
	Sat, 29 Jun 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719669159; cv=none; b=By7dz45aVgFjv4bhXJJ9vhuwn8+5yNgRmCh0LMmjqu2vSraEn7uSYqv79Z2tpbiLXgp+TvIsfeT92aL6EyNl46EVNk3WUcJbOXmwdrQzPTOgU48Zn7ElOw4jmWUxAzacp0q0Cm2J1f5OwZ2M4J+fh2/c4mxcIoF74FEOBQ0EPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719669159; c=relaxed/simple;
	bh=4JK/dGJ9vvO4cLTeLu7sbX/N3rtNnVVFCgve2xC0CtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdvzQ2EgLZ+a/aG2y04sQHRwpqob5eob3w5OiZdxhpJicjnD8kampKA0yKs+fQzF836axRLhHo7ed8PjFOQ+6HEBy5ENGE2NNMhh8VwkjHwW4vVGd9XxFPTMplF8wzcotOpZNRvTj6A28XMFgkYM4X1rgjdHBLVtMFKq35kEbx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZwv03Ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AE8C32789;
	Sat, 29 Jun 2024 13:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719669158;
	bh=4JK/dGJ9vvO4cLTeLu7sbX/N3rtNnVVFCgve2xC0CtM=;
	h=From:To:Cc:Subject:Date:From;
	b=WZwv03Ua2YjdX8OiM7lnP/Z25I34m+FpQrtS/c/Fc9Ex7OtQYniNJg8aFaGdvV2CX
	 ReIXK2RDLzpESL5oTCdRW7L/LsXevd8Zw4HQognwrjxdNr9hL4PjFewJNXblw2HsyH
	 bB59jlJHYe5PD5OOvf5+EiZLGkMbtnWpLJrAmr5l+MDtnL3pdapXjAG68nH8+44LAl
	 HyB6/lu5KCs7FywkAnTjqQ8lM0KQlsSDChejtuoQ4K9d/Rpg6JE5QUt0f/87FcFS4F
	 jz0ob2dpEL2fLQwl4kvAfLUo0UJkVTGdMHHhcp6labgZzv/fIsXj+R8RlQ/XH6Oosq
	 WC7Zo6y9PSBgw==
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
Subject: [PATCH v3 0/4] Add Airoha EN7581 PCIe support
Date: Sat, 29 Jun 2024 15:51:50 +0200
Message-ID: <cover.1719668763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for EN7581 SoC to mediatek-gen3 PCIe driver

Changes since v2:
- fix dt-bindings clock definitions
- fix mtk_pcie_of_match ordering
- add register definitions
- move pcie-phy registers configuration in pcie-phy driver
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

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  68 ++++++-
 drivers/pci/controller/Kconfig                |   2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c   | 175 ++++++++++++++++--
 3 files changed, 224 insertions(+), 21 deletions(-)

-- 
2.45.2


