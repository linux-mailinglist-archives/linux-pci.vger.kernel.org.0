Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012425679E7
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 00:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiGEWGP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 18:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGEWGO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 18:06:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8484193E7
        for <linux-pci@vger.kernel.org>; Tue,  5 Jul 2022 15:06:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g26so23963015ejb.5
        for <linux-pci@vger.kernel.org>; Tue, 05 Jul 2022 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drmmidETRk8G2bwexGZUxHDb5Ohrr3x5cIlAWvejWYM=;
        b=grP2bkDuP9b7CLsrdfiOG4iNaB3ImcN8HIhhcy9o5GQaGYasmChFKEw+16VOmjvPUu
         iJyxfb2LQJ+wuG+suD2Vyrc2G0PKkLyDq3hox2Fb+exo3Wx0qiKYjy40sX6T4bJenmCN
         +AFz7oT37mAeuz5EdhRC/qm1SSUHVCrUnpz3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drmmidETRk8G2bwexGZUxHDb5Ohrr3x5cIlAWvejWYM=;
        b=05Zj6PGY68mMOigA3CMlSAA46mXr13qU3xzkyrpatWlc0mZ3bxaXy+eK15ZZg8gS2Y
         1yIm0N8ai+8GcpjI2me6lkePR3FgnZ9poPz34R/+9+RtiPwC5ac8uZDIAp5Wc6lzeAdw
         I/WwIKY8yehrUofHqhCPH9G4y0Y15lw/38aS5UpcrDRq+sMsdfbAWbyZ1Ff3fSb9Szcg
         VidRy065Pjd2PZ6lvzkASF8zBYkM9BOpGLy5NgXLtyhHrUh4cBGJwvHrRxOtXPnLIiGc
         MYTLmDrdLYzx6z3nDzyUJNiv6rX9NbJVicx5gjDe4SA3qV0PPgeYKEtBJJnIbsBI1V5q
         BQeg==
X-Gm-Message-State: AJIora+2jKsW2qkXELYnmCyBWwR6cmW7OIUmpI7DfIV2CJ6ffZVmSpaX
        L3iDCzL0ipzYZ/eEVyNj2rQED4lp+muvX7idozG5zQ==
X-Google-Smtp-Source: AGRyM1uHrSrj3LPyU6AvGrnMIOEVgNomIOzy5Fz+4IjXjDk48F4/EuEev7/Z+d34C6U88KykY6yirM0J37Qn4Cdv5Q4=
X-Received: by 2002:a17:907:6e05:b0:72a:a141:962 with SMTP id
 sd5-20020a1709076e0500b0072aa1410962mr19423210ejc.545.1657058771486; Tue, 05
 Jul 2022 15:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220701162726.31346-1-jim2101024@gmail.com> <1a50e8b0-1453-4561-bc3d-c428bb65288a@gmail.com>
 <20220705205551.phbaqqpgyg3pvtv7@mraw.org> <68af8b36-76b7-23d2-c689-d05fd62086b1@gmail.com>
 <20220705212801.u2mq6iyq2dtwzc36@mraw.org>
In-Reply-To: <20220705212801.u2mq6iyq2dtwzc36@mraw.org>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 5 Jul 2022 18:06:00 -0400
Message-ID: <CA+-6iNwHaqyvc7ZVgv9SjR+s+=8gRbL6TXo-F_R6BOoFSPtM1Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Re-submit reverted patchset
To:     Cyril Brulebois <kibi@debian.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000075872805e3160f27"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000075872805e3160f27
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 5, 2022 at 5:28 PM Cyril Brulebois <kibi@debian.org> wrote:
>
> Florian Fainelli <f.fainelli@gmail.com> (2022-07-05):
> > On 7/5/22 13:55, Cyril Brulebois wrote:
> > > That happens with current master (v5.19-rc5-56-ge35e5b6f695d2), with
> > > or without this patchset.
> > >
> > > That being said, I'm not able to reproduce the showstopper
> > > regression that I reported against the initial patchset (booting was
> > > breaking in the very first few seconds), so I suppose it's fine to
> > > propose the following even if that's somewhat tainted by those mmc
> > > issues.
> >
> > Any chance you can bisect the eMMC issues so we can investigate those
> > separately? Thanks!
Cyril,

Before you go to the trouble of a bisection, can you just post the
(or email me) the following:

o complete boot log
o output of "cat /proc/interrupts"
o output of "for i in $(find /sys/devices/platform/ -type f -name
state) ; do echo $i: $(cat $i) ; done"

Thanks,
Jim Quinlan
Broadcom STB

>
>
> Definitely. I wanted to make sure I wouldn't delay the reintroduction of
> this patchset (feeling partly responsible for the revert that happened
> in the first place), by providing some feedback regarding a possible
> come-back of the regression, as soon as possible.
>
> Now that this is out of the way, I'll try and find time to investigate
> those MMC issues. Ditto for DRM, I seem to have completely lost the HDMI
> output (that's less of an issue thanks to the serial console that has
> been rather reliable to gather kernel logs).
>
> I think I started encountering both issues very early in the devel
> cycle (when we were still trying to find some follow-up commits to fix
> the regression instead of going for the full-on revert), but I couldn't
> afford spending time chasing multiple issues at once. I haven't checked
> whether reports exist already for those issues, but that's my next step.
>
>
> Cheers,
> --
> Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
> D-I release manager -- Release team member -- Freelance Consultant

--00000000000075872805e3160f27
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBdoxwFT4ccaFBDt2uBcNumAiL8CF9H
9vwJaOVh2WMAtjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA3
MDUyMjA2MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEASIyT//p2KUcCzX/7jtAlFDpnlCMA9ftMrDPPAE5nH8M4UJ4t
VxWnD78OLchk9Xy5JLfDXT46hp2o+OeCawvTbg93YwPWTA8IYfIfGPkBX5Qjel8zZofO8G1qCjCX
vaQgPX7K+N3rqOYfop2/UyY7+f2AgQs1og4aOo4R6PINT6NyMKwb7BKIkGVCIze5nZ3if3GZ7FDw
aJ3uTS5LxsLh/4+vV1T5mUjGWHATYVBzi17MoQlguphZ3Ms6sY4E/wmBZOkNgQ5uHAYuM5lFWgzL
XMJ6J9KfdNPHczVwDqB1u27LkJn6FdqW7jK8wwZ33xZG+/TtqX6B7m393JVOTSyP/g==
--00000000000075872805e3160f27--
