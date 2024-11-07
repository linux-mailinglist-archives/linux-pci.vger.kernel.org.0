Return-Path: <linux-pci+bounces-16223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF79C030E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 11:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A1D1F22471
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A541E32DC;
	Thu,  7 Nov 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG/0YCm+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D2A1D932F;
	Thu,  7 Nov 2024 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977192; cv=none; b=WEHj11pDK+NDP3jtpBOIl9pfRHFmLPivWqC0BYbQJjxQZxpBYhp8TRwGi6T2Zu+bt2Q6ucxp5ZsL4EBWwu/YLNYF33bvV3sA8skBV4Kj1n8vusE2AdXGzxCQu5nTjt0tFW78buDrHWdV8GmsHSu3tGdaBdvL7tGkZYHqkgRhFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977192; c=relaxed/simple;
	bh=ulJ1Mfc081n2BYrBwoce4yXqUrc0vALnBWkN8KQGmko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tsORp1fD0EwtoxgoaLEZ5g7IxGJfbNzQu2qhculKpWmuORniVqc7+vXA48qOHZBVWDb/m8bcCIKCOSk+PDD3qKGhNr7aiI+gH7ShAcDdqA2TJpMCKlTzhdEsNHxBx9wuiZFbTqbX35ocvLDIO1KHHhqOy9QNCjEfTj/sMeoWHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG/0YCm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFAAC4CECC;
	Thu,  7 Nov 2024 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730977191;
	bh=ulJ1Mfc081n2BYrBwoce4yXqUrc0vALnBWkN8KQGmko=;
	h=From:To:Cc:Subject:Date:From;
	b=PG/0YCm+Gk0R9TdATEB0FHWvZYV137vwKutlJMVZZFB97xFyzXQ/iwt63QiSwVCCm
	 gBz6zvnROaYLHBw3Y3KzF+FOlI59P1ux+H43FJnViU6rSazOPNJW3XdZqiiR530uno
	 KL1OrG+2zSWhUK7VgjogS/YGyqWLpG3nD/JppHmAVxHJ4+kCK9X5fH9tCDYFBYPFxm
	 BnvTvQC6mUNvpLIncGMQlShrGlcHHV5J+ogSqqgT4OJLlyVVXgsimec9jXl9jr0tfE
	 BdabkaEmhF1LxidljxPqENQlI+Ax+/zwH+xudTC9VCT2OJ8ifM6sN2E+qSqcVIGzGm
	 4BM99mndAZJ4Q==
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
Subject: [PATCH v6 0/2] PCI: microchip: support using either instance 1 or 2
Date: Thu,  7 Nov 2024 10:59:33 +0000
Message-ID: <20241107-aqueduct-petroleum-c002480ba291@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=fVyaqmi1x3CSNtda6SlOyTBYUpS/Zg4XH/v6iZNKKks=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOk6c2eXvrmxvr/yfpqwJov3vI4Pvh8/5EoXTJ7DdV9sX 3uW3qdfHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIm4UM/9N3Hk437PF1ea9w 1ma68d9LaW6Zj1flhWu3+W45EVn0bCPDHz6H957n1nvuC0wJ3f/KdpvHoa8S3EnixSLn9nq0p1p N5wIA
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

v6:
- rework commit messages to use Bjorn's preferred "root port" and "root
  complex" wording

v5:
- rebase on top of 6.11-rc1, which brought about a lot of driver change
  due to the plda common driver creation - although little actually
  changed in terms of the lines edited in this patch.

v4:
- fix a cocci warning reported off list about an inconsistent variable
  used between IS_ERR() and PTR_ERR() calls.

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
  PCI: microchip: rework reg region handing to support using either root
    port 1 or 2

 .../bindings/pci/microchip,pcie-host.yaml     |  11 +-
 .../pci/plda,xpressrich3-axi-common.yaml      |  14 ++-
 .../bindings/pci/starfive,jh7110-pcie.yaml    |   7 ++
 .../pci/controller/plda/pcie-microchip-host.c | 116 +++++++++---------
 4 files changed, 87 insertions(+), 61 deletions(-)

-- 
2.45.2


