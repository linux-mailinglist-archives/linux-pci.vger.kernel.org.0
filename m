Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB71779D4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 16:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgCCPCS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 10:02:18 -0500
Received: from foss.arm.com ([217.140.110.172]:48366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgCCPCS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 10:02:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49A8AFEC;
        Tue,  3 Mar 2020 07:02:17 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DE6E3F6C4;
        Tue,  3 Mar 2020 07:02:15 -0800 (PST)
Date:   Tue, 3 Mar 2020 15:02:09 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        robh+dt@kernel.org, jonathanh@nvidia.com, andrew.murray@arm.com,
        kishon@ti.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 0/5] Add support for PCIe endpoint mode in Tegra194
Message-ID: <20200303150209.GA6334@e121166-lin.cambridge.arm.com>
References: <20200303105418.2840-1-vidyas@nvidia.com>
 <20200303134053.GC2854899@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303134053.GC2854899@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 03, 2020 at 02:40:53PM +0100, Thierry Reding wrote:
> On Tue, Mar 03, 2020 at 04:24:13PM +0530, Vidya Sagar wrote:
> > Tegra194 has three (C0, C4 & C5) dual mode PCIe controllers that can operate
> > either in root port mode or in end point mode but only in one mode at a time.
> > Platform P2972-0000 supports enabling endpoint mode for C5 controller. This
> > patch series adds support for PCIe endpoint mode in both the driver as well as
> > in DT.
> > This patch series depends on the changes made for Synopsys DesignWare endpoint
> > mode subsystem that are recently accepted.
> > @ https://patchwork.kernel.org/project/linux-pci/list/?series=202211
> > which in turn depends on the patch made by Kishon
> > @ https://patchwork.kernel.org/patch/10975123/
> > which is also under review.
> > 
> > V4:
> > * Started using threaded irqs instead of kthreads
> > 
> > V3:
> > * Re-ordered patches in the series to make the driver change as the last patch
> > * Took care of Thierry's review comments
> > 
> > V2:
> > * Addressed Thierry & Bjorn's review comments
> > * Added EP mode specific binding documentation to already existing binding documentation file
> > * Removed patch that enables GPIO controller nodes explicitly as they are enabled already
> > 
> > Vidya Sagar (5):
> >   soc/tegra: bpmp: Update ABI header
> >   dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
> >   arm64: tegra: Add PCIe endpoint controllers nodes for Tegra194
> >   arm64: tegra: Add support for PCIe endpoint mode in P2972-0000
> >     platform
> >   PCI: tegra: Add support for PCIe endpoint mode in Tegra194
> 
> Hi Lorenzo,
> 
> I've acked patches 1, 2 and 5 of the series. I think you're going to
> need to apply patch 1 in order to satisfy a build-time dependency from
> patch 5. I can apply patches 3 and 4 to the Tegra tree since they're
> only adding device tree content that may conflict with some other
> patches that I have in the Tegra tree.
> 
> Does that sound reasonable?

Sure, that's absolutely fine by me, I will do.

Thanks,
Lorenzo
