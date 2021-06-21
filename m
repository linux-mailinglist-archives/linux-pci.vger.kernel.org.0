Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D88C3AF51B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhFUScu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 14:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhFUScu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 14:32:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0B0A6109F;
        Mon, 21 Jun 2021 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624300235;
        bh=7dNAcBaBB3r3f56b8noXX9KANJx89Luv9hz3RFrfo8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fJIgmzYL+E+F2mQOyhtGpctz9YKHx/aAG/J/6pbwRIHjqtTqsTt4oIdgn9BkHl21Z
         Ss3gz4NUOuYaYYYSRSNLn6DxQZIYU8ajzi3pJ1wBn+njHoykHPfl8E6pC0TiV3LdTH
         X/nCEcBFm0FBQgL38pXpvdQ8xTdymDPTnEhLQccuZWk6vHP8nZJJzxwgbTp6sdIjOe
         u+ClYAtq7z6Ly0jO8X6P+R6eImkbWDZwmIKllhQBU+2hyWSP4hIQOtJBj0Huzepwgk
         oHAdHrLtuUrBVg8qE7jHvkfPdPYhH2wrdIFk0O6iJGQWl8XNbTrp7KVLgpgIZsxx0G
         oPuea9leudQZw==
Date:   Mon, 21 Jun 2021 13:30:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Om Prakash Singh <omp@nvidia.com>
Cc:     kw@linux.com, vidyas@nvidia.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com
Subject: Re: [PATCH V2 0/5] Update pcie-tegra194 driver
Message-ID: <20210621183033.GA3290720@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606082204.14222-1-omp@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 06, 2021 at 01:51:59PM +0530, Om Prakash Singh wrote:
> Update pcie-tegra194 driver with bug fixing and cleanup
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
> V1:
> http://patchwork.ozlabs.org/project/linux-pci/patch/20210527115246.20509-2-omp@nvidia.com/
> 
> Om Prakash Singh (5):
>   PCI: tegra: Fix handling BME_CHGED event
>   PCI: tegra: Fix MSI-X programming
>   PCI: tegra: Disable interrupts before entering L2
>   PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
>   PCI: tegra: Cleanup unused code

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

But please update the subject lines to be:

  PCI: tegra194: ...

to differentiate this driver from drivers/pci/controller/pci-tegra.c.
In the past we've used the "PCI: tegra:" prefix for both, but that's
confusing.

I think Lorenzo will take care of this series, but he's been away for
a week or so and will take a bit to catch up.

>  drivers/pci/controller/dwc/pcie-tegra194.c | 36 +++++++++++++---------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> -- 
> 2.17.1
> 
