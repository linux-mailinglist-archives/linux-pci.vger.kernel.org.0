Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B814039E526
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 19:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGRUg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 13:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhFGRUg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 13:20:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41CE26105A;
        Mon,  7 Jun 2021 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623086324;
        bh=nIr1mQAIQFwHND4mpIGAK7vHdjVNdy/8Ggo14aQlSLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SLpq3M1cX8VG39nDxZAi1C7v3NnxvCQq+QwGFY8C5SplrnOILWQwQA777YbHJpx2F
         m5Kv9oRVF0rldOVwzFazfcchAZ/Fn879EJvQv0F6GmGMq2gjPRRwRsSomhKwJUps5Z
         Lbjd8Tt5dGhBszkqpzE/0lc9uFunviZSzsSIWjWDtwCST9Uq/qNJaBD3L9u1xYRPW+
         fQuSo0ghuvKF7d+5r3Hc/JIg7Nu6+mbAVbm1FyL50DWY+WB4q2nrN91Y9RwX3y09kS
         aSo0yikWk3WrFirmV41o4klH/7YIM/9bEt9vH5h30X37h+5vpMbkKyIvKZbl/pb1SP
         Oe14A8bmHuEhA==
Date:   Mon, 7 Jun 2021 12:18:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V3] PCI: tegra: Fix building Tegra194 PCIe driver
Message-ID: <20210607171842.GA2507565@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc6345fa-12a6-aee3-7fa1-1703bcffa6a5@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 07, 2021 at 04:50:34PM +0100, Jon Hunter wrote:
> Hi Bjorn, Lorenzo,
> 
> On 26/05/2021 13:33, Jon Hunter wrote:
> > Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
> > errata") caused a few build regressions for the Tegra194 PCIe driver
> > which are:
> > 
> > 1. The Tegra194 PCIe driver can no longer be built as a module. This
> >    was caused by removing the Makefile entry to build the pcie-tegra.c
> >    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
> >    so that we can build the driver as a module.
> > 2. 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
> >    errata") added "#ifdef CONFIG_PCIE_TEGRA194" around the native
> >    driver. But if we set CONFIG_PCIE_TEGRA194=m to build the driver as a
> >    module, autoconf.h contains "#define CONFIG_PCIE_TEGRA194_MODULE 1"
> >    (not "#define CONFIG_PCIE_TEGRA194 1"), so the #ifdef excludes the
> >    driver. Instead, use "IS_ENABLED(CONFIG_PCIE_TEGRA194)", which checks
> >    for either CONFIG_PCIE_TEGRA194 or CONFIG_PCIE_TEGRA194_MODULE.
> > 3. The below build warnings that are seen with particular kernel
> >    configurations. Fix these by moving these structure definitions to
> >    within the necessary guards.
> > 
> >   drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
> >   	‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
> >   drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
> >   	‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
> >   drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
> >   	‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]
> > 
> > Fixes: 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata")
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> 
> Any feedback on this? We need this for v5.13.

Thanks for the reminder, I'll take a look at this.  It looks like we
broke this in v5.13-rc1, so we should fix it before v5.13.
