Return-Path: <linux-pci+bounces-9735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8999265C3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 18:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF511C20991
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D317A59D;
	Wed,  3 Jul 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz28Cjov"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F6442C;
	Wed,  3 Jul 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023190; cv=none; b=n3uYXMc+4Ir6GnMNe7b0WoNMU3k9xioYGPB/frQKobm9ZyLAUaE3ab1hKCtg3IWk1NNUZn96K34M7sLox5KrcEE4KzyNxL+8CEF1GGT3xmQsJd/DbYSUyCSAH7xp2DNar3oLoAHoMndfIYllVaRQLZmLuSgFZEUP27i92jrvWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023190; c=relaxed/simple;
	bh=Neb1+LB5kKM5TcMku4Gly5fFzuTkl9jDF4ySZTpJyGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rodp+OehjkDYQNn3/hfq72T2G8ubKTUQ3il3Np88036pgVWe1JLxhDQ0yAFxs6vYMkVj868DIhGum/HvWHbJMxwSfegiJ/TzZJW2Ei3+eyqfqLPUo/eRozvBZY6BBIFStrUiTkFg0rHOTjikZkQ1TRymW6vKexkVPgkjIqjzweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz28Cjov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C41C2BD10;
	Wed,  3 Jul 2024 16:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720023188;
	bh=Neb1+LB5kKM5TcMku4Gly5fFzuTkl9jDF4ySZTpJyGg=;
	h=From:To:Cc:Subject:Date:From;
	b=Jz28CjovdwpnYTsy06MiZQAsMdek36QR+T93huuEQ0T6T1MGKIOdWF7gccz4ehhNL
	 rHsYWgk9J4JIjdU3jPo+jcHB+m0AZL3YbAn3GIyun5ACp8UY7fJAk2oztbqUDkCPrh
	 KhTvnqk80Q4Kl04qE9CbPbUJiSXg5hapKqZMA3T7l4BJDyvgLFuBKqQ4Tp/WmRIzFx
	 MtiGcNhLP30mGdAswGCpKCDVvwi3e4NEisRnWnZBCFmV+jY9I9422YYWgBJBATBB+b
	 bPXbTQO6xzliykSu+taPZWWs7HQ6u3F6nNogFbqNUXSIN8DKdKU8Qk8Py1LFpVceaf
	 HxBjBe1/Le+7g==
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
Subject: [PATCH v4 0/4] Add Airoha EN7581 PCIe support
Date: Wed,  3 Jul 2024 18:12:40 +0200
Message-ID: <cover.1720022580.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for EN7581 SoC to mediatek-gen3 PCIe driver

Changes since v3:
- move phy initialization delay in pcie-phy driver
- rename en7581 PCIe reset delay
- fix compilation warning
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
 drivers/pci/controller/pcie-mediatek-gen3.c   | 180 ++++++++++++++++--
 3 files changed, 229 insertions(+), 21 deletions(-)

-- 
2.45.2


