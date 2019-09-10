Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF0CAEF5A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2019 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394110AbfIJQQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Sep 2019 12:16:41 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42006 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbfIJQQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Sep 2019 12:16:41 -0400
Received: by mail-yw1-f68.google.com with SMTP id i207so6637332ywc.9;
        Tue, 10 Sep 2019 09:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDQLIng6kCw7wl/fv02qjtPxeGZB6gd6OThPCSovKTs=;
        b=LjDrRh4W31/m10U40aUMoKxR0cgMfqwGtYeBrZlHgiNbgMaLMKzRw14ygyw8R3YJds
         Jt5VmvBmfdNiyRSDbpKX/BnDjzUNTdt+d9TATzlVAr/q8O5UfleVeG/38/k4N88pAqUu
         U+CGVo06PqUCYDOgW0z13zeiVpD6J5fa0GevbiyofE7ej6liii51wbJLM1BKYYCCM8pW
         wr5HiFjpVnOguw0HtbB5Z/ItdD/hlhpEp2RtBkhoK05k2QjAC5iion3DB1jPDlVkoc+0
         vaFpuRp0aHdsoFOySzLP4IwdmaODghkOTfX/eBq1ltEYseGABQrLQzyKtIwJ/yGTffRc
         ak3A==
X-Gm-Message-State: APjAAAUC5rKu8dhq81dQB+3zgTjyxYLGjat+y4C5T0SHYXz2XRvSI4Wz
        TZ9QPUgCYPjCZYMU8zMFGxjZg2WyvwZnWZEUvZw=
X-Google-Smtp-Source: APXvYqzmsL42TZRBK6S3XMFhX7UkHuUJCmUwDrJ9agMT2fIQE8XEq9em+k3KCl5sn2MIVcOApA8FI+6GaRs+DWfpqxU=
X-Received: by 2002:a81:8105:: with SMTP id r5mr20891732ywf.489.1568132199817;
 Tue, 10 Sep 2019 09:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190910122514epcas5p4f00c0f999333dd7707c0a353fd06b57f@epcas5p4.samsung.com>
 <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com> <20190910135813.GK9720@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190910135813.GK9720@e119886-lin.cambridge.arm.com>
From:   Pankaj Dubey <pankaj.dubey@samsung.com>
Date:   Tue, 10 Sep 2019 21:46:28 +0530
Message-ID: <CAGcde9F6dTGga6Rxo62PPk3AMb3tK8oqo9K6Zi=0TbnFktmQQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: dwc: Add support to disable GEN3 equalization
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anvesh Salveru <anvesh.s@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Sep 2019 at 19:56, Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Tue, Sep 10, 2019 at 05:55:01PM +0530, Pankaj Dubey wrote:
> > From: Anvesh Salveru <anvesh.s@samsung.com>
> >
> > In some platforms, PCIe PHY may have issues which will prevent linkup
> > to happen in GEN3 or high speed. In case equalization fails, link will
> > fallback to GEN1.
>
> When you refer to "high speed", do you mean "higher speeds" as in GEN3,
> GEN4, etc?
>

Yes. Will reword the commit message as "higher speeds"

> >
> > Designware controller has support for disabling GEN3 equalization if
> > required. This patch enables the designware driver to disable the PCIe
> > GEN3 equalization by writing into PCIE_PORT_GEN3_RELATED.
>
> Thus limiting to GEN2 speeds max, right?
>
> Is the purpose of PORT_LOGIC_GEN3_EQ_DISABLE to disable GEN3 and above
> even though we advertise GEN3 and above speeds? I.e. the IP advertises
> GEN3 but the phy can't handle it, we can't change what the IP advertises
> and so we disable equalization to limit to GEN2?
>
> I notice many of the other dwc drivers (dra7xx, keystone, tegra194, imx6)
> seem to use the device tree to specify a max-link-speed and then impose
> that limit by changing the value in PCI_EXP_LNKCAP. Is your
> PORT_LOGIC_GEN3_EQ_DISABLE approach and alternative to the PCI_EXP_LNKCAP
> approach, or does your approach add something else?
>

No, max speed will be still as per advertised by link or it will be
equal to the limited speed as per DT property if any.
This register will prohibit to perform all phases of equalization and
thus allowing link to happen in maximum supported/advertised speed.

This is not to limit max link speed, this register helps link to
happen in higher speeds (GEN3/4) without going through equalization
phases. It is intended to use only if at all link fails to latch up in
GEN3/4 due to failure in equalization phases.

> >
> > Platform drivers can disable equalization by setting the dwc_pci_quirk
> > flag DWC_EQUALIZATION_DISABLE.
> >
> > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
> >  drivers/pci/controller/dwc/pcie-designware.h | 7 +++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 7d25102..bf82091 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -466,4 +466,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >               break;
> >       }
> >       dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +
> > +     val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > +
> > +     if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE)
> > +             val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> > +
> > +     dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
>
> The problem here is that even when DWC_EQUALIZATION_DISABLE is not set
> the driver will read and write PCIE_PORT_GEN3_RELATED when it is not
> needed. How about something like:
>
> > +
> > +     if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE) {
> > +             val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > +             val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> > +             dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > +     }
>

Yes, before posting we taught about it, but then next patchset is
adding one more quirk and in that case we need to repeat read and
write under each if condition. I hope that repetition should be fine.

> >  }
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index ffed084..a1453c5 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -29,6 +29,9 @@
> >  #define LINK_WAIT_MAX_IATU_RETRIES   5
> >  #define LINK_WAIT_IATU                       9
> >
> > +/* Parameters for PCIe Quirks */
> > +#define DWC_EQUALIZATION_DISABLE     0x1
>
> How about using BIT(1) instead? Thus implying that you can combine
> quirks.
>

Agreed.

> Thanks,
>
> Andrew Murray
>
> > +
> >  /* Synopsys-specific PCIe configuration registers */
> >  #define PCIE_PORT_LINK_CONTROL               0x710
> >  #define PORT_LINK_MODE_MASK          GENMASK(21, 16)
> > @@ -60,6 +63,9 @@
> >  #define PCIE_MSI_INTR0_MASK          0x82C
> >  #define PCIE_MSI_INTR0_STATUS                0x830
> >
> > +#define PCIE_PORT_GEN3_RELATED               0x890
> > +#define PORT_LOGIC_GEN3_EQ_DISABLE   BIT(16)
> > +
> >  #define PCIE_ATU_VIEWPORT            0x900
> >  #define PCIE_ATU_REGION_INBOUND              BIT(31)
> >  #define PCIE_ATU_REGION_OUTBOUND     0
> > @@ -244,6 +250,7 @@ struct dw_pcie {
> >       struct dw_pcie_ep       ep;
> >       const struct dw_pcie_ops *ops;
> >       unsigned int            version;
> > +     unsigned int            dwc_pci_quirk;
> >  };
> >
> >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> > --
> > 2.7.4
> >
