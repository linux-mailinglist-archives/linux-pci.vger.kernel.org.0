Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD8B17C162
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFPMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 10:12:14 -0500
Received: from foss.arm.com ([217.140.110.172]:35266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgCFPMO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 10:12:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12BB030E;
        Fri,  6 Mar 2020 07:12:14 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DD5A3F237;
        Fri,  6 Mar 2020 07:12:13 -0800 (PST)
Date:   Fri, 6 Mar 2020 15:12:10 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "maz@kernel.org" <maz@kernel.org>
Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200306151210.GB10297@e121166-lin.cambridge.arm.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200225114013.GB6913@e121166-lin.cambridge.arm.com>
 <MN2PR02MB63365B50058B35AA37341BC9A5ED0@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200228104442.GA2874@e121166-lin.cambridge.arm.com>
 <MN2PR02MB6336569F378683B05B262D4AA5E80@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200306111620.GA10297@e121166-lin.cambridge.arm.com>
 <MN2PR02MB6336BBFDCB07F424C36742B0A5E30@MN2PR02MB6336.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB6336BBFDCB07F424C36742B0A5E30@MN2PR02MB6336.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 06, 2020 at 11:45:47AM +0000, Bharat Kumar Gogada wrote:
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Friday, March 6, 2020 4:46 PM
> > To: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > bhelgaas@google.com; Ravikiran Gummaluri <rgummal@xilinx.com>;
> > maz@kernel.org
> > Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
> > 
> > On Fri, Feb 28, 2020 at 12:48:48PM +0000, Bharat Kumar Gogada wrote:
> > > > Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root
> > > > Port driver
> > > >
> > > > [+MarcZ, FHI]
> > > >
> > > > On Tue, Feb 25, 2020 at 02:39:56PM +0000, Bharat Kumar Gogada wrote:
> > > >
> > > > [...]
> > > >
> > > > > > > +/* ECAM definitions */
> > > > > > > +#define ECAM_BUS_NUM_SHIFT		20
> > > > > > > +#define ECAM_DEV_NUM_SHIFT		12
> > > > > >
> > > > > > You don't need these ECAM_* defines, you can use
> > pci_generic_ecam_ops.
> > > > > Does this need separate ranges region for ECAM space ?
> > > > > We have ECAM and controller space in same region.
> > > >
> > > > You can create an ECAM window with pci_ecam_create where *cfgres
> > > > represent the ECAM area, I don't get what you mean by "same region".
> > > >
> > > > Do you mean "contiguous" ? Or something else ?
> > > Yes, contiguous; within ECAM region some space is for controller registers.
> > 
> > What does that mean ? I don't get it. Can you explain to me how this address
> > space works please ?
> > 
> Hi Lorenzo,
> 		reg = <0x6 0x00000000 0x0 0x1000000>,

This supports up to 16 busses (it is 16MB in size rather than
full ECAM 256MB), right ? Please make sure that the bus-range
property reflects that.

> 		      <0x0 0xFCA10000 0x0 0x1000>;
> 		reg-names = "cfg", "cpm_slcr";
> 
> In the above cfg region some region of it reserved for bridge registers and rest for ECAM 
> address space transactions. The bridge registers are mapped at an unused offset in config space
> of root port, when the offset hit it will access controller register space.
> 
> This region is already being mapped 
> res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> port->reg_base = devm_ioremap_resource(dev, res);
> 
> Does pci_ecam_create will work along with above API simultaneously ?

Basically the bridge registers are accessible through the PCI
config accessors (after enumeration), since they are in the
bridge device specific config space (device specific area).

IIUC the answer is yes and you can access the bridge registers through
PCI config space accessors (after enumeration).

Pre-enumeration you can map (and unmap) the region as you are doing now
(+ the unmap) - since you need a pci_bus structure for PCI config
accessors to work and you don't have it till the enumeration is
actually executed.

Lorenzo
