Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE656BABA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiGHN3o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiGHN3l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 09:29:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B722CCA6
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 06:29:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l23so5929937ejr.5
        for <linux-pci@vger.kernel.org>; Fri, 08 Jul 2022 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xLpBzYN7b7OTQ6ZXO6u8hz9baie685xPOmDRw0Arw9I=;
        b=KqOAA1DGwHvEpoMXDixkIhgQnelCMfPOIOTm9bRO9QafGllpX+slhSJ+YqlF1WfLxy
         b6PEDjjbnlEtgBNjzmtvM7re26MaFiPmoeWQE18W9/j5aQU8yHY+FZs4kjzPo4FAPN4z
         TS+EyoXSfuvA4Zt4Cf11af4v1qLbn5OzuiVWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLpBzYN7b7OTQ6ZXO6u8hz9baie685xPOmDRw0Arw9I=;
        b=605hwe/eun7xDV0ACI+O7dxIuNAud+wseNWPcM//OntSxRydw6BEwRmk3VkIcZJKHG
         PjYTuc5On+MeiYILjufLTGn3Zf/ovfdjgsDN8ks2wyaFREaSFfAjSqb5L0oL82yMnY3s
         ISRqDNQ8Z9AYtp+s5bknfC9cUmD8G7e0fujaIsGwIeBE4LJQQHdt1rvVSrHjEeQ0PqWv
         ZuoisvKoB/HqOnDWF8kEoxRurrFGIBT+TyLIbPp5KadkRYFoWK9WVAeGts7LONXLiJNy
         Nz8qrjq9m2KRNcOhCYEWe3QD6f8+QcJO9Q7OYLQsylNv195MWY9QI2tAozBS2bfaFzv+
         0LOQ==
X-Gm-Message-State: AJIora8XBmqILB5pwnC1dE5nip7gEXXN4G6vg+RE4b51oBCPuu/2jsas
        FNTgmUKgyvimwOILwbH8zln017GjUS4LWklkFwIWpQ==
X-Google-Smtp-Source: AGRyM1vEDj25P8EV7USK0urrEat3wXgNEwKcGOJl0L24kfrPqzLoYuAIUnEf3VJgZeeT/wYsqfY3UZexC0iQ3VUl5/s=
X-Received: by 2002:a17:907:6e05:b0:72a:a141:962 with SMTP id
 sd5-20020a1709076e0500b0072aa1410962mr3629511ejc.545.1657286978295; Fri, 08
 Jul 2022 06:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220701162726.31346-2-jim2101024@gmail.com> <20220706215603.GA221278@bhelgaas>
In-Reply-To: <20220706215603.GA221278@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 8 Jul 2022 09:29:27 -0400
Message-ID: <CA+-6iNzQZVi8MbyeZNcBzE0hGjGiYSUk3riSXxTALtFyC00aPQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a6a1cb05e34b3115"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000a6a1cb05e34b3115
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 6, 2022 at 5:56 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jul 01, 2022 at 12:27:22PM -0400, Jim Quinlan wrote:
> > We need to take some code in brcm_pcie_setup() and put it in a new function
> > brcm_pcie_linkup().  In future commits the brcm_pcie_linkup() function will
> > be called indirectly by pci_host_probe() as opposed to the host driver
> > invoking it directly.
> >
> > Some code that was executed after the PCIe linkup is now placed so that it
> > executes prior to linkup, since this code has to run prior to the
> > invocation of pci_host_probe().
>
> This says we need to move some code from brcm_pcie_setup() to
> brcm_pcie_linkup(), but not *why* we need to do that.
I will elaborate in the commit message.
>
> In brcm_pcie_resume(), they're called together:
>
>   brcm_pcie_resume
>     brcm_pcie_setup
>     brcm_pcie_linkup
>
> In the probe path, they're not called together, but they're in the
> same order:
>
>   brcm_pcie_probe
>     brcm_pcie_setup
>     pci_host_probe
>       ...
>         brcm_pcie_add_bus               # bus->ops->add_bus
>           brcm_pcie_linkup
>
> Is there something that must happen *between* them in the probe path?

Yes.  In the probe() case, we must do things in this order:

1. brcm_pcie_setup()
2. Turn on regulators
3. brcm_pcie_linkup()

Since the voltage regulators are turned on during enumeration, pci_host_probe()
must be invoked prior to 3.  Before regulators, we did not care.

In the resume case, there is no enumeration of course but our driver
has a handle to
the regulators and can turn them on/off w/o help.

Regards,
Jim  Quinlan
Broradcom STB

