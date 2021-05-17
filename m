Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C6B383A59
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbhEQQs5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 12:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235874AbhEQQsw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 12:48:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 133D161028;
        Mon, 17 May 2021 16:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621270055;
        bh=X9VzPoSNITbIIcT8AyahccEJh1UTsUwx2wk0Kx+CyBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K3uFebAz0W8lwnYqM/Y2y41M0PQGFireBX6NU8tjYjmIFmAX0exRgntZg2Ca1yYQm
         ebHLqk/wtH7eFVKLr/00j4kY9lShwmdvxZ++KM61nSXyD39vUTGECNQTYo9GAVKSBB
         shmqvqipq6UPOOepgXLFWxG8yJC061X0Wo93l6/PXfYqoVDnbWDLNbYcot3ierqmSo
         XaQRVibSXXk64ne90pgumZJ/BIwPhVjuPijR3n3O+DpcDV22FtoaQgeAT3hB/lFaLe
         ryJ4tjMVAHwra4bS7rnZlABEAtkZrPUki5X+U0v1M+iieyqUmZn6XWE9JRsEPPwqts
         fITJeFytpcEGg==
Date:   Mon, 17 May 2021 11:47:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
        robh@kernel.org, bhelgaas@google.com, thierry.reding@gmail.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: tegra: Fix host initialization during resume
Message-ID: <20210517164733.GA22939@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517161835.GA9796@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 05:18:36PM +0100, Lorenzo Pieralisi wrote:
> On Mon, May 17, 2021 at 03:11:00PM +0100, Jon Hunter wrote:
> > Hi Lorenzo, Bjorn,
> > 
> > On 06/05/2021 09:49, Jon Hunter wrote:
> > > 
> > > On 04/05/2021 18:21, Vidya Sagar wrote:
> > >> Commit 275e88b06a27 ("PCI: tegra: Fix host link initialization") broke
> > >> host initialization during resume as it misses out calling the API
> > >> dw_pcie_setup_rc() which is required for host and MSI initialization.
> > >>
> > >> Fixes: 275e88b06a27 ("PCI: tegra: Fix host link initialization")
> > >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > >> ---
> > >>  drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > >> index 6fa216e52d14..4c3c0738f2e6 100644
> > >> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > >> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > >> @@ -2214,6 +2214,8 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
> > >>  		goto fail_host_init;
> > >>  	}
> > >>  
> > >> +	dw_pcie_setup_rc(&pcie->pci.pp);
> > >> +
> > >>  	ret = tegra_pcie_dw_start_link(&pcie->pci);
> > >>  	if (ret < 0)
> > >>  		goto fail_host_init;
> > > 
> > > Thanks for fixing!
> > > 
> > > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > > 
> > > We should also mark this for stable so that this gets back-ported.
> > 
> > Can we queue this as a fix for v5.13 and tag for stable?
> 
> We usually send fixes for -rc* when the patches they are fixing
> were merged in the current cycle (ie merged for v5.13).

Looks like this has been broken since v5.11-rc1 (December 27, 2020),
when 275e88b06a27 was merged.  Probably would be worth an occasional
boot test to make sure things stay working.

> This is not the case so I shall send it for v5.14.
> 
> Lorenzo
