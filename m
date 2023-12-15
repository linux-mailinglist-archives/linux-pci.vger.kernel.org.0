Return-Path: <linux-pci+bounces-1076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919128151AA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 22:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBD0286838
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 21:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212BF47F5E;
	Fri, 15 Dec 2023 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQsJlxhp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEAE495E7;
	Fri, 15 Dec 2023 21:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1B5C433C7;
	Fri, 15 Dec 2023 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702674678;
	bh=Pz52bZEiMprhIzxQzx7OqDCYrqRjBlVKFlQrM+jTYv0=;
	h=Date:From:To:Cc:Subject:From;
	b=ZQsJlxhp+zwITeFPYwXsDVQhF9yaGKhCx2bfckBmAnXzcR/34DYJjznCqQaKWjpfL
	 lnO+LjEGlbBdJF8bJ9DtT8wGgKyhAQVBf4sO2NCgjCSQe6Esd7rvfB56BZiptAG8YJ
	 InQVUUJSGuXfxgeFnGpPAkyLysxTBRrZaO2mKicZNUYnNXPgiK5ehQQEmFnVdZclBv
	 IYTMXezynPTiSmFPLoenuHvDVQaZhnAjpTHqeKVQzJ/5TXreOot4ihufrw6w8SCVVM
	 I/1Z3qZpVnPJwcukaFAq0rXeAUjn2kZhMriVOWEbV4rFIu6OWS57DAAgiWrevCXCwn
	 i81bCurFrZTFw==
Date: Fri, 15 Dec 2023 15:11:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Igor Mammedov <imammedo@redhat.com>,
	Fiona Ebner <f.ebner@proxmox.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Jonathan Woithe <jwoithe@just42.net>
Subject: [GIT PULL] PCI fixes for v6.7
Message-ID: <20231215211115.GA1141361@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.7-fixes-1

for you to fetch changes up to 5df12742b7e3aae2594a30a9d14d5d6e9e7699f4:

  Revert "PCI: acpiphp: Reassign resources on bridge if necessary" (2023-12-15 14:55:10 -0600)

----------------------------------------------------------------
- Limit Max_Read_Request_Size (MRRS) on some MIPS Loongson systems because
  they don't all support MRRS > 256, and firmware doesn't always initialize
  it correctly, which meant some PCIe devices didn't work (Jiaxun Yang)

- Add and use pci_enable_link_state_locked() to prevent potential deadlocks
  in vmd and qcom drivers (Johan Hovold)

- Revert recent (v6.5) acpiphp resource assignment changes that fixed
  issues with hot-adding devices on a root bus or with large BARs, but
  introduced new issues with GPU initialization and hot-adding SCSI disks
  in QEMU VMs and (Bjorn Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

Jiaxun Yang (1):
      PCI: loongson: Limit MRRS to 256

Johan Hovold (6):
      PCI/ASPM: Add pci_enable_link_state_locked()
      PCI: vmd: Fix potential deadlock when enabling ASPM
      PCI: qcom: Fix potential deadlock when enabling ASPM
      PCI: qcom: Clean up ASPM comment
      PCI/ASPM: Clean up __pci_disable_link_state() 'sem' parameter
      PCI/ASPM: Add pci_disable_link_state_locked() lockdep assert

 drivers/pci/controller/dwc/pcie-qcom.c |  7 ++--
 drivers/pci/controller/pci-loongson.c  | 46 +++++++++++++++++++++---
 drivers/pci/controller/vmd.c           |  2 +-
 drivers/pci/hotplug/acpiphp_glue.c     |  9 ++---
 drivers/pci/pcie/aspm.c                | 65 ++++++++++++++++++++++++----------
 include/linux/pci.h                    |  3 ++
 6 files changed, 100 insertions(+), 32 deletions(-)

