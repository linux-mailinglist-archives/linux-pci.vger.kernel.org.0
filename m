Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B10230A99
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgG1Msr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 08:48:47 -0400
Received: from foss.arm.com ([217.140.110.172]:34550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbgG1Msp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 08:48:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ED431FB;
        Tue, 28 Jul 2020 05:48:44 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DD4A3F718;
        Tue, 28 Jul 2020 05:48:42 -0700 (PDT)
Date:   Tue, 28 Jul 2020 13:48:35 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Will Deacon <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2 05/12] ACPI/IORT: Add an input ID to
 acpi_dma_configure()
Message-ID: <20200728124835.GA14596@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-6-lorenzo.pieralisi@arm.com>
 <20200709093514.GC18149@e121166-lin.cambridge.arm.com>
 <20200715091326.GA30074@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715091326.GA30074@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 15, 2020 at 10:13:26AM +0100, Lorenzo Pieralisi wrote:
> On Thu, Jul 09, 2020 at 10:35:14AM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Jun 19, 2020 at 09:20:06AM +0100, Lorenzo Pieralisi wrote:
> > > Some HW devices are created as child devices of proprietary busses,
> > > that have a bus specific policy defining how the child devices
> > > wires representing the devices ID are translated into IOMMU and
> > > IRQ controllers device IDs.
> > > 
> > > Current IORT code provides translations for:
> > > 
> > > - PCI devices, where the device ID is well identified at bus level
> > >   as the requester ID (RID)
> > > - Platform devices that are endpoint devices where the device ID is
> > >   retrieved from the ACPI object IORT mappings (Named components single
> > >   mappings). A platform device is represented in IORT as a named
> > >   component node
> > > 
> > > For devices that are child devices of proprietary busses the IORT
> > > firmware represents the bus node as a named component node in IORT
> > > and it is up to that named component node to define in/out bus
> > > specific ID translations for the bus child devices that are
> > > allocated and created in a bus specific manner.
> > > 
> > > In order to make IORT ID translations available for proprietary
> > > bus child devices, the current ACPI (and IORT) code must be
> > > augmented to provide an additional ID parameter to acpi_dma_configure()
> > > representing the child devices input ID. This ID is bus specific
> > > and it is retrieved in bus specific code.
> > > 
> > > By adding an ID parameter to acpi_dma_configure(), the IORT
> > > code can map the child device ID to an IOMMU stream ID through
> > > the IORT named component representing the bus in/out ID mappings.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Hanjun Guo <guohanjun@huawei.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > ---
> > >  drivers/acpi/arm64/iort.c | 59 +++++++++++++++++++++++++++++----------
> > >  drivers/acpi/scan.c       |  8 ++++--
> > >  include/acpi/acpi_bus.h   |  9 ++++--
> > >  include/linux/acpi.h      |  7 +++++
> > >  include/linux/acpi_iort.h |  7 +++--
> > >  5 files changed, 67 insertions(+), 23 deletions(-)
> > 
> > Hi Rafael,
> > 
> > just to ask if the ACPI core changes in this patch are OK with you,
> > thank you very much.
> 
> Hi Rafael,
> 
> are you OK with ACPI core changes in this patch ?
> 
> Please let me know, thanks.

Hi Rafael,

gentle ping, I think we are missing v5.9, we would need your feedback
on this please.

Thanks,
Lorenzo
