Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7498E2BA724
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 11:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgKTKLx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 05:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgKTKLx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 05:11:53 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307AF22272;
        Fri, 20 Nov 2020 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605867112;
        bh=oRF6mylMSIwIrnp3jROSzpmjuKuj4N8/pJejw/abE4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUGzQTO74JOY2cw/14EwGbV2iYSx5Xwk+O53czUoG/H6OmbX5fWBz3ZfJz/0z4OSX
         jOKBuQRIINCJlDvmDzkyA+LqABBA45Nws6GL3sbonDoJyyU4/F7FuGIQdcwmbWcA2K
         WrNo68KxOxOnzV4b2vpLaMoro9vhVSu+0iZtVxe8=
Date:   Fri, 20 Nov 2020 15:41:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4 4/5] phy: samsung: phy-exynos-pcie: rework driver to
 support Exynos5433 PCIe PHY
Message-ID: <20201120101138.GI2925@vkoul-mobl>
References: <20201113170139.29956-1-m.szyprowski@samsung.com>
 <CGME20201113170158eucas1p14b9e58e35f929e14aeb4f533071c8a47@eucas1p1.samsung.com>
 <20201113170139.29956-5-m.szyprowski@samsung.com>
 <20201120094152.GC2925@vkoul-mobl>
 <8eaebd62-345f-4d13-1b65-055a2acc68bd@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eaebd62-345f-4d13-1b65-055a2acc68bd@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-11-20, 10:58, Marek Szyprowski wrote:
> Hi Vinod,
> 
> On 20.11.2020 10:41, Vinod Koul wrote:
> > On 13-11-20, 18:01, Marek Szyprowski wrote:
> >> From: Jaehoon Chung <jh80.chung@samsung.com>
> >>
> >> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> >> dts: exynos: Remove Exynos5440"). Rework this driver to support PCIe PHY
> >> variant found in the Exynos5433 SoCs.
> > I am expecting this series to go thru PCI tree, so:
> >
> > Acked-By: Vinod Koul <vkoul@kernel.org>
> 
> Frankly, the PHY driver can also go via PHY tree without causing any 
> issue. The old driver is not used at all, so there is no runtime 
> dependency. This will help avoiding the merge conflict: yesterday I've 
> noticed that this patch conflicts with the commit 2f0c9fac3be6 ("phy: 
> samsung: convert to devm_platform_ioremap_resource") in phy-next. The 
> resolution is simple (use all the code from the new driver), but if 
> needed I can resend the PHY driver after a rebase onto the current next 
> tree.

Okay do send me the rebase patch

Thanks
-- 
~Vinod
