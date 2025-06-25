Return-Path: <linux-pci+bounces-30616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31378AE80C6
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 13:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E813AE445
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F462820D5;
	Wed, 25 Jun 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2DCP5nU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1381FECB0;
	Wed, 25 Jun 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850293; cv=none; b=LzMmJv+OjuKJhN7VqEHCfnEnUOo6fYtDq+TvZWfNMsHkzX+zdtFO+scthJu6sc3NQSFF35a9IiDYIbK9AnfiUMb/MyE4tnF6sh456/EyYTMtZLV1E+Skk1XmS2naEM/deAgkyu9uQwtK5TA3YTavM7VyGq5OKzroBXuJ6Iq2GLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850293; c=relaxed/simple;
	bh=f5Hh8EniuvqNTWMZOUFvKsPoX2Gz9kYbg420zS1PNeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SKMrsfzHzX21Lctp96HaSqC2Q9Hg3dHyfGjhNP0k9TdoquafWGZ/XhPFQr4ynDjYw3NTZXGabM6iQXDU8teerE3NjiA6CIpBQDcmUdn4dXOMPWywGvej2OISHOKpSlSCEGALPaiJAYEwvbTUj84BjRTaWjXP4hUD/tr1OXMltdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2DCP5nU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDF2C4CEEA;
	Wed, 25 Jun 2025 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850293;
	bh=f5Hh8EniuvqNTWMZOUFvKsPoX2Gz9kYbg420zS1PNeY=;
	h=From:To:Cc:Subject:Date:From;
	b=o2DCP5nU+45W7Fu/cDrRR1gxj+M/xIsd+BEBTrazCwp+72jGkeQnXW5oP1mLK9sAI
	 mbrDghA17d0XrcvECa7j6ga4ZMtyEXLNYCarO/ew8u4yRx7NXg3GnDVj7pTdYIRW4L
	 Jq5MC0klMMsPKIPR0mOUpBxSof2du6JxMgJhoosNZCUBJqYAnRUPSbQGz39B91D+iC
	 abiwjgPlVXP7G1az1n25LcjAVMGPIWiFGiMXh1v2UQuoas5IHf9AF+o6PQYpqp2ZJS
	 NSlYVX/h14CiGKu8k0QeZqc+H/ICvboUUXEjDCeDnlrCLvelhG3KF9yC32oD06A4Nz
	 F0HHNeEkNboLA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uUO8o-009qM2-LP;
	Wed, 25 Jun 2025 12:18:10 +0100
From: Marc Zyngier <maz@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PCI: host-generic: Fix driver_data overwriting bugs
Date: Wed, 25 Jun 2025 12:18:03 +0100
Message-Id: <20250625111806.4153773-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: bhelgaas@google.com, alyssa@rosenzweig.io, robh@kernel.org, mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, j@jannau.net, geert+renesas@glider.be, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Geert reports that some drivers do rely on the device driver_data
field containing a pointer to the bridge structure at the point of
initialising the root port, while this has been recently changed to
contain some other data for the benefit of the Apple PCIe driver.

This small series builds on top of Geert previously posted (and
included as a prefix for reference) fix for the Microchip driver,
which breaks the Apple driver. This is basically swapping a regression
for another, which isn't a massive deal at this stage, as the
follow-up patch fixes things for the Apple driver by adding extra
tracking.

Finally, we can revert a one-liner that glued the whole thing
together, and that isn't needed anymore.

All of this is candidate for 6.16, as we have regressed the Microchip
driver in -rc1, and that fixing it breaks the Apple driver.

Geert Uytterhoeven (1):
  PCI: host-generic: Set driver_data before calling gen_pci_init()

Marc Zyngier (2):
  PCI: apple: Add tracking of probed root ports
  Revert "PCI: ecam: Allow cfg->priv to be pre-populated from the root
    port device"

 drivers/pci/controller/pci-host-common.c |  4 +-
 drivers/pci/controller/pcie-apple.c      | 53 ++++++++++++++++++++++--
 drivers/pci/ecam.c                       |  2 -
 3 files changed, 51 insertions(+), 8 deletions(-)

-- 
2.39.2


