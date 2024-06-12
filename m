Return-Path: <linux-pci+bounces-8656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9380D9050F9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 12:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399962866C5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD86416EBFD;
	Wed, 12 Jun 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khTMS+5M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9E16E888;
	Wed, 12 Jun 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189895; cv=none; b=JRrK4yLCJN/aYGhX3uMbQefbTrhRluKfhrxvDloVX8rPPxFTz+OtNOYB7XgvlpfavsnO/+GgQDqiw+pa4o8ozgMBKVX39VGzVxSZeqR9iTs5+MJ/eI7ZezkSkm7HjIdMUJuJbPiLcuxdbP3BXlANnKDQ7h2GaZ0R2rohGYO2AFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189895; c=relaxed/simple;
	bh=47DU7S/KIbzHjqDBoxXBhMyQV6hLuFO+cJiT7+VrD4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nEWluwW7e53Y26MEoJ8v1FL6IfasRyMKLTEjhduznXVed6wHawdcSdpouM+zJIwbpYEniS56jCs1gjYMVU24dl1vXOXY27HwLCDYZkyEjCXNyqx+9JUiJZGk06FQrTStGYMjpsTTWPV/Uv5xKCqvr5jP6Ct4M1w0qpMRgYfLcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khTMS+5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57448C3277B;
	Wed, 12 Jun 2024 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718189895;
	bh=47DU7S/KIbzHjqDBoxXBhMyQV6hLuFO+cJiT7+VrD4I=;
	h=From:To:Cc:Subject:Date:From;
	b=khTMS+5MJFTFb8yXw4fHZGUMGkTy8jxGN/TYfeg32VavACwiQNP9s2rXch8BHSweR
	 WpHYVXLktmu7p0efcsOa4riHw1M+RVmhP3Me3ta8rbWC6AJU/lwiOM+hi0+4GiNUNZ
	 P0K9IHurqQauRbCFrRwd9pV3E6ueaCUZtyLTMeuDYEGExD5miK96AbcZtdkr98VZ7P
	 UvpL72If+ABOYLaHr68LHClktRQdPDvq3EJ9uN2da6OpFIL051Wh1YWu6VEdqITra7
	 3+x3xedBNEbIRhBfReG4/aw/lEGQu4x9K9hRmoqPtUeX3ht1rr0ilGgB94N8zDO47N
	 djVEKrl4Kl75g==
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
Subject: [PATCH v2 0/2] PCI: microchip: support using either instance 1 or 2
Date: Wed, 12 Jun 2024 11:57:54 +0100
Message-ID: <20240612-outfield-gummy-388a36d95100@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=zil4c1af9kgKB/4JC67HHkNcqLGWhATVWxa9QRrypgU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmZ9cY/Z7BPfVS3ag4/59Wal/d9DX7mfPdpzvrvbnDi4 qLiUyJKHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIKweG3+zbtq39aFjD7sk7 8V+ZYEja/xMFWuU1Ng8MPi9arCWxkY/hn07HFjfLrHKvyMMr/eSOWAeumNNT8eP6pzWpWxi/12x x4AUA
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

v2:
- try the new reg format before the old one to avoid warnings in the
  new case
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


