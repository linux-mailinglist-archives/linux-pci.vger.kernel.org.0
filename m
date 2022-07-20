Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A897557B8F4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiGTOxk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240946AbiGTOxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 10:53:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A766A3057C
        for <linux-pci@vger.kernel.org>; Wed, 20 Jul 2022 07:53:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sz17so33488900ejc.9
        for <linux-pci@vger.kernel.org>; Wed, 20 Jul 2022 07:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42T0nXnizqaCqi5PzPugMSD5zdmQ7UDz8QfNQBrJVKw=;
        b=esSyLhKZanTJM7IgVLVYprRI2dYX2cD6IKJFqhbVhLHr9MP2IvBJzOTp97chl16hyz
         0QL1cdZnASf14lcj1RCzfLD1MzFhX7pT+ggC+nwvWtJQs4iwtAad6NF1xZC6oql/oGCo
         YGUNhZYBaFhYNL/p4WtgvLqnp5bBUL1sKJPuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42T0nXnizqaCqi5PzPugMSD5zdmQ7UDz8QfNQBrJVKw=;
        b=DngIDi67S+ogQDqQDmfdELVH9pVrVa33Q+eQxUYylp4bZfpebaaXBNy3PKwMHAVtyX
         2EPPj9M/1erKI9NYhWPYhBF5j6rVshgHqSKCiRYJcXs26plZJiQTwAqUpU4nyQgSp23H
         FNQyvV9X+1vTaFt+V1bnDEMC7vkwOfgpx4OjSagCBcTdrRob5c5tuPEW2oIYA8UJaqXF
         AaRiqzFdxB8lJ2ZCkxRRB2Rj+kZsneafbtrx/rCHKqbReziPqXixX1AiUVVz2Dqu9t9L
         X9P21jfY1LAtyYtMtZvph/RZiMWQ9GzZ8kuZBPSBm7TZuBnP3tYo9rSoPb9kmnN4P1y0
         I6mQ==
X-Gm-Message-State: AJIora/LZgOfHIn4+rGPPxigWzilV07GcaYBFnBtrcE+QODJX4bcvxaH
        6Qxoitl/gLiLFNWc4vSRs4rbWamVX17LijXkwELSrQ==
X-Google-Smtp-Source: AGRyM1v2EC+Hjyqpka6aujTvod1B12SacJ7kuImQZqTfcejALD61e1pE1oksddVH3Kq/9ma+7pvcG7cRkA/DerUFT8Q=
X-Received: by 2002:a17:907:2bf4:b0:72b:3336:ca9e with SMTP id
 gv52-20020a1709072bf400b0072b3336ca9emr35721318ejc.341.1658328816117; Wed, 20
 Jul 2022 07:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-6iNz8DTjAMXnWuOd=0W=qa6J4uD03oH3RJezEk1WxaUN1NA@mail.gmail.com>
 <20220719200332.GA1552587@bhelgaas>
