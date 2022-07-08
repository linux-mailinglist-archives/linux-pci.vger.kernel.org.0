Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F0056BD90
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiGHPQZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238789AbiGHPQX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 11:16:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD4161D60
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 08:16:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sb34so38186945ejc.11
        for <linux-pci@vger.kernel.org>; Fri, 08 Jul 2022 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gJzV0TQryXxY4WRTABKpZwZb4JX9CihFGfozgcm2iQ=;
        b=bmvzQF82MwtiypvGDgH9yq170tO8EzfX8kmJfqQfp7e70st+oYrvpGazqmKFVKnBWc
         j3B//9isME8VWCGFd3+SBH56GoeOO3rC/AxYmTWgYmB/uHpY6MF0rWwcFNyF7LWx3v41
         +tv8CBH8xsjzu0I6jQIJl/0CuYkbjUlxgSGlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gJzV0TQryXxY4WRTABKpZwZb4JX9CihFGfozgcm2iQ=;
        b=KYZCB37q46U+CttDREJBDHYXmVLpwemaJ1n57yCKqPnw+NOAySdkuLCr5e4nwg1wVt
         zb0BRqvfprwuWYhCX09CJa8Vi7gOMTUiAAkQOVL4eI3uO3r69zgrfmXkRrNTVNw3hzxk
         g7oV4Q7FmJDx5EX9jKoIf42Z1mPkmqGOXXlzaBgeTSxpptG8ndO0UsytzuJAJ9frmko6
         qjpQc0aOiFcWAAH+1nAy5cwk0BZgbCNShC2CeMYCl1pq1XMPj44T04NPLBC+w5OAmTCJ
         utGU3Kgz9MPLSC/iKFgzdafGR6uWpqG2Pw8dTDjLOTWsn3qntxcBKFmza/EBNxfNAzmT
         Omsg==
X-Gm-Message-State: AJIora9ZriLv/NMP0NQswOxbWbLbl2nkqTbZ7jexUSS0zTZqZ/1AL29j
        A2wGP9OYOz76OXJ4QuqgGfvfJKqstb0QhtHzd/v1AA==
X-Google-Smtp-Source: AGRyM1v4Oh5eb0d6LZma5Pcb1nClj5nir6hOOmIYYnHGXTHdCc430WfXK2TT7XgoIcXZeHsG9iJmRAOaYAbZkbMhtic=
X-Received: by 2002:a17:907:9693:b0:726:372c:2c02 with SMTP id
 hd19-20020a170907969300b00726372c2c02mr4099897ejc.483.1657293379557; Fri, 08
 Jul 2022 08:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220701162726.31346-4-jim2101024@gmail.com> <20220706231323.GA237418@bhelgaas>
