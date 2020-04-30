Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF951C08AD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 23:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgD3VAv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 17:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgD3VAu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 17:00:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E686C035494
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 14:00:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so3852233wra.7
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUATwzpZxjtae1A7cwapMNJ5haJlC5HtdIYeEo2bhyI=;
        b=HdcxtBBTqr/xUzKOPsewGq+KhFdgf5wvseNGI2ZEIOXDWE46bkbjUocRTAcZ2uNLHp
         nForatMzsdPs8+L0IrFQikDJm2msJs+d9Tzz4+5/fMT652hPt+HIxLSJ02HdCHigVrN/
         9SAhr5CAesG8XtrGURdnaEgujEBNdBceBnfew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUATwzpZxjtae1A7cwapMNJ5haJlC5HtdIYeEo2bhyI=;
        b=HJc12hbsRDVsbNnRrqMx/g2PHwCo0mXItVCADJgNh3zNr/KuvaVv4Djl6PS12/IecL
         it/Ny8QOgByZw+l5mIHAiUPC2S7ECkQ8cWr6fQpniUCdZcGFxqB2DJ8/4gsfv+ywIop4
         oRyk3Z0gf6zuHAr9PgT8aCnVDRjC6GWMNskZx4XqI1HsM7w5CO5RZHdKRvtLFN8ODJqO
         j3ONFXlCBdkNk8fQXOKCCgdVH9A5cBqvma8+FuJTPD70lIdVPfi7gLbssnJasqVN6sj7
         xtVyZLPa5/pBbcLFsFa715gwoIt/MT+n6m1WAZf6cgX+aECkKd1zIbfoH2aNKe6yUMx2
         QRMA==
X-Gm-Message-State: AGi0PuaSW9v+7sXXJJ0sjihQg/jhTHzZV1/ndOWAsBbQmbPxvIqibxz8
        CS+NCmMOVsvAFD2GJfwNktSBZsx0dgivQXvyjqUUTw==
X-Google-Smtp-Source: APiQypKv2reBsz0zsRnGDK76QZ4WHS1pIYRkKF7BUdppHJAInOIMuK9/LUue0hxUkkq3QrQxmOz7Y/HtoRhuAgd7rtY=
X-Received: by 2002:adf:f1c5:: with SMTP id z5mr504368wro.100.1588280448870;
 Thu, 30 Apr 2020 14:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200430185522.4116-3-james.quinlan@broadcom.com> <20200430203252.GA62266@bjorn-Precision-5520>
In-Reply-To: <20200430203252.GA62266@bjorn-Precision-5520>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 30 Apr 2020 17:00:36 -0400
Message-ID: <CA+-6iNwnMjAYZzYedBqooeJAbot_5A=9C8iFNMc=vdpnzmzVrw@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: brcmstb: enable CRS
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

On Thu, Apr 30, 2020 at 4:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Apr 30, 2020 at 02:55:20PM -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > Configuration Retry Request Status is off by default on this
> > PCIe controller.  Turn it on.
>
> Are you talking about CRS itself, i.e., the ability of a Root Port to
> deal with Completions with Configuration Retry Request Status?  That
> really shouldn't be switchable in the hardware since it's a required
> feature for all PCIe devices.
>
> Or are you talking about CRS Software Visibility, which is controlled
> by a bit in the PCIe Root Control register?  That *should* be managed
> by the PCI core in pci_enable_crs().  Does that generic method of
> controlling it not work for this device?
>
My mistake; the commit will be dropped.

Thanks,
Jim
> It looks like maybe the latter, since the generic:
>
>   #define  PCI_EXP_RTCTL_CRSSVE   0x0010
>
> matches your new PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK.
>
> If pci_enable_crs() doesn't work on this device, it sounds like a
> hardware defect that we need to work around, but I'm not sure that
> just enabling it unconditionally here is the right thing.
>
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 5b0dec5971b8..2bc913c0262c 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -34,6 +34,9 @@
> >  #define BRCM_PCIE_CAP_REGS                           0x00ac
> >
> >  /* Broadcom STB PCIe Register Offsets */
> > +#define PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL                    0x00c8
> > +#define  PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK    0x10
> > +
> >  #define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1                              0x0188
> >  #define  PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK       0xc
> >  #define  PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN                       0x0
> > @@ -827,6 +830,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >                pci_speed_string(pcie_link_speed[cls]), nlw,
> >                ssc_good ? "(SSC)" : "(!SSC)");
> >
> > +     /* Enable configuration request retry (CRS) */
> > +     tmp = readl(base + PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL);
> > +     u32p_replace_bits(&tmp, 1,
> > +                       PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK);
> > +     writel(tmp, base + PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL);
> > +
> >       /* PCIe->SCB endian mode for BAR */
> >       tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
> >       u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
> > --
> > 2.17.1
> >
