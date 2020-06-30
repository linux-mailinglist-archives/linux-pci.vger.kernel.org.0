Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48520FF77
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgF3VuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 17:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbgF3VuT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 17:50:19 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9986D2077D;
        Tue, 30 Jun 2020 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593553818;
        bh=ps1O6n5AnikolRhBCTihXbQMNSMQfOZXAH36HgCoRS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WL8mIUlvP8ZdPw97GTFDhLE9owK5PSRrzSYFoyrfrPy7s6zYlX4vGfNy0fqqs/2oh
         el9Aov4LRM2pzOeyBjVVPOwgDWzB2EipRzYWknIge+BAXW4Ump22ZlnusvWs75GUYZ
         7+yeYxD7tbCNEwxePoIMEH2LsV9pocliXL/hIIcE=
Received: by mail-oi1-f177.google.com with SMTP id k4so18769655oik.2;
        Tue, 30 Jun 2020 14:50:18 -0700 (PDT)
X-Gm-Message-State: AOAM533mM9hB1pBsguGfBe1VXNmnuG/xlwveJ4YKEL+IhFcbccax7JzJ
        XOaAHM4BNbd95vfRMWhYAQsemGaFJdiGULxAFQ==
X-Google-Smtp-Source: ABdhPJzCDnjeyS6viPAYkeruMzz+Xbix7X+IUVSkcFqPPKsJXUmSUC2CQjq4+pFIKX1D4r7LaJBSvTlLXTtZij02xWI=
X-Received: by 2002:aca:6004:: with SMTP id u4mr18457843oib.106.1593553817987;
 Tue, 30 Jun 2020 14:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com> <20200619082013.13661-8-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200619082013.13661-8-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 30 Jun 2020 15:50:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK45W7i0jWum4_FL9+ZRzF8W-m2zzDTmJpRKwmyGDzAjw@mail.gmail.com>
Message-ID: <CAL_JsqK45W7i0jWum4_FL9+ZRzF8W-m2zzDTmJpRKwmyGDzAjw@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] of/device: Add input id to of_dma_configure()
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

On Fri, Jun 19, 2020 at 2:20 AM Lorenzo Pieralisi
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
>  drivers/bus/fsl-mc/fsl-mc-bus.c |  4 +-
>  drivers/iommu/of_iommu.c        | 81 ++++++++++++++++++---------------
>  drivers/of/device.c             |  8 ++--
>  include/linux/of_device.h       | 16 ++++++-
>  include/linux/of_iommu.h        |  6 ++-
>  5 files changed, 70 insertions(+), 45 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
