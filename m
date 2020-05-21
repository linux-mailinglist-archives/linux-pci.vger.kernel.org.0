Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41341DDAAB
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 01:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgEUXCd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 19:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgEUXCd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 19:02:33 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCFE2088E;
        Thu, 21 May 2020 23:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590102152;
        bh=u4I01Bd2QyL8HPxDkUrMsX0HSNDq0LynubrHvmfSbXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RiYUJx3r0NSHRBi8CE9gwpJPXRgz5WqYyZuoDvG/k/mV29oeCTMPA50Plh9HX9ac9
         ymVWclaGK1LCxKJKteoWzNj5exfqEiApBISSekxqsOLadecgNFhpB0S6E23smC/RO1
         UqBvA944tDh1FRa8/kjEC+nhcFSqtsgenhggmGKc=
Received: by mail-oi1-f174.google.com with SMTP id x23so7721380oic.3;
        Thu, 21 May 2020 16:02:32 -0700 (PDT)
X-Gm-Message-State: AOAM530qO+4fdgT+VLFZuUJYwh6N36Rh8ynDUzMFekqIl8PB/Hcf3Mfw
        uLUgcVEs2Sha1hvnQ6zdZ2QNJDfZLDo5RZBjdw==
X-Google-Smtp-Source: ABdhPJyTEOAtWUCXqQRm64QnwpCZ0isYcN6LyugKOxRT91W8qbotthhsTXaUlNcGWLVO8KSMeec5LvCcv0JMwyl2JAA=
X-Received: by 2002:a05:6808:7cb:: with SMTP id f11mr710834oij.152.1590102151546;
 Thu, 21 May 2020 16:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com> <20200521130008.8266-8-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200521130008.8266-8-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 21 May 2020 17:02:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJw3wyiUrbd1AekwDc5+uqhHi9BwoB-rYpypUEGNgzCtw@mail.gmail.com>
Message-ID: <CAL_JsqJw3wyiUrbd1AekwDc5+uqhHi9BwoB-rYpypUEGNgzCtw@mail.gmail.com>
Subject: Re: [PATCH 07/12] of/device: Add input id to of_dma_configure()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Devices sitting on proprietary busses have a device ID space that
> is owned by the respective bus and related firmware bindings. In order
> to let the generic OF layer handle the input translations to
> an IOMMU id, for such busses the current of_dma_configure() interface
> should be extended in order to allow the bus layer to provide the
> device input id parameter - that is retrieved/assigned in bus
> specific code and firmware.
>
> Augment of_dma_configure() to add an optional input_id parameter,
> leaving current functionality unchanged.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c |  4 ++-
>  drivers/iommu/of_iommu.c        | 53 +++++++++++++++++++++------------
>  drivers/of/device.c             |  8 +++--
>  include/linux/of_device.h       | 16 ++++++++--
>  include/linux/of_iommu.h        |  6 ++--
>  5 files changed, 60 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 40526da5c6a6..8ead3f0238f2 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -118,11 +118,13 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  static int fsl_mc_dma_configure(struct device *dev)
>  {
>         struct device *dma_dev = dev;
> +       struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> +       u32 input_id = mc_dev->icid;
>
>         while (dev_is_fsl_mc(dma_dev))
>                 dma_dev = dma_dev->parent;
>
> -       return of_dma_configure(dev, dma_dev->of_node, 0);
> +       return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
>  }
>
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index ad96b87137d6..4516d5bf6cc9 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -139,25 +139,53 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>         return err;
>  }
>
> -static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
> -                               struct device_node *master_np)
> +static int of_iommu_configure_dev_id(struct device_node *master_np,
> +                                    struct device *dev,
> +                                    const u32 *id)

Should have read this patch before #6. I guess you could still make
of_pci_iommu_init() call
of_iommu_configure_dev_id.

Rob