In-Reply-To: <20220706231323.GA237418@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 8 Jul 2022 11:16:08 -0400
Message-ID: <CA+-6iNxg1sMrejizShy7iDhdhun7b_4Yo1OA43=FufkZ_W6iyA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] PCI: brcmstb: Add control of subdevice voltage regulators
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000033126305e34caf2f"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000033126305e34caf2f
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 6, 2022 at 7:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jul 01, 2022 at 12:27:24PM -0400, Jim Quinlan wrote:
> > This Broadcom STB PCIe RC driver has one port and connects directly to one
> > device, be it a switch or an endpoint.  We want to be able to leverage the
> > recently added mechanism that allocates and turns on/off subdevice
> > regulators.
> >
> > All that needs to be done is to put the regulator DT nodes in the bridge
> > below host and to set the pci_ops methods add_bus and remove_bus.
> >
> > Note that the pci_subdev_regulators_add_bus() method is wrapped for two
> > reasons:
> >
> >    1. To achieve link up after the voltage regulators are turned on.
> >
> >    2. If, in the case of an unsuccessful link up, to redirect any PCIe
> >       accesses to subdevices, e.g. the scan for DEV/ID.  This redirection
> >       is needed because the Broadcom PCIe HW will issue a CPU abort if such
> >       an access is made when the link is down.
> >
> > [bhelgaas: fold in
> > https://lore.kernel.org/r/20220112013100.48029-1-jim2101024@gmail.com]
> > Link: https://lore.kernel.org/r/20220106160332.2143-7-jim2101024@gmail.com
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 86 ++++++++++++++++++++++++---
> >  1 file changed, 77 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 661d3834c6da..a86bf502a265 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -196,6 +196,8 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
> >  static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
> >  static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
> >  static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
> > +static int brcm_pcie_linkup(struct brcm_pcie *pcie);
> > +static int brcm_pcie_add_bus(struct pci_bus *bus);
>
> I think the brcm_pcie_add_bus() declaration is unnecessary.
Will remove.

>
> The brcm_pcie_linkup() one is probably unnecessary, too, but would
> require a lot of reordering that I don't think we should do in this
> series.

I have a future commit that will remove all forward declarations.  I just
wanted to keep this the un-revert patchset simple.

>
> >  enum {
> >       RGR1_SW_INIT_1,
> > @@ -329,6 +331,8 @@ struct brcm_pcie {
> >       u32                     hw_rev;
> >       void                    (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >       void                    (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> > +     bool                    refusal_mode;
> > +     struct subdev_regulators *sr;
> >  };
> >
> >  static inline bool is_bmips(const struct brcm_pcie *pcie)
> > @@ -497,6 +501,33 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> >       return 0;
> >  }
> >
> > +static int brcm_pcie_add_bus(struct pci_bus *bus)
> > +{
> > +     struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
> > +     int ret;
> > +
> > +     if (!bus->parent || !pci_is_root_bus(bus->parent))
> > +             return 0;
> > +
> > +     ret = pci_subdev_regulators_add_bus(bus);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Grab the regulators for suspend/resume */
> > +     pcie->sr = bus->dev.driver_data;
> > +
> > +     /*
> > +      * If we have failed linkup there is no point to return an error as
> > +      * currently it will cause a WARNING() from pci_alloc_child_bus().
> > +      * We return 0 and turn on the "refusal_mode" so that any further
> > +      * accesses to the pci_dev just get 0xffffffff
> > +      */
> > +     if (brcm_pcie_linkup(pcie) != 0)
> > +             pcie->refusal_mode = true;
>
> Is there a bisection hole between the previous patch and this one?
> The previous patch sets .add_bus() to pci_subdev_regulators_add_bus(),
> so we'll turn on the regulators, but we don't know whether the link
> came up.  If it didn't come up, it looks like we might get a CPU abort
> when enumerating?

I don't think so.  At this commit, attempting the link-up is still
done before the call
to pci_host_probe().  Since there is no power there will be no link,
the probe will
fail and pci_host_probe() will never be invoked.

>
> I think we should split out the refusal_mode patch:
>
>   - Add refusal mode
>   - Add subdev regulator mechanism
>   - This patch (which would then be clearly about managing regulators
>     in suspend/resume, IIUC)

Will do.

>
> > +     return 0;
> > +}
> > +
> >  static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
> >  {
> >       struct device *dev = &bus->dev;
> > @@ -826,6 +857,18 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
> >       /* Accesses to the RC go right to the RC registers if slot==0 */
> >       if (pci_is_root_bus(bus))
> >               return PCI_SLOT(devfn) ? NULL : base + where;
> > +     if (pcie->refusal_mode) {
> > +             /*
> > +              * At this point we do not have link.  There will be a CPU
> > +              * abort -- a quirk with this controller --if Linux tries
> > +              * to read any config-space registers besides those
> > +              * targeting the host bridge.  To prevent this we hijack
> > +              * the address to point to a safe access that will return
> > +              * 0xffffffff.
> > +              */
> > +             writel(0xffffffff, base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> > +             return base + PCIE_MISC_RC_BAR2_CONFIG_HI + (where & 0x3);
> > +     }
> >
> >       /* For devices, write to the config space index register */
> >       idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
> > @@ -854,7 +897,7 @@ static struct pci_ops brcm_pcie_ops = {
> >       .map_bus = brcm_pcie_map_conf,
> >       .read = pci_generic_config_read,
> >       .write = pci_generic_config_write,
> > -     .add_bus = pci_subdev_regulators_add_bus,
> > +     .add_bus = brcm_pcie_add_bus,
> >       .remove_bus = pci_subdev_regulators_remove_bus,
> >  };
> >
> > @@ -1327,6 +1370,14 @@ static int brcm_pcie_suspend(struct device *dev)
> >               return ret;
> >       }
> >
> > +     if (pcie->sr) {
> > +             ret = regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
> > +             if (ret) {
> > +                     dev_err(dev, "Could not turn off regulators\n");
> > +                     reset_control_reset(pcie->rescal);
> > +                     return ret;
> > +             }
> > +     }
> >       clk_disable_unprepare(pcie->clk);
> >
> >       return 0;
> > @@ -1344,9 +1395,17 @@ static int brcm_pcie_resume(struct device *dev)
> >       if (ret)
> >               return ret;
> >
> > +     if (pcie->sr) {
> > +             ret = regulator_bulk_enable(pcie->sr->num_supplies, pcie->sr->supplies);
> > +             if (ret) {
> > +                     dev_err(dev, "Could not turn on regulators\n");
> > +                     goto err_disable_clk;
> > +             }
> > +     }
> > +
> >       ret = reset_control_reset(pcie->rescal);
> >       if (ret)
> > -             goto err_disable_clk;
> > +             goto err_regulator;
> >
> >       ret = brcm_phy_start(pcie);
> >       if (ret)
> > @@ -1378,6 +1437,9 @@ static int brcm_pcie_resume(struct device *dev)
> >
> >  err_reset:
> >       reset_control_rearm(pcie->rescal);
> > +err_regulator:
> > +     if (pcie->sr)
> > +             regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
> >  err_disable_clk:
> >       clk_disable_unprepare(pcie->clk);
> >       return ret;
> > @@ -1488,10 +1550,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >       if (ret)
> >               goto fail;
> >
> > -     ret = brcm_pcie_linkup(pcie);
> > -     if (ret)
> > -             goto fail;
> > -
> >       pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
> >       if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
> >               dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
> > @@ -1513,7 +1571,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >
> >       platform_set_drvdata(pdev, pcie);
> >
> > -     return pci_host_probe(bridge);
> > +     ret = pci_host_probe(bridge);
> > +     if (!ret && !brcm_pcie_link_up(pcie))
> > +             ret = -ENODEV;
> > +
> > +     if (ret) {
> > +             brcm_pcie_remove(pdev);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +
> >  fail:
> >       __brcm_pcie_remove(pcie);
> >       return ret;
> > @@ -1522,8 +1590,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >  MODULE_DEVICE_TABLE(of, brcm_pcie_match);
> >
> >  static const struct dev_pm_ops brcm_pcie_pm_ops = {
> > -     .suspend = brcm_pcie_suspend,
> > -     .resume = brcm_pcie_resume,
> > +     .suspend_noirq = brcm_pcie_suspend,
> > +     .resume_noirq = brcm_pcie_resume,
>
> Can you name these brcm_pcie_suspend_noirq() and
> brcm_pcie_resume_noirq() to match the hook names?
Yes.

Jim Quintlan
Broadcom STB

>
> >  };
> >
> >  static struct platform_driver brcm_pcie_driver = {
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--00000000000033126305e34caf2f
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAHcX8jENCL0ZkQyxx8LpddpdtSpcFj
NHlM9ybZvfFkkDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA3
MDgxNTE2MTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAee2xcdqVHCYIVlgGgs2MR14h08NUFDyzzATAwmBS8WwMdBTY
ftw9r9DpzFseZNT0bsaLvjaAdg9u1LXygHMVBWeRfqAnOptWI7fUh11Zvl1CCW0sh00mYsuMVUxD
URD2CvwZ5kIHU01T3uSZa/cA2icaI9pDDTKSD5DEfhdcAMD2TDJlpqnyuCkABjmo4dvugB+PO8BG
qYelcxlW7dOiOSEDbbJm3EmwqWFxwiGUgPWlK8MEzZCSHpfOvbQnS6ZrB8MxfuvswXI1I9MCiIB/
9d1c6kjaeEKR7WpURrat20aYowFvngE2Vh/aepPDHi0mruP0v0076FlObN+wWfNIfw==
--00000000000033126305e34caf2f--
