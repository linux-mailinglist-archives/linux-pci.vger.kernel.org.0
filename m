Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE75EBF11
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiI0Jzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiI0Jzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:55:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6662C476E7
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:55:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rk17so6331611ejb.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skymem-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=XV9ssZrIcTJoriDQ00sgubDE7NtKif9nXDWu0n7DRrI=;
        b=mfTNXjhFSt2KsEjj4t4EvJwLc94NLVsIn8woiJsAQaX00UE4vdpKpxUau7w4cnfXg7
         lsTcBIZXxfa9cLOrl+wb+KyMyHwiWbnUTYlDoqrRe5i0XL1oRC7T+naQgMpQnUMfQELm
         GDgSVwrYZ+ROMIDdTGCoPPeL98DgoR4+KXI2e+ZwKZqAzqXZeQa76MNUjHv7YOOJYKOu
         hqubZoOs77HPEhqjc9AvXuUpw04DvjWsAob9V6s2xK4VcZJZu624sywIWawC70Rm8hPU
         f14DNOkuHzCM0r/KA5kkvK8VDH27j2bWEp7UP+yKIGrt+NLc3VyN6ypVVtNgyeIhP2K6
         HWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XV9ssZrIcTJoriDQ00sgubDE7NtKif9nXDWu0n7DRrI=;
        b=fYtDRMuhaDvo0jG2z2bkTJU4bn1bP6aX8RHQmcyNlLqY8k8UkZmurLJ8MsJ6YIxCNC
         gV3A9Gbbvy6dcGeh8N9PMQ3N+f6BWebmofVHqL4Z+LW4F36SAlT4IX//LtPvuvlt58ED
         CsjAgso7pLq3HMJgRgvmfca1Oa0X0UTDZ3iWpjLrn4Hvg6jYdXC51I7yuqU1Lx4cm5Mr
         5BCv/XNvmv1EgLUixEKxj8Yd2GJ7S9DxlgI0zimbPYkqTkfVYB1OU9WLazvGxBkErK3I
         SvYllwoflmqgBjFJaoclLgiYeXKC29znLfryzuCLFZFeBjJcvKGM0aIkAPtRnKkwnmxG
         2BvA==
X-Gm-Message-State: ACrzQf05HpQeNeBrWnyBV/8Bwx/2/3Vg7Bue7EypeedFuSBNtMawvywo
        tVRU2Hxlpg/S6e8IMe68BoxqVFP5d/7xggMyRRYv7Q==
X-Google-Smtp-Source: AMsMyM5z+srhMT4r/bP/skybDZPUbd0EfdpYPferZo6iV7zpEnHH6l/jpAkapGrHty5uPha40CNK1ucIbnJTCgm+le4=
X-Received: by 2002:a17:907:2cd8:b0:776:64a8:1adf with SMTP id
 hg24-20020a1709072cd800b0077664a81adfmr22036659ejc.151.1664272547883; Tue, 27
 Sep 2022 02:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <1664269036-16142-1-git-send-email-hongxing.zhu@nxp.com>
 <1664269036-16142-14-git-send-email-hongxing.zhu@nxp.com> <CAKvd=_hQUXCu4kv1tB=FpvP_-iE_7d2B232wwroMa9UtcBqmPQ@mail.gmail.com>
In-Reply-To: <CAKvd=_hQUXCu4kv1tB=FpvP_-iE_7d2B232wwroMa9UtcBqmPQ@mail.gmail.com>
From:   Info Skymem <info@skymem.com>
Date:   Tue, 27 Sep 2022 11:55:36 +0200
Message-ID: <CAKvd=_g+qvufQpX=ak2i-FqSsC9xqrNK_cPJYRV8xHKXD6LK3w@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] PCI: imx6: Add i.MX8MM PCIe EP support
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
thank you for your information.

On our website you can find email addresses of companies and people.
https://www.skymem.info

In short, it=E2=80=99s like Google for emails.

Best regards,
Robert,
Skymem team


