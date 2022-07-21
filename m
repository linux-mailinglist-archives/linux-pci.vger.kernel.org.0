Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615ED57CE41
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiGUOyJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiGUOyI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:54:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7E2981F
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 07:54:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k30so2467673edk.8
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMHhtHD1hf3iJepYJ8ceRNwH6fCOnvVvTafWeoP52sM=;
        b=BiZUY8JM1OQAIk/TZXPsqXhBfA8mZBjDoR8E7YpHpDB3qVKT2gpAGRthj0L26D4HO6
         uxwLD5euipHfPBpcdEfygdGrfYv6968sarZ5Nb1DC6/9rOXW11EoPAGFrQP7sO75wDXL
         vv+8rPqUwDmYGJ6Ku7o7BryySLxVv5VZ7nQJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMHhtHD1hf3iJepYJ8ceRNwH6fCOnvVvTafWeoP52sM=;
        b=RJxNaBfBGelSknGokdPY0FcCwd8nhUFBsAasNJQSLL41ZAw1ONkqlwzY8lqBzdhIFO
         8thENVB20V9LvETALWOYNWhojqZJlmQXOrGwY1HJ40K89K6VTalM4akw8gONt+lRWLrw
         UJcnsu72ozn+phveUmERK1o8PMBgv52x6XsSUhr7X9R+zDYsWqZpG/EWef45KwA795PZ
         L/eZjmEFAM+VdYZO9EzvrID93qOoKa7M83iLmLRiSCZvdFQfnRHyX4DfeP/Fi46Vsj4E
         SSIXeywYlh+AZfCVVVtowEF/9qf+7fhO/gEnegsF/er99ouKl2eGfCyKj0IqU5reOtNg
         4tJQ==
X-Gm-Message-State: AJIora+Tv3sBkA0jVq7NTssLMWxXoHuROo0ZfvtA8i7XmVbrDth8Jm9i
        8MI6sQFAf2B/Dw0ZHwRN9odzKq1AOrM85qFOOTZv/g==
X-Google-Smtp-Source: AGRyM1sKU5/O8mfIMSKIaBGKnBHyXSDhXUgiSAXiOyfISOy+u7vmrww4kWeaw6K/wWpJHzMX0ArX1ZUHGX7coL0uPXA=
X-Received: by 2002:a05:6402:26c8:b0:43a:c404:a553 with SMTP id
 x8-20020a05640226c800b0043ac404a553mr57620298edd.53.1658415245466; Thu, 21
 Jul 2022 07:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220716222454.29914-4-jim2101024@gmail.com> <20220720220558.GA1661469@bhelgaas>
In-Reply-To: <20220720220558.GA1661469@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 21 Jul 2022 10:53:54 -0400
Message-ID: <CA+-6iNyUB4es01xsSvsvS0gZyUuuttJJ4XSBVajtBrVNFT5dMw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] PCI: brcmstb: Add "refusal mode" to preclude
 PCIe-induced CPU aborts
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
        boundary="0000000000009f7c7a05e451e331"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000009f7c7a05e451e331
Content-Type: text/plain; charset="UTF-8"

