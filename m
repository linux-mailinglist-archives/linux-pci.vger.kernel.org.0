Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F02F7828BF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjHUMPT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 08:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjHUMPT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 08:15:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3DFE9
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 05:15:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so10586601fa.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692620115; x=1693224915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi0N4prYZFIquyf1AYTwTUf6bKfhIqjj2k/eAGXnIjg=;
        b=aoRZvF4RKYqAiKrI4NwQO9cNAy8l6nm1Qb+CO1Im+KQUOa7bfTm8AzZ6R9bIdXQs2b
         eZ+C297hTSLLADDs6oM/a9qPBr9wc0+Ezr8eArbHJXnz2nEJDbSGguBcdilUwcZRVpwr
         NII6ChyURbbclXw26RoB19+VFWCFY4ije1GyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692620115; x=1693224915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hi0N4prYZFIquyf1AYTwTUf6bKfhIqjj2k/eAGXnIjg=;
        b=AOvHOtOVl92J2nf6YrQkhMfi8t9ufzCn1V6OVoQWyiaGZZoSQDr+IBufgTBGFguxtT
         /EIBfFxgEkOcXkzsCK6X4iXYJGLTbbV2NWbe6tgWOjpLwGKLwrgn4jCIvJKk16IpQ7Nz
         ucyDuhSBF7l+RhGo/F/2ex60TEszhsTvVwkrK1nltVawljGd/+pBBE8m7HBMWzHepwGc
         OqXu0LVM/6uTK3VQ/SWe801OKfedaU60osfLeU6OeKqtuZCgUqrGTS6r/jB2OiJZ/8Bc
         9IYd3hlN2HvJW+1cPYTYDVup0x/p/SZPyWUju4ORTjoy+NJupnz4mXxjwEmYzUhsDupc
         KP1w==
X-Gm-Message-State: AOJu0Ywa8pvaKwX7ZyTuT/FOKN/p7lhWVIebJt0I9jA1oTHWTAqOvwcF
        7YEFJOHlQrPOZBpuw9+yDFuR01DdVYmAnQW8HW86Ow==
X-Google-Smtp-Source: AGHT+IEV3MVPbyx3PqqTRR02C2+z8R7ci6XRJuJuuqATuEwi+wZPEEswjYyZL6rqPJXz5uCRKJy+r1KsKEXcQ24YIQk=
X-Received: by 2002:a2e:3008:0:b0:2b9:4c17:7939 with SMTP id
 w8-20020a2e3008000000b002b94c177939mr5116783ljw.12.1692620114738; Mon, 21 Aug
 2023 05:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230623144100.34196-1-james.quinlan@broadcom.com> <ZOMhq8a/wnURWsFP@lpieralisi>
In-Reply-To: <ZOMhq8a/wnURWsFP@lpieralisi>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 21 Aug 2023 08:15:02 -0400
Message-ID: <CA+-6iNy7bqxSgCrgtPv3R-0ZePT92LWL0s3Zvz8kAANVH9b=cQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ# mode
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b368ac06036dd43c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000b368ac06036dd43c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 4:35=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Fri, Jun 23, 2023 at 10:40:53AM -0400, Jim Quinlan wrote:
> > v6 -- No code has been changed.
> >    -- Changed commit subject and comment in "#PERST" commit (Bjorn, Cyr=
il)
> >    -- Changed sign-off and author email address for all commits.
> >       This was due to a change in Broadcom's upstreaming policy.
> >
> > v5 -- Remove DT property "brcm,completion-timeout-us" from
> >       "DT bindings" commit.  Although this error may be reported
> >       as a completion timeout, its cause was traced to an
> >       internal bus timeout which may occur even when there is
> >       no PCIe access being processed.  We set a timeout of four
> >       seconds only if we are operating in "L1SS CLKREQ#" mode.
> >    -- Correct CEM 2.0 reference provided by HW engineer,
> >       s/3.2.5.2.5/3.2.5.2.2/ (Bjorn)
> >    -- Add newline to dev_info() string (Stefan)
> >    -- Change variable rval to unsigned (Stefan)
> >    -- s/implementaion/implementation/ (Bjorn)
> >    -- s/superpowersave/powersupersave/ (Bjorn)
> >    -- Slightly modify message on "PERST#" commit.
> >    -- Rebase to torvalds master
> >
> > v4 -- New commit that asserts PERST# for 2711/RPi SOCs at PCIe RC
> >       driver probe() time.  This is done in Raspian Linux and its
> >       absence may be the cause of a failing test case.
> >    -- New commit that removes stale comment.
> >
> > v3 -- Rewrote commit msgs and comments refering panics if L1SS
> >       is enabled/disabled; the code snippet that unadvertises L1SS
> >       eliminates the panic scenario. (Bjorn)
> >    -- Add reference for "400ns of CLKREQ# assertion" blurb (Bjorn)
> >    -- Put binding names in DT commit Subject (Bjorn)
> >    -- Add a verb to a commit's subject line (Bjorn)
> >    -- s/accomodat(\w+)/accommodat$1/g (Bjorn)
> >    -- Rewrote commit msgs and comments refering panics if L1SS
> >       is enabled/disabled; the code snippet that unadvertises L1SS
> >       eliminates the panic scenario. (Bjorn)
> >
> > v2 -- Changed binding property 'brcm,completion-timeout-msec' to
> >       'brcm,completion-timeout-us'.  (StefanW for standard suffix).
> >    -- Warn when clamping timeout value, and include clamped
> >       region in message. Also add min and max in YAML. (StefanW)
> >    -- Qualify description of "brcm,completion-timeout-us" so that
> >       it refers to PCIe transactions. (StefanW)
> >    -- Remvove mention of Linux specifics in binding description. (Stefa=
nW)
> >    -- s/clkreq#/CLKREQ#/g (Bjorn)
> >    -- Refactor completion-timeout-us code to compare max and min to
> >       value given by the property (as opposed to the computed value).
> >
> > v1 -- The current driver assumes the downstream devices can
> >       provide CLKREQ# for ASPM.  These commits accomodate devices
> >       w/ or w/o clkreq# and also handle L1SS-capable devices.
> >
> >    -- The Raspian Linux folks have already been using a PCIe RC
> >       property "brcm,enable-l1ss".  These commits use the same
> >       property, in a backward-compatible manner, and the implementaion
> >       adds more detail and also automatically identifies devices w/o
> >       a clkreq# signal, i.e. most devices plugged into an RPi CM4
> >       IO board.
> >
> >
> > Jim Quinlan (5):
> >   dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
> >   PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream
> >     device
>
> I am not merging the first two patches since the discussion thread
> is still open and I'd like to understand better what can/should be
> done, sorry.

