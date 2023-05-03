Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9756F6092
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 23:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjECVib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 May 2023 17:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECVib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2023 17:38:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22C4EE0
        for <linux-pci@vger.kernel.org>; Wed,  3 May 2023 14:38:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f1738d0d4cso35995255e9.1
        for <linux-pci@vger.kernel.org>; Wed, 03 May 2023 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1683149908; x=1685741908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x9R3tSTKfe90r2tNnqycMZnhUlSl05qt8KSj4INgaB4=;
        b=S48OWAE+l+uw+QpQTgEuLD35AZvOT5xvNDbC+T/l7TaXfKHGEuF/lequIGevLuoF7f
         p+ngPEX62B17u5otCmyKFj11U+/XBF/B0bQYrjR1dPA5R5sSrYWuzMO2xtGpbPeLexzc
         GXqTfqk9hMjJJupnh4EZEFdFd9lwzv2pxfQNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683149908; x=1685741908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9R3tSTKfe90r2tNnqycMZnhUlSl05qt8KSj4INgaB4=;
        b=K4xwgKlp62IdSCVSNonhTllN8rl9v/tmSCH6NgqvY5X6FiwGtNM5XGxZ3hcefUHWCs
         +6tRztRjqr7p8yO5XhJT6v1aolyGO50U1wbjc0LC7LhC94prpoM7mPzAG1gzABqxm37R
         fYr7WZk6pLu2gLrLacyQuePPjy/pTG84GwzfDc/5IXwRU+qKbHD8vzjt7C0s0WZPD+CB
         CRsN7TnIAcm/MTfPQ3tOr/C/m/ZeBalPE7QpmlWRSvYPXq7D860Z/t0zJHlcwbrLyrRr
         ASe7hIq8SP/lFYFyZxK+coRYQNTIrC6Z0nmpwMVPV7GlGQchRAKwNG1DzuB5hJjH9aYi
         d1fA==
X-Gm-Message-State: AC+VfDz3IarWfERdM4Vz9YDrrlna/RRy1ZoQ1Otu5wAFA+VlI1iF8cOi
        5P+9VKXE4fqRry1aM/JAow9KmrtuCXLb+XozZ1fJ0ixoyL2nBQIs8vA=
X-Google-Smtp-Source: ACHHUZ4dVvXiE4GCJSMmrHAq1rBn32PazU1r1gAaXck2y41FdwX9+ER1onwQmzeaypGv/FUGm6LTd69bfRVKzbVBwoQ=
X-Received: by 2002:adf:dc0f:0:b0:2f9:ee8c:a2fa with SMTP id
 t15-20020adfdc0f000000b002f9ee8ca2famr973392wri.64.1683149907746; Wed, 03 May
 2023 14:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-6iNxO6y_y5En2Q7YHgDGh=v4a-8E1Qbr2VL0NpWNNJqRf-g@mail.gmail.com>
 <20230503180728.GA778510@bhelgaas>
In-Reply-To: <20230503180728.GA778510@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 3 May 2023 17:38:15 -0400
Message-ID: <CA+-6iNwBCn822NBv1wjLcbd0=bHEfx9V3R_UcAcuMz1_etUjMg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: PCI: brcmstb: brcm,{enable-l1ss,completion-timeout-us}
 props
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006092fd05fad0e0d5"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000006092fd05fad0e0d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 3, 2023 at 2:07=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, May 03, 2023 at 10:38:57AM -0400, Jim Quinlan wrote:
> > On Sun, Apr 30, 2023 at 3:10=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Fri, Apr 28, 2023 at 06:34:55PM -0400, Jim Quinlan wrote:
> > > > brcm,enable-l1ss (bool):
> > > >
> > > >   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SO=
Cs --
> > > >   requires the driver probe() to deliberately place the HW one of t=
hree
> > > >   CLKREQ# modes:
> > > >
> > > >   (a) CLKREQ# driven by the RC unconditionally
> > > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > > >
> > > >   The HW+driver can tell the difference between downstream devices =
that
> > > >   need (a) and (b), but does not know when to configure (c).  All d=
evices
> > > >   should work fine when the driver chooses (a) or (b), but (c) may =
be
> > > >   desired to realize the extra power savings that L1SS offers.  So =
we
> > > >   introduce the boolean "brcm,enable-l1ss" property to inform the d=
river
> > > >   that (c) is desired.  Setting this property only makes sense when=
 the
