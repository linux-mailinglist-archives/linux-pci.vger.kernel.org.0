Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C13AD3E1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 22:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhFRUvt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 16:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234095AbhFRUvs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 16:51:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B675560FE7;
        Fri, 18 Jun 2021 20:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624049379;
        bh=u2+9Z4JAqMRUNt7me/KmgIgu69/08XwgMNp8qC7JyeQ=;
        h=Date:From:To:Cc:Subject:From;
        b=FkKIjqh80xti/9RHdaPw9Sq35ftdhnYIl1NHIR15s83N6yAfFLgmtTT7I4W/+di4s
         3+jjRVRQ7XqjH6C0k4tu145CtgrK8AJFWJ23n0/SDIoNVcDwf6aDseUEzUK6HsTs7P
         OZgh5/b0WU5g1/ljj3+3pUGYsEzg/T8XshHwb3/4IG5La0LY5gd6AzstZLtqISHYtz
         2jr1tgU3XNIjqHowWWWdq61ZgaXDyx3ZUqMtNsLUIUBwYjo929hEan2sa4RIHlWpSv
         cTGdVZhPN36mvPntutl4ybjI88cHKqnuXu1Fg+GuwuaTbjJgNzFxqUxo1T5nirJIYY
         bbH1WNGpvoKGA==
Date:   Fri, 18 Jun 2021 15:49:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Qu Wenruo <wqu@suse.com>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Antti =?iso-8859-1?Q?J=E4rvinen?= <antti.jarvinen@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Chiqijun <chiqijun@huawei.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Mikel Rychliski <mikel@mikelr.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: [GIT PULL] PCI fixes for v5.13
Message-ID: <20210618204937.GA3216522@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.13-fixes-2

for you to fetch changes up to f18139966d072dab8e4398c95ce955a9742e04f7:

  PCI: aardvark: Fix kernel panic during PIO transfer (2021-06-18 10:32:35 -0500)


I rebased these this morning to add a tested-by.  The commits
themselves have all been in linux-next, though not for as long
as I'd like.

----------------------------------------------------------------
PCI fixes:

  - Clear 64-bit flag for host bridge windows below 4GB to fix a resource
    allocation regression added in -rc1 (Punit Agrawal)

  - Fix tegra194 MCFG quirk build regressions added in -rc1 (Jon Hunter)

  - Avoid secondary bus resets on TI KeyStone C667X devices (Antti
    Järvinen)

  - Avoid secondary bus resets on some NVIDIA GPUs (Shanker Donthineni)

  - Work around FLR erratum on Huawei Intelligent NIC VF (Chiqijun)

  - Avoid broken ATS on AMD Navi14 GPU (Evan Quan)

  - Trust Broadcom BCM57414 NIC to isolate functions even though it
    doesn't advertise ACS support (Sriharsha Basavapatna)

  - Work around AMD RS690 BIOSes that don't configure DMA above 4GB (Mikel
    Rychliski)

  - Fix panic during PIO transfer on Aardvark controller (Pali Rohár)

----------------------------------------------------------------
Antti Järvinen (1):
      PCI: Mark TI C667X to avoid bus reset

Chiqijun (1):
      PCI: Work around Huawei Intelligent NIC VF FLR erratum

Evan Quan (1):
      PCI: Mark AMD Navi14 GPU ATS as broken

Jon Hunter (1):
      PCI: tegra194: Fix MCFG quirk build regressions

Mikel Rychliski (1):
      PCI: Add AMD RS690 quirk to enable 64-bit DMA

Pali Rohár (1):
      PCI: aardvark: Fix kernel panic during PIO transfer

Punit Agrawal (1):
      PCI: of: Clear 64-bit flag for non-prefetchable memory below 4GB

Shanker Donthineni (1):
      PCI: Mark some NVIDIA GPUs to avoid bus reset

Sriharsha Basavapatna (1):
      PCI: Add ACS quirk for Broadcom BCM57414 NIC

 arch/x86/pci/fixup.c                            |  44 ++++++++
 drivers/pci/controller/dwc/Makefile             |   3 +-
 drivers/pci/controller/dwc/pcie-tegra194-acpi.c | 108 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c      | 138 ++++--------------------
 drivers/pci/controller/pci-aardvark.c           |  49 +++++++--
 drivers/pci/of.c                                |   2 +
 drivers/pci/quirks.c                            |  93 +++++++++++++++-
 7 files changed, 306 insertions(+), 131 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-tegra194-acpi.c
