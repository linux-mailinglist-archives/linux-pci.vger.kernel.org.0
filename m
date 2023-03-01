Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5EA6A6B2D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Mar 2023 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCAK6N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 05:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCAK6L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 05:58:11 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFEB14E85;
        Wed,  1 Mar 2023 02:58:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso712324pju.0;
        Wed, 01 Mar 2023 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677668287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgbtT5VMo9Vg7rJLdgD/z46AIvGTupdTznrZ5pjSr1Y=;
        b=N/pTfrGBr4o5Yp3FyiP5YRAf92/V//p4ALFOsEF2CBdwzXHbuO64/bjlsvgXSr8WNR
         PvHSZBjqf+vYRjnCk/Jy5g3wIzoTzSdsDm3RC0lFjUbOAJhRDA9Y+npeyCyV7/LdYL8r
         Y4J5ipob8rKVW5ftmL81iTCSiChyRPQ94avam0hhL8MoaQvQKYMKVjJqItNEyVW1lLv6
         VmAZBQh1zoJ/a8eTMxKcs+gJwtMqJ81kkYkHcaqe6kikkokNURXLav/Gx97Zhjk520kF
         OhtaqYkFSfoUCWdkR/OSdqGweRKCwMJMrt8O5jStggAOrLO7Yefk2/hHkLNJjgmvTNiM
         mxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677668287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgbtT5VMo9Vg7rJLdgD/z46AIvGTupdTznrZ5pjSr1Y=;
        b=wh68unDQJfWTCFm3/V3xtB1POvPRRBneCM/JlUCeujcyYehaK8nH2WCB/IsfpJvU5Y
         blmhgYz1hImy9DYHZuMMG83cn1OhVlSja5QOw7EoLp+qbBgpbdW2ZD3mheXvRiETy/22
         lIb/us1zBwy8X1DCgmVsgiuqrxSlS27jZUgmiTNeMrkFTyP0ccZYY4pqtxZrmNPkxeIE
         2OvfTZxY8w2odc2RX5MCoesGQouqaidq2PpMNZTSJn2Lp/Orht2Z6TOBK+koTns6YDCZ
         dkirU6WLS5YPS4GGNN1DFx4YU4h7+ROdk3acN4xWqn+hFT22/Td2Q5KicBg7J+4982Tw
         t8og==
X-Gm-Message-State: AO0yUKVx0GC+R1t/62JtNcNbXlPri4TpCL7OK3ZfYb5KOfi7Yna/mKud
        EOpCEpGXd+JeYwKFdpzhLLto40J6ypjTDpxqGZk=
X-Google-Smtp-Source: AK7set+0V4d9xQ7YZHs/VfWrDGTBSguweM3j4JjnjLbFsnJ9h6gqnYrkCKS6U/QvImgf274dK9/tMg0gQ2lpUo+vPhI=
X-Received: by 2002:a17:90a:4e8a:b0:234:e49:ba9f with SMTP id
 o10-20020a17090a4e8a00b002340e49ba9fmr2316700pjh.4.1677668287312; Wed, 01 Mar
 2023 02:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20230113164449.906002-1-robimarko@gmail.com> <20230113164449.906002-8-robimarko@gmail.com>
 <7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com> <CAOX2RU5Y642gWMSaK6fJ2tz=9N2AO-1fFhL5=wfLeTWWkVjz7Q@mail.gmail.com>
 <968c056c-74f9-4a8f-b662-51f60df93694@app.fastmail.com> <20230228132043.GC4839@thinkpad>
In-Reply-To: <20230228132043.GC4839@thinkpad>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 1 Mar 2023 11:57:56 +0100
Message-ID: <CAOX2RU61KotntoxEC+J9vDE1JEfhwDR2B21Z+GDu4nHC+y749g@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe node
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, bhelgaas@google.com,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        krzysztof.kozlowski+dt@linaro.org, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 28 Feb 2023 at 14:20, Manivannan Sadhasivam <mani@kernel.org> wrote=
:
>
> On Thu, Feb 02, 2023 at 10:42:15AM +0100, Arnd Bergmann wrote:
> > On Thu, Feb 2, 2023, at 10:16, Robert Marko wrote:
> > > On Mon, 30 Jan 2023 at 18:11, Arnd Bergmann <arnd@arndb.de> wrote:
> > >> On Fri, Jan 13, 2023, at 17:44, Robert Marko wrote:
> > >
> > > As pointed out in the commit description, the ranges property was cop=
ied
> > > from the QCA-s downstream 5.4 kernel [1] as I dont have any documenta=
tion
> > > on the SoC.
> > >
> > > I have runtime tested this on Xiaomi AX3600 which has a QCA9889 card =
on the
> > > Gen3 PCIe port, and on Xiaomi AX9000 which has QCA9889 on Gen2 port
> > > and QCN9074 on the Gen3 port and they are working fine.
> >
> > Neither of those use I/O ports though, nor does any other sensible
> > device that was made in the past decade.
> >
> > The compatible string tells me that this is a designware pcie block,
> > so I think driver actually sets up the mapping based on the ranges
> > property in DT in dw_pcie_iatu_detect() and dw_pcie_iatu_setup(),
> > rather than the mapping being determined by hardware or firmware
> > in advance.
> >
> > Not sure about the general policy we have for this case, maybe the
> > pci controller or pci-dwc maintainers have an idea here. I would
> > think it's better to either have no I/O ranges in DT or have
> > sensible ones than ones that are clearly bogus, if the controller
> > is able to set up the ranges.
> >
>
> Just happen to see this thread and I agree that the I/O port range is ind=
eeed
> bogus. This is due to the fact that no one tested I/O range with a compat=
ible
> device.
>
> I'm not sure about the PCI policy though but we should fix the mapping ac=
ross
> all SoCs. I will send out a series for that.

Thanks for sorting this out.

Regards,
Robert
>
> Thanks for spotting, Arnd!
>
> - Mani
>
> >      Arnd
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
