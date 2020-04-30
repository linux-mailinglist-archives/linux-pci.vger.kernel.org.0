Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CBE1C0908
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 23:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgD3VR2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 17:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726626AbgD3VRX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 17:17:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70488C08E859
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 14:17:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d15so9061264wrx.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WL5+R63j920S0bt22y/MPX2pfyBeTnA7YIOS7PRZKQ=;
        b=frQcDQ4WCQVLv5/aD12Lmk0nCBUbfuzzI+xShWJ0lmfghfmg7u5Nyib31+KLW4DWf6
         emuYWTL/tu7itw/WxmjNCM6SVWPFLDFvZQ7ZVwNJ8cWZ/IQGEw25HZT3j5HnFP/80pEI
         bXwkKq1SaFh6ohPsp1ttXqes/+ik4IqrL5Kdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WL5+R63j920S0bt22y/MPX2pfyBeTnA7YIOS7PRZKQ=;
        b=np8o8aId8wuLZJVlK9JKRnDx3DaIHxdM13iahH23N60EDF1N9A04Oibj8Ne7/mIEEY
         L5IiTWRNeJcBXoc9Qqg4UIpKpCO0vdLPEr7aYMSFXunFQGOEHLGXXq2ies2MzBdoaBIn
         H9UCx1N8sm2YfC8cKgR85mm8bddqsCNOfg7zgFurWnU3xrhHy0FJ5k7i503WCzoOUGIH
         W8CfHye+Kv14JAsECrIuI7WasnMPqYy+tdIRdrvbKLnHEdfHAdUR2VuBRMSyOMuR9JQi
         8NB/DGHVcswQgiXhcFL13usHhwgQeaDf14TYlunAt4+InMDMvtQdIv4kHVhFZXxq+9eC
         AOLA==
X-Gm-Message-State: AGi0PubhY4KNe8eUabs7pxwKKXD18bXRTtNzrLTKRGVP56VwWFRhoUDN
        ZJ/52CZHX4NmtXDLkVfWuXAFYKq8075PeNY5tzgRyA==
X-Google-Smtp-Source: APiQypIrbs9SeynjYCjcsyxd3tGq+jY5BQu3eRy4jVk1GxW92FiZ1RNN0wUrj73yIHP4rSrPXj6fVWi+Iva7Qb24Nhw=
X-Received: by 2002:adf:f74f:: with SMTP id z15mr491830wrp.297.1588281441827;
 Thu, 30 Apr 2020 14:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200430185522.4116-5-james.quinlan@broadcom.com> <20200430204017.GA62947@bjorn-Precision-5520>
In-Reply-To: <20200430204017.GA62947@bjorn-Precision-5520>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 30 Apr 2020 17:17:10 -0400
Message-ID: <CA+-6iNzwxL0T130Bww-TkoVWhn_2--a1URu4JktGb6aD6qGjbA@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: brcmstb: disable L0s component of ASPM by default
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 4:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Apr 30, 2020 at 02:55:22PM -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > Some informal internal experiments has shown that the BrcmSTB ASPM L0s
> > savings may introduce an undesirable noise signal on some customers'
> > boards.  In addition, L0s was found lacking in realized power savings,
> > especially relative to the L1 ASPM component.  This is BrcmSTB's
> > experience and may not hold for others.  At any rate, we disable L0s
> > savings by default unless the DT node has the 'brcm,aspm-en-l0s'
> > property.
>
> I assume this works by writing the PCIe Link Capabilities register,
> which is read-only via the config space path used by the generic ASPM
> code, so that code thinks the device doesn't support L0s at all.
Correct.
>
> Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt includes
> an "aspm-no-l0s" property.  It'd be nice if this could use the same
> property.
I'd like to use the existing "aspm-no-l0s" but we'd really like to
have it disabled by default.  I'll probably switch but let me dwell on
it a little.
Thanks, Jim
>
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 2bc913c0262c..bc1d514b19e4 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -44,6 +44,9 @@
> >  #define PCIE_RC_CFG_PRIV1_ID_VAL3                    0x043c
> >  #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK   0xffffff
> >
> > +#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY                    0x04dc
> > +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK 0xc00
> > +
> >  #define PCIE_RC_DL_MDIO_ADDR                         0x1100
> >  #define PCIE_RC_DL_MDIO_WR_DATA                              0x1104
> >  #define PCIE_RC_DL_MDIO_RD_DATA                              0x1108
> > @@ -696,7 +699,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >       int num_out_wins = 0;
> >       u16 nlw, cls, lnksta;
> >       int i, ret;
> > -     u32 tmp;
> > +     u32 tmp, aspm_support;
> >
> >       /* Reset the bridge */
> >       brcm_pcie_bridge_sw_init_set(pcie, 1);
> > @@ -806,6 +809,15 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >               num_out_wins++;
> >       }
> >
> > +     /* Only support ASPM L1 unless L0s is explicitly desired */
> > +     aspm_support = PCIE_LINK_STATE_L1;
> > +     if (of_property_read_bool(pcie->np, "brcm,aspm-en-l0s"))
> > +             aspm_support |= PCIE_LINK_STATE_L0S;
> > +     tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > +     u32p_replace_bits(&tmp, aspm_support,
> > +             PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> > +     writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > +
> >       /*
> >        * For config space accesses on the RC, show the right class for
> >        * a PCIe-PCIe bridge (the default setting is to be EP mode).
> > --
> > 2.17.1
> >
