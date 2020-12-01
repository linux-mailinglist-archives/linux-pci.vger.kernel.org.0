Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359322CA17B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 12:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgLALfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 06:35:10 -0500
Received: from foss.arm.com ([217.140.110.172]:41146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgLALfK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Dec 2020 06:35:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F14A6101E;
        Tue,  1 Dec 2020 03:34:24 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D74EE3F718;
        Tue,  1 Dec 2020 03:34:23 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:34:12 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: linux-next: Tree for Nov 30
 (drivers/pci/controller/dwc/pcie-designware-host.c)
Message-ID: <20201201113412.GA2389@e121166-lin.cambridge.arm.com>
References: <20201130193626.1c408e47@canb.auug.org.au>
 <bc0f6da9-6dd4-c1ad-f2f3-dc1a5cd6a51b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc0f6da9-6dd4-c1ad-f2f3-dc1a5cd6a51b@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 08:44:55PM -0800, Randy Dunlap wrote:
> On 11/30/20 12:36 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20201127:
> > 
> 
> on x86_64:
> 
> WARNING: unmet direct dependencies detected for PCIE_DW_HOST
>   Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>   Selected by [y]:
>   - PCI_EXYNOS [=y] && PCI [=y] && (ARCH_EXYNOS || COMPILE_TEST [=y])


[...]

> caused by:
> commit f0a6743028f938cdd34e0c3249d3f0e6bfa04073
> Author: Jaehoon Chung <jh80.chung@samsung.com>
> Date:   Fri Nov 13 18:01:39 2020 +0100
> 
>     PCI: dwc: exynos: Rework the driver to support Exynos5433 varian
> 
> 
> which removed "depends on PCI_MSI_IRQ_DOMAIN from config PCI_EXYNOS.

Fixed up and squashed in the original commit - we should probably rework
the DWC driver dependencies on PCI_MSI_IRQ_DOMAIN to really fix it, for
the time being this should do.

Thanks,
Lorenzo
