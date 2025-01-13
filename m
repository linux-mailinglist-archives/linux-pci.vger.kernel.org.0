Return-Path: <linux-pci+bounces-19693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F286A0C567
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 00:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB52C1886BFC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 23:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A31D5CD4;
	Mon, 13 Jan 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWg2B/De"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2751CEEB4;
	Mon, 13 Jan 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810163; cv=none; b=liM85xL3Bvj0TJEaBtlDNZYnJcwRXofPtKkut9WH3X+fPwgCAQD+uawqOQ1M0s67mmkXPui9pV4rLLi+rjWdm1LNDMeFQe/9fxEm3X5G48CJUvLAPNSBHBWSCvi4+a1f1NWgeX81KpYT2TtTrmMxVLk93cc9pztYEcQOKEZzQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810163; c=relaxed/simple;
	bh=91orUz6hgNoFmJ317Cgbt4RyTw1TdbcwsWbQtTHFiV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mvyBbexGkS2ponKMPODaqmIpQ5X3OWpb6bGzJIhjKRGRDmx4kbOT8YWASMyyjYn8EbcUsvT0X+zxd696IZR8UoYRV/+2tg5NK6u7Mpl3VF7kMRscK0dIVeC4MvcqOWH86qZoI4AsaAltvYKuYsvzxClVH5mbPC8ir5EpYYfSlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWg2B/De; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC6EC4CED6;
	Mon, 13 Jan 2025 23:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736810162;
	bh=91orUz6hgNoFmJ317Cgbt4RyTw1TdbcwsWbQtTHFiV0=;
	h=From:To:Cc:Subject:Date:From;
	b=KWg2B/DeJzoqP4LcfuNPuLbELJ7k6sGxHKPn7x4XFEgPgJk+jbnCYpz1bWRBivhTk
	 9eyqGn+R/vxcEazexGcHsI3pUGEIRcp8WMS6cvMm6YLaCq27fNOdQYbq2DrTJPA2WH
	 6vCfrpkZmydBZijZYfscX3EAuLTrAMeM/3JcgWyjqcmPOhUw6vSh/fPpWhj1+wQvsZ
	 GaL+wRiJ7HxCY85SeIt9nvQ4s71iZm8Pq7lq9QJXWFVzmhpk0SoOLLhuxwHu8wRzss
	 uTCYAGQA5zv+nhSvn2SRO0A0gY8AUwUgNYSfL61a0w3J0wG040XrwnE/8iL38NqwiO
	 3L/gCGpPk3TrQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/4] PCI: Simplify bus range parsing
Date: Mon, 13 Jan 2025 17:15:53 -0600
Message-Id: <20250113231557.441289-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Unexport of_pci_parse_bus_range() since it's only used in drivers/pci/of.c.

Drop the "No bus range found" message since host bridges typically lead to
[bus 00-ff], and we already default to that if there is no "bus-range" DT
property, so there's no point in requiring it in DT or complaining if it's
not there.

Drop bus range parameters from devm_of_pci_get_host_bridge_resources()
since they're always the same values.

Update a sparc comment that referred to of_pci_get_host_bridge_resources(),
which no longer exists.

Bjorn Helgaas (4):
  PCI: Unexport of_pci_parse_bus_range()
  PCI: of: Drop 'No bus range found' message
  PCI: of: Simplify devm_of_pci_get_host_bridge_resources() interface
  sparc/PCI: Update reference to devm_of_pci_get_host_bridge_resources()

 arch/sparc/kernel/pci_common.c |  2 +-
 drivers/pci/of.c               | 22 ++++++++++------------
 drivers/pci/pci.h              |  7 -------
 3 files changed, 11 insertions(+), 20 deletions(-)

Changes since v1
(https://lore.kernel.org/r/20250103213129.5182-1-helgaas@kernel.org):
  - Fix compile error
  - Drop 'No bus range found' message
  - Add Ack from Andreas for the sparc/PCI comment update
  - Add Reviewed-by from Rob for the unexport patch

