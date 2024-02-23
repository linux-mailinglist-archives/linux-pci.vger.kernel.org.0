Return-Path: <linux-pci+bounces-3944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD99861E47
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 21:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E717B2164A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 20:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930661448F3;
	Fri, 23 Feb 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKJO1XJA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EE12A16D;
	Fri, 23 Feb 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721935; cv=none; b=qJI0VPNHy2CvIsu6fKiQwt9yW13t6uvvGJWLsPbAUcR2QsH8E6c1v3nTnE/1n3cHGxhkQ0ZirmYrBPLtpL0tRe2Aguu16vy6uCvgaG5D5Z+kjBZPYWQJSWK0WwPUfOXyma+hN4Cmn5FW/k2tDicaE5Dnj/u+s1inanuH49ARX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721935; c=relaxed/simple;
	bh=ZnhJxh0/iM55/Ih9OWsBqkos+7Gz6O4NkpMi/NZLabM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LP2ZaF0YlpIwkFr++ni/9sSjqG5AOlJmwfQaIXBpCOlrKEfdTo2GyBKY2dEHL/haHJ5PLaqs3ADerMbQbQrMvY5Zigf+d7axPDuDsv4zDEhlCQyWsCZL1VWzJRXbqePtaSt503ygctliKBaBY6/1T6Rkwq2VQT+N+f+yx+TsPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKJO1XJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF24C433F1;
	Fri, 23 Feb 2024 20:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721934;
	bh=ZnhJxh0/iM55/Ih9OWsBqkos+7Gz6O4NkpMi/NZLabM=;
	h=From:To:Cc:Subject:Date:From;
	b=SKJO1XJAV3byIfprXimylg/0/cOa72YkVcW2E/j5DAtRQ+zhgVF1vWvSv+xxbwVLB
	 InNYbiDaV89suN0QAjcUd/UltBHwWQPunJ6Pi7N9gyIXrxIDx7jjP38ZSIqzEAuSZh
	 ukS7vWy+ohfhN66QthEMg2EsyGGwdO5E9pB7V8dIC2WbgA8ydnzsNREJUg5Erj6SMG
	 pkPw4aOoxy9KPhMm9oZ1DLkBAWm5jPo7r8d0bVPfRF5OJ2Rkdc50s+HcMYvnwYUeaX
	 PJQ8eWqOHfHynQKi3beH5yNloYu1EdTJoJbgxDLD6mv7w2MuAkBzi/z4YLPPBSlTGZ
	 f4AEkzlhgVazQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tasev Nikola <tasev.stefanoska@skynet.be>,
	Mark Enriquez <enriquezmark36@gmail.com>,
	Thomas Witt <kernel@witt.link>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7 0/5] PCI/ASPM: Save/restore L1 PM Substates for suspend/resume
Date: Fri, 23 Feb 2024 14:58:46 -0600
Message-Id: <20240223205851.114931-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This is some rework of David's series to preserve ASPM L1 substate
configuration across suspend/resume.

We've had several attempts to make this work:

  (unlabeled): https://lore.kernel.org/r/20240128233212.1139663-1-david.e.box@linux.intel.com
  v5: https://lore.kernel.org/r/20231221011250.191599-1-david.e.box@linux.intel.com
  v4: https://lore.kernel.org/all/20231002070044.2299644-1-mika.westerberg@linux.intel.com/
  v3: https://lore.kernel.org/linux-pci/20230925074636.2893747-1-mika.westerberg@linux.intel.com/
  v2: https://lore.kernel.org/linux-pci/20230911073352.3472918-1-mika.westerberg@linux.intel.com/
  v1: https://lore.kernel.org/linux-pci/20230627062442.54008-1-mika.westerberg@linux.intel.com/

The most recent posting is the unlabeled one mentioned above, and I'm
calling it v6 and this rework v7.

Changes since the unlabeled v6:

  - Rename pci_save_aspm_state() to pci_save_aspm_l1ss_state() (this
    is the reason for opening this again, because Vidya's patch [1]
    had to do some incidental renaming).

  - Rename pcie_restore_aspm_l1ss() to pci_restore_aspm_l1ss_state()
    to match.

  - Move the PCI_EXP_LNKCTL_ASPMC from pci_restore_aspm_state() to
    pci_restore_pcie_state() so both writes are in the same place.

  - Rename pci_aspm_get_l1ss() to pci_configure_aspm_l1ss() and add
    the save_buffer there as well.

  - Split [1/5] into two patches: move pci_configure_ltr() and
    pci_bridge_reconfigure_ltr() to aspm.c, and build aspm.c
    unconditionally.

  - Squash [2/5] and [3/5] since [2/5] didn't add any functionality
    itself so they seem like a single logical change.

[1] https://lore.kernel.org/r/20230125133830.20620-1-vidyas@nvidia.com

David E. Box (5):
  PCI/ASPM: Move pci_configure_ltr() to aspm.c
  PCI/ASPM: Always build aspm.c
  PCI/ASPM: Move pci_save_ltr_state() to aspm.c
  PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
  PCI/ASPM: Call pci_save_ltr_state() from pci_save_pcie_state()

 drivers/pci/pci.c         |  89 ++++------------
 drivers/pci/pci.h         |  13 ++-
 drivers/pci/pcie/Makefile |   2 +-
 drivers/pci/pcie/aspm.c   | 215 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c       |  62 +----------
 include/linux/pci.h       |   2 +-
 6 files changed, 252 insertions(+), 131 deletions(-)

-- 
2.34.1


