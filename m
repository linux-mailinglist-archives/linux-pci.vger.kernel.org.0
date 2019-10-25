Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104C0E46BA
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408685AbfJYJJ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 05:09:29 -0400
Received: from foss.arm.com ([217.140.110.172]:37350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407217AbfJYJJ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 05:09:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCD7428;
        Fri, 25 Oct 2019 02:09:28 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 456E73F71F;
        Fri, 25 Oct 2019 02:09:28 -0700 (PDT)
Date:   Fri, 25 Oct 2019 10:09:26 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
Message-ID: <20191025090926.GX47056@e119886-lin.cambridge.arm.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
 <20191021130339.GP47056@e119886-lin.cambridge.arm.com>
 <661f7e9c-a79f-bea6-08d8-4df54f500019@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <661f7e9c-a79f-bea6-08d8-4df54f500019@linux.intel.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 22, 2019 at 05:04:21PM +0800, Dilip Kota wrote:
> Hi Andrew Murray,
> 
> On 10/21/2019 9:03 PM, Andrew Murray wrote:
> > On Mon, Oct 21, 2019 at 02:39:19PM +0800, Dilip Kota wrote:

> > > +
> > > +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
> > > +{
> > > +	u32 val;
> > > +
> > > +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > > +	val &= ~PORT_LOGIC_N_FTS;
> > > +	val |= n_fts;
> > > +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > > +}
> > I notice that pcie-artpec6.c (artpec6_pcie_set_nfts) also writes the FTS
> > and defines a bunch of macros to support this. It doesn't make sense to
> > duplicate this there. Therefore I think we need to update pcie-artpec6.c
> > to use this new function.
> I think we can do in a separate patch after these changes get merged and
> keep this patch series for intel PCIe driver and required changes in PCIe
> DesignWare framework.

The pcie-artpec6.c is a DWC driver as well. So I think we can do all this
together. This helps reduce the technical debt that will otherwise build up
in duplicated code.

> > > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > new file mode 100644
> > > index 000000000000..9142c70db808
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > @@ -0,0 +1,590 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PCIe host controller driver for Intel Gateway SoCs
> > > + *
> > > + * Copyright (c) 2019 Intel Corporation.
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/of_irq.h>
> > > +#include <linux/of_pci.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/pci_regs.h>
> > > +#include <linux/phy/phy.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/reset.h>
> > > +
> > > +#include "../../pci.h"
> > I expected this to be removed, is it needed now?
> 
> In the earlier patch you suggested to use "of_pci_get_max_link_speed()"
> instead of device_get_*.
> And, pci.h is required for it.

OK that makes sense.

> > > +
> > > +static int intel_pcie_get_resources(struct platform_device *pdev)
> > > +{
> > > +	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
> > > +	struct dw_pcie *pci = &lpp->pci;
> > > +	struct device *dev = pci->dev;
> > > +	struct resource *res;
> > > +	int ret;
> > > +
> > > +	ret = device_property_read_u32(dev, "linux,pci-domain", &lpp->id);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to get domain id, errno %d\n", ret);
> > > +		return ret;
> > > +	}
> > Why is this a required property?
> I marked it required property because lpp->id is being used during debug
> prints.
>   -> sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
>  -> dev_info(dev, "Intel PCIe Root Complex Port %d init done\n", lpp->id);
> 
> Hmmm.. I found, domain id can be traversed from pci_host_bridge structure
> after dw_pcie_host_init().
> I will remove the code for getting the pci-domain here.

Excellent.

> 
> > 
> > > +#define  PCI_EXP_LNKCTL2_HASD		0x0200 /* Hw Autonomous Speed Disable */
> > I think this should be 0x0020.
> Yes, my miss, i will update.
> Thanks for pointing it.
> 
> Thanks for reviewing and providing the inputs.
> Regards,
> Dilip
> > 
> > Thanks,
> > 
> > Andrew Murray

Thanks,

Andrew Murray

> > 
> > >   #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
> > >   #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
> > >   #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
> > > -- 
> > > 2.11.0
> > > 
