Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141157CBE6
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 15:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiGUN3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 09:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGUN3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 09:29:48 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E14753A7
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 06:29:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r21so1204443qtn.11
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ui3he7DowmFEO/fEYSCWy+Md4Ohe389ZK5/NC3CDYLQ=;
        b=FTvS2RR6/8WdClMMdUmnXQUGbeUY+JFDEdOng6jp3cvtOBZZVVct/NtwltPoEUu+F4
         TYPY6ixrlMv49oKIeAaNIHvc3E00rWPS0HWe5785ld+YnTn+PvCVTStK7uOyBFG64A9y
         2d+gzkKJCYAC6MFO/D03oktdWg1oxYPdKaHGYyACwpbGH9Aki/hsi/2e/ZXAL4RodJNj
         Gmt3KedOnbrq6xznPX4yWAALCcGR4p8iSqGsbyODHfWoCbqvAAC5GvvqGnS2QnCD02gr
         nO36by/loAixhGuzkJClqIoS4jrOG9Ao/oEK8/nRfo9b0njIQ729O6GdB+4d0xPtXlWH
         3zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ui3he7DowmFEO/fEYSCWy+Md4Ohe389ZK5/NC3CDYLQ=;
        b=lWDpcLQZGnXurWbFqmt+Luaw++WfnyoyCVpXrWGxHhFk5dcRiNImhTI+YBewcQac/a
         HZ8qB13H0KDHLmo2EZhrPbaivsUY2g5syyarStJOmFGbPPdwZsocibeHz5Eth17f968r
         XqlHr8+g9FGey1MYu+Pun+Z5rl5VZojHm5b1oZg+UF+rLjsH8kPprRdOSmO9SPuFVv2Z
         IqWZj1O3xbYPZ1i/d7A0lXqsy8q7kxJ+vxTTkk0lCZUeak8dpQhSunlMBzsTVYpzLLVc
         2M+xe55jAj8meq2lJ9EcstIVIQ5izPHa90bUzdWJhIOUdxN4e8W/GRrIa7tpS7NbLDWD
         CEvg==
X-Gm-Message-State: AJIora8Lvh4WgHCt/nz9Q8ogGsKzyvx8I52ejn1Z30tmHGkTz/7Vm9x6
        RnDvXODQzWzMb0XzMxbrqiEoSzYV7ne76jbq94bYpw==
X-Google-Smtp-Source: AGRyM1u/hEA8MVKfS1pR/OdjyEyyfJwLsRAo0+lFcqnHYQCN+Lp0OhlYemZauGLN9EdZWde7muKf0n4NNhP7DIyolkI=
X-Received: by 2002:ac8:5dca:0:b0:31e:85b8:8a18 with SMTP id
 e10-20020ac85dca000000b0031e85b88a18mr33195980qtx.370.1658410186088; Thu, 21
 Jul 2022 06:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220719200626.976084-1-dmitry.baryshkov@linaro.org> <20220721101530.GE39125@thinkpad>
In-Reply-To: <20220721101530.GE39125@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 21 Jul 2022 16:29:33 +0300
Message-ID: <CAA8EJpqgBBoyn1ba72NuupoPPEcs_txUunkD83M4bvT68ivXRA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] PCI: qcom: support using the same PHY for both RC
 and EP
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 21 Jul 2022 at 13:15, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Jul 19, 2022 at 11:06:22PM +0300, Dmitry Baryshkov wrote:
> > Programming of QMP PCIe PHYs slightly differs between RC and EP modes.
> >
> > Currently both qcom and qcom-ep PCIe controllers setup the PHY in the
> > default mode, making it impossible to select at runtime whether the PHY
> > should be running in RC or in EP modes. Usually this is not an issue,
> > since for most devices only the RC mode is used, while for some (SDX55)
> > the EP mode is used without support for working as the RC.
> >
>
> SDX55 could work in RC mode also. Support is on the way.
>
> > Some of the Qualcomm platforms would still benefit from being able to
> > switch between RC and EP depending on the driver being used. While it i=
s
> > possible to use different compat strings for the PHY depending on the
> > mode, it seems like an incorrect approach, since the PHY doesn't differ
> > between usecases. It's the PCIe controller, who should decide how to
> > configure the PHY.
> >
> > This patch series implements the ability to select between RC and EP
> > modes, by allowing the PCIe QMP PHY driver to switch between
> > programming tables.
> >
>
> This is really nice! On the case of SDX55, there is a single PHY and PCIe
> controller that is being used as both RC and EP depending on the usecase.=
 While
> it makes sense to use a different PCIe node based on usecase, it does not=
 for
> the PHY. So the runtime switch is a neat way of handling the differences.
>
> I've provided my review for the patches. But for the next iteration, you =
could
> remove the RFC tag.

Thanks for the review!

> Also, please mention the dependency of the series in the cover letter if =
any.
> Like this one depends on your previous PHY cleanup series. It will help
> maintainers while picking the patches.

Ack. However the PHY series are already part of phy/next, thus I
omitted mentioning them.

>
> Thanks a lot for the series!
>
> Regards,
> Mani
>
> > Dmitry Baryshkov (4):
> >   phy: qcom-qmp-pcie: split register tables into primary and secondary
> >     part
> >   phy: qcom-qmp-pcie: suppor separate tables for EP mode
> >   PCI: qcom: call phy_set_mode_ext()
> >   PCI: qcom-ep: call phy_set_mode_ext()
> >
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c |   4 +
> >  drivers/pci/controller/dwc/pcie-qcom.c    |   4 +
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c  | 155 ++++++++++++----------
> >  3 files changed, 96 insertions(+), 67 deletions(-)
> >
> > --
> > 2.35.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--=20
With best wishes
Dmitry
