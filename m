Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672A9AEF78
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2019 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394173AbfIJQVx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Sep 2019 12:21:53 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45440 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394159AbfIJQVx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Sep 2019 12:21:53 -0400
Received: by mail-yb1-f196.google.com with SMTP id u32so6310430ybi.12;
        Tue, 10 Sep 2019 09:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EFG8GMdoWm20YXUmdUc6sNlJ41b0YnBqTWjjuYQ4/s=;
        b=QdFBV7YRAWNNhYpMK0eB/qNvC7NgXODYdXUbQKw7FmaL+LkvmDXOiG4PzXLEGi/add
         hB/6CH/z5zlqs0maskH4TWI3942fjOa4MLFigJUAktlUo40FcgsUVsSRTOEDm0XS6jL0
         vfDZgnaI2+4LntOz1tvF1uozglJYM2L3r05c5QHcrIPfcuXg/cusUp6y40DVrcsUiYoH
         +4FiyNEytQGrez/aObzgq+UekOyf5/d8uBabgU9uDp+AJokxGkzVZ/6qPy8Qy6ME8qw8
         YkFDKyhvxM10+VEfcGL8zTdyD79CEN+RfXF+BNq5DunBrxO0TlLHAkCQXR70sET1WADp
         CxhQ==
X-Gm-Message-State: APjAAAWVGf33FQVSr1Pn1BfhF5bYaRd9EhKBr1Fj+X9JGb65162w4ROm
        HdfhbusD2wS5B0ibB/9ICSH9EskaMzdTcEkZG2Y=
X-Google-Smtp-Source: APXvYqyF3P9idq9zDTrvwWz84GVFga/Fi7j8wWBkRUutPwTrSqHwy0A+Nquvmx/x12REHS9GnaJGK0BdinGOVMfYFUE=
X-Received: by 2002:a5b:645:: with SMTP id o5mr21428343ybq.175.1568132512518;
 Tue, 10 Sep 2019 09:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <1568118302-10505-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20190910122520epcas5p1faeb16f7c38ee057ce93783a637e6bf4@epcas5p1.samsung.com>
 <1568118302-10505-2-git-send-email-pankaj.dubey@samsung.com> <20190910140502.GL9720@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190910140502.GL9720@e119886-lin.cambridge.arm.com>
From:   Pankaj Dubey <pankaj.dubey@samsung.com>
Date:   Tue, 10 Sep 2019 21:51:41 +0530
Message-ID: <CAGcde9Fm+WGamjAC6R4jmaShMYxAoCsofggfwdJ7viYt3NE_sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: dwc: Add support to disable equalization phase 2
 and 3
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

On Tue, 10 Sep 2019 at 19:59, Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Tue, Sep 10, 2019 at 05:55:02PM +0530, Pankaj Dubey wrote:
> > From: Anvesh Salveru <anvesh.s@samsung.com>
> >
> > In some platforms, PCIe PHY may have issues which will prevent linkup
> > to happen in GEN3 or high speed. In case equalization fails, link will
> > fallback to GEN1.
> >
> > Designware controller gives flexibility to disable GEN3 equalization
> > completely or only phase 2 and 3.
>
> Do some platforms have issues conducting phase 2 and 3 when they successfully
> conduct phase 0 and 1?
>

Yes, it is possible.

> >
> > Platform drivers can disable equalization phase 2 and 3, by setting
> > dwc_pci_quirk flag DWC_EQUALIZATION_DISABLE.
> >
> > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 3 +++
> >  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index bf82091..97a8268 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -472,5 +472,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >       if (pci->dwc_pci_quirk & DWC_EQUALIZATION_DISABLE)
> >               val |= PORT_LOGIC_GEN3_EQ_DISABLE;
> >
> > +     if (pci->dwc_pci_quirk & DWC_EQ_PHASE_2_3_DISABLE)
> > +             val |= PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
> > +
> >       dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> >  }
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index a1453c5..b541508 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -31,6 +31,7 @@
> >
> >  /* Parameters for PCIe Quirks */
> >  #define DWC_EQUALIZATION_DISABLE     0x1
> > +#define DWC_EQ_PHASE_2_3_DISABLE     0x2
>
> It only makes sense for either DWC_EQUALIZATION_DISABLE or DWC_EQ_PHASE_2_3_DISABLE
> to be specified, though if dwc_pci_quirk intends to hold other quirks should these
> be numbers and not bit fields?
>
Yes, you are right in a given platform it will be either
DWC_EQUALIZATION_DISABLE or DWC_EQ_PHASE_2_3_DISABLE.

Intention behind making it bit-field was to add other quirks in future.

> Thanks,
>
> Andrew Murray
>
> >
> >  /* Synopsys-specific PCIe configuration registers */
> >  #define PCIE_PORT_LINK_CONTROL               0x710
> > @@ -65,6 +66,7 @@
> >
> >  #define PCIE_PORT_GEN3_RELATED               0x890
> >  #define PORT_LOGIC_GEN3_EQ_DISABLE   BIT(16)
> > +#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE BIT(9)
> >
> >  #define PCIE_ATU_VIEWPORT            0x900
> >  #define PCIE_ATU_REGION_INBOUND              BIT(31)
> > --
> > 2.7.4
> >
