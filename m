Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB84757A034
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 15:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiGSN5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 09:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiGSN5h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 09:57:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44C686C02
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 06:09:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v12so19503208edc.10
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uax/14TNR7abJSZKzXpAbE4j+CPkDQumdWZ0JXE8q3s=;
        b=ht3dr97cDzTtGLz0iY18QZI8MRDReHONK44nxU5a/vu9BL71Yd/z5ubhqwcq23QoHw
         urKxDjjygJRZUA/o2hFf2ZM0WoSaaRG7Z/E24pyNHlMW2/rUoYlgEAnD6kr767c1Jv5+
         f9yNUoQgbbKj1EW6O8dynNk6XMk0byEdf1yI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uax/14TNR7abJSZKzXpAbE4j+CPkDQumdWZ0JXE8q3s=;
        b=JPSdhJ2zNI1JAsqGkJXhrLQTiU+CeG2irLm1VD63k+UJ26I/x2vef8FGku273UG/sp
         knsyyma+69jJkJ6W/uV8xnD0FdhjHdO7Syjw7IiZ9JFpkTky7kg2zZg44w0PkqHMDzsZ
         lUBBHOVcIU5UGZEmJ80QkSFgZlARsstZt3MJPB/iNNF5sAky+CJYvPHMsaBtlIoJkg81
         ek03MttmYLeIyB91NAlNHWfwBEcB4mQ5A/fsC8tHkSt6All/8QgA4I9m2O/jmvBBSz6T
         UEDbOKFuh0HRIbIeYgggM/czcEzj6MoTW/qhXpJKpImsaQNIi8ty4DKTr7eqWAT3Rcit
         0opw==
X-Gm-Message-State: AJIora/k+qeCU7OfnkBJXKyGNdlXHV1n2wSCzFzQdADKYdUtp821Tmjw
        3Ocogw2gXTt1w0URoXm1sivdf7LjMYm/Z8liJDVpbg==
X-Google-Smtp-Source: AGRyM1swZSMbv1nffZXohDMXDg3RZQnrhfUyuT/n3WCM9JqzcZ7u6ZZ7Om1rAoycjcdUU6IAxp7Q1k9omsUYrE17ISo=
X-Received: by 2002:a05:6402:4488:b0:43a:7b6e:4b04 with SMTP id
 er8-20020a056402448800b0043a7b6e4b04mr43460104edb.202.1658236139693; Tue, 19
 Jul 2022 06:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-6iNwjPr2gu_oyn4NheLPJZHh-3eib-3onz63sfNOJpdJ6Tw@mail.gmail.com>
 <20220718224000.GA1456196@bhelgaas>
In-Reply-To: <20220718224000.GA1456196@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 19 Jul 2022 09:08:48 -0400
Message-ID: <CA+-6iNz8DTjAMXnWuOd=0W=qa6J4uD03oH3RJezEk1WxaUN1NA@mail.gmail.com>
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
        boundary="00000000000012baad05e42830a0"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000012baad05e42830a0
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 18, 2022 at 6:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jul 18, 2022 at 02:56:03PM -0400, Jim Quinlan wrote:
> > On Mon, Jul 18, 2022 at 2:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Sat, Jul 16, 2022 at 06:24:49PM -0400, Jim Quinlan wrote:
> > > > Currently, the function does the setup for establishing PCIe link-up
> > > > with the downstream device, and it does the actual link-up as well.
> > > > The calling sequence is (roughly) the following in the probe:
> > > >
> > > > -> brcm_pcie_probe()
> > > >     -> brcm_pcie_setup();                       /* Set-up and link-up */
> > > >     -> pci_host_probe(bridge);
> > > >
> > > > This commit splits the setup function in two: brcm_pcie_setup(), which only
> > > > does the set-up, and brcm_pcie_start_link(), which only does the link-up.
> > > > The reason why we are doing this is to lay a foundation for subsequent
> > > > commits so that we can turn on any power regulators, as described in the
> > > > root port's DT node, prior to doing link-up.
> > >
> > > All drivers that care about power regulators turn them on before
> > > link-up, but typically those regulators are described directly under
> > > the host bridge itself.
> >
> > Actually, what you describe is what I proposed with my v1 back in Nov 2020.
> > The binding commit message said,
> >
> >     "Quite similar to the regulator bindings found in
> >     "rockchip-pcie-host.txt", this allows optional regulators to be
> >     attached and controlled by the PCIe RC driver."
> >
> > > IIUC the difference here is that you have regulators described under
> > > Root Ports (not the host bridge/Root Complex itself), so you don't
> > > know about them until you've enumerated the Root Ports.
> > > brcm_pcie_probe() can't turn them on directly because it doesn't know
> > > what Root Ports are present and doesn't know about regulators below
> > > them.
> >
> > The reviewer's requested me to move the regulator node(s)
> > elsewhere, and at some point later it was requested to be placed
> > under the Root Port driver.  I would love to return them under the
> > host bridge, just say the word!
>
> Actually, I think my understanding is wrong.  Even though the PCI core
> hasn't enumerated the Root Port as a pci_dev, brcm_pcie_setup() knows
> about it and should be able to look up the regulators and turn them
> on.


One can do this with
        regulator_bulk_get(NULL, ...);

However, MarkB did not like the idea of a driver getting the regulator from
the global DT namespace [1].

For the RC driver, one  cannot invoke  regulator_bulk_get(dev, ...) if
there is not a
direct child regulator node.  One needs to use the Port driver device.
The Port driver
device does not exist at this point unless one tries to prematurely create it;
I tried this and it was a mess to say the least.

>
> Can you dig up the previous discussion about why the regulators need
> to be under the Root Port and why they can't be turned on before
> calling pci_host_probe()?


RobH did not want the regulators to be under the RC as he said their DT
location should resemble the HW [2].  The consensus evolved
to place it under the port driver, which can provide a general
mechanism for turning
on regulators anywhere in the PCIe tree.

Regards,
Jim Quinlan
Broadcom STB

[1] https://lore.kernel.org/linux-pci/20210329162539.GG5166@sirena.org.uk/
[2] https://lore.kernel.org/linux-pci/CAL_JsqKPKk3cPO8DG3FQVSHrKnO+Zed1R=PV7n7iAC+qJKgHcw@mail.gmail.com/


>
>
> Bjorn

--00000000000012baad05e42830a0
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDcxPrUFqoY3pztD0ahmVwV3n3brL4K
h/ed7Bj9KVgYVzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA3
MTkxMzA4NTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAZNH3JIHUnsZma+FRgoqQFYJlEt6BcA4RcSVVT66Sgg2PtjlH
8rdoI2MJL1IqUuK39gtPPCovkBnv+1dJLWU2QgagEZbTcXBOZTcIXDzOzt1hnrNPyEf40T3bmjf0
hs0u9a1uhdqF95HQLI6e+8kO0HC2kwxJUUVWDYyuMR+djhC161noaTHOWHmmFenT+RQkxm14o9WX
pBR7SUbF1j6QZrUBaRmTd8by2pszk4bK8UM8HmfQmJWQfKqJrh6LcAUTaoyxiXC1pPwJszR9T4OC
uZ5dKQNenKeLbSXLQW93c1CrO1UT7pSQvyMsEo+xY1HtLWuMaWsv4J+W1c3zptMO2Q==
--00000000000012baad05e42830a0--
