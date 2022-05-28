Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA69536955
	for <lists+linux-pci@lfdr.de>; Sat, 28 May 2022 02:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiE1ATe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 20:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbiE1ATb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 20:19:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D795F8C9
        for <linux-pci@vger.kernel.org>; Fri, 27 May 2022 17:19:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id jx22so11344492ejb.12
        for <linux-pci@vger.kernel.org>; Fri, 27 May 2022 17:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dy9PAcwFR0YAFFeoxZSpIDqAbpcRuX2jjRoesg3AIyw=;
        b=W+ZZ9XK/18MYChPa32LjJUOV0m8j9L8d2psrVeVVLPKAHtUSELeFmZnoTUDfoRh3l9
         r/2RcGciie14o+BAgZz4SU/5UQvipGyKBUy7NC0bMnD13OWsoxHAmMbjRunSjlzjJejp
         aV6NfNoWgWazuecDtWa3xYa0i3BiqQRH8Hc8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dy9PAcwFR0YAFFeoxZSpIDqAbpcRuX2jjRoesg3AIyw=;
        b=nDSX7eUQSgShS7M8bdeycZrr09kJZb8TYzeAYx5YmqqdwOTcuzijxzL7dFdcabDOIM
         CZf76WNrpvY3+z7yg5OR3AORrMj2fkLf8K8ghGVSIY1vqFwlM9sLWbTZZc+V74oV6Pu9
         Sw8w3nRe/vK0bP5VNNR79ETiugwU8fgEkassTZPKntQzBTa+KiNgI6z1GEqfCTDD+8cv
         8TQItA0C4lSE02kUxNawJs880paJarmuS+l+g2Be/XGyEv5rCFICIVRfG19rAtXyoEH+
         3xb6QjWrZ0IFkeAkIXYfWdfgH6bKJLv2GyIo1ZrITpgb0E2/GHY6VXl86ZdDE4pUdaQ5
         MrEA==
X-Gm-Message-State: AOAM530UhGDktP3eEr/niJtx8oOn3oJnPDDDLSRWBdQ88gIP1Lq0KcM+
        9MV479Xx0xuy/mUSX+u6lgkr2AVSiZiMxj8Cl4TLhW7bE4CqTg==
X-Google-Smtp-Source: ABdhPJxxCJ+nsrWPv2WFBK+a6IGIqGPBewf6NjSoaJhwnhj4k+VGLDRAzEqmUIaHZXhPim+wYzYmCWxqeVB1NfrR0Lk=
X-Received: by 2002:a17:907:1693:b0:6ff:be2:fe6b with SMTP id
 hc19-20020a170907169300b006ff0be2fe6bmr15827381ejc.674.1653697168088; Fri, 27
 May 2022 17:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220525215739.GA275957@bhelgaas> <20220527232757.GA515159@bhelgaas>
In-Reply-To: <20220527232757.GA515159@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 27 May 2022 20:19:16 -0400
Message-ID: <CA+-6iNzfT1Ut3P-mn3kL=ZUdso+FV9KJUpQzOZpQfpJAT7BTkQ@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe linkup
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004a189c05e00760af"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000004a189c05e00760af
Content-Type: text/plain; charset="UTF-8"

On Fri, May 27, 2022 at 7:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, May 25, 2022 at 04:57:39PM -0500, Bjorn Helgaas wrote:
> > On Tue, May 24, 2022 at 12:54:48PM -0400, Jim Quinlan wrote:
> > > On Mon, May 23, 2022 at 6:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Sat, May 21, 2022 at 02:51:42PM -0400, Jim Quinlan wrote:
> > > > > On Sat, May 21,
> > > > > 2CONFIG_INITRAMFS_SOURCE="/work3/jq921458/cpio/54-arm64-rootfs.cpio022
> > > > > at 12:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Wed, May 18, 2022 at 03:42:11PM -0400, Jim Quinlan wrote:
> > > > > > > commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice
> > > > > > > voltage regulators")
> > > > > > >
> > > > > > > introduced a regression on the PCIe RPi4 Compute Module.  If the
> > > > > > > PCIe endpoint node described in [2] was missing, no linkup would
> > > > > > > be attempted, and subsequent accesses would cause a panic
> > > > > > > because this particular PCIe HW causes a CPU abort on illegal
> > > > > > > accesses (instead of returning 0xffffffff).
> > > > > > >
> > > > > > > We fix this by allowing the DT endpoint subnode to be missing.
> > > > > > > This is important for platforms like the CM4 which have a
> > > > > > > standard PCIe socket and the endpoint device is unknown.
> >
> > > > But above you say it's the *endpoint* node that doesn't exist.  The
> > > > existing code looks like it's checking for the *bridge* node
> > > > (bus->dev->of_node).  We haven't even enumerated the devices on the
> > > > child bus, so we don't know about them at this point.
> > >
> > > You are absolutely correct and I must change the commit message
> > > to say the "root port DT node".   I'm sorry; this mistake likely did not
> > > help you understand the fix. :-(
> >
> > Great, that will help me out!  I think including the relevant DT
> > snippet would also make it more concrete and might conceivably be
> > helpful to somebody working around it on a kernel without the fix.
>
> Where are we at with this?  Linus just merged my pull request, and I'd
> really like to get this resolved before -rc1 (expected June 5 or so),
> which means I'd like to ask him to pull the fix early next week.
I was waiting to see where the email thread was going...
I'll send out the v2 regression fix in less than 24 hours.


Regards,
Jim Quinlan
Broadcom STB
>
> The alternative is to ask him to pull these reverts, which have
> actually been in -next since May 11:
>
>   4246970a3bcb ("Revert "PCI: brcmstb: Split brcm_pcie_setup() into two funcs"")
>   f35b19f02e01 ("Revert "PCI: brcmstb: Add mechanism to turn on subdev regulators"")
>   ae65b283d7a4 ("Revert "PCI: brcmstb: Add control of subdevice voltage regulators"")
>   d938b26e9b14 ("Revert "PCI: brcmstb: Do not turn off WOL regulators on suspend"")
>
> Bjorn

--0000000000004a189c05e00760af
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBzBDndQ2JrJAzCO6Pfg2mQcluVHHsR
5QBJ+XzlktTazzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA1
MjgwMDE5MjhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAenZTcykbJ8f0uHi0dtaFRNf4RklS4bIQmQvUw9QqweayDDR4
Nr1ifYwo/82ICUrwOk14EAzJ65L5eUwBjG9X1SteECS5K4Vq8Qq6u7OzYzpx4ejRO+nBs0wHqv+S
mky6jlMAGNwD51ZK7hIIWfXk4/ID9eenuVfZ7GC37MPlFqp0XpLzi7qGOllJVMjfi5BIWx15bsyC
Ecshgl1RV7I1UuKkj8sugysDnXlLN2wzLBwHlGwe0e1mdBvFC15GUEhHU4Ys+3xa8hI7ujC3SoUX
ywIfVKbvUhsDQB4K7J4UYnsOQWISBN8wKcP8Rb/b4nUWgf8ydV4QDI76DDc3U+Pb3g==
--0000000000004a189c05e00760af--
