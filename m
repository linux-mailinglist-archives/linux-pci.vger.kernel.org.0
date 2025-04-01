Return-Path: <linux-pci+bounces-25041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D0BA77766
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731583A9569
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE731EDA20;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSL72YDS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FC156653;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499057; cv=none; b=F16og6Yed0FTTtZKEIsd35WkdI5tgxN7BZHDEXqi+Mutimv+xhYmqkMaf754R115rbyh1S0trQOOiUeg110xSIevFE2sCC6ew45BBTdSjrMNetOsrWqF9cj6BOy/79eeazD+7AASh8hzbxUlPhjZrZi0WYIqAiKz+I7G27yPX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499057; c=relaxed/simple;
	bh=J0L3Um0GRQp3OOt5WA3u+E6KwaB9/4HhItKzHfizai8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OE5Keh8FoqnOi6aKsHnzd9CjmKRleY2+mdsaRaF0Y7cy6QkGGKqzML1BN5mwRMKMj7IWSFhIJGvaIOuhNk2J/PPtmgH9B69C7voHCIekARowNyRqV5wkggNDroWE4/VIP9qZ8wfhvho8eIwW3HKVq2pUbyg6PqSWNhMBhB6MUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSL72YDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB891C4CEE5;
	Tue,  1 Apr 2025 09:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743499057;
	bh=J0L3Um0GRQp3OOt5WA3u+E6KwaB9/4HhItKzHfizai8=;
	h=From:To:Cc:Subject:Date:From;
	b=PSL72YDSphuHVNiRVQPhKnAlDu25lss3jTft7Ftm6/j3r4+h5NlPPNNnmZLcLOcDW
	 KZn4m4M2jNsleaMzuAx56MzaG599Rk6H04X/FlGq+EVjtvCepELZ9mMDjbwEUKATsF
	 q3oraUMaj+fEZlmcOmxPMGu9wDdRyy/l+m/cK06B77bqFZBD1NJoAuHMdPrY+Z3cv7
	 eAWYzJsjUi+qZkI2uXBo/rWmFy65fVCsatgi71ti1JJZKaVhNEMQIZBe+D5o8hL74X
	 X7AWDBnILkEURZjXsxXQw7B0YrU9jetOuYPp3EdsLxleBuneELlqEelkIWlxaj2WrY
	 8no/VKQhDwXIQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tzXkU-001GqU-JG;
	Tue, 01 Apr 2025 10:17:34 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: [PATCH v3 00/13] PCI: apple: Add support for t6020
Date: Tue,  1 Apr 2025 10:17:00 +0100
Message-Id: <20250401091713.2765724-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, mark.kettenis@xs4all.nl
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

As Alyssa didn't have the bandwidth to deal with this series, I have
taken it over. All bugs are therefore mine.

The initial series [1] stated:

"This series adds T6020 support to the Apple PCIe controller. Mostly
 Apple shuffled registers around (presumably to accommodate the larger
 configurations on those machines). So there's a bit of churn here but
 not too much in the way of functional changes."

The biggest change is affecting the ECAM layer, allowing an ECAM
driver to provide its own probe function instead of relying on the
.init() callback to do the work. The ECAM layer can therefore be used
as a library instead of a convoluted driver.

The rest is a mix of bug fixes, cleanups, and required abstraction.

This has been tested on T6020 (M2-Pro mini) and T8103 (M1 mini).

* From v2[2]:

  - Fixed the DT binding with new constraints specific to t6020

  - Moved the "for_each_available_node()" fix to the head of the series

  - Collected, RBs, TBs, ABs (thanks!)

* From v1[1]:

  - Described the PHY registers in the DT binding

  - Extracted a ecam bridge creation helper from the host-common layer

  - Moved probing into its own function instead of pci_host_common_probe()
    
  - Moved host-specific data to the of_device_id[] table

  - Added dynamic allocation of the RID/SID bitmap

  - Fixed latent bug in RC-generated interrupts

  - Renamed reg_info to hw_info

  - Dropped useless max_msimap

  - Dropped code being moved around without justification

  - Re-split some of the patches to follow a more logical progression

  - General cleanup to fit my own taste

[1] https://lore.kernel.org/r/20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io
[2] https://lore.kernel.org/r/20250325102610.2073863-1-maz@kernel.org

Alyssa Rosenzweig (1):
  dt-bindings: pci: apple,pcie: Add t6020 compatible string

Hector Martin (6):
  PCI: apple: Fix missing OF node reference in apple_pcie_setup_port
  PCI: apple: Move port PHY registers to their own reg items
  PCI: apple: Drop poll for CORE_RC_PHYIF_STAT_REFCLK
  PCI: apple: Use gpiod_set_value_cansleep in probe flow
  PCI: apple: Abstract register offsets via a SoC-specific structure
  PCI: apple: Add T602x PCIe support

Janne Grunau (1):
  PCI: apple: Set only available ports up

Marc Zyngier (5):
  PCI: host-generic: Extract an ecam bridge creation helper from
    pci_host_common_probe()
  PCI: ecam: Allow cfg->priv to be pre-populated from the root port
    device
  PCI: apple: Move over to standalone probing
  PCI: apple: Dynamically allocate RID-to_SID bitmap
  PCI: apple: Move away from INTMSK{SET,CLR} for INTx and private
    interrupts

 .../devicetree/bindings/pci/apple,pcie.yaml   |  33 ++-
 drivers/pci/controller/pci-host-common.c      |  24 +-
 drivers/pci/controller/pcie-apple.c           | 241 +++++++++++++-----
 drivers/pci/ecam.c                            |   2 +
 include/linux/pci-ecam.h                      |   2 +
 5 files changed, 220 insertions(+), 82 deletions(-)

-- 
2.39.2


