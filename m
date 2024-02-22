Return-Path: <linux-pci+bounces-3896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6860786057F
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 23:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3349289B1C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 22:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D35D12D218;
	Thu, 22 Feb 2024 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzUWt68G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC314B81E;
	Thu, 22 Feb 2024 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640134; cv=none; b=esZEkTfVv7OSd94EtkbZ1jcApBui8fbqcyqej1Z7UgQPHU8pMUVr/Tu3KRZ4n94B3BDKzgIIJDoa6FqT46oCzI9vWQ0eO8KWsrdD8eGWmXbs6iAntBKDrglryLQOQHLig/kIm3Q2I4ZGC7iC96eeCozVCDDvKAJEfwI2RlT/xSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640134; c=relaxed/simple;
	bh=P5o8neBVE3O5U/nFyHiW0oafwt0FP0+GwbHlvNgjyZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MUX+s0FZiF4/CBvIhVpwahv5Fe20a8sgXi/wPAmQF7MCgF7ljt715dMUQ7MYJTm9EAKWz8qerqZVJOqigHK8VGfzLsa0Km9iT20T5i1SfLgP19merTvCIxOlIrUgp33si9dvXdUkecMXboDpFBocmMji/Yz4o3QJy+pCVUc8jS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzUWt68G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93129C433C7;
	Thu, 22 Feb 2024 22:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708640133;
	bh=P5o8neBVE3O5U/nFyHiW0oafwt0FP0+GwbHlvNgjyZA=;
	h=From:To:Cc:Subject:Date:From;
	b=dzUWt68Gv56NC3EUZr9w0My1v0hnD1jcQWUCyb0KYc223c5ZBDIXAPSjoQipFuiB7
	 bbkftEo4m9OJqaKgdK2ourtaXcLszjJ8qZPVTwAwdmwv5pdkVku26OdVmzhWYmhR9j
	 KrpgauZC+5B+bWg6JrqAPWIxYzfwP46G4er7337kkiyskznOMeALd0scYDelyJGlZ3
	 Vqd8Sc3Agr8228ncZjeIyck13KClL8bJrCYaY8wcUoYILw6JySbll+7SHJ25frnQI1
	 rP08lXypFBPbORBYZIFGpZw5CY0Z6h3zcBORtkzUMuLoPtheHx+xMQkLPO3zJay5+i
	 tRe3KaWlrM2Ow==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/3] PCI/DPC: Clean up DPC vs AER/EDR ownership and Kconfig
Date: Thu, 22 Feb 2024 16:15:18 -0600
Message-Id: <20240222221521.32159-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we could request control of DPC without AER, which is illegal
per spec.  Also, we could enable CONFIG_PCIE_DPC without CONFIG_PCIE_EDR,
which is also illegal.  This series addresses both.

Bjorn Helgaas (3):
  PCI/DPC: Request DPC only if also requesting AER
  PCI/DPC: Remove CONFIG_PCIE_EDR
  PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()

 drivers/acpi/pci_root.c   | 22 ++++++++++++----------
 drivers/pci/pci.h         |  4 ++++
 drivers/pci/pcie/Kconfig  | 14 ++++----------
 drivers/pci/pcie/Makefile |  5 ++++-
 drivers/pci/pcie/dpc.c    | 10 ----------
 include/linux/pci-acpi.h  |  8 --------
 6 files changed, 24 insertions(+), 39 deletions(-)

-- 
2.34.1


