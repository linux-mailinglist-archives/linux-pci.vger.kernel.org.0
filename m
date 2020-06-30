Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987FC20FF87
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 23:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgF3Vu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 17:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgF3Vu6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 17:50:58 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EF322081A;
        Tue, 30 Jun 2020 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593553858;
        bh=Y08yb1+85H5CsPhN8ZHhbI4ulSqWuc3rJJ7/ULdUJNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LfOglyVc53syQnH+ENGGMBJ43MMGwpXaAFiPzBQhdI/fJHlPjgPyT1ZYdY1WJehvq
         2eAP36M/GRNzPxR0NdnQqPx0pWf1+Qu8CDMaH2wi2Z/DcgIoowR0WVyxmfgkTRrZsO
         2msYeR93Pkd6ApEYizVCifZploGHdUvEZDRNlaeM=
Received: by mail-ot1-f54.google.com with SMTP id 72so19760939otc.3;
        Tue, 30 Jun 2020 14:50:58 -0700 (PDT)
X-Gm-Message-State: AOAM530ZJ36y4fMWfbktGJeps0XHxjYb56FXroPEjgiV9CrxDuCNCsTG
        BEhgWFl8PWYC7nfhkXb8Cw8iY/mRbflXl/396A==
X-Google-Smtp-Source: ABdhPJx7pnl9Svudsv4ydHbc2/CjlDVMFTLvVkn6po1+o39FpJpEk6/LM/iNmoDYoPrvmUEdQJboN67w9UvSKjOzwhQ=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr20071478ots.192.1593553857583;
 Tue, 30 Jun 2020 14:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com> <20200619082013.13661-10-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200619082013.13661-10-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 30 Jun 2020 15:50:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKEXOhmK6Mi1BK4UWwc=eZKNoAvfHU-K7DnMcW34fNFdw@mail.gmail.com>
Message-ID: <CAL_JsqKEXOhmK6Mi1BK4UWwc=eZKNoAvfHU-K7DnMcW34fNFdw@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] of/irq: make of_msi_map_get_device_domain() bus agnostic
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 19, 2020 at 2:20 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> From: Diana Craciun <diana.craciun@oss.nxp.com>
>
> of_msi_map_get_device_domain() is PCI specific but it need not be and
> can be easily changed to be bus agnostic in order to be used by other
> busses by adding an IRQ domain bus token as an input parameter.
>
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # pci/msi.c
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/irq.c       | 8 +++++---
>  drivers/pci/msi.c      | 2 +-
>  include/linux/of_irq.h | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
