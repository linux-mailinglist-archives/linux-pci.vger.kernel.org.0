Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9F6D9E45
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjDFRP3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 13:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDFRP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 13:15:28 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045BA1BF1;
        Thu,  6 Apr 2023 10:15:24 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id p91so11163213uap.1;
        Thu, 06 Apr 2023 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680801323; x=1683393323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RsjMymseXVw0+RE+qQyjRcpOBPhR+2ni5FaZRWtc+0=;
        b=cNkCGlJCVBHmmQesYsGzJHBWxhdD8qRJSr4vVDqB20kYWTtPsIRBRx7JFv+Vzo8wTY
         l+Z9Yu15OsccQgMTDttqevtRWG2c+cgiCR+stZDmE6VkUvcRXnhy5jiH6ySyWGwqCaD/
         K88TkpVaCFxl8YsUfdF5Pi81lwSGrLXdrIQ5LUH7waicfCqkBhCs9PabCg6KYe6aDsfW
         AJHB9VtX1IEt5JXRvhTL5RZaDGlUPGoaIQtMxOsbY08CftWk4m/60ZMqNDkBoaqZIwjT
         5NO8ZM0NY5x0D35sNf58JtDY8ZE0tryglT79/vG6aiGmhx5rKoHm92QfuLMAvpahYOuS
         uRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680801323; x=1683393323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RsjMymseXVw0+RE+qQyjRcpOBPhR+2ni5FaZRWtc+0=;
        b=UuJlrK4Itw1P+qrKmtBREec55z1qsQinS3cmUmkP90iBmFeLiO0N+QRSfIoPNVCDyP
         AqUrk+49YVyf3pb7PQ6YaM0LooMTo+hWjjElCNh5a1lXyv3kZV/7TzWiQXYmCuL4drGm
         7JWAwDWesHk3LCTdZAJ0zq32T8yRKxlKoeaUxgEb5YUqBZjMgSYL3KgBSOV5oMGHdJPL
         GPaZr4a+i23C/l0nFWLPYMN2+E6i1ddggM10oYEi2LxxZ7S79rU/hGoEOj+7MnB8D5cQ
         0ErBCe9nK28N9l+Xv3dWEUCSGOlin2k/I0T8dUw23ZV5FGVh/qrX4ezmK2FtHVwcRaSK
         wmWw==
X-Gm-Message-State: AAQBX9eCPUqynMgjVMs6dFVf7FOFq47woCyblWVPkztnKuSnFjVvuiXb
        QxIWhSToLC1Ay8cceAMK45ar/FhtMosJSO9EkIc=
X-Google-Smtp-Source: AKy350aoBODMZu1xNKVxIfJvujvOrnExAbV/fh0ofuhRW9fPYeopxr9i4+NPn+YJ5LRAtnKEYTN5xM1TZFBLg0PBYyA=
X-Received: by 2002:ab0:474f:0:b0:688:c23f:c22f with SMTP id
 i15-20020ab0474f000000b00688c23fc22fmr8410376uac.1.1680801322625; Thu, 06 Apr
 2023 10:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230406124625.41325-1-jim2101024@gmail.com> <20230406124625.41325-4-jim2101024@gmail.com>
 <09926d3d-2f1f-d060-af0f-bbc5b02d3664@i2se.com>
In-Reply-To: <09926d3d-2f1f-d060-af0f-bbc5b02d3664@i2se.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 6 Apr 2023 13:15:10 -0400
Message-ID: <CANCKTBspbkTXVBXTS+woymM+6kEgd+F5XH7ycPhaAgASEi7rhQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PCI: brcmstb: Allow setting the completion timeout
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 6, 2023 at 11:59=E2=80=AFAM Stefan Wahren <stefan.wahren@i2se.c=
om> wrote:
>
> Hi Jim,
>
> Am 06.04.23 um 14:46 schrieb Jim Quinlan:
> > Since the STB PCIe HW will cause a CPU abort on a completion timeout ab=
ort,
> > we might as well extend the timeout limit.  Further, different devices =
and
> > systems may requires a larger or smaller amount for L1SS exit.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >   drivers/pci/controller/pcie-brcmstb.c | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 129eee7bdbc1..92d78f4dfaae 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -1080,6 +1080,29 @@ static void brcm_config_clkreq(struct brcm_pcie =
*pcie)
> >       writel(clkreq_set, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> >   }
> >
> > +static void brcm_config_completion_timeout(struct brcm_pcie *pcie)
> > +{
> > +     /* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
> > +     const unsigned int REG_OFFSET =3D PCIE_RGR1_SW_INIT_1(pcie) - 8;
> > +     u32 timeout, timeout_msec =3D 1000;
> > +     u64 tmp64;
> > +     int ret;
> > +
> > +     ret =3D of_property_read_u32(pcie->np, "brcm,completion-abort-mse=
cs",
> > +                                &timeout_msec);
> > +
> > +     if (ret && ret !=3D -EINVAL)
> > +             dev_err(pcie->dev, "bad 'brcm,completion-abort-msecs' pro=
p\n");
>
> i'm not sure about the error behavior. If we want to proceed with
> defaults in such a case, i would make this a warning and mention the
> used defaults.
Will do.

>
> > +
> > +     /* Each unit in timeout register is 1/216,000,000 seconds */
> > +     tmp64 =3D (u64)216000 * timeout_msec;
> > +
> > +     /* Clamp the requested value before writing it */
> > +     timeout =3D tmp64 > 0xffffffff ? 0xffffffff : tmp64;
> > +     timeout =3D timeout < 0xffff ? 0xffff : timeout;
>
> Personally i'm not a huge fan of silently clamping wrong DT values.
I will add a warning with limit info  on clamp and have the YAML min+max.

Thanks
Jim Quinlan
Broadcom STB
>
> Best regards
>
> > +     writel(timeout, pcie->base + REG_OFFSET);
> > +}
> > +
> >   static int brcm_pcie_start_link(struct brcm_pcie *pcie)
> >   {
> >       struct device *dev =3D pcie->dev;
> > @@ -1110,6 +1133,7 @@ static int brcm_pcie_start_link(struct brcm_pcie =
*pcie)
> >               return -ENODEV;
> >       }
> >
> > +     brcm_config_completion_timeout(pcie);
> >       brcm_config_clkreq(pcie);
> >
> >       if (pcie->gen)