In-Reply-To: <20220719200332.GA1552587@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 20 Jul 2022 10:53:24 -0400
Message-ID: <CA+-6iNzn=JsG=xU2BxagyfeUMZ13p9yg=y+_wVcsAaZ0NgEvKg@mail.gmail.com>
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
        boundary="000000000000060ba705e43dc48c"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000060ba705e43dc48c
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 19, 2022 at 4:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jul 19, 2022 at 09:08:48AM -0400, Jim Quinlan wrote:
> > On Mon, Jul 18, 2022 at 6:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Jul 18, 2022 at 02:56:03PM -0400, Jim Quinlan wrote:
> > > > On Mon, Jul 18, 2022 at 2:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Sat, Jul 16, 2022 at 06:24:49PM -0400, Jim Quinlan wrote:
> > > > > > Currently, the function does the setup for establishing PCIe link-up
> > > > > > with the downstream device, and it does the actual link-up as well.
> > > > > > The calling sequence is (roughly) the following in the probe:
> > > > > >
> > > > > > -> brcm_pcie_probe()
> > > > > >     -> brcm_pcie_setup();                       /* Set-up and link-up */
> > > > > >     -> pci_host_probe(bridge);
> > > > > >
> > > > > > This commit splits the setup function in two: brcm_pcie_setup(), which only
> > > > > > does the set-up, and brcm_pcie_start_link(), which only does the link-up.
> > > > > > The reason why we are doing this is to lay a foundation for subsequent
> > > > > > commits so that we can turn on any power regulators, as described in the
> > > > > > root port's DT node, prior to doing link-up.
> > > > >
> > > > > All drivers that care about power regulators turn them on before
> > > > > link-up, but typically those regulators are described directly under
> > > > > the host bridge itself.
> > > >
> > > > Actually, what you describe is what I proposed with my v1 back in Nov 2020.
> > > > The binding commit message said,
> > > >
> > > >     "Quite similar to the regulator bindings found in
> > > >     "rockchip-pcie-host.txt", this allows optional regulators to be
> > > >     attached and controlled by the PCIe RC driver."
> > > >
> > > > > IIUC the difference here is that you have regulators described under
> > > > > Root Ports (not the host bridge/Root Complex itself), so you don't
> > > > > know about them until you've enumerated the Root Ports.
> > > > > brcm_pcie_probe() can't turn them on directly because it doesn't know
> > > > > what Root Ports are present and doesn't know about regulators below
> > > > > them.
> > > >
> > > > The reviewer's requested me to move the regulator node(s)
> > > > elsewhere, and at some point later it was requested to be placed
> > > > under the Root Port driver.  I would love to return them under the
> > > > host bridge, just say the word!
> > >
> > > Actually, I think my understanding is wrong.  Even though the PCI core
> > > hasn't enumerated the Root Port as a pci_dev, brcm_pcie_setup() knows
> > > about it and should be able to look up the regulators and turn them
> > > on.
> >
> > One can do this with
> >         regulator_bulk_get(NULL, ...);
> >
> > However, MarkB did not like the idea of a driver getting the
> > regulator from the global DT namespace [1].
> >
> > For the RC driver, one  cannot invoke  regulator_bulk_get(dev, ...)
> > if there is not a direct child regulator node.  One needs to use the
> > Port driver device.  The Port driver device does not exist at this
> > point unless one tries to prematurely create it; I tried this and it
> > was a mess to say the least.
> >
> > > Can you dig up the previous discussion about why the regulators need
> > > to be under the Root Port and why they can't be turned on before
> > > calling pci_host_probe()?
> >
> > RobH did not want the regulators to be under the RC as he said their
> > DT location should resemble the HW [2].  The consensus evolved to
> > place it under the port driver, which can provide a general
> > mechanism for turning on regulators anywhere in the PCIe tree.
>
> I don't want to redesign this whole thing.  I just want a crisp
> rationale for the commit log.
>
> All other drivers (exynos, imx6, rw-rockchip, histb, qcom, tegra194,
> tegra, rockchip-host) have regulators for downstream PCIe power
> directly under the RC.  If putting the regulators under an RP instead
> is the direction of the future, I guess that might be OK, and I guess
> the reasons are:
>
>   1) Slot or device power regulators that are logically below the RP
>      should be described that way in the DT.
>
>   2) Associating regulators with a RP allows the possibility of
>      selectively controlling power to slots/devices below the RP,
>      e.g., to power down devices below RP A when suspending while
>      leaving wakeup devices below RP B powered up.
>
> I think in your case the motivating reason is 2).
>
> Your commit log for "Add mechanism to turn on subdev regulators"
> suggests that you want some user control of endpoint power, e.g., via
> sysfs, but I don't see that implemented yet except possibly via a
> "remove" file that would unbind the driver and remove the entire
> device.
Hi Bjorn,

Initially we wanted to (a) turn on any regulator found under the RC
node and (b) allow the possibility of the regulator to control the
EP's power. From the feedback, we realized early on that neither of
these were going to fly, so we conceded both requests and just wanted
to turn on standard PCIe regulators.  Upon reading the aforementioned
commit message I realize that there are a couple of leftover sentences
from these early days that must be removed.

I think when I submitted v1 of the original series that only the
rockchip driver had regulators under the RC.   And my recollection was
that this was accepted but there was apprehension of this turning into
the "standard" way of turning on such regulators,  as the location of
the regulator nodes was in question.

In short, I would be quite content  to follow the existing examples.

Regards,
Jim Quinlan
Broadcom STB

>
> > [1] https://lore.kernel.org/linux-pci/20210329162539.GG5166@sirena.org.uk/
> > [2] https://lore.kernel.org/linux-pci/CAL_JsqKPKk3cPO8DG3FQVSHrKnO+Zed1R=PV7n7iAC+qJKgHcw@mail.gmail.com/

--000000000000060ba705e43dc48c
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCjNddhdlQM3zuW9Zd4GGZxwviIa9GU
dl202BaJrEneWjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA3
MjAxNDUzMzZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAYEMuM9ri/PnCbYZccHQMUZbXcttIxHy7VcBP47ME+VkdKfrF
La3taH6K7zPukv2ncLrg82nzprzOJPYBYTiH56tR1Up3F3j1ASlnQC/7iuM17Xo7vBvDoQTCK7p5
DAPwBseHPUiQLFEvXULxbsaS0wGVWFcMbBwG2p7CyevOJwAyfpYy+pEboBZBX9Xw//Dkpqvvz5wO
D5PDcJzpR6GCkBtkyYVgRrCPstMPdQBXolDsinabF1fmhAFW6DnpS93ZL6cXWiEtlKqZxuIkNTIw
X7S2OJ9Q3MI4U/CKMWq4/JP66V0o8/InTGBkPqdkzsrSC7Mm7x5jtYJ/OyVNvpTuLQ==
--000000000000060ba705e43dc48c--
