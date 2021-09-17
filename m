Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2ED40FC15
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbhIQPVe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 11:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241474AbhIQPUG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Sep 2021 11:20:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBC08611F2;
        Fri, 17 Sep 2021 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631891924;
        bh=PZIlRARynL4Z5ygeF1kzNhS47sHsh3d+I4skXXzHP7M=;
        h=Date:From:To:Cc:Subject:From;
        b=l7t7BNH9HwYaEvZw0oJ1vPtNqXyFCbI9OuQbRcwN8swq94h+uIkfrnyN7PvFtjk5f
         xCmNTIprPjD6HIuA/O8KviU0O5FLStuvdVmOF/mQoug7UtdnALpMmKOi+AVgm5PiyO
         224p5g7O7v6w0lMwChaPuth0D80JhKwcDhtxiyComwDL4fvSu7tnK0YPaCgsSyCe5I
         n79Afjxq8N1aRPE7mu/YJVXa5vce23TWSln2pzKK4vS72vZGEAaKmHE0vmk76Jmv1I
         NTvckExnxre96hHutweqwfdaSvZbqR98VoEfHLsjQDh8JI+JWbYW8YnUvNzWqmTfp/
         0vnfe7rZPBYEA==
Date:   Fri, 17 Sep 2021 10:18:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@linux.dev>,
        Dave Jones <davej@codemonkey.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: [GIT PULL] PCI fixes for v5.15
Message-ID: <20210917151842.GA1716604@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.15-fixes-1

for you to fetch changes up to e042a4533fc346a655de7f1b8ac1fa01a2ed96e5:

  MAINTAINERS: Add Nirmal Patel as VMD maintainer (2021-09-15 16:44:03 -0500)

----------------------------------------------------------------
PCI fixes:

  - Defer VPD sizing until we actually need the contents; fixes a
    boot-time slowdown reported by Dave Jones (Bjorn Helgaas)

  - Stop clobbering OF fwnodes when we look for an ACPI fwnode; fixes
    a virtio-iommu boot regression (Jean-Philippe Brucker)

  - Add AMD GPU multi-function power dependencies; fixes runtime power
    management, including GPU resume and temp and fan sensor issues
    (Evan Quan)

  - Update VMD maintainer to Nirmal Patel (Jon Derrick)

----------------------------------------------------------------
Bjorn Helgaas (1):
      PCI/VPD: Defer VPD sizing until first access

Evan Quan (1):
      PCI: Add AMD GPU multi-function power dependencies

Jean-Philippe Brucker (1):
      PCI/ACPI: Don't reset a fwnode set by OF

Jon Derrick (1):
      MAINTAINERS: Add Nirmal Patel as VMD maintainer

 MAINTAINERS            |  3 ++-
 drivers/pci/pci-acpi.c |  2 +-
 drivers/pci/quirks.c   |  9 +++++++--
 drivers/pci/vpd.c      | 36 ++++++++++++++++++++++++++----------
 4 files changed, 36 insertions(+), 14 deletions(-)
