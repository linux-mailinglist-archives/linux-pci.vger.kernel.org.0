Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9D839D6
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfHFTuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 15:50:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46417 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfHFTuh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2019 15:50:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so89048488wru.13
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2019 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGaKvQFsZgZRc0gqerogxzfGiThuXifNLB2OEC0cIoY=;
        b=KcpdUETMBYuJyx4JKxpCZkDiJd9PgHCJ+KVUsKbiK69I/uNOk1diB7NGlPKuUTgu03
         5bvA0tDzp9uxmVSvU3Lv5Kpo7zoW4UH6UPRVZc6txr//tC1JsGtF6JpWd1zZHIskDlEb
         TiRFuGrOZGzTrirywRRsM6BJdkmLwC1GzPQDKM/xujPh5hjKsBo+NZHsVRyUVRK6xBU2
         vJqGL0IWeQCMCKJQRh7DG0Ngjau29xL3YjVRvzBQoh73f4JOplrpPqhkR0G094ZbQUaY
         Grq5Qh03BfsG/86N1AeD7/6qVYclfLMGsRTp4j/jG1NhjPNzUa1Pc3kMLtmlv43w7HEU
         F9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGaKvQFsZgZRc0gqerogxzfGiThuXifNLB2OEC0cIoY=;
        b=rQZgTOaF8UZRbUT7w2A3QsG+EHOWVbqU1rNAdA5Sq0RHsLfsNqPN+39ULQfIvnaovq
         DzLUYmwoQDtXWU6IJQCbXlgUQQNIdQjeb9gbXHgrJzFRRFGMWZgpBSAkslv3NUwzm7LC
         MIrBbyyGf6rvUvK50XdOSnzBMZNu72ml9e4nctY/uyRM9i1HKrsxCGWki+pllzSEViPN
         gdH+TZjLCYBDM/s7iEzVUmGBugTwLvoRXJCk4fBxDayDjAufxk5qSe/HSi+fHPwGXMbS
         PDPOyrN9/yra7r70vrKdO5N1jpTFdR9NtbboiuECF/8LOGRTLcRlrPmNgCPCCEvfO1Kx
         AdBQ==
X-Gm-Message-State: APjAAAWQR26DKFBieZJuLWmgY5wdLIs72qt4yn+eAcQjyYlo8q7U3cHf
        Hpc04NXu7jli4H7c6QYJvPAiHIP/x+bZ2II3xFHN
X-Google-Smtp-Source: APXvYqyDnhoa/uCrTWnPgUp2jKiHChoqXQq+xQxY9yMjyk5SXnWI/bXZHLptGN4xGZpSOxpD0VQaSeeW0iGW7hI8NOM=
X-Received: by 2002:a5d:6650:: with SMTP id f16mr6385465wrw.89.1565121033666;
 Tue, 06 Aug 2019 12:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190628073425.25165-1-jianjun.wang@mediatek.com>
 <20190628073425.25165-3-jianjun.wang@mediatek.com> <1564385918.17211.6.camel@mhfsdcap03>
 <20190806162432.GA15498@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190806162432.GA15498@e121166-lin.cambridge.arm.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 6 Aug 2019 14:50:20 -0500
Message-ID: <CAErSpo5AVXekj8hWxDbf+zTwv9WmQessdBppNrVtOWOkuTREtA@mail.gmail.com>
Subject: Re: [v2,2/2] PCI: mediatek: Add controller support for MT7629
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        youlin.pei@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 6, 2019 at 11:24 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> [trim the CC list please to keep only required maintainers]
>
> On Mon, Jul 29, 2019 at 03:38:38PM +0800, Jianjun Wang wrote:
> > On Fri, 2019-06-28 at 15:34 +0800, Jianjun Wang wrote:
> > > MT7629 is an ARM platform SoC which has the same PCIe IP with MT7622.
> > >
> > > The HW default value of its Device ID is invalid, fix its Device ID to
> > > match the hardware implementation.
> > >
> > > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek.c | 18 ++++++++++++++++++
> > >  include/linux/pci_ids.h                |  1 +
> > >  2 files changed, 19 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > index 80601e1b939e..e5e6740b635d 100644
> > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > @@ -73,6 +73,7 @@
> > >  #define PCIE_MSI_VECTOR            0x0c0
> > >
> > >  #define PCIE_CONF_VEND_ID  0x100
> > > +#define PCIE_CONF_DEVICE_ID        0x102
> > >  #define PCIE_CONF_CLASS_ID 0x106
> > >
> > >  #define PCIE_INT_MASK              0x420
> > > @@ -141,12 +142,16 @@ struct mtk_pcie_port;
> > >  /**
> > >   * struct mtk_pcie_soc - differentiate between host generations
> > >   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> > > + * @need_fix_device_id: whether this host's Device ID needed to be fixed or not
> > > + * @device_id: Device ID which this host need to be fixed
> > >   * @ops: pointer to configuration access functions
> > >   * @startup: pointer to controller setting functions
> > >   * @setup_irq: pointer to initialize IRQ functions
> > >   */
> > >  struct mtk_pcie_soc {
> > >     bool need_fix_class_id;
> > > +   bool need_fix_device_id;
> > > +   unsigned int device_id;
> > >     struct pci_ops *ops;
> > >     int (*startup)(struct mtk_pcie_port *port);
> > >     int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> > > @@ -696,6 +701,9 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > >             writew(val, port->base + PCIE_CONF_CLASS_ID);
> > >     }
> > >
> > > +   if (soc->need_fix_device_id)
> > > +           writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
> > > +
> > >     /* 100ms timeout value should be enough for Gen1/2 training */
> > >     err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
> > >                              !!(val & PCIE_PORT_LINKUP_V2), 20,
> > > @@ -1216,11 +1224,21 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
> > >     .setup_irq = mtk_pcie_setup_irq,
> > >  };
> > >
> > > +static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
> > > +   .need_fix_class_id = true,
> > > +   .need_fix_device_id = true,
> > > +   .device_id = PCI_DEVICE_ID_MEDIATEK_7629,
> > > +   .ops = &mtk_pcie_ops_v2,
> > > +   .startup = mtk_pcie_startup_port_v2,
> > > +   .setup_irq = mtk_pcie_setup_irq,
> > > +};
> > > +
> > >  static const struct of_device_id mtk_pcie_ids[] = {
> > >     { .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
> > >     { .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
> > >     { .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
> > >     { .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_mt7622 },
> > > +   { .compatible = "mediatek,mt7629-pcie", .data = &mtk_pcie_soc_mt7629 },
> > >     {},
> > >  };
> > >
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > index 70e86148cb1e..aa32962759b2 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -2131,6 +2131,7 @@
> > >  #define PCI_VENDOR_ID_MYRICOM              0x14c1
> > >
> > >  #define PCI_VENDOR_ID_MEDIATEK             0x14c3
> > > +#define PCI_DEVICE_ID_MEDIATEK_7629        0x7629
> > >
> > >  #define PCI_VENDOR_ID_TITAN                0x14D2
> > >  #define PCI_DEVICE_ID_TITAN_010L   0x8001
> >
> > Hi Bjorn & Lorenzo,
> >
> > Is this patch ok or is there anything I need to fixed?
>
> The commit log need to be fixed and I will do it, the code if
> Bjorn is OK with it I can merge it.

Sure, I'm fine with this.  I don't think there's a need to add
PCI_DEVICE_ID_MEDIATEK_7629, since it's only used in one place, but
I'm fine with the code.
