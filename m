Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35C3313965
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 17:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhBHQ1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 11:27:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234304AbhBHQ1e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Feb 2021 11:27:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69C8164E8A;
        Mon,  8 Feb 2021 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612801614;
        bh=upuD7jLgilWsLkH/ZlfS+wK9Gj1LxuD4y1rjKeF8k6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MXwj3J3jafPAZEF3GcdlgLAWuHrHTI3mWiqFr8zJHpGgQXFqL+Ob7hXqgBJmdPxRb
         ArVKSBca6OuoSvDrteHkzzecP4Iy4+vS+q6kEhT67L+ii9y2XoE8T7efw7deT7E4NX
         ldEeZVxuR/aGpR6zz1xx2eYZDnMwF4CoNaMAuJcGEYgd1kdMaDYCNGc7cwS+zJVba8
         zKD+/SLhkHtxO3bHhAt4QEPsO208Z7EMc4mhE92IPPEEPWDwI30GSmKInYhelyZgKN
         avphQBvSPCnlDkQhbq7FQcAdhfiEw/1TrI/0O2sgvdmfaaC1pmz9/Z/5kDZ/a+wqOC
         zfH02vtbIfPhg==
Date:   Mon, 8 Feb 2021 10:26:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: New Defects reported by Coverity Scan for Linux
Message-ID: <20210208162651.GA392069@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6020c2368a549_2dfbcf2b02da5acf501000c7@prd-scan-dashboard-0.mail>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FYI

On Mon, Feb 08, 2021 at 04:46:46AM +0000, scan-admin@coverity.com wrote:
> 3 new defect(s) introduced to Linux found with Coverity Scan.
> ...

> *** CID 1472841:  Error handling issues  (CHECKED_RETURN)
> /drivers/pci/controller/dwc/pci-exynos.c: 263 in exynos_pcie_host_init()
> 257     
> 258     	pp->bridge->ops = &exynos_pci_ops;
> 259     
> 260     	exynos_pcie_assert_core_reset(ep);
> 261     
> 262     	phy_reset(ep->phy);
> >>>     CID 1472841:  Error handling issues  (CHECKED_RETURN)
> >>>     Calling "phy_power_on" without checking return value (as is done elsewhere 40 out of 50 times).
> 263     	phy_power_on(ep->phy);
> 264     	phy_init(ep->phy);
> 265     
> 266     	exynos_pcie_deassert_core_reset(ep);
> 267     	exynos_pcie_enable_irq_pulse(ep);
> 268     
