Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FCD3E002E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 13:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhHDL3z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 07:29:55 -0400
Received: from foss.arm.com ([217.140.110.172]:59542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237630AbhHDL3u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 07:29:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A3F813D5;
        Wed,  4 Aug 2021 04:29:37 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.38.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7084E3F719;
        Wed,  4 Aug 2021 04:29:35 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     thierry.reding@gmail.com, bhelgaas@google.com, vidyas@nvidia.com,
        kw@linux.com, Om Prakash Singh <omp@nvidia.com>,
        helgaas@kernel.org, jonathanh@nvidia.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com,
        linux-tegra@vger.kernel.org, kthota@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 0/5] Update pcie-tegra194 driver
Date:   Wed,  4 Aug 2021 12:29:28 +0100
Message-Id: <162807654994.14268.4256716042526607815.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210623100525.19944-1-omp@nvidia.com>
References: <20210623100525.19944-1-omp@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 23 Jun 2021 15:35:20 +0530, Om Prakash Singh wrote:
> Update pcie-tegra194 driver with bug fixing and cleanup
> 
> Changes from V2->V3
>   Updated subject line from "PCI: tegra:" to  "PCI: tegra194:"
> 
> Changes from V1->V2
>   PCI: tegra: Fix handling BME_CHGED event
> 	- Update variable naming
>   PCI: tegra: Fix MSI-X programming
> 	- No change
>   PCI: tegra: Disable interrupts before entering L2
> 	- Rephrase the commit message
>   PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
> 	- Update return value to -ENOTSUPP.
>   PCI: tegra: Cleanup unused code
> 	- No Change
> 
> [...]

Applied to pci/tegra194, thanks!

[1/5] PCI: tegra194: Fix handling BME_CHGED event
      https://git.kernel.org/lpieralisi/pci/c/ceb1412c1c
[2/5] PCI: tegra194: Fix MSI-X programming
      https://git.kernel.org/lpieralisi/pci/c/43537cf7e3
[3/5] PCI: tegra194: Disable interrupts before entering L2
      https://git.kernel.org/lpieralisi/pci/c/834c5cf2b5
[4/5] PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode
      https://git.kernel.org/lpieralisi/pci/c/de2bbf2b71
[5/5] PCI: tegra194: Cleanup unused code
      https://git.kernel.org/lpieralisi/pci/c/f62750e691

Thanks,
Lorenzo
