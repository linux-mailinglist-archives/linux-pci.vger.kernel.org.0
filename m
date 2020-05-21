Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86A1DDAD9
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 01:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgEUXRt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 19:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730716AbgEUXRt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 19:17:49 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 693222100A;
        Thu, 21 May 2020 23:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590103068;
        bh=EyK2DMGY1yaM+F8516LQrBIpk2NNn0s0Z37DLtuZPEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CLhLY45tfjDzW/4QzoCLzjzXDitprZjeX6jCl/TTiDNf1smTgNixutkYBE1Ltk7N+
         bGuj4VCEQRCeGfsupUKY8MgwYvf2v3r3ry5ehzBBz2Vd9XnvyT50v3+/1fYDziASsk
         an0rGuPaYsEVmZTE5CauU7LzvZWPFnLZ8bU6LsLs=
Received: by mail-ot1-f53.google.com with SMTP id 63so6893002oto.8;
        Thu, 21 May 2020 16:17:48 -0700 (PDT)
X-Gm-Message-State: AOAM531oK31t74ap52p2EU9xCDgZmV0OibQTBzdK8ZPFlcpa+pPQk0NM
        xNyF4QMq5u61oots8DalIcTpLv615yH7G6zylA==
X-Google-Smtp-Source: ABdhPJxVgcCXhuH2DfTXSUau1TIQTXIwHoWhmRU4UZnxmjy/ftT6A+o4gIk78ZAgFUEU2gCUM+w/Etpe/R6HZFsyFVk=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr8467347ote.107.1590103067633;
 Thu, 21 May 2020 16:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com> <20200521130008.8266-11-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200521130008.8266-11-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 21 May 2020 17:17:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLTBxX_3KjiEqMfw0qMaTmj_DdPD3j-yMUvrvONPBSvjg@mail.gmail.com>
Message-ID: <CAL_JsqLTBxX_3KjiEqMfw0qMaTmj_DdPD3j-yMUvrvONPBSvjg@mail.gmail.com>
Subject: Re: [PATCH 10/12] of/irq: Make of_msi_map_rid() PCI bus agnostic
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
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
        Will Deacon <will@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> There is nothing PCI bus specific in the of_msi_map_rid()
> implementation other than the requester ID tag for the input
> ID space. Rename requester ID to a more generic ID so that
> the translation code can be used by all busses that require
> input/output ID translations.
>
> Leave a wrapper function of_msi_map_rid() in place to keep
> existing PCI code mapping requester ID syntactically unchanged.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/irq.c       | 28 ++++++++++++++--------------
>  include/linux/of_irq.h | 14 ++++++++++++--
>  2 files changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 48a40326984f..25d17b8a1a1a 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -576,43 +576,43 @@ void __init of_irq_init(const struct of_device_id *matches)
>         }
>  }
>
> -static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
> -                           u32 rid_in)
> +static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
> +                           u32 id_in)
>  {
>         struct device *parent_dev;
> -       u32 rid_out = rid_in;
> +       u32 id_out = id_in;
>
>         /*
>          * Walk up the device parent links looking for one with a
>          * "msi-map" property.
>          */
>         for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
> -               if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
> -                               "msi-map-mask", np, &rid_out))
> +               if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
> +                               "msi-map-mask", np, &id_out))
>                         break;
> -       return rid_out;
> +       return id_out;
>  }
>
>  /**
> - * of_msi_map_rid - Map a MSI requester ID for a device.
> + * of_msi_map_id - Map a MSI ID for a device.
>   * @dev: device for which the mapping is to be done.
>   * @msi_np: device node of the expected msi controller.
> - * @rid_in: unmapped MSI requester ID for the device.
> + * @id_in: unmapped MSI ID for the device.
>   *
>   * Walk up the device hierarchy looking for devices with a "msi-map"
> - * property.  If found, apply the mapping to @rid_in.
> + * property.  If found, apply the mapping to @id_in.
>   *
> - * Returns the mapped MSI requester ID.
> + * Returns the mapped MSI ID.
>   */
> -u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
> +u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
>  {
> -       return __of_msi_map_rid(dev, &msi_np, rid_in);
> +       return __of_msi_map_id(dev, &msi_np, id_in);
>  }
>
>  /**
>   * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
>   * @dev: device for which the mapping is to be done.
> - * @rid: Requester ID for the device.
> + * @id: Device ID.
>   * @bus_token: Bus token
>   *
>   * Walk up the device hierarchy looking for devices with a "msi-map"
> @@ -625,7 +625,7 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
>  {
>         struct device_node *np = NULL;
>
> -       __of_msi_map_rid(dev, &np, id);
> +       __of_msi_map_id(dev, &np, id);
>         return irq_find_matching_host(np, bus_token);
>  }
>
> diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> index 7142a3722758..cf9cb1e545ce 100644
> --- a/include/linux/of_irq.h
> +++ b/include/linux/of_irq.h
> @@ -55,7 +55,12 @@ extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
>                                                         u32 id,
>                                                         u32 bus_token);
>  extern void of_msi_configure(struct device *dev, struct device_node *np);
> -u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
> +u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
> +static inline u32 of_msi_map_rid(struct device *dev,
> +                                struct device_node *msi_np, u32 rid_in)
> +{
> +       return of_msi_map_id(dev, msi_np, rid_in);
> +}
>  #else
>  static inline int of_irq_count(struct device_node *dev)
>  {
> @@ -93,10 +98,15 @@ static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev
>  static inline void of_msi_configure(struct device *dev, struct device_node *np)
>  {
>  }
> +static inline u32 of_msi_map_id(struct device *dev,
> +                                struct device_node *msi_np, u32 id_in)
> +{
> +       return id_in;
> +}
>  static inline u32 of_msi_map_rid(struct device *dev,
>                                  struct device_node *msi_np, u32 rid_in)

Move this out of the ifdef and you only need it declared once.

But again, I think I'd just kill of_msi_map_rid.

>  {
> -       return rid_in;
> +       return of_msi_map_id(dev, msi_np, rid_in);
>  }
>  #endif
>
> --
> 2.26.1
>
