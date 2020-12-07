Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2D52D16B2
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgLGQps (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 11:45:48 -0500
Received: from foss.arm.com ([217.140.110.172]:55404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLGQps (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 11:45:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20C56101E;
        Mon,  7 Dec 2020 08:45:02 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.35.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17ECE3F68F;
        Mon,  7 Dec 2020 08:44:59 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     robh+dt@kernel.org, dinghao.liu@zju.edu.cn, bhelgaas@google.com,
        thierry.reding@gmail.com, amanharitsh123@gmail.com,
        Vidya Sagar <vidyas@nvidia.com>, jonathanh@nvidia.com,
        kw@linux.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, sagar.tv@gmail.com,
        kthota@nvidia.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH V5 0/5] Enhancements to Tegra194 PCIe driver
Date:   Mon,  7 Dec 2020 16:44:55 +0000
Message-Id: <160735947003.21087.14076950970582278435.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201203133451.17716-1-vidyas@nvidia.com>
References: <20201203133451.17716-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 3 Dec 2020 19:04:46 +0530, Vidya Sagar wrote:
> This series of patches do some enhancements and some bug fixes to the
> Tegra194 PCIe platform driver like
> - Fix Vendor-ID corruption
> - Update DWC IP version
> - Continue with uninitialization sequence even if parts fail
> - Check return value of tegra_pcie_init_controller()
> - Disable LTSSM during link's L2 entry
> 
> [...]

Applied to pci/dwc, thanks!

[1/5] PCI: tegra: Fix ASPM-L1SS advertisement disable code
      https://git.kernel.org/lpieralisi/pci/c/6b6fafc1ab
[2/5] PCI: tegra: Set DesignWare IP version
      https://git.kernel.org/lpieralisi/pci/c/01254b6d6b
[3/5] PCI: tegra: Continue unconfig sequence even if parts fail
      https://git.kernel.org/lpieralisi/pci/c/b8f0d67149
[4/5] PCI: tegra: Check return value of tegra_pcie_init_controller()
      https://git.kernel.org/lpieralisi/pci/c/3d710af75b
[5/5] PCI: tegra: Disable LTSSM during L2 entry
      https://git.kernel.org/lpieralisi/pci/c/cf68e3b7a6

Thanks,
Lorenzo
