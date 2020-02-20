Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5817C1661B1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 17:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgBTQBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 11:01:07 -0500
Received: from foss.arm.com ([217.140.110.172]:45498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgBTQBH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Feb 2020 11:01:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DA5C31B;
        Thu, 20 Feb 2020 08:01:06 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 418113F6CF;
        Thu, 20 Feb 2020 08:01:04 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:00:54 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, andrew.murray@arm.com,
        Tom Joseph <tjoseph@cadence.com>,
        Milind Parab <mparab@cadence.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, bhelgaas@google.com,
        thierry.reding@gmail.com, Jisheng.Zhang@synaptics.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 0/5] Add support to defer core initialization
Message-ID: <20200220160044.GA8859@e121166-lin.cambridge.arm.com>
References: <20200103100736.27627-1-vidyas@nvidia.com>
 <a8678df3-141b-51ab-b0cb-5e88c6ac91b5@nvidia.com>
 <680a58ec-5d09-3e3b-2fd6-544c32732818@nvidia.com>
 <ca911119-da45-4cbd-b173-2ac8397fd79a@ti.com>
 <b4af8353-3a56-fa31-3391-056050c0440a@ti.com>
 <7e8dafcd-bc3f-4acc-7023-85e24bebdd94@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e8dafcd-bc3f-4acc-7023-85e24bebdd94@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 19, 2020 at 07:06:47PM +0530, Vidya Sagar wrote:
> Hi Lorenzo, Andrew,
> Kishon did rebase [1] mentioned below and removed dependencies.
> New patch series is available
> @ http://patchwork.ozlabs.org/project/linux-pci/list/?series=158088
> 
> I rebased my patches on top of this and is available for review
> @ http://patchwork.ozlabs.org/project/linux-pci/list/?series=158959
> 
> Please let us know the way forward towards merging these patches.

Hi Vidya,

I shall have a look shortly, I have planned to start queueing patches
from next week.

Thanks,
Lorenzo

> Thanks,
> Vidya Sagar
> 
> On 2/5/2020 12:07 PM, Kishon Vijay Abraham I wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > +Tom, Milind
> > 
> > Hi,
> > 
> > On 23/01/20 3:25 PM, Kishon Vijay Abraham I wrote:
> > > Hi Vidya Sagar,
> > > 
> > > On 23/01/20 2:54 pm, Vidya Sagar wrote:
> > > > Hi Kishon,
> > > > Apologies for pinging again. Could you please review this series?
> > > > 
> > > > Thanks,
> > > > Vidya Sagar
> > > > 
> > > > On 1/11/2020 5:18 PM, Vidya Sagar wrote:
> > > > > Hi Kishon,
> > > > > Could you please review this series?
> > > > > 
> > > > > Also, this series depends on the following change of yours
> > > > > http://patchwork.ozlabs.org/patch/1109884/
> > > > > Whats the plan to get this merged?
> > > 
> > > I've posted the endpoint improvements as a separate series
> > > http://lore.kernel.org/r/20191231100331.6316-1-kishon@ti.com
> > > 
> > > I'd prefer this series gets tested by others. I'm also planning to test
> > > this series. Sorry for the delay. I'll test review and test this series
> > > early next week.
> > 
> > I tested this series with DRA7 configured in EP mode. So for the series
> > itself
> > 
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > 
> > Tom, Can you test this series in Cadence platform?
> > 
> > Lorenzo, Andrew,
> > 
> > How do you want to go about merging this series? This series depends on
> > [1] which in turn is dependent on two other series. If required, I can
> > rebase [1] on mainline kernel and remove it's dependencies with the
> > other series. That way this series and [1] could be merged. And the
> > other series could be worked later. Kindly let me know.
> > 
> > Thanks
> > Kishon
> > 
> > [1] ->
> > https://lore.kernel.org/linux-pci/20191231100331.6316-1-kishon@ti.com/
> > > 
> > > Thanks
> > > Kishon
> > > 
> > > > > 
> > > > > Thanks,
> > > > > Vidya Sagar
> > > > > 
> > > > > On 1/3/20 3:37 PM, Vidya Sagar wrote:
> > > > > > EPC/DesignWare core endpoint subsystems assume that the core
> > > > > > registers are
> > > > > > available always for SW to initialize. But, that may not be the case
> > > > > > always.
> > > > > > For example, Tegra194 hardware has the core running on a clock that
> > > > > > is derived
> > > > > > from reference clock that is coming into the endpoint system from host.
> > > > > > Hence core is made available asynchronously based on when host system
> > > > > > is going
> > > > > > for enumeration of devices. To accommodate this kind of hardwares,
> > > > > > support is
> > > > > > required to defer the core initialization until the respective
> > > > > > platform driver
> > > > > > informs the EPC/DWC endpoint sub-systems that the core is indeed
> > > > > > available for
> > > > > > initiaization. This patch series is attempting to add precisely that.
> > > > > > This series is based on Kishon's patch that adds notification mechanism
> > > > > > support from EPC to EPF @ http://patchwork.ozlabs.org/patch/1109884/
> > > > > > 
> > > > > > Vidya Sagar (5):
> > > > > >     PCI: endpoint: Add core init notifying feature
> > > > > >     PCI: dwc: Refactor core initialization code for EP mode
> > > > > >     PCI: endpoint: Add notification for core init completion
> > > > > >     PCI: dwc: Add API to notify core initialization completion
> > > > > >     PCI: pci-epf-test: Add support to defer core initialization
> > > > > > 
> > > > > >    .../pci/controller/dwc/pcie-designware-ep.c   |  79 +++++++-----
> > > > > >    drivers/pci/controller/dwc/pcie-designware.h  |  11 ++
> > > > > >    drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++------
> > > > > >    drivers/pci/endpoint/pci-epc-core.c           |  19 ++-
> > > > > >    include/linux/pci-epc.h                       |   2 +
> > > > > >    include/linux/pci-epf.h                       |   5 +
> > > > > >    6 files changed, 164 insertions(+), 70 deletions(-)
> > > > > > 
