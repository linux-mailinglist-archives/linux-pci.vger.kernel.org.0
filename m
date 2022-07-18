Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28BE5789E4
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiGRS4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 14:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiGRS4R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 14:56:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05492F03E
        for <linux-pci@vger.kernel.org>; Mon, 18 Jul 2022 11:56:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id va17so23075712ejb.0
        for <linux-pci@vger.kernel.org>; Mon, 18 Jul 2022 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0WOvyoqadjpEITlMzRPBvEYMnXCNxGE7c+O0MJD504=;
        b=XJS5FZ5zhEAEbuqi8Y+6fkRVJQrliRRdil1M7NY2CTQks7BLEwTQuEAYfRgWfB3/Nn
         wT+tzwHbFutPe0fLqbfiThThbqHXRVSJ+eIqDsQQE6z7ZnhSZ8SgiCNJDQIjxGwtY7vO
         6SIjv38OPKevyHhfzIXydxSSPltWYNqYa5fyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0WOvyoqadjpEITlMzRPBvEYMnXCNxGE7c+O0MJD504=;
        b=C+Ys8rvlnjcymmIHeRzavNG3y2Okki4SgoApQYJju03wZNd1t6aK+NCj2qyEFdJAE+
         EWu7/0WtNOSDz7fJ0ZNnNGcC3ap9DSymQSAQAVdFPPI678lx39IgZHmTiMHRQjkfTjHe
         fa6oT9fV/jwlmiwWVTJ/1lw9bSoRof3uZt8H4VZGaPt72rPZJeteNyWGcKiBhsHrn9/H
         0duSnZ+HByHgb5a4tp4BTY0F6sNN936gxsKYqdz4imi08MXHdETi8cMgCSwnsOtJTgti
         G0CEA5K1b04iJij4rYp/09FueOTN0yU5o3631SgGj/tIQ+HSgjLdylSM9lZZl9v+10a0
         6mzg==
X-Gm-Message-State: AJIora8yHVpJAH/DmbGevcFeyh6IhshWOQWzPsGaMwTl8OM5lhWSDOdm
        NhzHOjW3XzSr0U8/R8aaFzYFcWvjT55fIop3oZ3NkQ==
X-Google-Smtp-Source: AGRyM1uo031Zdy22MbXpwGfGpcKqCn6IvBlAnm7yWcskFnaXLXp81/Bd6TlVQEXSCslz3eJkrirRKWfcSpzZwaICnwg=
X-Received: by 2002:a17:907:9809:b0:72f:817:d433 with SMTP id
 ji9-20020a170907980900b0072f0817d433mr14173469ejc.483.1658170575172; Mon, 18
 Jul 2022 11:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220716222454.29914-3-jim2101024@gmail.com> <20220718181425.GA1431580@bhelgaas>
In-Reply-To: <20220718181425.GA1431580@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 18 Jul 2022 14:56:03 -0400
Message-ID: <CA+-6iNwjPr2gu_oyn4NheLPJZHh-3eib-3onz63sfNOJpdJ6Tw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
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
        boundary="0000000000001ffb6705e418eccc"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000001ffb6705e418eccc
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 18, 2022 at 2:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Jul 16, 2022 at 06:24:49PM -0400, Jim Quinlan wrote:
> > Currently, the function does the setup for establishing PCIe link-up
> > with the downstream device, and it does the actual link-up as well.
> > The calling sequence is (roughly) the following in the probe:
> >
> > -> brcm_pcie_probe()
> >     -> brcm_pcie_setup();                       /* Set-up and link-up */
> >     -> pci_host_probe(bridge);
> >
> > This commit splits the setup function in two: brcm_pcie_setup(), which only
> > does the set-up, and brcm_pcie_start_link(), which only does the link-up.
> > The reason why we are doing this is to lay a foundation for subsequent
> > commits so that we can turn on any power regulators, as described in the
> > root port's DT node, prior to doing link-up.
>
> All drivers that care about power regulators turn them on before
> link-up, but typically those regulators are described directly under
> the host bridge itself.
Hi Bjorn,

Actually, what you describe is what I proposed with my v1 back in Nov 2020.
The binding commit message said,

    "Quite similar to the regulator bindings found in "rockchip-pcie-host.txt",
     this allows optional regulators to be attached and controlled by the
     PCIe RC driver."

>
> IIUC the difference here is that you have regulators described under
> Root Ports (not the host bridge/Root Complex itself), so you don't
> know about them until you've enumerated the Root Ports.
> brcm_pcie_probe() can't turn them on directly because it doesn't know
> what Root Ports are present and doesn't know about regulators below
> them.

The reviewer's requested me to move the regulator node(s)  elsewhere,
and at some point later it was requested to be placed under the Root Port
driver.  I would love to return them under the host bridge, just say the word!

>
> So I think brcm_pcie_setup() does initialization that doesn't depend
> on the link or any downstream devices, and brcm_pcie_start_link() does
> things that depend on the link being up.  Right?
Yes.

>
> If so, "start_link" might be a slight misnomer since AFAICT
> brcm_pcie_start_link() doesn't do anything to initiate link-up except
> maybe deasserting fundamental reset.  Some drivers start the LTSSM or
> explicitly enable link training, but brcm_pcie_start_link() doesn't
> seem to do anything like that.
>
> brcm_pcie_start_link() still does brcm_pcie_set_outbound_win().  Does
> that really depend on the link being up?  If that only affects the
> Root Port, maybe it could be done before link-up?
Some of the registers cannot be accessed until after linkup but these do
not have that issue.  I will change this.

Jim Quinlan
Broadcom STB

>
> > We do this by defining an
> > add_bus() callback which is invoked during enumeraion.  At the end of this
> > patchset the probe function trace will look something like this:
> >
> > -> brcm_pcie_probe()
> >     -> brcm_pcie_setup();                       /* Set-up only */
> >     -> pci_host_probe(bridge);
> >         -> [enumeration]
> >             -> pci_alloc_child_bus()
> >                 -> bus->ops->add_bus(bus);      /* We've set this op */
> >                 -> brcm_pcie_add_bus()          /* Our callback      */
> >                      -> [turn on regulators]    /* Main objective!   */
> >                      -> brcm_pcie_start_link()  /* Link-up           */

--0000000000001ffb6705e418eccc
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC89bumtyjc43/YB73JCm2tfvLY0Hgk
eq192u3hYzM/UDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA3
MTgxODU2MTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAgCWjvQYbszcn1/qNTjV5NmuD4JnsCD35U1xrbQdc3PHnC9Eu
fhuGiO8DgLDQtqMArscQolDY1s6wbEuxi7Y+4igYugHrDbbx5GRJQe3NTsVlKOt7B6hUC1nO2Q8n
7T9nWOJjvgb2ybnKXouuBWrSeJy9R1xUnix18pjA9Zdcq06FsIA7Hbrxw6S8gflBMN6DROn0D5lN
822Sc3Kl+rNnwvurcHSbd95aSVbgl3OIMW00A9kT11ZCSS1e3hXZGKR1pNWo3JbHXbcnrfJbgaTr
JTOZ2LzlTNWPVJLvZS2bz8jwChgXKFEq+bTio3vWgwLwXyNpwKaduyq5TfHsF6GyLQ==
--0000000000001ffb6705e418eccc--
