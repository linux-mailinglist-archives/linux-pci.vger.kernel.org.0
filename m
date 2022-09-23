Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6050E5E78E0
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 12:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiIWK5L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 06:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiIWK4u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 06:56:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636F3248E0;
        Fri, 23 Sep 2022 03:56:48 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYpqw6w0Pz682Wq;
        Fri, 23 Sep 2022 18:51:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 12:56:46 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 11:56:46 +0100
Date:   Fri, 23 Sep 2022 11:56:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <yangyicong@hisilicon.com>,
        "Shuai Xue" <xueshuai@linux.alibaba.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <rdunlap@infradead.org>,
        <robin.murphy@arm.com>, <mark.rutland@arm.com>,
        <baolin.wang@linux.alibaba.com>, <zhuo.song@linux.alibaba.com>,
        <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20220923115644.00002c76@huawei.com>
In-Reply-To: <6592c0a0-e976-2d3b-b7f3-12bc72d55e9b@huawei.com>
References: <20220922173217.GA1316280@bhelgaas>
        <6592c0a0-e976-2d3b-b7f3-12bc72d55e9b@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 23 Sep 2022 11:35:45 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> On 2022/9/23 1:32, Bjorn Helgaas wrote:
> > On Thu, Sep 22, 2022 at 04:58:20PM +0100, Jonathan Cameron wrote:  
> >> On Sat, 17 Sep 2022 20:10:35 +0800
> >> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> >>  
> >>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> >>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> >>> Core controller IP which provides statistics feature. The PMU is not a PCIe
> >>> Root Complex integrated End Point(RCiEP) device but only register counters
> >>> provided by each PCIe Root Port.
> >>>
> >>> To facilitate collection of statistics the controller provides the
> >>> following two features for each Root Port:
> >>>
> >>> - Time Based Analysis (RX/TX data throughput and time spent in each
> >>>   low-power LTSSM state)
> >>> - Event counters (Error and Non-Error for lanes)
> >>>
> >>> Note, only one counter for each type.
> >>>
> >>> This driver add PMU devices for each PCIe Root Port. And the PMU device is
> >>> named based the BDF of Root Port. For example,
> >>>
> >>>     10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
> >>>
> >>> the PMU device name for this Root Port is pcie_bdf_100000.
> >>>
> >>> Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> >>>
> >>>     $# perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/
> >>>
> >>> average RX bandwidth can be calculated like this:
> >>>
> >>>     PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
> >>>
> >>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>  
> >>
> >> +CC linux-pci list and Bjorn.  
> > 
> > Thanks, this is definitely of interest to linux-pci.
> >   
> >> Question in here which I've been meaning to address for other reasons
> >> around how to register 'extra features' on pci ports.
> >>
> >> This particular PMU is in config space in a Vendor Specific Extended
> >> Capability.
> >>
> >> I've focused on that aspect for this review rather than the perf parts.
> >> We'll need to figure that story out first as doing this from a bus walk
> >> makes triggered of a platform driver is not the way I'd expect to see
> >> this work.  
> >   
> >>> +static int dwc_pcie_pmu_discover(struct dwc_pcie_pmu_priv *priv)
> >>> +{
> >>> +	int val, where, index = 0;
> >>> +	struct pci_dev *pdev = NULL;
> >>> +	struct dwc_pcie_info_table *pcie_info;
> >>> +
> >>> +	priv->pcie_table =
> >>> +	    devm_kcalloc(priv->dev, RP_NUM_MAX, sizeof(*pcie_info), GFP_KERNEL);
> >>> +	if (!priv->pcie_table)
> >>> +		return -EINVAL;
> >>> +
> >>> +	pcie_info = priv->pcie_table;
> >>> +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL &&
> >>> +	       index < RP_NUM_MAX) {  
> >>
> >> This having a driver than then walks the pci topology to find root ports and add
> >> extra stuff to them is not a clean solution.
> >>
> >> The probing should be driven from the existing PCI driver topology.
> >> There are a bunch of new features we need to add to ports in the near future
> >> anyway - this would just be another one.
> >> Same problem exists for CXL CPMU perf devices - so far we only support those
> >> on end points, partly because we need a clean way to probe them on pci ports.
> >>
> >> Whatever we come up with there will apply here as well.  
> > 
> > I agree, I don't like to see more uses of pci_get_device() because it
> > doesn't fit the driver model at all.  For one thing, it really screws
> > up the hotplug model because this doesn't account for hot-added
> > devices and there's no clear cleanup path for removal.
> > 
> > Hotplug is likely not an issue in this particular case, but it gets
> > copied to places where it is an issue.
> > 
> > Maybe we need some kind of PCI core interface whereby drivers can
> > register their interest in VSEC and/or DVSEC capabilities.


Something along those lines works if the facility is constrained to just
VSEC / DVSEC.
 * This one is.
 * CMA / SPDM / IDE all are - but with complexity of interrupts.
   After the plumbers SPDM BoF the resulting plan would not fit in the
   same model as this driver (need to be done earlier in PCI registration
   flow I think).  I need to write up and share some notes on what we
   are planning around that to get wider feedback - but might be a few
   weeks!

Others are less well confined.
 * CXL PMU uses registers in bar space - but is hanging off a DVSEC
   description to tell you where to find it.

> >   
> 
> Considering this PMU is related to each Root Port without real backup device. I'm
> wondering whether we can extend the pcie port bus and make use of it (though it's
> currently used by the standard services).

I did that a few years back for our older PCI PMUs.  It wasn't pretty.
https://lore.kernel.org/all/20181214131055.52253-2-Jonathan.Cameron@huawei.com/

We never took that driver forwards - it was mostly useful to understand what
might work for newer hardware - we went the RCiEP route at least partly to avoid
software complexity (and because of hardware topology - counters shared by multiple
RP)

We could do something more generic along the same lines as the portdrv framework
 - that highlights some of the complexities however.
There are some nasty potential ordering issues in registering interest caused
by any attempt to make this work with modules.
I'd want to see a solution that works just as well for all the components that
might have DVSEC / VSEC entries - not just those covered by portdrv.

+CC Dan Williams and linux-cxl as they may also be interested in this discussion.

> 
> Thanks.
> 