> > > >   downstream device is L1SS-capable and the OS is configured to act=
ivate
> > > >   this mode (e.g. policy=3D=3Dsuperpowersave).
> > ...
>
> > > What bad things would happen if the driver always configured (c)?
> >
> > Well, our driver has traditionally only supported (b) and our
> > existing boards have been designed with this in mind.  I would not
> > want to switch modes w'o the user/customer/engineer opting-in to do
> > so.  Further, the PCIe HW engineer told me defaulting to (c) was a
> > bad idea and was "asking for trouble".  Note that the commit's
> > comment has that warning about L1SS mode not meeting this 400ns
> > spec, and I suspect that many of our existing designs have bumped
> > into that.
> >
> > But to answer your question, I haven't found a scenario that did not
> > work by setting mode (c).  That doesn't mean they are not out there.
> >
> > > Other platforms don't require this, and having to edit the DT
> > > based on what PCIe device is plugged in seems wrong.  If brcmstb
> > > does need it, that suggests a hardware defect.  If we need this to
> > > work around a defect, that's OK, but we should acknowledge the
> > > defect so we can stop using this for future hardware that doesn't
> > > need it.
> >
> > All devices should work w/o the user having to change the DT.  Only
> > if they desire L1SS must they add the "brcm,enable-l1ss" property.
>
> I thought the DT was supposed to describe properties of the
> *hardware*, but this seems more like "use this untested clkreq
> configuration," which maybe could be done via a module parameter?
Electrically, it has been tested, but  specifically for L1SS capable
devices.  What is untested AFAICT are platforms using this mode on
non-L1SS capable
devices.  I was not aware that Raspian OS was turning this on as a
default until the CM4 came out.

As far as "DT describing the HW only", one doesn't have to go far to
find exceptions to the rule.
One example off the top of my head is "linux,pci-domain" -- all this
does is assign
an "id" to a controller to make life easier.  We've gone from not
using it, with three controllers no less,
to using it, but the HW was the same all along.

WRT bootline param
pci=3D[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*pci:<vendor>:<device>[:<=
subvendor>:<subdevice>]:
this does not look compatible for vendor specific DT options like
"brcm,enable-l1ss".  I observe that pci_dev_str_match_path() is a
static function and I don't see a single option in pci.c  that is
vendor specific.  FWIW, moving something like this to the bootline
would not be popular with our customers; for some reason they really
don't like changes to the bootline.


>
> Whatever the mechanism, it looks like patch 2/5 makes brcmstb
> advertise the appropriate ASPM and L1SS stuff in the PCIe and L1SS
> Capabilities so the OS will do the right thing without any core
> changes.
>
> > > Maybe the name should be more specific to CLKREQ#, since this
> > > doesn't actually *enable* L1SS; apparently it's just one of the
> > > pieces needed to enable L1SS?
> >
> > The other pieces are:  (a) policy =3D=3D POWERSUPERSAVE and (b) an
> > L1SS-capable device, which seem unrelated and are out of the scope
> > of the driver.
>
> Right.  Of course, if ASPM and L1SS support are advertised, the OS can
> still choose whether to enable them, and that choice can change at
> run-time.
Agree.

Thanks & regards,
Jim Quinlan
Broadcom STB
>
> > The RPi Raspian folks have been using "brcm,enable-l1ss"  for a
> > while now and I would prefer to keep that name for compatibility.
>
> BTW, the DT comment in the patch refers to PCIe Mini CEM .0 sec
> 3.2.5.2.5.  I think the correct section is 3.2.5.2.2 (at least in the
> r2.1 spec).
>
> There's also a footnote to the effect that T_CRLon is allowed to
> exceed 400ns when LTR is supported and enabled.  L1.2 requires LTR, so
> if L1.2 is the case where brcmstb exceeds 400ns, that might not be a
> problem.
>
> Bjorn

--0000000000006092fd05fad0e0d5
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAd5f5+wrmmAKUd6cLTsu5TZR/Rs8ig
y5o1R0LIEE0+DzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA1
MDMyMTM4MjhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAaLmJ2Vq7qAnRvNyNQJjqMemznps1iKJ5aR5LmDfrJB+1Z/Xu
dfzbytjpS8svQPzbRUr6Ab+g7xuSZDYfAgMoESSIcppgm/9lf3N50TPcdxlQstjyVzhKqAhSA94z
SxGT2MtR2NNjZj74HqzN+Pv69m7XWIA6O0gp4RgavCKzSt+nhqqcmWax+bKSTm2NpjyRZriPvuAI
9P4fNZudkjiZ1zfbZ17XUM8l7eEqU1uD4TBiUT6PwMqjl799gM+S22zHK1KKushH+9P1yZa0orH2
Iso59wLxoZFTLL24R6JuUHHi3ftNXu7et5y1+/ZAw6jZHxoAUo/ACXnx3lq2XlSKQg==
--0000000000006092fd05fad0e0d5--
