Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3036F5A3F
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjECOjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 May 2023 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjECOjV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2023 10:39:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415C4EC9
        for <linux-pci@vger.kernel.org>; Wed,  3 May 2023 07:39:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f315735514so27201105e9.1
        for <linux-pci@vger.kernel.org>; Wed, 03 May 2023 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1683124750; x=1685716750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q23n/goK87yK035YmCtMbivXyWSqFzcSegxSbPKH5A8=;
        b=a6kYpQQ47EK49wA2SzkyExSNHhPaeXKgJJmVI3DgCZiAhGpC/FaDlJraWmb8+A2tOD
         jWm59DbLJn6YFixvadVVg9oSwbThhtwiqvswgXP/ZxJBB6Ljqhf1t3uAJnXMTALDg6Hz
         YQwybXLyPu+1eo56ApII/ht0meipnQEXG5KAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124750; x=1685716750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q23n/goK87yK035YmCtMbivXyWSqFzcSegxSbPKH5A8=;
        b=MRxZfaOF0shKinCLFK0czDnUwefHi1HTNWW9pdPVOKPz81N3sctkH8VoZ6PXTQZfP0
         dAyiZVMqktCajuUOyUJiCfN1q0Yzjt1iCMoev30LEF7FoY61TQrcn1IeBe6lHYmWPEfm
         v9jhjjdedVVgVbC9AlOiwDjCpHHezbcIdGTM/NOiMvHh0+/IzFq3D3xy++ANrjBvYwnc
         VKGFcHWHwpg68njzyra8wFZfKx9H01CNVPcVwCmUUpK/9nATf70hRYauxX/lCvwuyDLh
         zmyAVXW2EjYRGJTVjRAqI04DAr24kICdKaGGi3mKhV8yKVVIys+YUweBKHI09bgacr9x
         q2JA==
X-Gm-Message-State: AC+VfDz795bCPBo83faRkhwoOuPboGITzEKGs/ec8KFXhMIqLqDH5olA
        /l8xsrcVTiI7hQa+YvLIuyyxprkJBtHar/gjgFi8iA==
X-Google-Smtp-Source: ACHHUZ5Nm7xRLs9RW53+kW/oTf7ojf1dBDPO/pL/y7MwoYmgeHSl3uad1Sf1teQMjzi6+KoiKRKFuzH1mybsOCkHSAI=
X-Received: by 2002:adf:f583:0:b0:2d9:10e7:57e8 with SMTP id
 f3-20020adff583000000b002d910e757e8mr207087wro.16.1683124749680; Wed, 03 May
 2023 07:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230428223500.23337-2-jim2101024@gmail.com> <20230430191051.GA515900@bhelgaas>
In-Reply-To: <20230430191051.GA515900@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 3 May 2023 10:38:57 -0400
Message-ID: <CA+-6iNxO6y_y5En2Q7YHgDGh=v4a-8E1Qbr2VL0NpWNNJqRf-g@mail.gmail.com>
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
        boundary="000000000000d77bf905facb040d"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000d77bf905facb040d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 30, 2023 at 3:10=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Apr 28, 2023 at 06:34:55PM -0400, Jim Quinlan wrote:
> > This commit introduces two new properties:
>
> Doing two things makes this a candidate for splitting into two
> patches, as you've already done for the driver support.  They seem
> incidentally related but not indivisible.
>
> > brcm,enable-l1ss (bool):
> >
> >   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs -=
-
> >   requires the driver probe() to deliberately place the HW one of three
> >   CLKREQ# modes:
> >
> >   (a) CLKREQ# driven by the RC unconditionally
> >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> >
> >   The HW+driver can tell the difference between downstream devices that
> >   need (a) and (b), but does not know when to configure (c).  All devic=
es
> >   should work fine when the driver chooses (a) or (b), but (c) may be
> >   desired to realize the extra power savings that L1SS offers.  So we
> >   introduce the boolean "brcm,enable-l1ss" property to inform the drive=
r
> >   that (c) is desired.  Setting this property only makes sense when the
> >   downstream device is L1SS-capable and the OS is configured to activat=
e
> >   this mode (e.g. policy=3D=3Dsuperpowersave).
>
> Is this related to the existing generic "supports-clkreq" property?  I
> guess not, because supports-clkreq looks like a description of CLKREQ
> signal routing, while brcm,enable-l1ss looks like a description of
> what kind of downstream device is present?

It is related, I thought about using it,  but not helpful for our needs.  B=
oth
cases (b) and (c)  assume "supports-clkreq", and our HW needs to know
the difference between them.  Further, we have a register that tells
us if the endpoint device has requested a CLKREQ#, so we already
have this information.

As an aside, I would think that the "supports-clkreq" property should be in
the port-driver or endpoint node.

