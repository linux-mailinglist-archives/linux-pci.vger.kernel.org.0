Return-Path: <linux-pci+bounces-8931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B300390DDCF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 22:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75D31C22919
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 20:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB7A1741FE;
	Tue, 18 Jun 2024 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtTtFPkW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904261741FC;
	Tue, 18 Jun 2024 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743792; cv=none; b=o1RD8M8z0U8QEcWErX4das8uCIayInVaGFmED97L/6DrbfUT22SuV0P79QNmL6UAvYXs9twsMn3IJxjiUyTKmBQ0jOmYBo7pwLIOQKglL2lfJ4s2RjSlHYyezMgnuTxePUZFFG3X2d/oZkosYc8K7KrR1vJIuwvbCyICL3ncq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743792; c=relaxed/simple;
	bh=CkxYcZq8lMhZtQeh+gh2bGRvtFYZZWl5V5Oif5kfgr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oIXHrDRF+yP6fBSYys/QTgEXDwVm48cI86b1dXZ+Jvxzz1DGp6IcER575PN/dW0uO83jeaLiLe0PTlS9eRw7B0iRXrOK7k+9uyvOXBlm31oCf7Gco1ef+xMkL/YkPZlUf0a1so24QIRSFCBw9g5mK6BKQSF7uM/xm50FSeuf4IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtTtFPkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B61C3277B;
	Tue, 18 Jun 2024 20:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718743792;
	bh=CkxYcZq8lMhZtQeh+gh2bGRvtFYZZWl5V5Oif5kfgr0=;
	h=From:To:Cc:Subject:Date:From;
	b=NtTtFPkWR9PN9rl/hh7cLp2Bgo45qAe0Nd1YSQPZdlmWSzsqsruf3WYzecSPgbeqI
	 zO32c+un6WskSZ75Lo9tW8AaOVmXwSyBux6basDs2x51R+Q4mYbUmptS7JUkmeyx51
	 V/71Fc8GI5+izP9hWVpUWwSzyhcVtGJruI0Z/klP/E4tKetTkIZv5YzbKUXv5y75X3
	 M01MhSGJzQVrN1hxlCo0rh+RcgdyF6Q4n+1VLscMPXjlP03CJ/hA7CS47b/319r4QF
	 frOM8AR10Zd467TmvaoLrn1BgM83WMvLeb1Z2L63H0W9CVcH+VmeFEjzzYETHlNGUV
	 9oqrc8q+QMIvg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Crider <gloriouseggroll@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-nvme@lists.infradead.org,
	regressions@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v9 0/2] PCI: Disable AER & DPC on suspend
Date: Tue, 18 Jun 2024 15:49:44 -0500
Message-Id: <20240618204946.1271042-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This is an old series from Kai-Heng that I didn't handle soon enough.  The
intent is to fix several suspend/resume issues:

  - Spurious wakeup from s2idle
    (https://bugzilla.kernel.org/show_bug.cgi?id=216295)

  - Steam Deck doesn't resume after suspend
    (https://bugzilla.kernel.org/show_bug.cgi?id=218090)

  - Unexpected ACS error and DPC event when resuming after suspend
    (https://bugzilla.kernel.org/show_bug.cgi?id=209149)

It seems that a glitch when the link is powered down during suspend causes
errors to be logged by AER.  When AER is enabled, this causes an AER
interrupt, and if that IRQ is shared with PME, it may cause a spurious
wakeup.

Also, errors logged during link power-down and power-up seem to cause
unwanted error reporting during resume.

This series disables AER interrupts, DPC triggering, and DPC interrupts
during suspend.  On resume, it clears AER and DPC error status before
re-enabling their interrupts.

I added a couple cosmetic changes for the v9, but this is essentially all
Kai-Heng's work.  I'm just posting it as a v9 because I failed to act on
this earlier.

Bjorn

v9:
 - Drop pci_ancestor_pr3_present() and pm_suspend_via_firmware; do it
   unconditionally
 - Clear DPC status before re-enabling DPC interrupt

v8: https://lore.kernel.org/r/20240416043225.1462548-1-kai.heng.feng@canonical.com
 - Wording.
 - Add more bug reports.

v7:
 - Wording.
 - Disable AER completely (again) if power will be turned off
 - Disable DPC completely (again) if power will be turned off

v6: https://lore.kernel.org/r/20230512000014.118942-1-kai.heng.feng@canonical.com

v5: https://lore.kernel.org/r/20230511133610.99759-1-kai.heng.feng@canonical.com
 - Wording.

v4: https://lore.kernel.org/r/20230424055249.460381-1-kai.heng.feng@canonical.com
v3: https://lore.kernel.org/r/20230420125941.333675-1-kai.heng.feng@canonical.com
 - Correct subject.

v2: https://lore.kernel.org/r/20230420015830.309845-1-kai.heng.feng@canonical.com
 - Only disable AER IRQ.
 - No more AER check on PME IRQ#.
 - Use AER helper.
 - Only disable DPC IRQ.
 - No more DPC check on PME IRQ#.

v1: https://lore.kernel.org/r/20220727013255.269815-1-kai.heng.feng@canonical.com

Kai-Heng Feng (2):
  PCI/AER: Disable AER service on suspend
  PCI/DPC: Disable DPC service on suspend

 drivers/pci/pcie/aer.c | 18 +++++++++++++
 drivers/pci/pcie/dpc.c | 60 +++++++++++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 12 deletions(-)

-- 
2.34.1