Hello Lorenzo,

This patch-set has been stable for months, V5 was out early May and
the V6 changes
did not involve code.  I'm a little surprised that you are voicing
concern at this stage.

The previous discussions covered all aspects of these commits AFAICT.
Please  review
them and the commit messages and let me know what issues you do not underst=
and
or any topics that were not considered.

Are you concerned about the Broadcom STB/CM community  or the RPi community=
?
For the former, I have direct communication w/ our customers and none of th=
em
are even close to using upstream (they may backport my commits).  For
the latter, I have
tested these commits on the official RPi4 and CM4 IO platforms, and
Cyril has also put in
an admiral amount of testing.

Note that I have on my desk a CM4 IO board w/ a conventional PCIe
device, and it does not boot
upstream master Linux until these patches are applied.

Further, Raspian OS has already introduced the "brcm,enable-l1ss"
property but did not upstream it, and
my commits are backwards compatible with this.

>
> >   PCI: brcmstb: Set higher value for internal bus timeout
> >   PCI: brcmstb: Assert PERST# on BCM2711
> >   PCI: brcmstb: Remove stale comment
>
> Is it OK to apply these three on their own ? Overall it would be
> great to avoid mixing patches with different end goals in a single
> series.

Well, they are related for one customer who wants to use L1SS power
savings AND require
a long  period for the internal timeout.  But, yes, these commits are
fine  to apply
independently.

Regards,
Jim Quinlan
Broadcom STB

>
> Thanks,
> Lorenzo
>
> >  .../bindings/pci/brcm,stb-pcie.yaml           |  9 ++
> >  drivers/pci/controller/pcie-brcmstb.c         | 91 ++++++++++++++++---
> >  2 files changed, 89 insertions(+), 11 deletions(-)
> >
> >
> > base-commit: 8a28a0b6f1a1dcbf5a834600a9acfbe2ba51e5eb
> > --
> > 2.17.1
> >
>
>

--000000000000b368ac06036dd43c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC0GNjHSOUXkE7A6vi/gpy9I+YBGrHK
naltvZ4qFdayezAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA4
MjExMjE1MTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEASQsj9vpkQAU70XH+6lMuymsB2fBUk427pCeSg8LuWMjLo15T
Rb0xqRufoJZRz9xFbPx1m+42Pg9d+MhiEtpBmVAUtk/JZOVyf/b4E85YLZSQoHBlEiTAa4k4p56h
PUaPuz4nY72+xPp7t8C8GUeUdopc9x5Z45c5Ys0UdHqhTWECFb+99NDtC+vURYDeGmO0lFIOSH5y
ro+wirwuM6oaTwle9aIf4JoLyGkVEr2ikH9ZZvsj6MO2xL78YjT0jjXwXiRuYQqmAY/LS0+EATgq
Id7gPlPv7Q/NN9vYZXGBWosFtLkDoDcT/ucU7rQNfaEuSEPWNT1HftXxhUmbK+GqEg==
--000000000000b368ac06036dd43c--
