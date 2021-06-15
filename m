Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA73A89B1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 21:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOToQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 15:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOToQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 15:44:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 060B261166;
        Tue, 15 Jun 2021 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623786131;
        bh=F7vbSprOP5Rudz4mCUZIL34WYECvKuqqAhRsSQFYsyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X8WBzy5JguRPGV3D65bv6IZ3C+Tud3fIsIiQVU4QjPBOn1VLl8NKFd4HoLJdIFqrz
         BpnR+DZV8X4/zBxMFDUPcbrmnFpDxe7O0JQuulOM3rcdsItfiRNGwFegFv9o7X5m5l
         wHpmJhNVC+OB24rFnFoJzxskveEXsAa9N9qk+StXgVwOEtjSekoF+rDGcke/IamgMN
         kr+bvlxXxcn4DfYW6lW5KBe05UjCQ6KV+67uWp6Nk7SNO7/doLJi+GNr/7iIN1PyVO
         cQaC4r+E94/3s7Ct0c+LCxWL8moqaNYAR/j6E2aNaPrfquUDn2hOJq7isvW/KER/bq
         wM8z+QIkprkag==
Date:   Tue, 15 Jun 2021 14:42:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh+dt@kernel.org,
        amurray@thegoodpenguin.co.uk, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        Thierry Reding <treding@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Query regarding the use of pcie-designware-plat.c file
Message-ID: <20210615194209.GA2908457@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2970bdf2-bef2-bdcb-6ee3-ac1181d97b78@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 09, 2021 at 05:54:38PM +0100, Jon Hunter wrote:
> 
> On 09/06/2021 17:30, Bjorn Helgaas wrote:
> > On Wed, Jun 09, 2021 at 12:52:37AM +0530, Vidya Sagar wrote:
> >> Hi,
> >> I would like to know what is the use of pcie-designware-plat.c file. This
> >> looks like a skeleton file and can't really work with any specific hardware
> >> as such.
> >> Some context for this mail thread is, if the config CONFIG_PCIE_DW_PLAT is
> >> enabled in a system where a Synopsys DesignWare IP based PCIe controller is
> >> present and its configuration is enabled (Ex:- Tegra194 system with
> >> CONFIG_PCIE_TEGRA194_HOST enabled), then, it can so happen that the probe of
> >> pcie-designware-plat.c called first (because all DWC based PCIe controller
> >> nodes have "snps,dw-pcie" compatibility string) and can crash the system.
> > 
> > What's the crash?  If a device claims to be compatible with
> > "snps,dw-pcie" and pcie-designware-plat.c claims to know how to
> > operate "snps,dw-pcie" devices, it seems like something is wrong.
> > 
> > "snps,dw-pcie" is a generic device type, so pcie-designware-plat.c
> > might not know how to operate device-specific details of some of those
> > devices, but basic functionality should work and it certainly
> > shouldn't crash.
> 
> It is not really a crash but a hang when trying to access the hardware
> before it has been properly initialised.

This doesn't really answer my question.

If the hardware claims to be compatible with "snps,dw-pcie" and a
driver knows how to operate "snps,dw-pcie" devices, it should work.

If the hardware requires initialization that is not part of the
"snps,dw-pcie" programming model, it should not claim to be compatible
with "snps,dw-pcie".  Or, if pcie-designware-plat.c is missing some
init that *is* part of the programming model, maybe it needs to be
enhanced?

> The scenario I saw was that if the Tegra194 PCIe driver was built as a
> module but the pcie-designware-plat.c was built into the kernel, then on
> boot we would attempt to probe the pcie-designware-plat.c driver because
> module was not available yet and this would hang. Hence, I removed the
> "snps,dw-pcie" compatible string for Tegra194 to avoid this and ONLY
> probe the Tegra194 PCIe driver.

Maybe something like driver_override (I know this is supported via
sysfs, but maybe not via a kernel parameter) or a module parameter for
pcie-designware-plat.c to keep it from claiming devices?

> Sagar is wondering why this hang is only seen/reported for Tegra and
> could this happen to other platforms? I think that is potentially could.

Maybe pcie-designware-plat.c works on other platforms, i.e., they
don't require the hardware init?