On Tue, Sep 27, 2022 at 11:54 AM Info Skymem <info@skymem.com> wrote:
>
> Hi,
> thank you for your information.
>
> On our website you can find email addresses of companies and people.
> https://www.skymem.info
>
> In short, it=E2=80=99s like Google for emails.
>
> Best regards,
> Robert,
> Skymem team
>
> On Tue, Sep 27, 2022 at 11:31 AM Richard Zhu <hongxing.zhu@nxp.com> wrote=
:
>>
>> Add i.MX8MM PCIe EP support.
>>
>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>> ---
>>  drivers/pci/controller/dwc/pci-imx6.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/control=
ler/dwc/pci-imx6.c
>> index 777ad946ec7f..907a36e18842 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -53,6 +53,7 @@ enum imx6_pcie_variants {
>>         IMX8MM,
>>         IMX8MP,
>>         IMX8MQ_EP,
>> +       IMX8MM_EP,
>>  };
>>
>>  #define IMX6_PCIE_FLAG_IMX6_PHY                        BIT(0)
>> @@ -156,6 +157,7 @@ static unsigned int imx6_pcie_grp_offset(const struc=
t imx6_pcie *imx6_pcie)
>>         WARN_ON(imx6_pcie->drvdata->variant !=3D IMX8MQ &&
>>                 imx6_pcie->drvdata->variant !=3D IMX8MQ_EP &&
>>                 imx6_pcie->drvdata->variant !=3D IMX8MM &&
>> +               imx6_pcie->drvdata->variant !=3D IMX8MM_EP &&
>>                 imx6_pcie->drvdata->variant !=3D IMX8MP);
>>         return imx6_pcie->controller_id =3D=3D 1 ? IOMUXC_GPR16 : IOMUXC=
_GPR14;
>>  }
>> @@ -319,6 +321,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx=
6_pcie)
>>  {
>>         switch (imx6_pcie->drvdata->variant) {
>>         case IMX8MM:
>> +       case IMX8MM_EP:
>>         case IMX8MP:
>>                 /*
>>                  * The PHY initialization had been done in the PHY
>> @@ -577,6 +580,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie=
 *imx6_pcie)
>>         case IMX7D:
>>                 break;
>>         case IMX8MM:
>> +       case IMX8MM_EP:
>>         case IMX8MQ:
>>         case IMX8MQ_EP:
>>         case IMX8MP:
>> @@ -623,6 +627,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pc=
ie *imx6_pcie)
>>                                    IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
>>                 break;
>>         case IMX8MM:
>> +       case IMX8MM_EP:
>>         case IMX8MQ:
>>         case IMX8MQ_EP:
>>         case IMX8MP:
>> @@ -694,6 +699,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_=
pcie *imx6_pcie)
>>                 reset_control_assert(imx6_pcie->pciephy_reset);
>>                 fallthrough;
>>         case IMX8MM:
>> +       case IMX8MM_EP:
>>         case IMX8MP:
>>                 reset_control_assert(imx6_pcie->apps_reset);
>>                 break;
>> @@ -771,6 +777,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6=
_pcie *imx6_pcie)
>>                 break;
>>         case IMX6Q:             /* Nothing to do */
>>         case IMX8MM:
>> +       case IMX8MM_EP:
>>         case IMX8MP:
>>                 break;
>>         }
>> @@ -822,6 +829,7 @@ static void imx6_pcie_ltssm_enable(struct device *de=
v)
>>         case IMX8MQ:
>>         case IMX8MQ_EP:
>>         case IMX8MM:
>> +       case IMX8MM_EP:
>>         case IMX8MP:
>>                 reset_control_deassert(imx6_pcie->apps_reset);
>>                 break;
>> @@ -843,6 +851,7 @@ static void imx6_pcie_ltssm_disable(struct device *d=
ev)
>>         case IMX8MQ:
>>         case IMX8MQ_EP:
>>         case IMX8MM:
>> +       case IMX8MM_EP:
>>         case IMX8MP:
>>                 reset_control_assert(imx6_pcie->apps_reset);
>>                 break;
>> @@ -1094,6 +1103,7 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6=
_pcie,
>>
>>         switch (imx6_pcie->drvdata->variant) {
>>         case IMX8MQ_EP:
>> +       case IMX8MM_EP:
>>                 pcie_dbi2_offset =3D SZ_1M;
>>                 break;
>>         default:
>> @@ -1306,6 +1316,7 @@ static int imx6_pcie_probe(struct platform_device =
*pdev)
>>                 }
>>                 break;
>>         case IMX8MM:
>> +       case IMX8MM_EP:
>>         case IMX8MP:
>>                 imx6_pcie->pcie_aux =3D devm_clk_get(dev, "pcie_aux");
>>                 if (IS_ERR(imx6_pcie->pcie_aux))
>> @@ -1471,6 +1482,11 @@ static const struct imx6_pcie_drvdata drvdata[] =
=3D {
>>                 .mode =3D DW_PCIE_EP_TYPE,
>>                 .gpr =3D "fsl,imx8mq-iomuxc-gpr",
>>         },
>> +       [IMX8MM_EP] =3D {
>> +               .variant =3D IMX8MM_EP,
>> +               .mode =3D DW_PCIE_EP_TYPE,
>> +               .gpr =3D "fsl,imx8mm-iomuxc-gpr",
>> +       },
>>  };
>>
>>  static const struct of_device_id imx6_pcie_of_match[] =3D {
>> @@ -1482,6 +1498,7 @@ static const struct of_device_id imx6_pcie_of_matc=
h[] =3D {
>>         { .compatible =3D "fsl,imx8mm-pcie", .data =3D &drvdata[IMX8MM],=
 },
>>         { .compatible =3D "fsl,imx8mp-pcie", .data =3D &drvdata[IMX8MP],=
 },
>>         { .compatible =3D "fsl,imx8mq-pcie-ep", .data =3D &drvdata[IMX8M=
Q_EP], },
>> +       { .compatible =3D "fsl,imx8mm-pcie-ep", .data =3D &drvdata[IMX8M=
M_EP], },
>>         {},
>>  };
>>
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
