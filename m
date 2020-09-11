Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3E2663A6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 18:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIKQVi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgIKP2x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 11:28:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8501C0613ED
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 08:28:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l9so5188352wme.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/NVggog85gMYBFBjIifGv7vTyeIVF41fxb/NZLkpM4=;
        b=LvwncH/DM81zEfuRZbcXrZsBOfCKfq+7sHrazGqdgGq5+MlVWa6DA061UrG0ErUS4h
         +l5EHtg/NT6mttUqm0+0Q6oeeFtb1Pa25yZSU/JYxwrVYSsLD421hbVsYhhq/hKrpq2a
         YnA/SzPQZLlg1T2O0UkNrCvZG7knem6FKVJVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/NVggog85gMYBFBjIifGv7vTyeIVF41fxb/NZLkpM4=;
        b=AmJNKdih3wR1vGpYPXWiehLmwAx5/MB8BZNl10xBfMEfBVD1l5+WPtVudsW9fj5Za2
         1mDGr3iv7acn0/9Geb03rCBU741ZEJxPdaSMcEeUtyt2/j4DthDVPeasCOsUpRvJ/+6X
         U95PNBLIjogoK47zLjcQyp3jrt0Euut6t5/CZgI8LLpOVG8+28xXnLfwsfh9TDGgFiTX
         bpDgWYUtagN4PG755ukjSywGq/VBlLv3QfRH4KvjN1bj/Vu38kOCOFuFMOvG+N2OwGTf
         zjV+d/ZRMQR6aYil1dovjvYZWqiNIWQnbqysqht+CxSRRpp25wL87QH54nIPlihM8tnj
         dO9Q==
X-Gm-Message-State: AOAM532Xk2DE6yd+buWLB0+eqVKWfdx8V5x/zAbCw5XJGJqRjlxo7wFs
        uEHNcj9w9mYZMdr0oRS/PL/KBv5IGXwTFL6wLRF/Ea12Y7s=
X-Google-Smtp-Source: ABdhPJxOIGK7mEv8fau8DdYzuZXtPYlfvXbXOxsTIsXw91D1X48AEq1eUyLwdpoGKbli7jSfKIv1nDk3JR+l7rCK77E=
X-Received: by 2002:a1c:9d83:: with SMTP id g125mr2672702wme.41.1599838127354;
 Fri, 11 Sep 2020 08:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-9-james.quinlan@broadcom.com> <20200910161710.GA456155@bogus>
