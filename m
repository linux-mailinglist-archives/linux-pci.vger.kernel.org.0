Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B8219BFB
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 11:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGIJWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 05:22:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgGIJWC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 05:22:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 143C231B;
        Thu,  9 Jul 2020 02:22:01 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83EC53F887;
        Thu,  9 Jul 2020 02:21:58 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:21:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2 01/12] ACPI/IORT: Make iort_match_node_callback walk
 the ACPI namespace for NC
Message-ID: <20200709092156.GB18149@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-2-lorenzo.pieralisi@arm.com>
 <718cae1f-2f33-f6d9-f278-157300b73116@huawei.com>
 <20200629090551.GA28873@e121166-lin.cambridge.arm.com>
 <765078e7-b3ec-af5d-0405-7834ba0f120a@huawei.com>
 <20200630102454.GA17556@e121166-lin.cambridge.arm.com>
 <4817d766-0437-5356-a0b9-97b111d4cae2@huawei.com>
 <952a6720-f401-1441-5548-5b40cfc76d3a@arm.com>
 <0cbd1da8-e283-7e13-d2b3-4d14775fd870@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cbd1da8-e283-7e13-d2b3-4d14775fd870@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 02, 2020 at 04:22:00PM +0800, Hanjun Guo wrote:
> Hi Robin,
> 
> On 2020/7/2 0:12, Robin Murphy wrote:
> > On 2020-06-30 14:04, Hanjun Guo wrote:
> > > On 2020/6/30 18:24, Lorenzo Pieralisi wrote:
> > > > On Tue, Jun 30, 2020 at 11:06:41AM +0800, Hanjun Guo wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > For devices that aren't described in the DSDT - IORT translations
> > > > > > are determined by their ACPI parent device. Do you see/Have you
> > > > > > found any issue with this approach ?
> > > > > 
> > > > > The spec says "Describes the IO relationships between devices
> > > > > represented in the ACPI namespace.", and in section 3.1.1.3 Named
> > > > > component node, it says:
> > > > 
> > > > PCI devices aren't necessarily described in the ACPI namespace and we
> > > > still use IORT to describe them - through the RC node.
> > > > 
> > > > > "Named component nodes are used to describe devices that are also
> > > > > included in the Differentiated System Description Table (DSDT). See
> > > > > [ACPI]."
> > > > > 
> > > > > So from my understanding, the IORT spec for now, can only do ID
> > > > > translations for devices in the DSDT.
> > > > 
> > > > I think you can read this multiple ways but this patch does not
> > > > change this concept. What changes, is applying parent's node IORT
> > > > mapping to child nodes with no associated DSDT nodes, it is the
> > > > same thing we do with PCI and the _DMA method - we could update
> > > > the wording in the specs if that clarifies but I don't think this
> > > > deliberately disregards the specifications.
> > > 
> > > I agree, but it's better to update the wording of the spec.
> > > 
> > > > 
> > > > > > > For a platform device, if I use its parent's full path name for
> > > > > > > its named component entry, then it will match, but this will violate
> > > > > > > the IORT spec.
> > > > > > 
> > > > > > Can you elaborate on this please I don't get the point you
> > > > > > are making.
> > > > > 
> > > > > For example, device A is not described in DSDT so can't represent
> > > > > as a NC node in IORT. Device B can be described in DSDT and it
> > > > > is the parent of device A, so device B can be represented in IORT
> > > > > with memory access properties and node flags with Substream width
> > > > > and Stall supported info.
> > > > > 
> > > > > When we trying to translate device A's ID, we reuse all the memory
> > > > > access properties and node flags from its parent (device B), but
> > > > > will it the same?
> > > > 
> > > > I assume so why wouldn't it be ? Why would be describe them in
> > > > a parent-child relationship if that's not how the system looks like
> > > > in HW ?
> > > 
> > > The point I'm making is that I'm not sure all the memory access and
> > > stall properties are the same for the parent and the device itself.
> > 
> > Is that even a valid case though? The principal thing we want to
> > accommodate here is when device B *is* the one accessing memory, either
> > because it is a bridge with device A sat behind it, or because device A
> > is actually just some logical function or subset of physical device B.
> 
> Thanks for the clarify, for CCA attributes, child device should be the
> same as its parent and that was written in the ACPI spec, so it's better
> to make it clear for other properties in the spec as well.
> 
> > 
> > If the topology is such that device A is a completely independent device
> > with its own path to memory such that it could have different
> > properties, I would expect that it *should* be described in DSDT, and I
> > can't easily think of a good reason why it wouldn't be. I'm also
> > struggling to imagine how it might even have an ID that had to be
> > interpreted in the context of device B if it wasn't one of the cases
> > above :/
> > 
> > I don't doubt that people could - or maybe even have - come up with crap
> > DSDT bindings that don't represent the hardware sufficiently accurately,
> > but I'm not sure that should be IORT's problem...
> 
> As I said in previous email, I'm not against this patch, and seems
> have no regressions for platforms that using named component node
> such as D05/D06 (I will test it shortly to make sure), but it's better
> to update the wording of the spec (even after this patch set is merged).

Have you managed to test this series ?

Thanks,
Lorenzo
