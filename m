Return-Path: <linux-pci+bounces-38501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1BABEB0C4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 19:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 324B14E1F05
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59082FA0EE;
	Fri, 17 Oct 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwApvdlQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBE2F8BC0;
	Fri, 17 Oct 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721492; cv=none; b=UeRTPOQgPdDH3dEwpG9j0hakTcOLLOTXCkFGZ5ss/PvlqXfWkIxLpbNjHO7NVInkHIwG89wep0zpy8/UYOgjud5hByyTehNhzMpQOvU01JKwsrPqY6ss1P9Uh5RFThcgr7LIQpfy9Q2YgM30kZmy9f4o7RVDkAuz7gLmoNogh4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721492; c=relaxed/simple;
	bh=B6E2wpMJBvcJ194lmI41fKxMzXJkUATkPDUH0wB8Nuw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J/YnHdCZ1AGs0RYmj6MlLDk/RhwUiJgt1qBuzCO5HvOR1vh+t1qW8fPmZtn9HfkNNYIWjMsWKsIqjFa5DOrTHSzeH0IK1OE6Qu2X3zA5opxVdra00LS0MD3mDnrJe9YmiZapH9S/P2lFjpSDfITU+fd4I2eRN0pN0f6DGFKTP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwApvdlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF19C4CEE7;
	Fri, 17 Oct 2025 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760721492;
	bh=B6E2wpMJBvcJ194lmI41fKxMzXJkUATkPDUH0wB8Nuw=;
	h=Date:From:To:Cc:Subject:From;
	b=JwApvdlQAiTod3POqDMKwmBS3OVlltiMlBVbolB///aJNbuxN8lWRktcjaN59jHgI
	 yJWxbO+HX8nk/r437dA01nVSG5E00nLFhFtCQXYBCIoCxhgyKVwJTB8Gxcqm+zWtRs
	 km4v+nLSOdPJdQip783pMbc0UpZHkqg25Fck6K8fBC23x429Nr9F0PolhVbA54gpBb
	 Pizrmva0uePXOkT/gZ3jpqlKoylF9KBmnqzTyIqoE4yAwlOHdrxFP9SG5zt5g55wRl
	 v6OU+aO4yp62A+lSfDSKFOs2VJIffsUD1XFGSwM2ZCzvLS1P41EShSVGrdUMatlLzO
	 BZuOzfuKhYm0w==
Date: Fri, 17 Oct 2025 12:18:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Hans Zhang <18255117159@163.com>, Sasha Levin <sashal@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Val Packett <val@packett.cool>, Guenter Roeck <linux@roeck-us.net>,
	Inochi Amaoto <inochiama@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kenneth Crudup <kenny@panix.com>, Genes Lists <lists@sapience.com>,
	Todd Brandt <todd.e.brandt@intel.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	=?utf-8?B?SGVydsOp?= <herve@dxcv.net>,
	Mario Limonciello <superm1@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Chen Wang <unicorn_wang@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [GIT PULL] PCI fixes for v6.18
Message-ID: <20251017171810.GA1035665@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-2

for you to fetch changes up to a78835b86a4414230e4cf9a9f16d22302cdb8388:

  PCI/VGA: Select SCREEN_INFO on X86 (2025-10-17 08:31:14 -0500)

----------------------------------------------------------------

- Search for MSI Capability with correct ID to fix an MSI regression on
  platforms with Cadence IP (Hans Zhang)

- Revert early bridge resource set up to fix resource assignment failures
  that broke at least alpha boot and Snapdragon ath12k WiFi (Ilpo Järvinen)

- Implement VMD .irq_startup()/.irq_shutdown() to fix IRQ issues that
  caused boot crashes and broken devices below VMD (Inochi Amaoto)

- Select CONFIG_SCREEN_INFO on X86 to fix black screen on boot when
  SCREEN_INFO not selected (Mario Limonciello)

----------------------------------------------------------------
Hans Zhang (1):
      PCI: cadence: Search for MSI Capability with correct ID

Ilpo Järvinen (1):
      PCI: Revert early bridge resource set up

Inochi Amaoto (1):
      PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()

Mario Limonciello (AMD) (1):
      PCI/VGA: Select SCREEN_INFO on X86

 drivers/pci/Kconfig                              |  1 +
 drivers/pci/controller/cadence/pcie-cadence-ep.c |  2 +-
 drivers/pci/controller/vmd.c                     | 13 +++++++++++++
 drivers/pci/probe.c                              | 13 +++----------
 drivers/pci/vgaarb.c                             |  6 ++----
 5 files changed, 20 insertions(+), 15 deletions(-)

