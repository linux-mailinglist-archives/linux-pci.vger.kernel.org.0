Return-Path: <linux-pci+bounces-12317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0758961ACB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 01:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437B91F2427D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6C19644B;
	Tue, 27 Aug 2024 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT2JXHCt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7A677117;
	Tue, 27 Aug 2024 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802545; cv=none; b=OqbdUveos5O3KAwML9w5bDB45fZyiSidH664RZJLb/zZX+ICXkWz8UzVgI5JMDM2DOrR12jLZwsOrTWoru7cCQiZtV8ZnF+9gK4NYbMefSPIxDhceIMhXqOGN3fzmux/sFf0qRkuT9UhUtp+B694g9ED9R6mIplk6GpyyzB3Ceg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802545; c=relaxed/simple;
	bh=1habWAnCQ47osugdIaCzrpBhW1lUXfQzMLywMlynk2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZMpA+dVewRf3m2DfArNLPbL3ot2LwuYVffYHIE+z0E8VKj9sV2shHEUVUwY/XwkwwqXQM0rClZJD5BubD2rWHuTfAjQ9ANNG5vBERFRFAA73LpS3jWNa4y6z3i64dst0m6JNqEkGIK1oFSVC6wZ3J0pvsZ3tquIlb9iuXfVUqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT2JXHCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB5BC4FDF8;
	Tue, 27 Aug 2024 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724802544;
	bh=1habWAnCQ47osugdIaCzrpBhW1lUXfQzMLywMlynk2c=;
	h=From:To:Cc:Subject:Date:From;
	b=LT2JXHCtnnE0ZtOjUnRsB6oCSG78fenG8+MxOsOVnar/5/2ItDU6Tm1NiCqDqaR4T
	 ocHZqxVSKN5xWWzihBcUQQtn/H4dp/mFA8XqgV08rDFnKPmQ/iQtO+QTiB190TdFei
	 IFmwHC1gw4v97zbpz49ydDLKgCKjyPt4yDM/5AqrpOiYBVuxjPOlsvOIgwA1BmjEUy
	 d2a62+K6ZaVgXGr76p78waztW1rIeRdVqTnCeDnXJChVvnaCLyCW8V5+9GV1LGESUV
	 vIBgouykNt7FeQqWn2lyL4Gmw0q54yNsBjKfMJKSnimt8g5yKw+gerSPf5iHYnzYyx
	 T05bz76+u+X/Q==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 0/3] PCI: Use Configuration RRS to wait for device ready
Date: Tue, 27 Aug 2024 18:48:45 -0500
Message-Id: <20240827234848.4429-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

After a device reset, pci_dev_wait() waits for a device to become
completely ready by polling the PCI_COMMAND register.  The spec envisions
that software would instead poll for the device to stop responding to
config reads with Completions with Request Retry Status (RRS).

Polling PCI_COMMAND leads to hardware retries that are invisible to
software and the backoff between software retries doesn't work correctly.

Root Ports are not required to support the Configuration RRS Software
Visibility feature that prevents hardware retries and makes the RRS
Completions visible to software, so this series only uses it when available
and falls back to PCI_COMMAND polling when it's not.

This is completely untested and posted for comments.

Bjorn Helgaas (3):
  PCI: Wait for device readiness with Configuration RRS
  PCI: aardvark: Correct Configuration RRS checking
  PCI: Rename CRS Completion Status to RRS

 drivers/bcma/driver_pci_host.c             | 10 ++--
 drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++---
 drivers/pci/controller/pci-aardvark.c      | 64 +++++++++++-----------
 drivers/pci/controller/pci-xgene.c         |  6 +-
 drivers/pci/controller/pcie-iproc.c        | 18 +++---
 drivers/pci/pci-bridge-emul.c              |  4 +-
 drivers/pci/pci.c                          | 41 +++++++++-----
 drivers/pci/pci.h                          | 11 +++-
 drivers/pci/probe.c                        | 33 +++++------
 include/linux/bcma/bcma_driver_pci.h       |  2 +-
 include/linux/pci.h                        |  1 +
 include/uapi/linux/pci_regs.h              |  6 +-
 12 files changed, 117 insertions(+), 97 deletions(-)

-- 
2.34.1


