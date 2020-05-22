Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344A11DE384
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgEVJxM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 05:53:12 -0400
Received: from foss.arm.com ([217.140.110.172]:60386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgEVJxL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 05:53:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95F79D6E;
        Fri, 22 May 2020 02:53:10 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCEDC3F305;
        Fri, 22 May 2020 02:53:07 -0700 (PDT)
Date:   Fri, 22 May 2020 10:53:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Makarand Pawagi <makarand.pawagi@nxp.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
Message-ID: <20200522095301.GA11785@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-13-lorenzo.pieralisi@arm.com>
 <3045acd5-0bcf-40c1-e65f-0b740200b2e0@nxp.com>
 <AM6PR04MB49847931D51AD92057043D92EBB40@AM6PR04MB4984.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB49847931D51AD92057043D92EBB40@AM6PR04MB4984.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 22, 2020 at 05:32:02AM +0000, Makarand Pawagi wrote:

[...]

> > Subject: Re: [PATCH 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
> > 
> > Hi Lorenzo,
> > 
> > On 5/21/2020 4:00 PM, Lorenzo Pieralisi wrote:
> > > From: Diana Craciun <diana.craciun@oss.nxp.com>
> > >
> > > Add ACPI support in the fsl-mc driver. Driver parses MC DSDT table to
> > > extract memory and other resources.
> > >
> > > Interrupt (GIC ITS) information is extracted from the MADT table by
> > > drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.
> > >
> > > IORT table is parsed to configure DMA.
> > >
> > > Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
> > > Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > ---
> > 
> > The author of this patch should be Makarand. I think I accidentaly broke it when
> > we exchanged the patches. Very sorry about it.
> > 
>  
> Will you be able to correct this or should I post another patch?

I will update it.

Lorenzo