https://lore.kernel.org/linux-pci/20171215201434.GY30595@bhelgaas-glaptop.roam.corp.google.com/
On Wed, Jul 20, 2022 at 6:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Jul 16, 2022 at 06:24:50PM -0400, Jim Quinlan wrote:
> > Our PCIe RC HW has an atypical behavior: if it does not have PCIe link
> > established between itself and downstream, any subsequent config space
> > access causes a CPU abort.  This commit sets a "refusal mode" if the PCIe
> > link-up fails, and this has our pci_ops map_bus function returning a NULL
> > address, which in turn precludes the access from happening.
> >
> > Right now, "refusal mode" is window dressing.  It will become relevant
> > in a future commit when brcm_pcie_start_link() is invoked during
> > enumeration instead of before it.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index c026446d5830..72219a4f3964 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -255,6 +255,7 @@ struct brcm_pcie {
> >       u32                     hw_rev;
> >       void                    (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >       void                    (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> > +     bool                    refusal_mode;
> >  };
> >
> >  static inline bool is_bmips(const struct brcm_pcie *pcie)
> > @@ -687,6 +688,19 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
> >       if (pci_is_root_bus(bus))
> >               return PCI_SLOT(devfn) ? NULL : base + where;
> >
> > +     if (pcie->refusal_mode) {
> > +             /*
> > +              * At this point we do not have PCIe link-up.  If there is
> > +              * a config read or write access besides those targeting
> > +              * the host bridge, our PCIe HW throws a CPU abort.  To
> > +              * prevent this we return the NULL address.  The calling
> > +              * functions -- pci_generic_config_*() -- will notice this
> > +              * and not perform the access, and if it is a read access,
> > +              * 0xffffffff is returned.
> > +              */
> > +             return NULL;
> > +     }
>
> Is this any different from all the other .map_bus() implementations
> that return NULL when the link is down?

Not really,,but long ago I submitted code that gated the config spec
access based on link status and was advised not to do it  [1].
I'll be happy to make it look like the others.

Regards,
Jim Quinlan
Broadcom STB

[1] https://lore.kernel.org/linux-pci/20171215201434.GY30595@bhelgaas-glaptop.roam.corp.google.com/

>
>   cdns_pci_map_bus()
>   dw_pcie_other_conf_map_bus()
>   nwl_pcie_map_bus() (see nwl_pcie_valid_device())
>   xilinx_pcie_map_bus() (see xilinx_pcie_valid_device())
>
> If you can implement this the same way, i.e., using
> brcm_pcie_link_up(), it would be nice.
>
> >       /* For devices, write to the config space index register */
> >       idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
> >       writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
> > @@ -704,6 +718,11 @@ static void __iomem *brcm_pcie_map_conf32(struct pci_bus *bus, unsigned int devf
> >       if (pci_is_root_bus(bus))
> >               return PCI_SLOT(devfn) ? NULL : base + (where & ~0x3);
> >
> > +     if (pcie->refusal_mode) {
> > +             /* See note above in brcm_pcie_map_conf() */
> > +             return NULL;
> > +     }
> > +
> >       /* For devices, write to the config space index register */
> >       idx = PCIE_ECAM_OFFSET(bus->number, devfn, (where & ~3));
> >       writel(idx, base + IDX_ADDR(pcie));
> > @@ -989,6 +1008,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
> >               dev_err(dev, "link down\n");
> >               return -ENODEV;
> >       }
> > +     pcie->refusal_mode = false;
> >
> >       if (!brcm_pcie_rc_mode(pcie)) {
> >               dev_err(dev, "PCIe misconfigured; is in EP mode\n");
> > @@ -1134,6 +1154,8 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> >       void __iomem *base = pcie->base;
> >       int tmp;
> >
> > +     pcie->refusal_mode = true;
> > +
> >       if (brcm_pcie_link_up(pcie))
> >               brcm_pcie_enter_l23(pcie);
> >       /* Assert fundamental reset */
> > @@ -1185,6 +1207,7 @@ static int brcm_pcie_resume(struct device *dev)
> >       u32 tmp;
> >       int ret;
> >
> > +     pcie->refusal_mode = true;
> >       base = pcie->base;
> >       ret = clk_prepare_enable(pcie->clk);
> >       if (ret)
> > @@ -1361,6 +1384,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >       pcie->type = data->type;
> >       pcie->perst_set = data->perst_set;
> >       pcie->bridge_sw_init_set = data->bridge_sw_init_set;
> > +     pcie->refusal_mode = true;
> >
> >       pcie->base = devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(pcie->base))
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--0000000000009f7c7a05e451e331
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCcfLLzxAVOHh/E9KP8Y18dg61oQKvp
i6yBVTYVn2I5wDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA3
MjExNDU0MDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAA2P9GdG0hEWWk94H1EnbbkTA4soRaGGzdunJ/jRzTz+Lhmso
gU8Wc7XpwzjqTMfpTCbmEFBe4fBKcvehy6dgEE+pBqBcwJq9D7kkCZYknQ31ouPhcEpC70Avz3zO
ALaZTwNam9v8lBgbG4OLT57VVePZIrsUBjrAlMqdLVTU7NsASh25tKzrZ3IUHVXnzbinycCQMIWx
9iiZ8tp/ShlFjbOEgAfcFfurXjloYx9Q4r27rA3sbGRxsNyKJpGDT3dfAgr8QBdVG7AoOX21pfx/
MgySpJJoX8HT+KpbHHjolBYvTysn0kQH1dHMvV+wm/S7dL4XbNTHLuZGn0ZVa35r7w==
--0000000000009f7c7a05e451e331--
