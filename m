Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53056BB85
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 16:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbiGHOO1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 10:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbiGHOO0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 10:14:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3001839F
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 07:14:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id d2so38002503ejy.1
        for <linux-pci@vger.kernel.org>; Fri, 08 Jul 2022 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z55r+xyEnJjFtDWlHdwWeT/s7GAOBdRaqImA2C784+Y=;
        b=CkaFJwLB/Q6Vp86FM6e/v8jozA5i2hHUoGYyeV3i3VZHGby0ANlPWcFRos1gt6qZrD
         FR8eijinvxWshy1f66K5NcHkpc1Y1XP6JsCtslVU4O0UGUyF0+198aQ2ip2rLYed8Tn2
         OVnRxFuAwR9hQEzbdxfQZPoblcilKFWy19mak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z55r+xyEnJjFtDWlHdwWeT/s7GAOBdRaqImA2C784+Y=;
        b=g+5NgEWG3W0C5OFdAw6CcF9lC/r3HJY/wGqUOwOHi6VLKibFNjydn7Zg23vr6n2Azj
         8H1W1WVsZRmq9W1cHer38NysRe5QZKKaCT4BWqLAmY1g3Bd65T3kaTNXsZEjl4gSLUOk
         vWPLKVC3pc6aXefiJZMPQOvdCHcvRt0RGPvPXvIwhvkdxyPd2GZRv04jE05/6Ar9YOx8
         X8h3Ej4mh9OA4tQ7NyEj+3SpyTtqhE+ZUSfODWE9OaGcISEv5ykvCZA08RpB0sH2jjf+
         T5c0dElLmmGom7u0SlH57XtpsKtuMLBNrxV/U/yIoyryAJXPsOkO/QgamKFJ98/Zkoby
         QAcQ==
X-Gm-Message-State: AJIora/OJMYvj0FiqJNbpze4HwEMXSRUHtQycy4BR/J1aGTXd/A0y4U/
        3yb6pdt+YBDecJmFRvPLB8/pCBTuHKihIHCJ30Pqvw==
X-Google-Smtp-Source: AGRyM1sRp4ytAhyPqtAtdwQKbtCRl2+bmX6kKMktSfNbRbTvyEroGrtSodQxstN2I4hJpZTry9ZQ/r3OyXvFRWZXBCc=
X-Received: by 2002:a17:907:6e05:b0:72a:a141:962 with SMTP id
 sd5-20020a1709076e0500b0072aa1410962mr3824181ejc.545.1657289663188; Fri, 08
 Jul 2022 07:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220701162726.31346-3-jim2101024@gmail.com> <20220706231250.GA231452@bhelgaas>
In-Reply-To: <20220706231250.GA231452@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 8 Jul 2022 10:14:11 -0400
Message-ID: <CA+-6iNyfi805jef2dSAAup5r=V=WEE0dm5=kYLMhLrcAfeQHUQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] PCI: brcmstb: Add mechanism to turn on subdev regulators
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
        boundary="000000000000af1f1105e34bd149"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000af1f1105e34bd149
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 6, 2022 at 7:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jul 01, 2022 at 12:27:23PM -0400, Jim Quinlan wrote:
> > Add a mechanism to identify standard PCIe regulators in the DT, allocate
> > them, and turn them on before the rest of the bus is scanned during
> > pci_host_probe().
> >
> > The allocated structure that contains the regulators is stored in the port
> > driver dev.driver_data field.  Here is a point-by-point of how and when
> > this mechanism is activated:
> >
> > If:
> >     -- PCIe RC driver sets pci_ops {add,remove)_bus to
> >        pci_subdev_regulators_{add,remove}_bus during its probe.
> >     -- There is a DT node "RB" under the host bridge DT node.
>
> "RB" isn't mentioned in pcie-brcmstb.c.  What's the connection to it?
> Is it just an example, and the actual name doesn't matter?

I will reword this to something like "a regulator with one of these names
... under a root port DT node.  I will review/edit this entire commit msg.

