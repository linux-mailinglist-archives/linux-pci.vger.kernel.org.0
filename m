Return-Path: <linux-pci+bounces-31955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD5AB025C7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 22:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11991CA623D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3FB1F4181;
	Fri, 11 Jul 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktfnEpU6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6319CC11;
	Fri, 11 Jul 2025 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265684; cv=none; b=KtkRBjGfglHOl/KL//Iqna/MH28WBSXynsITmVgsTCoLVMpTymHkw4b/1s50ot6w4psqMZHtIsMuGsFfRVc9LuITHsSwHCF0OQLbqsTPzItTQzHjrCFh1faa5McWBGnY21CyVWYjxvsWCUpVSWqdSXcI1yc5N0B6FKourftqY8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265684; c=relaxed/simple;
	bh=nmvju27kEL3rjgH7XfdyPwyl6WgZl50gxdJJMMXCt8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AMw2oFC9YPlcTWZbufUZ1mPVk/dIyT9lf23pwtwkqlXeVZ1YxKpcjF22vunuIQMPQCEEJ87Hs1LFxH4KTrBEDdMD5Q7jDs1QtQi9nZvlJHwAQ4zx64u213+xQtGIJP+gmVVXMEhQInTC2mNlXMwn1G3muj9f7gbSNrGlsMwFMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktfnEpU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C239C4CEED;
	Fri, 11 Jul 2025 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752265683;
	bh=nmvju27kEL3rjgH7XfdyPwyl6WgZl50gxdJJMMXCt8k=;
	h=Date:From:To:Cc:Subject:From;
	b=ktfnEpU6RVyYojDLhTLD3lbbiV6oSjMgzYH9ZV1eJhlDNDbi/h8Y4uwdgl78ho15B
	 a8dbFqLV7Nl+DLITzl8nV82JU39vFwmCflxuNQBxamtNBPG9dVTtc/cMMGO1Wq9rpo
	 2OYT0APHloFgSjTg+RZHsCrixEiUnVYSH6ZuFvaz1oj6jaGleX7SXR4H4Qt34dtyBP
	 dhD90aH/hqvfKYYHJPB154xl9syu4krFKwoukLJw35QGCBsIs562YjEAt3DFYTyMzs
	 B/pxw/7JMowXzYeUZLbFutuen2I83aoHxNlbWWdMXCrkSCn4GNACmAi43TSmG7CqS5
	 8Gu+SwZ33OeEQ==
Date: Fri, 11 Jul 2025 15:28:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [GIT PULL] PCI fixes for v6.16
Message-ID: <20250711202802.GA2304110@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-3

for you to fetch changes up to ba74278c638df7c333a970a265dfcc258e70807b:

  Revert "PCI: ecam: Allow cfg->priv to be pre-populated from the root port device" (2025-06-30 12:30:03 -0500)

----------------------------------------------------------------

- Track apple Root Ports explicitly and look up the driver data from the
  struct device instead of using dev->driver_data, which is used by
  pci_host_common_init() for the generic host bridge pointer (Marc Zyngier)

- Set dev->driver_data before pci_host_common_init() calls gen_pci_init()
  because some drivers need it to set up ECAM mappings; this fixes a
  regression on MicroChip MPFS Icicle (Geert Uytterhoeven)

- Revert the now-unnecessary use of ECAM pci_config_window.priv to store a
  copy of dev->driver_data (Marc Zyngier)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      PCI: host-generic: Set driver_data before calling gen_pci_init()

Marc Zyngier (2):
      PCI: apple: Add tracking of probed root ports
      Revert "PCI: ecam: Allow cfg->priv to be pre-populated from the root port device"

 drivers/pci/controller/pci-host-common.c |  4 +--
 drivers/pci/controller/pcie-apple.c      | 53 +++++++++++++++++++++++++++++---
 drivers/pci/ecam.c                       |  2 --
 3 files changed, 51 insertions(+), 8 deletions(-)

