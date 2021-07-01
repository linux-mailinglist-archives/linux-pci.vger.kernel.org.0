Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2E03B953B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhGARKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 13:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhGARKS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 13:10:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD0EB613FD;
        Thu,  1 Jul 2021 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625159267;
        bh=aTKWcebr4gvOdJEh+MwCAWFIMDCqNX7Qa2V/EBQEtiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mye9w1C+v7xkZ4mI1bW7x1IG6ac5vQpTckShNCuuKVKP+2KFUsvI/rRjEsUINs/zS
         Qb14K3Imigs8QXCmpfUEyccNUfVPmu1kOCqb6pBX3w8NAz8zBoW/2l7WieidNXtSMB
         LOqwVMEcI7V5smYsxjJlY62256PRGa+zidPJ/OaThDjy6L/T7t9p5IEIKaFnOCGLAR
         jQ5nRHJHPWPFnFJATfyuOXc1X3LpGtaDLpuIjqRrArf+LulFJsPx16glpAzo1KvOB7
         qEL1wcxyX78a4HERA5tkevE7XHHJnK0P+nXFaXPBaWTCLEvx9RBtpWNykBCVFDpgKd
         cpqOdnK48CJng==
Received: by mail-ej1-f50.google.com with SMTP id gt10so10209744ejc.5;
        Thu, 01 Jul 2021 10:07:47 -0700 (PDT)
X-Gm-Message-State: AOAM533EQFQAEHmE41PpIid1ojKpkrckXg/NepMHVOSUfDZE+Hqr1qfg
        ioghYBXWTmSuvbY+8MVUNWl3ijBwALOE/bizbg==
X-Google-Smtp-Source: ABdhPJxMUoof2kutwTR0KYkA8LrVVB8luU4gaBx2d5dFt2FtiQBOmrHMMm++Vt9EmJelAopleLH0UPhrp23B32WUcg0=
X-Received: by 2002:a17:906:1951:: with SMTP id b17mr983711eje.468.1625159266413;
 Thu, 01 Jul 2021 10:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210619063952.2008746-1-art@khadas.com> <20210619063952.2008746-3-art@khadas.com>
In-Reply-To: <20210619063952.2008746-3-art@khadas.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Jul 2021 11:07:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKV6iV1pbYNqFig5h5bH1cQ3pbdGc35F=sALNKdh2g4HA@mail.gmail.com>
Message-ID: <CAL_JsqKV6iV1pbYNqFig5h5bH1cQ3pbdGc35F=sALNKdh2g4HA@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: core: quirks: add mrrs_limit_quirk
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        art@khadas.com, Nick Xie <nick@khadas.com>, gouwa@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 19, 2021 at 12:40 AM Artem Lapkin <email2tema@gmail.com> wrote:
>
> Prepare new MRRS limit quirk which can replace dublicated functionality

typo

> for some controllers from Loongson, Keystone, DesignWare
>
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  drivers/pci/quirks.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3b..73344ec71 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5612,3 +5612,57 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>                                PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> +
> +/*
> + * Some Loongson PCIe ports have a h/w limitation of
> + * 256 bytes maximum read request size...
> + *
> + * Keystone PCI controller has a h/w limitation of
> + * 256 bytes maximum read request size.
> + *
> + * Amlogic DesignWare PCI controller on Khadas VIM3/VIM3L have some
> + * issue with HDMI scrambled picture and nvme devices
> + * at intensive writing...
> + */
> +static void mrrs_limit_quirk(struct pci_dev *dev)
> +{
> +       struct pci_bus *bus = dev->bus;
> +       struct pci_dev *bridge;
> +       int mrrs;
> +       int mrrs_limit = 256;
> +       static const struct pci_device_id bridge_devids[] = {
> +               { PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_PCIE_PORT_0) },
> +               { PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_PCIE_PORT_1) },
> +               { PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_PCIE_PORT_2) },
> +               { PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_RC_K2HK),
> +                .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },

Seems like checking the class is redundant given the VID and Device ID
seems to be pretty unique.

> +               { PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_RC_K2E),
> +                .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
> +               { PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_RC_K2L),
> +                .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
> +               { PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_RC_K2G),
> +                .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
> +               { PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3) },

This is Amlogic I guess. But they are reusing the IP default values?
Any other vendor that does the same will get the same quirk applied?
These are write-able,
so perhaps the driver should set them to something Amlogic specific.

> +               { 0, },
> +       };
> +
> +       /* look for the matching bridge */
> +       while (!pci_is_root_bus(bus)) {
> +               bridge = bus->self;
> +               bus = bus->parent;
> +               /*
> +                * 256 bytes maximum read request size. They can't handle
> +                * anything larger than this. So force this limit on
> +                * any devices attached under these ports.
> +                */
> +               if (pci_match_id(bridge_devids, bridge)) {

I would invert this to save some indentation:

if (!pci_match_id(bridge_devids, bridge))
    continue;

> +                       mrrs = pcie_get_readrq(dev);
> +                       if (mrrs > mrrs_limit) {
> +                               pci_info(dev, "limiting MRRS %d to %d\n", mrrs, mrrs_limit);
> +                               pcie_set_readrq(dev, mrrs_limit);
> +                       }
> +                       break;
> +               }
> +       }
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, mrrs_limit_quirk);
> --
> 2.25.1
>
