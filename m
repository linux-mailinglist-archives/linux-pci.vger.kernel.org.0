Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81BB1C3805
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 13:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEDLZq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 07:25:46 -0400
Received: from foss.arm.com ([217.140.110.172]:42270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEDLZq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 07:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 623631FB;
        Mon,  4 May 2020 04:25:45 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 433BC3F71F;
        Mon,  4 May 2020 04:25:44 -0700 (PDT)
Date:   Mon, 4 May 2020 12:25:35 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: cadence: Fix to read 32-bit Vendor ID/Device
 ID property from DT
Message-ID: <20200504112535.GA27662@e121166-lin.cambridge.arm.com>
References: <20200417114322.31111-1-kishon@ti.com>
 <20200417114322.31111-5-kishon@ti.com>
 <20200501151131.GC7398@e121166-lin.cambridge.arm.com>
 <47cc8236-4bec-244d-4ab3-cda8eb37d4bf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47cc8236-4bec-244d-4ab3-cda8eb37d4bf@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 04, 2020 at 02:22:30PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 5/1/2020 8:41 PM, Lorenzo Pieralisi wrote:
> > On Fri, Apr 17, 2020 at 05:13:22PM +0530, Kishon Vijay Abraham I wrote:
> >> The PCI Bus Binding specification (IEEE Std 1275-1994 Revision 2.1 [1])
> >> defines both Vendor ID and Device ID to be 32-bits. Fix
> >> pcie-cadence-host.c driver to read 32-bit Vendor ID and Device ID
> >> properties from device tree.
> >>
> >> [1] -> https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/controller/cadence/pcie-cadence-host.c | 4 ++--
> >>  drivers/pci/controller/cadence/pcie-cadence.h      | 4 ++--
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > I don't see how you would use a 32-bit value for a 16-bit register so
> > certainly the struct cdns_pcie_rc fields size is questionable anyway.
> > 
> > I *assume* you are referring to 4.1.2.1 and the property list
> > encoded as "encode-int".
> > 
> > I would like to get RobH's opinion on this - I don't know myself
> > whether the PCI OF bindings you added are still relevant and how
> > they should be interpreted.
> 
> This change was made due to RobH's comment below [1]
> 
> [1] ->
> https://lore.kernel.org/r/CAL_JsqLYScxGySy8xaN-UB6URfw8K_jSiuSXwVoTU9-RdJecww@mail.gmail.com/

Thanks for the pointer - that's what I needed to proceed with this
patch.

Lorenzo

> Thanks
> Kishon
> 
> > 
> > Thanks
> > Lorenzo
> > 
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> index 8f72967f298f..31e67c9c88cf 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> >> @@ -229,10 +229,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> >>  	}
> >>  
> >>  	rc->vendor_id = 0xffff;
> >> -	of_property_read_u16(np, "vendor-id", &rc->vendor_id);
> >> +	of_property_read_u32(np, "vendor-id", &rc->vendor_id);
> >>  
> >>  	rc->device_id = 0xffff;
> >> -	of_property_read_u16(np, "device-id", &rc->device_id);
> >> +	of_property_read_u32(np, "device-id", &rc->device_id);
> >>  
> >>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
> >>  	pcie->reg_base = devm_ioremap_resource(dev, res);
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> >> index 6bd89a21bb1c..df14ad002fe9 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> >> @@ -262,8 +262,8 @@ struct cdns_pcie_rc {
> >>  	struct resource		*bus_range;
> >>  	void __iomem		*cfg_base;
> >>  	u32			no_bar_nbits;
> >> -	u16			vendor_id;
> >> -	u16			device_id;
> >> +	u32			vendor_id;
> >> +	u32			device_id;
> >>  };
> >>  
> >>  /**
> >> -- 
> >> 2.17.1
> >>
