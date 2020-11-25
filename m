Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F12C48BE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 20:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgKYTwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 14:52:00 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6588 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgKYTv7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 14:51:59 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbeb5df0000>; Wed, 25 Nov 2020 11:51:59 -0800
Received: from [10.40.102.42] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Nov
 2020 19:51:49 +0000
Subject: Re: [PATCH V4 0/6] Enhancements to Tegra194 PCIe driver
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "amanharitsh123@gmail.com" <amanharitsh123@gmail.com>,
        "dinghao.liu@zju.edu.cn" <dinghao.liu@zju.edu.cn>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20201109171937.28326-1-vidyas@nvidia.com>
 <20201125175709.GA1274379@ulmo>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <9291ac83-0f14-88df-8c1d-81f57b0340ee@nvidia.com>
Date:   Thu, 26 Nov 2020 01:21:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201125175709.GA1274379@ulmo>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606333919; bh=ixWL4EOpRfrPXrl40i6mo64j5n1lhFO+bCWPBDJNeeU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=pmEC6EgDjCofHhpuGtafbXCwe6Ss2k4V/ttvQToLcL3wk980NxI624heshHU4xMAp
         5gaptxmoscfZ5zd+IvLdXzDX5vkbTLH7qVqKmw+NayvPSjrpn9Cu67OMHgd7CO7vpc
         popvRMQQQofZ9MTKrYNJmbuvCUY1syQuH9Dr6aN+CftRgncL3sJ+OXSALk/N2YClCq
         YtveQ5R5aNpR8aHC8RQvWgGgdSCKP215DDcfGgpJjbS+FnZdOaVY28LRuxGn87/DNf
         fksCCQtrzI0HAfUrC8/AgqRW2VFoegNNnMSlKy/KzI5JUKUPTxQt1gXaxdlsTVl/9d
         fXMuM3ZV9LG2A==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Wednesday, November 25, 2020 11:27 PM
> To: Vidya Sagar <vidyas@nvidia.com>
> Cc: lorenzo.pieralisi@arm.com; robh+dt@kernel.org; bhelgaas@google.com;
> Jonathan Hunter <jonathanh@nvidia.com>; amanharitsh123@gmail.com;
> dinghao.liu@zju.edu.cn; kw@linux.com; linux-pci@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Krishna Thota
> <kthota@nvidia.com>; Manikanta Maddireddy <mmaddireddy@nvidia.com>;
> sagar.tv@gmail.com
> Subject: Re: [PATCH V4 0/6] Enhancements to Tegra194 PCIe driver
> 
> On Mon, Nov 09, 2020 at 10:49:31PM +0530, Vidya Sagar wrote:
> > This series of patches do some enhancements and some bug fixes to the
> > Tegra194 PCIe platform driver like
> > - Fix Vendor-ID corruption
> > - Map DBI space correctly
> > - Update DWC IP version
> > - Continue with uninitialization sequence even if parts fail
> > - Check return value of tegra_pcie_init_controller()
> >
> > V4:
> > * Added a new patch to address link-up issues with some of the cards
> >
> > V3:
> > * Addressed Bjorn's review comments
> > * Split earlier patch-4 into two
> >   - Continue with the uninitialization sequence even if some parts fail
> >   - Check return value of tegra_pcie_init_controller() and exit
> > accordingly
> >
> > V2:
> > * Addressed Rob's comments. Changed 'Strongly Ordered' to 'nGnRnE'
> >
> > Vidya Sagar (6):
> >   PCI: tegra: Fix ASPM-L1SS advertisement disable code
> >   PCI: tegra: Map configuration space as nGnRnE
> >   PCI: tegra: Set DesignWare IP version
> >   PCI: tegra: Continue unconfig sequence even if parts fail
> >   PCI: tegra: Check return value of tegra_pcie_init_controller()
> >   PCI: tegra: Disable LTSSM during L2 entry
> >
> >  drivers/pci/controller/dwc/pcie-tegra194.c | 78
> > +++++++++++-----------
> >  1 file changed, 39 insertions(+), 39 deletions(-)
> 
> I was going to test this series, but then I noticed that PCI is causing a crash on
> linux-next (as of fairly recently).
I root caused the crash issue to the following commit
a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource 
setup into common code")

I also pushed the following two patches to fix this issue for review

http://patchwork.ozlabs.org/project/linux-pci/patch/20201125192234.2270-1-vidyas@nvidia.com/
http://patchwork.ozlabs.org/project/linux-pci/patch/20201125192554.5401-1-vidyas@nvidia.com/


> So I tried applying this on top of v5.10-rc1, but
> that gives me the following:
> 
> 	[    3.595161] ahci 0001:01:00.0: version 3.0
> 	[    3.595726] ahci 0001:01:00.0: SSS flag set, parallel bus scan disabled
> 	[    4.609923] ahci 0001:01:00.0: controller reset failed (0xffffffff)
> 	[    4.610343] ahci: probe of 0001:01:00.0 failed with error -5
> 
> So the device enumerates fine, but it's not able to reset the SATA controller.
> That said, this seems to happen regardless of this patch series, so plain v5.10-rc1
> also shows the above.
This was also a known issue and we need the following commit to make 
things work (FWIW, it is already accepted)
9fff3256f93d PCI: dwc: Restore ATU memory resource setup to use last entry

Otherwise, v5.10-rc3 can be used which has working state of PCIe on 
Tegra194.

> 
> Given the above, I think we should hold off on applying this series until we've
> fixed PCI on linux-next and made sure that SATA also works properly, otherwise
> we don't have a known good baseline to test this against.
> 
> Thierry
