Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EFF230AD0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgG1NAl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 09:00:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35498 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgG1NAk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 09:00:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id 93so4631354otx.2;
        Tue, 28 Jul 2020 06:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQxWRGpK+7J5zPyI+x2auaL/xO1F0G6D2eChmPkLka4=;
        b=jpWuEcrD9XhEVv/7ZcG5mOXpiy/nx0mKDBfo3NY7T+oOBbXHdbCuk8pLafHQNm204I
         Krw1i40hFAs8T0ohYtKVpMP7sstJ/CvWh9ZItNwt0LLYdWaB4YrCJA12H7cVO6q337cC
         92+AaNG3xRc8wHiXRDhz1lXD8TpCKGcapHVHVBMNl1iuh4YjU/jyctx+rYtWcLZkHYt4
         sMlFkLxqyUKKI9AAJgC/YYvgbYncxb4ndpfFhiMDDn0A6sklt5pFxMHTssXE/vdqJpG4
         k8yaC7yRD1WmKL/BZyfvYSiTOlLqxr1oERfZfg4VL6pDUGRrPWUAb8EgWFxrHDQ5HSbB
         qXNg==
X-Gm-Message-State: AOAM533IBH7yJfmB9XmRAT8jMB8XEwC+r7eSAsL9Msmqga+wOX3vXjIc
        hvAlcUC92BHczEo63St4fIA8Tm+jpKV8lEC0E+8=
X-Google-Smtp-Source: ABdhPJyjkPbmbdSrKoRnxAHeoGfwpBzGL7q9+aCpuvVIqlYJ3d/ztRYP2FQgQ2jADdtZcBOiq9wpwzTBFyKVN4fiMIs=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr24293860oth.262.1595941239566;
 Tue, 28 Jul 2020 06:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com> <20200619082013.13661-6-lorenzo.pieralisi@arm.com>
 <20200709093514.GC18149@e121166-lin.cambridge.arm.com> <20200715091326.GA30074@e121166-lin.cambridge.arm.com>
 <20200728124835.GA14596@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200728124835.GA14596@e121166-lin.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jul 2020 15:00:28 +0200
Message-ID: <CAJZ5v0irrPd7kNqDX=BoPx7pf0zBgBRy3FHze5CA_UWi5Jv0Ag@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] ACPI/IORT: Add an input ID to acpi_dma_configure()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 2:48 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Jul 15, 2020 at 10:13:26AM +0100, Lorenzo Pieralisi wrote:
> > On Thu, Jul 09, 2020 at 10:35:14AM +0100, Lorenzo Pieralisi wrote:
> > > On Fri, Jun 19, 2020 at 09:20:06AM +0100, Lorenzo Pieralisi wrote:
> > > > Some HW devices are created as child devices of proprietary busses,
> > > > that have a bus specific policy defining how the child devices
> > > > wires representing the devices ID are translated into IOMMU and
> > > > IRQ controllers device IDs.
> > > >
> > > > Current IORT code provides translations for:
> > > >
> > > > - PCI devices, where the device ID is well identified at bus level
> > > >   as the requester ID (RID)
> > > > - Platform devices that are endpoint devices where the device ID is
> > > >   retrieved from the ACPI object IORT mappings (Named components single
> > > >   mappings). A platform device is represented in IORT as a named
> > > >   component node
> > > >
> > > > For devices that are child devices of proprietary busses the IORT
> > > > firmware represents the bus node as a named component node in IORT
> > > > and it is up to that named component node to define in/out bus
> > > > specific ID translations for the bus child devices that are
> > > > allocated and created in a bus specific manner.
> > > >
> > > > In order to make IORT ID translations available for proprietary
> > > > bus child devices, the current ACPI (and IORT) code must be
> > > > augmented to provide an additional ID parameter to acpi_dma_configure()
> > > > representing the child devices input ID. This ID is bus specific
> > > > and it is retrieved in bus specific code.
> > > >
> > > > By adding an ID parameter to acpi_dma_configure(), the IORT
> > > > code can map the child device ID to an IOMMU stream ID through
> > > > the IORT named component representing the bus in/out ID mappings.
> > > >
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Hanjun Guo <guohanjun@huawei.com>
> > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > ---
> > > >  drivers/acpi/arm64/iort.c | 59 +++++++++++++++++++++++++++++----------
> > > >  drivers/acpi/scan.c       |  8 ++++--
> > > >  include/acpi/acpi_bus.h   |  9 ++++--
> > > >  include/linux/acpi.h      |  7 +++++
> > > >  include/linux/acpi_iort.h |  7 +++--
> > > >  5 files changed, 67 insertions(+), 23 deletions(-)
> > >
> > > Hi Rafael,
> > >
> > > just to ask if the ACPI core changes in this patch are OK with you,
> > > thank you very much.

Sorry for the delay, I was offline last week.

> > Hi Rafael,
> >
> > are you OK with ACPI core changes in this patch ?

Yes, I am.

Please feel free to route it through whatever tree you think would be
appropriate.

Thanks!