In-Reply-To: <20200910161710.GA456155@bogus>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 11 Sep 2020 11:28:35 -0400
Message-ID: <CA+-6iNwSua4tHvkw-PyGs34f7oRpsdJ38kT9pJ_Sicno=z8u1Q@mail.gmail.com>
Subject: Re: [PATCH v11 08/11] PCI: brcmstb: Set additional internal memory
 DMA viewport sizes
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004eab9205af0b572b"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000004eab9205af0b572b
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 10, 2020 at 12:17 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 24, 2020 at 03:30:21PM -0400, Jim Quinlan wrote:
> > The Raspberry Pi (RPI) is currently the only chip using this driver
> > (pcie-brcmstb.c).  There, only one memory controller is used, without an
> > extension region, and the SCB0 viewport size is set to the size of the
> > first and only dma-range region.  Other BrcmSTB SOCs have more complicated
> > memory configurations that require setting additional viewport sizes.
> >
> > BrcmSTB PCIe controllers are intimately connected to the memory
> > controller(s) on the SOC.  The SOC may have one to three memory
> > controllers; they are indicated by the term SCBi.  Each controller has a
> > base region and an optional extension region.  In physical memory, the base
> > and extension regions of a controller are not adjacent, but in PCIe-space
> > they are.
> >
> > There is a "viewport" for each memory controller that allows DMA from
> > endpoint devices.  Each viewport's size must be set to a power of two, and
> > that size must be equal to or larger than the amount of memory each
> > controller supports which is the sum of base region and its optional
> > extension.  Further, the 1-3 viewports are also adjacent in PCIe-space.
> >
> > Unfortunately the viewport sizes cannot be ascertained from the
> > "dma-ranges" property so they have their own property, "brcm,scb-sizes".
> > This is because dma-range information does not indicate what memory
> > controller it is associated.  For example, consider the following case
> > where the size of one dma-range is 2GB and the second dma-range is 1GB:
> >
> >     /* Case 1: SCB0 size set to 4GB */
> >     dma-range0: 2GB (from memc0-base)
> >     dma-range1: 1GB (from memc0-extension)
> >
> >     /* Case 2: SCB0 size set to 2GB, SCB1 size set to 1GB */
> >     dma-range0: 2GB (from memc0-base)
> >     dma-range1: 1GB (from memc0-extension)
> >
> > By just looking at the dma-ranges information, one cannot tell which
> > situation applies. That is why an additional property is needed.  Its
> > length indicates the number of memory controllers being used and each value
> > indicates the viewport size.
> >
> > Note that the RPI DT does not have a "brcm,scb-sizes" property value,
> > as it is assumed that it only requires one memory controller and no
> > extension.  So the optional use of "brcm,scb-sizes" will be backwards
> > compatible.
> >
> > One last layer of complexity exists: all of the viewports sizes must be
> > added and rounded up to a power of two to determine what the "BAR" size is.
> > Further, an offset must be given that indicates the base PCIe address of
> > this "BAR".  The use of the term BAR is typically associated with endpoint
> > devices, and the term is used here because the PCIe HW may be used as an RC
> > or an EP.  In the former case, all of the system memory appears in a single
> > "BAR" region in PCIe memory.  As it turns out, BrcmSTB PCIe HW is rarely
> > used in the EP role and its system of mapping memory is an artifact that
> > requires multiple dma-ranges regions.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 68 ++++++++++++++++++++-------
> >  1 file changed, 50 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 041b8d109563..7150eaa803c2 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -57,6 +57,8 @@
> >  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK     0x300000
> >  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128              0x0
> >  #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK          0xf8000000
> > +#define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK          0x07c00000
> > +#define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK          0x0000001f
>
> Perhaps make 0-2 an arg and then you can just do:
>
> u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB_SIZE_MASK(memc))

