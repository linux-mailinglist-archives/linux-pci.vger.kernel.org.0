Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A7F20FF9F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 23:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgF3Vz2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 17:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbgF3Vz1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 17:55:27 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E937F2082F;
        Tue, 30 Jun 2020 21:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593554127;
        bh=9zUNEj5oN5SAHU+Io1r3um4tcIvwZ7eKxubOap/7K8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lpGi+UmK0xrOa0TnvN84TL80dShRY2LD83QbJjVdqwdL5m3Bcxg4ix7D/UuXS8syi
         Ev+0nVmOMYLw7+nSwWZkTvd0gLh4Th+p8+Y4MjVXO1Sj+xx1LLWyiIFHkV3rDqMVi9
         69gmggX4k/RoeEtt5QNR7yZ1qhn8NYYdA7/rfDZ0=
Received: by mail-ot1-f44.google.com with SMTP id t18so6951238otq.5;
        Tue, 30 Jun 2020 14:55:26 -0700 (PDT)
X-Gm-Message-State: AOAM532XwCDvzTd5SEJHZFZ5IILy//gN0IIB6bonXGk2cGIYYZqo/otd
        yXh1iu1y676s3arXJ7rtaRYbIwhZAAkkg2lOeA==
X-Google-Smtp-Source: ABdhPJyyXxnAxH4wFWhtv/D22m3Q6cMFmZqY7qj0MphhN0JdR130l2+haUVcQhVV5W4bGOQJ2dvD35JH+WEsZ6nyYQ4=
X-Received: by 2002:a9d:3a36:: with SMTP id j51mr20268426otc.129.1593554126266;
 Tue, 30 Jun 2020 14:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com> <20200619082013.13661-9-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200619082013.13661-9-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 30 Jun 2020 15:55:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLdq16MR8W96G9CfEcUytY+957Mm8PDXwBgkCk1=A_wAg@mail.gmail.com>
Message-ID: <CAL_JsqLdq16MR8W96G9CfEcUytY+957Mm8PDXwBgkCk1=A_wAg@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 19, 2020 at 2:20 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> The existing bindings cannot be used to specify the relationship
> between fsl-mc devices and GIC ITSes.
> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
> msi-map property.
> In addition, deprecate msi-parent property which no longer makes sense
> now that we support translating the MSIs.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 50 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
