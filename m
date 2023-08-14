Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4066577C11E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjHNTzq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 15:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHNTzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 15:55:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61C10F
        for <linux-pci@vger.kernel.org>; Mon, 14 Aug 2023 12:55:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9c0391749so75378931fa.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Aug 2023 12:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692042912; x=1692647712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SQd0QFP69WaehrLE/nigiD0BgWvKy1Tf8R46ley9P8=;
        b=M/PZyGxgRtMtxAe5BO+1/z3oShPCQQYp9M883cAd8dms0I2C72fWMbLdeH05GDhSgc
         LJVLQkLrRnnLcu+Up93l4iBdHrp8+PnzCcMnZMsPAzrczuHJh5C0ZEq7TOYR7nqd8Qh/
         aR4W+5wT4RgC/KN25mm6rtyzpQCCeP8b6jr20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692042912; x=1692647712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SQd0QFP69WaehrLE/nigiD0BgWvKy1Tf8R46ley9P8=;
        b=fq0SFHK6JzqhbDkhFTuGT3lrvP0TgMZS6oh9+CkflcB5IiarDtOh+HC5bG4QKaeEzW
         IMOfIpmeowpBC1+x95bv838lBaKt0IdxbAUb0O4PUpvsQWn/yA0Hb/e8FClmGAM16ezM
         tTcN/Jbp37/on57ZNFPKisblxMLNHOKqkIZFiqCcRkspeI3hupE3JrqOw7QEp9YVbcX6
         HZ+KRhxB2AfFgCkyjOJEJR3w7EDdMQp23GF9/L+HbZAAEiI+oiy6FOco3igIvxdf2+uW
         t5dN6o8tSf7osTEnD91rI5MOOeP1eZJg5cljHVmxNNA4peFYc8QHQFrc8T0xmi+qvvwe
         hg8w==
X-Gm-Message-State: AOJu0YxUuVDzr8bsWbM+fpd3QeGl2YGe7/ym4vG06Z6Cg4eUhnOMree6
        9tL89U7DjrKhZ4XOhOrs62xnNQqZ2/G8S3EPJHA9Eg==
X-Google-Smtp-Source: AGHT+IETwSsp1ReSrSUscYPJFZtJN0mMFAyD35LojDTMGCedxDvdi1lfj0wlfo18lMvKemz58t1CErSDCvX5i+EKfzs=
X-Received: by 2002:a2e:8811:0:b0:2b9:e304:5f82 with SMTP id
 x17-20020a2e8811000000b002b9e3045f82mr7006825ljh.13.1692042912558; Mon, 14
 Aug 2023 12:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <385baf9dbfb6b65112803998dfc0cd6f84a5e6ba.1691296765.git.lukas@wunner.de>
 <7f6a7a38-8683-7275-d3ee-24a4cd06f8a6@broadcom.com>
In-Reply-To: <7f6a7a38-8683-7275-d3ee-24a4cd06f8a6@broadcom.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 14 Aug 2023 15:55:00 -0400
Message-ID: <CA+-6iNxb6hzz8P_jg3-Jy9NAHf3XfyhiVf79w2_R5vNUrdFzAA@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Avoid downstream access during link training
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Cyril Brulebois <kibi@debian.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c4aeb00602e770ba"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000c4aeb00602e770ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 6, 2023 at 11:16=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
>
>
> On 8/5/2023 9:44 PM, Lukas Wunner wrote:
> > The Broadcom Set Top Box PCIe controller signals an Asynchronous SError
> > Interrupt and thus causes a kernel panic when non-posted transactions
> > time out.  This differs from most other PCIe controllers which return a
> > fabricated "all ones" response instead.
> >
> > To avoid gratuitous kernel panics, the driver reads the link status fro=
m
> > a proprietary PCIE_MISC_PCIE_STATUS register and skips downstream
> > accesses if the link is down.
> >
> > However the bits in the proprietary register may purport that the link
> > is up even though link training is still in progress (as indicated by
> > the Link Training bit in the Link Status register).
> >
> > This has been observed with various PCIe switches attached to a BCM2711
> > (Raspberry Pi CM4):  The issue is most pronounced with the Pericom
> > PI7C9X2G404SV, but has also occasionally been witnessed with the Perico=
m
> > PI7C9X2G404SL and ASMedia ASM1184e.
> >
> > Check the Link Training bit in addition to the PCIE_MISC_PCIE_STATUS
> > register before performing downstream accesses.
> >
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: <stable@vger.kernel.org>
>
> Since you CC stable, it would be neat to provide a Fixes: tag here, most
> likely this dates back from the original commit adding support for this
> driver.
>
> > ---
> >   drivers/pci/controller/pcie-brcmstb.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index f593a422bd63..b4abfced8e9b 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -679,8 +679,10 @@ static bool brcm_pcie_link_up(struct brcm_pcie *pc=
ie)
> >       u32 val =3D readl(pcie->base + PCIE_MISC_PCIE_STATUS);
> >       u32 dla =3D FIELD_GET(PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK, =
val);
> >       u32 plu =3D FIELD_GET(PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK, =
val);
> > +     u16 lnksta =3D readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LN=
KSTA);
> > +     u16 lt =3D FIELD_GET(PCI_EXP_LNKSTA_LT, lnksta);
> >
> > -     return dla && plu;
> > +     return dla && plu && !lt;
>
> The patch looks good to me in spirit though I want Jim to review and

This looks good to me but please allow me a few days to do some
testing -- I'm currently in Covid prison.

Regards,
Jim Quinlan
Broadcom STB

> provide feedback here since he was looking at this sort of issues not so
> long ago.
>
> Thanks for tracking this down!
> --
> Florian

--000000000000c4aeb00602e770ba
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCD6cRvl9hmNBFEihEXyVeoLgsRNJxV
4MdNxJmtUeOhSDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA4
MTQxOTU1MTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAgA92DHLpC7N4LntnE/cNgXvrWjiUKwHU14Baoyp/ZzEJr566
3j+fpkg84Rf+KNe//agvWsJkVeTRzh4LZ8MrW6daU9HrplKrhIU1e0K3KeWcqF9eREDsgYAOpgBN
XCW/ghfBXZq6xozPk/y+Gb9V5HIAWhh+uy7bJdhRmZycsxKhmT6vTU7Djl208ZBVvXwAYYS7J5X4
XmpMuo2Oa182docV91hpH8yF/E8t0OQ/EyW+DCjGjAIIt+iVeU5sYH5I8xx7JsXf0DvSaJH+Q6Zx
xOgB4Nt78rGBLYcHb0D7B7Q/mJVaU3V12DeLQlVLeE3PSKUB8V0WQiGyk6/ZgMkoJA==
--000000000000c4aeb00602e770ba--
