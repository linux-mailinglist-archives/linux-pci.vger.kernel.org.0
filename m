Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58CB5E69AF
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiIVRcY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 13:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIVRcX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 13:32:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE74105D4D;
        Thu, 22 Sep 2022 10:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2387B82444;
        Thu, 22 Sep 2022 17:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F94C433D6;
        Thu, 22 Sep 2022 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663867939;
        bh=1Skf5wiBol+qGBVz6JasNK7icy4lAhhPx0SLST8QPpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eGu3JUSEuVFz1QcOmxcMhM48f8mxiQn4zee7aDnTEQEOrAHrHePtkHA8I188kLAbA
         RdyLpQvP0kNPcjlIMkk6Wch055YUPjOFDBDw9aWqt5StVGoYtVIaIFcNCSFlzcdKqA
         yWDKr/YbD3M0730Aqw8bMg1S1cXhPUArWtdBpBfZ8swnyL96llHB6DGhsPnaAkggrZ
         dzHhmHU3xGotL1faI8WgyPcplaR9WzAEA00vl2HLhZHbUOb3boKv0prUaxvFICJMxk
         Beovo7zhCbp1hhBGwE+6Lna+dUtoJ6wMwdH2wayQtL0lmbnxPOy/VzhwrkkX3quFLC
         vrD1Gb0fhi9aw==
Date:   Thu, 22 Sep 2022 12:32:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20220922173217.GA1316280@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922165820.000017b6@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 22, 2022 at 04:58:20PM +0100, Jonathan Cameron wrote:
> On Sat, 17 Sep 2022 20:10:35 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
> > This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> > for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> > Core controller IP which provides statistics feature. The PMU is not a PCIe
> > Root Complex integrated End Point(RCiEP) device but only register counters
> > provided by each PCIe Root Port.
> > 
> > To facilitate collection of statistics the controller provides the
> > following two features for each Root Port:
> > 
> > - Time Based Analysis (RX/TX data throughput and time spent in each
> >   low-power LTSSM state)
> > - Event counters (Error and Non-Error for lanes)
> > 
> > Note, only one counter for each type.
> > 
> > This driver add PMU devices for each PCIe Root Port. And the PMU device is
> > named based the BDF of Root Port. For example,
> > 
> >     10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
> > 
> > the PMU device name for this Root Port is pcie_bdf_100000.
> > 
> > Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> > 
> >     $# perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/
> > 
> > average RX bandwidth can be calculated like this:
> > 
> >     PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
> > 
> > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> +CC linux-pci list and Bjorn.

Thanks, this is definitely of interest to linux-pci.

> Question in here which I've been meaning to address for other reasons
> around how to register 'extra features' on pci ports.
> 
> This particular PMU is in config space in a Vendor Specific Extended
> Capability.
> 
> I've focused on that aspect for this review rather than the perf parts.
> We'll need to figure that story out first as doing this from a bus walk
> makes triggered of a platform driver is not the way I'd expect to see
> this work.

> > +static int dwc_pcie_pmu_discover(struct dwc_pcie_pmu_priv *priv)
> > +{
> > +	int val, where, index = 0;
> > +	struct pci_dev *pdev = NULL;
> > +	struct dwc_pcie_info_table *pcie_info;
> > +
> > +	priv->pcie_table =
> > +	    devm_kcalloc(priv->dev, RP_NUM_MAX, sizeof(*pcie_info), GFP_KERNEL);
> > +	if (!priv->pcie_table)
> > +		return -EINVAL;
> > +
> > +	pcie_info = priv->pcie_table;
> > +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL &&
> > +	       index < RP_NUM_MAX) {
> 
> This having a driver than then walks the pci topology to find root ports and add
> extra stuff to them is not a clean solution.
> 
> The probing should be driven from the existing PCI driver topology.
> There are a bunch of new features we need to add to ports in the near future
> anyway - this would just be another one.
> Same problem exists for CXL CPMU perf devices - so far we only support those
> on end points, partly because we need a clean way to probe them on pci ports.
> 
> Whatever we come up with there will apply here as well.

I agree, I don't like to see more uses of pci_get_device() because it
doesn't fit the driver model at all.  For one thing, it really screws
up the hotplug model because this doesn't account for hot-added
devices and there's no clear cleanup path for removal.

Hotplug is likely not an issue in this particular case, but it gets
copied to places where it is an issue.

Maybe we need some kind of PCI core interface whereby drivers can
register their interest in VSEC and/or DVSEC capabilities.

Bjorn
