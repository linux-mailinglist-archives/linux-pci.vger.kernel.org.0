Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B40383986
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbhEQQV0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 12:21:26 -0400
Received: from foss.arm.com ([217.140.110.172]:57448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344264AbhEQQT7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 12:19:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA309106F;
        Mon, 17 May 2021 09:18:42 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3923F3F73D;
        Mon, 17 May 2021 09:18:41 -0700 (PDT)
Date:   Mon, 17 May 2021 17:18:36 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: tegra: Fix host initialization during resume
Message-ID: <20210517161835.GA9796@lpieralisi>
References: <20210504172157.29712-1-vidyas@nvidia.com>
 <fecc2899-06ef-f91f-4a39-bb4ee664c800@nvidia.com>
 <7dbc7daf-5512-c938-3aee-3c1994b50d07@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dbc7daf-5512-c938-3aee-3c1994b50d07@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 03:11:00PM +0100, Jon Hunter wrote:
> Hi Lorenzo, Bjorn,
> 
> On 06/05/2021 09:49, Jon Hunter wrote:
> > 
> > On 04/05/2021 18:21, Vidya Sagar wrote:
> >> Commit 275e88b06a27 ("PCI: tegra: Fix host link initialization") broke
> >> host initialization during resume as it misses out calling the API
> >> dw_pcie_setup_rc() which is required for host and MSI initialization.
> >>
> >> Fixes: 275e88b06a27 ("PCI: tegra: Fix host link initialization")
> >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >> ---
> >>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> >> index 6fa216e52d14..4c3c0738f2e6 100644
> >> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> >> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> >> @@ -2214,6 +2214,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
> >>  		goto fail_host_init;
> >>  	}
> >>  
> >> +	dw_pcie_setup_rc(&pcie->pci.pp);
> >> +
> >>  	ret = tegra_pcie_dw_start_link(&pcie->pci);
> >>  	if (ret < 0)
> >>  		goto fail_host_init;
> >>
> > 
> > 
> > Thanks for fixing!
> > 
> > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > 
> > We should also mark this for stable so that this gets back-ported.
> 
> 
> Can we queue this as a fix for v5.13 and tag for stable?

We usually send fixes for -rc* when the patches they are fixing
were merged in the current cycle (ie merged for v5.13).

This is not the case so I shall send it for v5.14.

Lorenzo
