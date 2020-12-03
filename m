Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7BC2CCFE0
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 07:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgLCGyD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 01:54:03 -0500
Received: from foss.arm.com ([217.140.110.172]:60474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgLCGyC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 01:54:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 132481435;
        Wed,  2 Dec 2020 22:53:17 -0800 (PST)
Received: from mail-pg1-f170.google.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 015753FA35;
        Wed,  2 Dec 2020 22:53:17 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id n7so840978pgg.2;
        Wed, 02 Dec 2020 22:53:16 -0800 (PST)
X-Gm-Message-State: AOAM530TqgLMHSp5GPM3ZBNgVnwA2UWn0wXpHFeBGlbw7dhFECh4R/9q
        5RJyjl89AUn9ptqxRz2iug3MHf4UOLkbHBnlues=
X-Google-Smtp-Source: ABdhPJygtekmLjjncvjFwG4SdpDCdLwfKHAXG6gTy9UWIl0OW84LFK0WMjkvnr+8NjJZe42RTQB3PnaS/Udv9iPQkrg=
X-Received: by 2002:a62:790f:0:b029:18a:ae57:353f with SMTP id
 u15-20020a62790f0000b029018aae57353fmr1698141pfc.78.1606978392331; Wed, 02
 Dec 2020 22:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
From:   Vivek Gautam <vivek.gautam@arm.com>
Date:   Thu, 3 Dec 2020 12:22:59 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHAiZ22t9gOv04HfYGeFdmKxTYhLb0yXDPo0bgcSfHUSg@mail.gmail.com>
Message-ID: <CAFp+6iHAiZ22t9gOv04HfYGeFdmKxTYhLb0yXDPo0bgcSfHUSg@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] iommu: I/O page faults for SMMUv3
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        lorenzo.pieralisi@arm.com, "robh+dt" <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-acpi@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>, guohanjun@huawei.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        sudeep.holla@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        zhangfei.gao@linaro.org, Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,


On Thu, Nov 12, 2020 at 6:33 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Add support for stall and PRI to the SMMUv3 driver, along with a common
> I/O Page Fault handler.
>
> These patches were last sent as part of v7 of the larger SVA series [1].
> Main changes since v7:
> * Dropped CONFIG_IOMMU_PAGE_FAULT, reuse CONFIG_IOMMU_SVA_LIB instead.
> * Extracted devicetree support into patch 4.
> * Added patch 5 for ACPI support.
> * Dropped event queue flush on unbind(). Since device drivers must
>   complete DMA transactions before calling unbind(), there cannot be any
>   pending stalled event.
> * A few small fixes.
>
> The series depends on "iommu/sva: Add PASID helpers" [2], since it
> provides the function to search an mm_struct by PASID.
>
> Has anyone been testing the PRI patches on hardware? I still only have a
> software model to test them, so as much as I'd like to cross this off my
> list, we could leave out patches 7-9 for now.
>
I have been testing this series for sometime now with a RDN1Edge platform model.
The public model for N1-Edge rd FVP can be found at [A].
With reference software [B] and your kernel branch with smmute [C], I
was able to
test smmute by initiating different DMA transactions. With model logs I was able
to validate ATS and PRI command flows as well.
So I am happy to give my tested-by tag.

Tested-by: Vivek Gautam <vivek.gautam@arm.com>

Best regards
Vivek

[A] https://developer.arm.com/tools-and-software/open-source-software/arm-platforms-software/arm-ecosystem-fvps
[B] https://git.linaro.org/landing-teams/working/arm/arm-reference-platforms.git/about/docs/rdn1edge/user-guide.rst
[C] https://jpbrucker.net/git/linux/log/?h=sva/smmute-2020-11-12

> [1] https://lore.kernel.org/linux-iommu/20200519175502.2504091-1-jean-philippe@linaro.org/
> [2] https://lore.kernel.org/linux-iommu/20201106155048.997886-1-jean-philippe@linaro.org/
>
> Jean-Philippe Brucker (9):
>   iommu: Add a page fault handler
>   iommu/arm-smmu-v3: Maintain a SID->device structure
>   dt-bindings: document stall property for IOMMU masters
>   of/iommu: Support dma-can-stall property
>   ACPI/IORT: Enable stall support for platform devices
>   iommu/arm-smmu-v3: Add stall support for platform devices
>   PCI/ATS: Add PRI stubs
>   PCI/ATS: Export PRI functions
>   iommu/arm-smmu-v3: Add support for PRI
>
>  drivers/iommu/Makefile                        |   1 +
>  .../devicetree/bindings/iommu/iommu.txt       |  18 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  69 +-
>  drivers/iommu/iommu-sva-lib.h                 |  53 ++
>  include/linux/iommu.h                         |   4 +
>  include/linux/pci-ats.h                       |   7 +
>  drivers/acpi/arm64/iort.c                     |   1 +
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  52 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 605 +++++++++++++++---
>  drivers/iommu/io-pgfault.c                    | 462 +++++++++++++
>  drivers/iommu/of_iommu.c                      |   5 +-
>  drivers/pci/ats.c                             |   4 +
>  12 files changed, 1191 insertions(+), 90 deletions(-)
>  create mode 100644 drivers/iommu/io-pgfault.c
>
> --
> 2.29.1
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
