Return-Path: <linux-pci+bounces-9507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B68E91DC4F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 12:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3CF1F22EA0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219B4139CFE;
	Mon,  1 Jul 2024 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1vuLZrA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E112A177;
	Mon,  1 Jul 2024 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829345; cv=none; b=VfWw2EH7FyAmlTxQAhjU2hsOCFk6CAZ1/AqsChb0LupJ4Cb9JN8WLTPkJMQhFH6htwL+r/te+Pz6sXnU9TvGW4c1iNnZz04HNNGH5GfQZFzTbGZbHsPA0hJ4cDWRtygzo2UrkR9WBH7ksItBbESDA2fv8sanmeH9VgY0tceecBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829345; c=relaxed/simple;
	bh=lILPFujAusSuBTPER4NperHFzpZF4Joa/IjBo7MTe2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0YMRD/+uJN77KHkULTf5GfTNYOx+RX1CVsJ662QB4VUVWqgTUZeuDflIniazXxdFahFc7ljCVDpE8ih+LCeVY0Zo/Y81GEXhQrD/t7Shski0VAI54WbrxdC4f82MA6yYspPIbK7SAnSRLyl5OFQjhIMK84HJQ/hrIYYwHQQHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1vuLZrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E660EC116B1;
	Mon,  1 Jul 2024 10:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829344;
	bh=lILPFujAusSuBTPER4NperHFzpZF4Joa/IjBo7MTe2A=;
	h=From:To:Cc:Subject:Date:From;
	b=k1vuLZrA1BxXnG7EmaOnQoLNLn5zL09PvdR2NWvoacYbl5o07GdTGO5Svz5pU5X5Z
	 rEtZZ06ZbJwZQs0WCWmw0b/4Z+pZUapkEzrbllXSTkhr1l6cihw2helBls4bUAfkEH
	 qnV+7/dJzEqzrfWVSmlhADxODnygQJfOFIS14Ftq9lo4FOEefr5rMo9GgX7bjEv4oL
	 0NYs2szFNXCtlOFR61fFoS5doADt6s627sWblQhVCZn83BUYtfE+rIS4jv8T8JEyM4
	 n0TGGnIHwsjj4E2o0LUx74e94b7NnVFuWcCdc7xPW7eJkRldalvvUjekjthmSg6t2o
	 0+waEe6BBvqBg==
From: Conor Dooley <conor@kernel.org>
To: linux-pci@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/2] PCI: microchip: support using either instance 1 or 2
Date: Mon,  1 Jul 2024 11:22:10 +0100
Message-ID: <20240701-plant-tycoon-db11909036e6@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=6PYNzTuci0j48BqrGaPbxVulQndcuM5qX19cbMOrGKs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlNzSGxAkwT7vw8zzWp9Zl3083UF5P9cyq9ckv3ss/9u kvvPpNSRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTAC6SwPDP8pfk4eU99WLKit+i erx0ni3XSV643SbucvP/3AX1ucarGBnmxny/NM9ecNmV4zPTb+yxkPy/y0Z37i+26xO/c3svOf6 cBQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The current driver and binding for PolarFire SoC's PCI controller assume
that the root port instance in use is instance 1. The second reg
property constitutes the region encompassing both "control" and "bridge"
registers for both instances. In the driver, a fixed offset is applied to
find the base addresses for instance 1's "control" and "bridge"
registers. The BeagleV Fire uses root port instance 2, so something must
be done so that software can differentiate. This series splits the
second reg property in two, with dedicated "control" and "bridge"
entries so that either instance can be used.

Cheers,
Conor.

v3:
- rename a variable in probe s/axi/apb/

v2:
- try the new reg format before the old one to avoid warnings in the
  good case
- reword $subject for 2/2

CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Krzysztof Wilczyński <kw@linux.com>
CC: Rob Herring <robh@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: linux-pci@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org

Conor Dooley (2):
  dt-bindings: PCI: microchip,pcie-host: fix reg properties
  PCI: microchip: rework reg region handing to support using either
    instance 1 or 2

 .../bindings/pci/microchip,pcie-host.yaml     |  10 +-
 drivers/pci/controller/pcie-microchip-host.c  | 155 +++++++++---------
 2 files changed, 79 insertions(+), 86 deletions(-)

-- 
2.43.0


