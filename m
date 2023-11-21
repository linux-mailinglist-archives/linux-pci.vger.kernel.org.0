Return-Path: <linux-pci+bounces-53-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BCD7F360E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D6A281FB9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FBEA2D;
	Tue, 21 Nov 2023 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pikMlQn3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629A5101F
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 18:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0859FC433C7;
	Tue, 21 Nov 2023 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700591810;
	bh=iUIz/SwdoSJeQb7e6Gxw95AuLdR6o8t7aa9vIVBVcl8=;
	h=From:To:Cc:Subject:Date:From;
	b=pikMlQn3Oj8RTANE4jzV/LDOk/isKXa2rIbLdcmxJsx1Fd84N6Hs23H/1PtdFQFa8
	 jgm2HYGPtOPCohu0G0EcSrk+wmjSoKhI2SSZSlLwYUgAFbq5s3uVlQ6Fb94yZuKjEn
	 ctjlmkItYi2GuBXgRx9B9PlNgdUGVh8kVnGAx7nBQJ4+Ise7fvComSyuG5Ipfir0AF
	 C/WCfYG1QbW5bVVM7sOv8HHqfd23Mqbjx/NmZgX3a+9g9j4sHZcOQ2r8uaGVSF/p8g
	 ZuUIX8EX1iErDf3MtAH6CGVW/d5mZ5M02Xoa24W59Zd9SIB12WzOOQKDa/nSXJl59V
	 PnK80iVt2d6Cg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Yunying Sun <yunying.sun@intel.com>,
	Tomasz Pala <gotar@polanet.pl>,
	Sebastian Manciulea <manciuleas@protonmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/9] x86/pci: Work around lack of ECAM space reservation
Date: Tue, 21 Nov 2023 12:36:34 -0600
Message-Id: <20231121183643.249006-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The ECAM space described in the ACPI MCFG table should be reserved via a
PNP0C02 _CRS method, per PCI Firmware spec (r3.3, sec 4.1.2).

Some platforms (at least Supermicro X9DRi-LN4+, HP Proliant ML30 Gen9) do
not include these PNP0C02 reservations, and at the same time, they *do*
include that space in the PNP0A03 host bridge windows, which makes it
available for assignment to PCI devices.

In this case, we treat the ECAM space as valid (after fd3a8cff4d4a
("x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space")), but
there was no actual reservation to prevent assignment to PCI devices.

This series adds that reservation to prevent assigning ECAM space to PCI
BARs, adds more debug logging, changes "MMCONFIG" to "ECAM" to match the
spec terminology, and cleans up some coding style.

I propose to merge this via the PCI tree for v6.8.

Bjorn Helgaas (9):
  x86/pci: Reserve ECAM if BIOS didn't include it in PNP0C02 _CRS
  x86/pci: Reword ECAM EfiMemoryMappedIO logging to avoid 'reserved'
  x86/pci: Add MCFG debug logging
  x86/pci: Rename 'MMCONFIG' to 'ECAM', use pr_fmt
  x86/pci: Rename acpi_mcfg_check_entry() to acpi_mcfg_valid_entry()
  x86/pci: Rename pci_mmcfg_check_reserved() to pci_mmcfg_reserved()
  x86/pci: Comment pci_mmconfig_insert() obscure MCFG dependency
  x86/pci: Return pci_mmconfig_add() failure early
  x86/pci: Reorder pci_mmcfg_arch_map() definition before calls

 arch/x86/pci/acpi.c            |   3 +
 arch/x86/pci/mmconfig-shared.c | 178 ++++++++++++++++++---------------
 arch/x86/pci/mmconfig_32.c     |   2 +-
 arch/x86/pci/mmconfig_64.c     |  42 ++++----
 4 files changed, 120 insertions(+), 105 deletions(-)

-- 
2.34.1


