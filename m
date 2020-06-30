Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C72920FFB9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 23:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgF3V46 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 17:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgF3V45 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 17:56:57 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 894F22081A;
        Tue, 30 Jun 2020 21:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593554216;
        bh=Adv2/880uaGmJ4dh7B8Ggp1jOzWVuFLpdGHKuacuBSw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GMhKMpQXblH1a/O0fh0GOyzv0WdIbAgigYUIXgIAMqAQBQYyuGUUiR7a4bXIbrKXP
         jSMkLwxseVcB08wHZ8iOBf9Ur1bnzq1KAVWRVjtAtDx2Jydyl5PDsl3h2NRgufA90O
         GfgsXG1AM3yGjmVEv5NbLUZnyer9jMJLB0Hf0fNU=
Received: by mail-ot1-f49.google.com with SMTP id k15so19720781otp.8;
        Tue, 30 Jun 2020 14:56:56 -0700 (PDT)
X-Gm-Message-State: AOAM531ThqE3txRgotY/tZYBEvee3SvQ9feuqZZL6uMMzvIN+DP3/A5z
        bf+w8+LQ8+AoMqFNn5gP/MfsyY4BkDKU2Aj52g==
X-Google-Smtp-Source: ABdhPJyKDbfQDtx3HWuOj8pgh2vtwwUduqe+y/gv6f3hKh8dipeWe6XCyppTBRvPXxLq1UHPOfwznTH5xUq/MCLPMuw=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr18672129otb.107.1593554215926;
 Tue, 30 Jun 2020 14:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com> <20200619082013.13661-11-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200619082013.13661-11-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 30 Jun 2020 15:56:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLPScU4be1tatPFqL4BpBdm5KgwzT79Hyjm_atAHPgm3Q@mail.gmail.com>
Message-ID: <CAL_JsqLPScU4be1tatPFqL4BpBdm5KgwzT79Hyjm_atAHPgm3Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] of/irq: Make of_msi_map_rid() PCI bus agnostic
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
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
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 19, 2020 at 2:20 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> There is nothing PCI bus specific in the of_msi_map_rid()
> implementation other than the requester ID tag for the input
> ID space. Rename requester ID to a more generic ID so that
> the translation code can be used by all busses that require
> input/output ID translations.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/irq.c       | 28 ++++++++++++++--------------
>  drivers/pci/msi.c      |  2 +-
>  include/linux/of_irq.h |  8 ++++----
>  3 files changed, 19 insertions(+), 19 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
