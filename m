Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997753027FD
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 17:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbhAYQgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 11:36:22 -0500
Received: from foss.arm.com ([217.140.110.172]:51054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730778AbhAYQf7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 11:35:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 265A41042;
        Mon, 25 Jan 2021 08:34:35 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07DD13F68F;
        Mon, 25 Jan 2021 08:34:33 -0800 (PST)
Date:   Mon, 25 Jan 2021 16:34:31 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     zhangqilong <zhangqilong3@huawei.com>, vidyas@nvidia.com
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIFBDSQ==?= =?utf-8?Q?=3A?= dwc:
 fix reference leak in pex_ep_event_pex_rst_deassert
Message-ID: <20210125163431.GB5795@e121166-lin.cambridge.arm.com>
References: <20201102143045.142121-1-zhangqilong3@huawei.com>
 <f09c0801-d584-3c27-d3e7-ca59a64a30d1@nvidia.com>
 <b1f6b6805a7746b48020d7cfaaa73fab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f6b6805a7746b48020d7cfaaa73fab@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 03, 2020 at 03:14:21AM +0000, zhangqilong wrote:
> Hi
> 
> > 
> > 
> > On 11/2/2020 8:00 PM, Zhang Qilong wrote:
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > pm_runtime_get_sync will increment pm usage counter even it failed.
> > > Forgetting to pm_runtime_put_noidle will result in reference leak in
> > > pex_ep_event_pex_rst_deassert, so we should fix it.
> > >
> > > Fixes: c57247f940e8e ("PCI: tegra: Add support for PCIe endpoint mode
> > > in Tegra194")
> > > Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index f920e7efe118..936510b5c649 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -1662,6 +1662,7 @@ static void pex_ep_event_pex_rst_deassert(struct
> > > tegra_pcie_dw *pcie)
> > >
> > >          ret = pm_runtime_get_sync(dev);
> > >          if (ret < 0) {
> > > +               pm_runtime_put_noidle(dev);
> > Why can't we call pm_runtime_put_sync(dev) as that is what is being called in
> > failure cases anyway further down in this API?
> > 
> Both of the two functions are OK, the difference is that, when pm_runtime_put_sync failed(runtime of the device has error, the device is in Inaccessible state or other error state...), it only increase the usage count of the power, and do nothing else. We merely need call pm_runtime_put_noidle to decrease the usage count. If we call pm_runtime_put_sync to reset it, it will notify device bus type if the device can be suspended, and that is meanless when pm_runtime_put_sync failed.

I don't understand. Vidya any feedback ?

Lorenzo

> Thanks, best wish!
> 
> Zhang Qilong
> > >                  dev_err(dev, "Failed to get runtime sync for PCIe
> > dev: %d\n",
> > >                          ret);
> > >                  return;
> > > --
> > > 2.17.1
> > >