>
> >     -- During the RC driver's pci_host_probe() the add_bus callback
> >        is invoked where (bus->parent && pci_is_root_bus(bus->parent)
> >        is true
> >
> > Then:
> >     -- A struct subdev_regulators structure will be allocated and
> >        assigned to bus->dev.driver_data.
> >     -- regulator_bulk_{get,enable} will be invoked on &bus->dev
> >        and the former will search for and process any
> >        vpcie{12v,3v3,3v3aux}-supply properties that reside in node "RB".
> >     -- The regulators will be turned off/on for any unbind/bind operations.
> >     -- The regulators will be turned off/on for any suspend/resumes, but
> >        only if the RC driver handles this on its own.  This will appear
> >        in a later commit for the pcie-brcmstb.c driver.
>
> I guess this is all functionality that depends on new properties in
> the DT?  Prior to this patch, pcie-brcmstb.c didn't do anything at all
> with regulators, although brcm,stb-pcie.yaml does mention
> "vpcie3v3-supply" in an example.

What is new in the DT is the presence of a regulator under a root
port node.  That is it.  I submitted the regulator YAML allowance
to Rob's Github repo  and I  believe it was accepted.

>
> > The unabridged reason for doing this is as follows.  We would like the
> > Broadcom STB PCIe root complex driver (and others) to be able to turn
> > off/on regulators[1] that provide power to endpoint[2] devices.  Typically,
> > the drivers of these endpoint devices are stock Linux drivers that are not
> > aware that these regulator(s) exist and must be turned on for the driver to
> > be probed.  The simple solution of course is to turn these regulators on at
> > boot and keep them on.  However, this solution does not satisfy at least
> > three of our usage modes:
> >
> >   1. For example, one customer uses multiple PCIe controllers, but wants
> >      the ability to, by script invoking and unbind, turn any or all of them
> >      and their subdevices off to save power, e.g. when in battery mode.
> >
> >   2. Another example is when a watchdog script discovers that an endpoint
> >      device is in an unresponsive state and would like to unbind, power
> >      toggle, and re-bind just the PCIe endpoint and controller.
> >
> >   3. Of course we also want power turned off during suspend mode.  However,
> >      some endpoint devices may be able to "wake" during suspend and we need
> >      to recognise this case and veto the nominal act of turning off its
> >      regulator.  Such is the case with Wake-on-LAN and Wake-on-WLAN support
> >      where the PCIe endpoint device needs to be kept powered on in order to
> >      receive network packets and wake the system.
> >
> > In all of these cases it is advantageous for the PCIe controller to govern
> > the turning off/on the regulators needed by the endpoint device.  The first
> > two cases can be done by simply unbinding and binding the PCIe controller,
> > if the controller has control of these regulators.
> >
> > [1] These regulators typically govern the actual power supply to the
> >     endpoint chip.  Sometimes they may be the official PCIe socket
> >     power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
> >     the regulator(s) that supply power to the EP chip.
> >
> > [2] The 99% configuration of our boards is a single endpoint device
> >     attached to the PCIe controller.  I use the term endpoint but it could
> >     possibly mean a switch as well.
> >
> > Link: https://lore.kernel.org/r/20220106160332.2143-6-jim2101024@gmail.com
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 77 +++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 2bf5cc399fd0..661d3834c6da 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/pci-ecam.h>
> >  #include <linux/printk.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/reset.h>
> >  #include <linux/sizes.h>
> >  #include <linux/slab.h>
> > @@ -283,6 +284,14 @@ static const struct pcie_cfg_data bcm2711_cfg = {
> >       .bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> >  };
> >
> > +struct subdev_regulators {
> > +     unsigned int num_supplies;
> > +     struct regulator_bulk_data supplies[];
> > +};
> > +
> > +static int pci_subdev_regulators_add_bus(struct pci_bus *bus);
> > +static void pci_subdev_regulators_remove_bus(struct pci_bus *bus);
>
> I think these forward declarations are unnecessary.  I can remove them
> if you agree.

It is up to you.  I have a commit-set ready that will make a number of
improvements to our driver.
One of them removes all forward declarations.  Other commits concern
other suggestions you
have made, e.g. rename brcm_pcie_linkup() to brcm_pcie_start_link().

>
> >  struct brcm_msi {
> >       struct device           *dev;
> >       void __iomem            *base;
> > @@ -436,6 +445,72 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pcie)
> >       return ssc && pll ? 0 : -EIO;
> >  }
> >
> > +static void *alloc_subdev_regulators(struct device *dev)
> > +{
> > +     static const char * const supplies[] = {
> > +             "vpcie3v3",
> > +             "vpcie3v3aux",
> > +             "vpcie12v",
> > +     };
> > +     const size_t size = sizeof(struct subdev_regulators)
> > +             + sizeof(struct regulator_bulk_data) * ARRAY_SIZE(supplies);
> > +     struct subdev_regulators *sr;
> > +     int i;
> > +
> > +     sr = devm_kzalloc(dev, size, GFP_KERNEL);
> > +     if (sr) {
> > +             sr->num_supplies = ARRAY_SIZE(supplies);
> > +             for (i = 0; i < ARRAY_SIZE(supplies); i++)
> > +                     sr->supplies[i].supply = supplies[i];
> > +     }
> > +
> > +     return sr;
> > +}
> > +
> > +static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> > +{
> > +     struct device *dev = &bus->dev;
> > +     struct subdev_regulators *sr;
> > +     int ret;
> > +
> > +     if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
> > +             return 0;
> > +
> > +     if (dev->driver_data)
> > +             dev_err(dev, "dev.driver_data unexpectedly non-NULL\n");
>
> I guess you're using the pci_bus dev->driver_data.  I don't know of
> other users of it, but there's really no ownership model for it.  If
> it's non-NULL here, it means somebody else, e.g., the PCI core, is
> already using it, and when you overwrite it below, you will break that
> other user.

Yes, I'm not happy about this vulnerability.

>
> I think you should complain and return instead of breaking the other
> user.  That will mean the regulator won't get enabled and your
> endpoint won't work, but I think that's a better way to fail than by
> overwriting somebody else's pointer, which may lead to memory
> corruption that's very hard to debug.

Agree, will do in v2.

Regards,
Jim Quinlan
Broadcom STB
>
> > +     sr = alloc_subdev_regulators(dev);
> > +     if (!sr)
> > +             return -ENOMEM;
> > +
> > +     dev->driver_data = sr;
> > +     ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = regulator_bulk_enable(sr->num_supplies, sr->supplies);
> > +     if (ret) {
> > +             dev_err(dev, "failed to enable regulators for downstream device\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
> > +{
> > +     struct device *dev = &bus->dev;
> > +     struct subdev_regulators *sr = dev->driver_data;
> > +
> > +     if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
> > +             return;
> > +
> > +     if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
> > +             dev_err(dev, "failed to disable regulators for downstream device\n");
> > +     regulator_bulk_free(sr->num_supplies, sr->supplies);
> > +     dev->driver_data = NULL;
> > +}
> > +
> >  /* Limits operation to a specific generation (1, 2, or 3) */
> >  static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
> >  {
> > @@ -779,6 +854,8 @@ static struct pci_ops brcm_pcie_ops = {
> >       .map_bus = brcm_pcie_map_conf,
> >       .read = pci_generic_config_read,
> >       .write = pci_generic_config_write,
> > +     .add_bus = pci_subdev_regulators_add_bus,
> > +     .remove_bus = pci_subdev_regulators_remove_bus,
> >  };
> >
> >  static struct pci_ops brcm_pcie_ops32 = {
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--000000000000af1f1105e34bd149
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDqe9/a3/rsq7fMUUH82RGWcG1kS6K5
qdy1imx9+r7R6jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA3
MDgxNDE0MjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAyNF/GHJyskDoYimyLpfAcTkrzfJPWhOZQmgP0TOw2OJdnASt
vu21FSvGArkRvxFrZGNtYd8M36dxVXHfRI4hCk8d+FbG3RChQWGjJtlksgqJxQoYV32rcK8JxnVw
hGw4vOyF4z20NwYk6J0eS8zx9OEC4TNof57yUKof680+zzJFFrQjSVs9PYkn4Epq66ibOvyQfpyC
NhAUQab6VBpRodWA+iVLBabSij/ylkucXDW0bTkARdeB2z6Zo2T01ieUSPHPV4Bq43zMDGUp6799
pfKAaEbcAKe0e0JPE2Ahy4h7zsdfMYEhfcuvf2O50K7yvMsNa34TrSAYO0+XYULhrQ==
--000000000000af1f1105e34bd149--