I cannot get this to work.  In this case u32p_replace_bits requires
that the mask is a compile-time constant; when "memc" is a variable I
don't see how to do this.
>
> >
> >  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO             0x400c
> >  #define PCIE_MEM_WIN0_LO(win)        \
> > @@ -154,6 +156,7 @@
> >  #define SSC_STATUS_OFFSET            0x1
> >  #define SSC_STATUS_SSC_MASK          0x400
> >  #define SSC_STATUS_PLL_LOCK_MASK     0x800
> > +#define PCIE_BRCM_MAX_MEMC           3
> >
> >  #define IDX_ADDR(pcie)                       (pcie->reg_offsets[EXT_CFG_INDEX])
> >  #define DATA_ADDR(pcie)                      (pcie->reg_offsets[EXT_CFG_DATA])
> > @@ -259,6 +262,8 @@ struct brcm_pcie {
> >       const int               *reg_field_info;
> >       enum pcie_type          type;
> >       struct reset_control    *rescal;
> > +     int                     num_memc;
> > +     u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> >  };
> >
> >  /*
> > @@ -714,22 +719,44 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> >                                                       u64 *rc_bar2_offset)
> >  {
> >       struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > -     struct device *dev = pcie->dev;
> >       struct resource_entry *entry;
> > +     struct device *dev = pcie->dev;
> > +     u64 lowest_pcie_addr = ~(u64)0;
> > +     int ret, i = 0;
> > +     u64 size = 0;
> >
> > -     entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
> > -     if (!entry)
> > -             return -ENODEV;
> > +     resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> > +             u64 pcie_beg = entry->res->start - entry->offset;
> >
> > +             size += entry->res->end - entry->res->start + 1;
> > +             if (pcie_beg < lowest_pcie_addr)
> > +                     lowest_pcie_addr = pcie_beg;
> > +     }
> >
> > -     /*
> > -      * The controller expects the inbound window offset to be calculated as
> > -      * the difference between PCIe's address space and CPU's. The offset
> > -      * provided by the firmware is calculated the opposite way, so we
> > -      * negate it.
> > -      */
> > -     *rc_bar2_offset = -entry->offset;
> > -     *rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
> > +     if (lowest_pcie_addr == ~(u64)0) {
> > +             dev_err(dev, "DT node has no dma-ranges\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
> > +                                               PCIE_BRCM_MAX_MEMC);
> > +
> > +     if (ret <= 0) {
> > +             /* Make an educated guess */
> > +             pcie->num_memc = 1;
> > +             pcie->memc_size[0] = 1ULL << fls64(size - 1);
>
> Use roundup_pow_of_two()
The reason I didn't use roundup_pow_of_two() is that it returns a
ulong which on ARM is 32bits and cannot represent  4GB.

>
> > +     } else {
> > +             pcie->num_memc = ret;
> > +     }
> > +
> > +     /* Each memc is viewed through a "port" that is a power of 2 */
> > +     for (i = 0, size = 0; i < pcie->num_memc; i++)
> > +             size += pcie->memc_size[i];
> > +
> > +     /* System memory starts at this address in PCIe-space */
> > +     *rc_bar2_offset = lowest_pcie_addr;
> > +     /* The sum of all memc views must also be a power of 2 */
> > +     *rc_bar2_size = 1ULL << fls64(size - 1);
>
> Use roundup_pow_of_two()
Ditto

Jim Quinlan
Broadcom STB
>
> >
> >       /*
> >        * We validate the inbound memory view even though we should trust
> > @@ -781,12 +808,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >       void __iomem *base = pcie->base;
> >       struct device *dev = pcie->dev;
> >       struct resource_entry *entry;
> > -     unsigned int scb_size_val;
> >       bool ssc_good = false;
> >       struct resource *res;
> >       int num_out_wins = 0;
> >       u16 nlw, cls, lnksta;
> > -     int i, ret;
> > +     int i, ret, memc;
> >       u32 tmp, aspm_support;
> >
> >       /* Reset the bridge */
> > @@ -826,11 +852,17 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >       writel(upper_32_bits(rc_bar2_offset),
> >              base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> >
> > -     scb_size_val = rc_bar2_size ?
> > -                    ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
> >       tmp = readl(base + PCIE_MISC_MISC_CTRL);
> > -     u32p_replace_bits(&tmp, scb_size_val,
> > -                       PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
> > +     for (memc = 0; memc < pcie->num_memc; memc++) {
> > +             u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
> > +
> > +             if (memc == 0)
> > +                     u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
> > +             else if (memc == 1)
> > +                     u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK);
> > +             else if (memc == 2)
> > +                     u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK);
> > +     }
> >       writel(tmp, base + PCIE_MISC_MISC_CTRL);
> >
> >       /*
> > --
> > 2.17.1
> >

--0000000000004eab9205af0b572b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOQpUzbypTZI
/nIiyPaUZh4OsKIriiHFXltIrRPgtHLwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMDkxMTE1Mjg0N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDAvLrJlfEVjsxUIvJ1lTEnBVQdaF/2
aS1C9p888y5BHOAeQhfL9Bz/ARLL2cd/9NNLz+pbYFSy/6ISSP0sAlr96XJwgqpehBI9jYke1THi
LLbFKcZCMTwVk2bikqzd868Z8NrMe74A6FxJv48qA/ew7Ak5nTG9zUekW+4JxB5FVQ07f/5ahBf5
/yV9UzFt2v3q2NqfHpZRkVGd8dCZc7hg36rFIaClaj8QxTqR5Hz9kgUOgWfu0nq1mSv7uVOwV6Po
AegrQSD4RXv8jY8cmQEpqhLv/AInnXRfUpQ56ZUkEjHfNypdG4fgDDl6VRRGnYoB6KXyOYPdQSuK
62nTsudR
--0000000000004eab9205af0b572b--