>
> What bad things would happen if the driver always configured (c)?
Well, our driver has traditionally only supported (b) and our existing
boards have
been designed with this in mind.  I would not want to switch modes w'o
the user/customer/engineer opting-in to do so.
Further, the PCIe HW engineer
told me defaulting to (c) was a bad idea and was "asking for trouble".
Note that the commit's comment has that warning about L1SS mode
not meeting this 400ns spec, and I suspect that many of our existing design=
s
have bumped into that.

But to answer your question, I haven't found a scenario that did not work
by setting mode (c).  That doesn't mean they are not out there.

>
> Other platforms don't require this, and having to edit the DT based on
> what PCIe device is plugged in seems wrong.  If brcmstb does need it,
> that suggests a hardware defect.  If we need this to work around a
> defect, that's OK, but we should acknowledge the defect so we can stop
> using this for future hardware that doesn't need it.

All devices should work w/o the user having to change the DT.  Only if they
desire L1SS must they add the "brcm,enable-l1ss" property.

Now there is this case where Cyril has found a regression, but recent
investigation
into this indicates that this particular failure was due to the RPi
CM4 using a "beta" eeprom
version -- after updating, it works fine.

>
> Maybe the name should be more specific to CLKREQ#, since this doesn't
> actually *enable* L1SS; apparently it's just one of the pieces needed
> to enable L1SS?

The other pieces are:  (a) policy =3D=3D POWERSUPERSAVE and (b) an L1SS-cap=
able
device, which seem unrelated and are out of the scope of the driver.

The RPi Raspian folks have been using "brcm,enable-l1ss"  for a while now a=
nd
I would prefer to keep that name for compatibility.

>
> >   This property is already present in the Raspian version of Linux, but=
 the
> >   upstream driver implementaion that follows adds more details and disc=
erns
> >   between (a) and (b).
>
> s/implementaion/implementation/
>
> > brcm,completion-timeout-us (u32):
> >
> >   Our HW will cause a CPU abort on any PCI transaction completion abort
> >   error.  It makes sense then to increase the timeout value for this ty=
pe
> >   of error in hopes that the response is merely delayed.  Further,
> >   L1SS-capable devices may have a long L1SS exit time and may require a
> >   custom timeout value: we've been asked by our customers to make this
> >   configurable for just this reason.
>
> I asked before whether this should be made generic and not
> brcm-specific, since completion timeouts are generic PCIe things.  I
> didn't see any discussion, but Rob reviewed this so I guess it's OK
> as-is.
I am going to drop it, thanks for questioning its purpose and
I apologize for  the noise.

Regards,
Jim Quinlan
Broadcom STB
>
> Is there something unique about brcm that requires this?  I think it's
> common for PCIe Completion Timeouts to cause CPU aborts.
>
> Surely other drivers need to configure the completion timeout, but
> pcie-rcar-host.c and pcie-rcar-ep.c are the only ones I could find.
> Maybe the brcmstb power-up values are just too small?  Does the
> correct value need to be in DT, or could it just be built into the
> driver?
>
> This sounds like something dependent on the downstream device
> connected, which again sounds hard for users to deal with.  How would
> they know what to use here?
>
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/pci/brcm,stb-pcie.yaml   | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b=
/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 7e15aae7d69e..239cc95545bd 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -64,6 +64,22 @@ properties:
> >
> >    aspm-no-l0s: true
> >
> > +  brcm,enable-l1ss:
> > +    description: Indicates that PCIe L1SS power savings
> > +      are desired, the downstream device is L1SS-capable, and the
> > +      OS has been configured to enable this mode.  For boards
> > +      using a mini-card connector, this mode may not meet the
> > +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.5
> > +      of the PCI Express Mini CEM 2.0 specification.
> > +    type: boolean
> > +
> > +  brcm,completion-timeout-us:
> > +    description: Number of microseconds before PCI transaction
> > +      completion timeout abort is signalled.
> > +    minimum: 16
> > +    default: 1000000
> > +    maximum: 19884107
> > +
> >    brcm,scb-sizes:
> >      description: u64 giving the 64bit PCIe memory
> >        viewport size of a memory controller.  There may be up to
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--000000000000d77bf905facb040d
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA5EXKV8/4Gl8f1XaXtzfeEpgG17tNH
3OhJkKFM9acX0jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA1
MDMxNDM5MTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAZUdqIt4Dst9NB1XMRtLfDm1dG8e6ZAVGFrRTTqjU7g0LU1pe
ertekc56VNrqNYkqs38ar+jGYnU0kP8tPuIquyEaBqKWUyWQdqKevAF/2OScT3sVV8kanpzgcC61
4/lYN+Q46s4r/Qui10SrgYSy7qey+gl3qjol7QHJ0DdWhCJd0sf+x08/U850Gf6IQY2/SEjA999t
sfLnauXzoBqwmbzSRWrfDB9+GOHl+osoN2N+VG2LE5ycOPyZlGIZy5racvfbKykKn2hAZ5MvyE9b
tf+Vq0yYSbq2OEnP4IKxCSuAtsb25G9fagxE/7ZukCDx3YFzytUkJlkNWr4BYzHNAg==
--000000000000d77bf905facb040d--