>
> > Link: https://lore.kernel.org/r/20220106160332.2143-5-jim2101024@gmail.com
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 69 +++++++++++++++++----------
> >  1 file changed, 43 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index e61058e13818..2bf5cc399fd0 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -926,16 +926,9 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> >
> >  static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >  {
> > -     struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> >       u64 rc_bar2_offset, rc_bar2_size;
> >       void __iomem *base = pcie->base;
> > -     struct device *dev = pcie->dev;
> > -     struct resource_entry *entry;
> > -     bool ssc_good = false;
> > -     struct resource *res;
> > -     int num_out_wins = 0;
> > -     u16 nlw, cls, lnksta;
> > -     int i, ret, memc;
> > +     int ret, memc;
> >       u32 tmp, burst, aspm_support;
> >
> >       /* Reset the bridge */
> > @@ -1025,6 +1018,40 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >       if (pcie->gen)
> >               brcm_pcie_set_gen(pcie, pcie->gen);
> >
> > +     /* Don't advertise L0s capability if 'aspm-no-l0s' */
> > +     aspm_support = PCIE_LINK_STATE_L1;
> > +     if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> > +             aspm_support |= PCIE_LINK_STATE_L0S;
> > +     tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > +     u32p_replace_bits(&tmp, aspm_support,
> > +             PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> > +     writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > +
> > +     /*
> > +      * For config space accesses on the RC, show the right class for
> > +      * a PCIe-PCIe bridge (the default setting is to be EP mode).
> > +      */
> > +     tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > +     u32p_replace_bits(&tmp, 0x060400,
> > +                       PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> > +     writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > +
> > +     return 0;
> > +}
> > +
> > +static int brcm_pcie_linkup(struct brcm_pcie *pcie)
> > +{
> > +     struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > +     struct device *dev = pcie->dev;
> > +     void __iomem *base = pcie->base;
> > +     struct resource_entry *entry;
> > +     struct resource *res;
> > +     int num_out_wins = 0;
> > +     u16 nlw, cls, lnksta;
> > +     bool ssc_good = false;
> > +     u32 tmp;
> > +     int ret, i;
> > +
> >       /* Unassert the fundamental reset */
> >       pcie->perst_set(pcie, 0);
> >
> > @@ -1075,24 +1102,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >               num_out_wins++;
> >       }
> >
> > -     /* Don't advertise L0s capability if 'aspm-no-l0s' */
> > -     aspm_support = PCIE_LINK_STATE_L1;
> > -     if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> > -             aspm_support |= PCIE_LINK_STATE_L0S;
> > -     tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > -     u32p_replace_bits(&tmp, aspm_support,
> > -             PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> > -     writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > -
> > -     /*
> > -      * For config space accesses on the RC, show the right class for
> > -      * a PCIe-PCIe bridge (the default setting is to be EP mode).
> > -      */
> > -     tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > -     u32p_replace_bits(&tmp, 0x060400,
> > -                       PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> > -     writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > -
> >       if (pcie->ssc) {
> >               ret = brcm_pcie_set_ssc(pcie);
> >               if (ret == 0)
> > @@ -1281,6 +1290,10 @@ static int brcm_pcie_resume(struct device *dev)
> >       if (ret)
> >               goto err_reset;
> >
> > +     ret = brcm_pcie_linkup(pcie);
> > +     if (ret)
> > +             goto err_reset;
> > +
> >       if (pcie->msi)
> >               brcm_msi_set_regs(pcie->msi);
> >
> > @@ -1398,6 +1411,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >       if (ret)
> >               goto fail;
> >
> > +     ret = brcm_pcie_linkup(pcie);
> > +     if (ret)
> > +             goto fail;
> > +
> >       pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
> >       if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
> >               dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--000000000000a6a1cb05e34b3115
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LeylbuEJGL9I80yqq8e6Z+Q6ulLxa6SopzpoysJe/vEVHgp9jPNppZzwKngVd2iDBRqpKlCngIAM
DXgVGyEojXnuEbRs3NlB7wq1kJGlYysrnDug55ncJM8CAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFCeTeUYv84Mo3T1V+OyDdxib
DDLvMA0GCSqGSIb3DQEBCwUAA4IBAQCCqR1PBVtHPvQHuG8bjMFQ94ZB7jmFEGhgfAsFJMaSMLov
qyt8DKr8suCYF4dKGzqalbxo5QU9mmZXdLifqceHdt/Satxb+iGJjBhZg4E0cDds24ofYq+Lbww2
YlIKC2HHxIN+JX2mFpavSXkshR5GT29B9EIJ8hgSjbs61XXeAcrmVIDfYbXQEmGbsnwqxdq+DJpQ
S2kM2wvSlgSWDb6pL7myuKR5lCkQhj7piGSgrVLJRDRrMPw1L4MvnV9DjUFMlGCB40Hm6xqn/jm0
8FCLlWhxve5mj+hgUOPETiKbjhCxJhhAPDdCvDRkZtJlQ8oxUVvXHugG8jm1YqB5AWx7MYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMI+Aj9XRk/wFexb9/
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAZ0O7we2fMsvGb7CAm/oSCu+EHbfpQ
N1qm687MzuXvojAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA3
MDgxMzI5MzhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAvC5IEheQB/Qgx8flHQ00tHe+X9e373ctEGN0c3rlmki4cKq/
Y0dselqrlexT6YPTT/s+R2mVaSVbtjp2qQwr9Br3VRD9H+hPtyd8VJZqO5rnyQg8e6wfEyBlOBcm
YueaPG9YLJn4UXNI4CcxYKGzKSKpuvKIgxAzWhKrRyWBQ7LejPWQbuDbLnezfFmtoW3H+sRyoPbg
AjdP+1BA/6f541zRAPbB7bHd1lH3pv4Zh5ax3975aXDyOvegDzaoum/cNKlZA1dttPa1pNklIBCA
z85YQKvUpvCkIPBIQtf0d/zb/hOX3wWO9PWdtOjgGIsZXe32qEcfGnzWrfoh+P+UnA==
--000000000000a6a1cb05e34b3115--
