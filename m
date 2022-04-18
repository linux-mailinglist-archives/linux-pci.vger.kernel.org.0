Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50E504F86
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 13:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiDRLsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiDRLrw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 07:47:52 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04326ED;
        Mon, 18 Apr 2022 04:45:13 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v77so25039995ybi.12;
        Mon, 18 Apr 2022 04:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QYWuVtVlC10CN/U+uRjoO+2nquc2+/bWq8BF83jGkg=;
        b=jfQaZilDsjqziuXCg9rlesjzPfFiG3oIMyOIqq5lw8qAztwHtpWY4jtAArkSDne/hj
         WHMReGX6BfrGLoQnV8WR5NKGH+wYTMucY49FMaoybLsVogUeG5UHNJB90L26is73oQ2a
         HLEfKNtE1MPtZ0s2VfikMrbz7fcrUP/pZ7JNAwnlEcFoK33Mj/9Y7e/2CjMrd7ZeuZgy
         pgf6YvEg8sa9VGkmZsUP1Tx72gvCoriVLtdKucG2AtMK1WjpswZgBVERLVq1qETCw6xu
         aA9NlwqWySqcw07791GL/QEQWtHumXnMAHyu7bIBiQyNxqop33xJp5PvM1nnNFmAy6jK
         RIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QYWuVtVlC10CN/U+uRjoO+2nquc2+/bWq8BF83jGkg=;
        b=k+KBrApq9ITCj/owHBTmsgdSupHP5JlZRz1A9odfwC/R6o/C/XmZGP1/dITPylZUAA
         yYbT1hN40IGlJTF6BsKeG00LisnYpz9v5n+YZMHdQvVdnalmp15qV3plKFYERlL2bA13
         NV1h1kukaOYcaNB0q8ZCzuBmS9OuSbnHHbkZzsz55Ij4lUAcHov50abIVvn0kjP+Me/t
         mqG8SuV9tHxCCmUTO5JTa8qbIJbgrvzzHjPtIWiGtNMUW8nZ3ZN+E85T1Ai5F+9jnL+s
         BvcJfHBvBE8x29Q9hZlMGmSV9vdy66M1tKFRbgoR4+YU5QXB/7ZJ+Ttm+AJouBOR+BfV
         BoYw==
X-Gm-Message-State: AOAM530IgADmSwhb78/mF2/TkMppWpLt93Sm70BM30i+lUdLw4QvXxKT
        dJMEbyyR1byZu56yuo5Hhlt1L2PGJR6znwyJbXBHXjL+5pQ=
X-Google-Smtp-Source: ABdhPJw+jWAcmcfFZ237nXEhtG2xq0d8v20HKmocJKhYOlQFPTgC1WBVREyz/ckqjsxTm4JfzpWxDClmhqtXY0reNTw=
X-Received: by 2002:a05:6902:1249:b0:644:d8bb:e741 with SMTP id
 t9-20020a056902124900b00644d8bbe741mr7161250ybu.585.1650282313075; Mon, 18
 Apr 2022 04:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220416100502.627289-1-pgwipeout@gmail.com> <20220416100502.627289-4-pgwipeout@gmail.com>
 <eadc4422-15bb-0b46-8235-db6e160e8d32@collabora.com> <CAMdYzYq=nQhwY_4+Y=PM9do_Dcrg1pD-jeD=q36D48ks=WDVgw@mail.gmail.com>
 <a8bb3ef6-8f37-709f-adfe-3608e5c1e11f@collabora.com>
In-Reply-To: <a8bb3ef6-8f37-709f-adfe-3608e5c1e11f@collabora.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 18 Apr 2022 07:45:02 -0400
Message-ID: <CAMdYzYrwGyxRnB8YU9vvgqXsKhi9fZ1a7UJhixCbC5mGm9aP8Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] arm64: dts: rockchip: add rk3568 pcie2x1 controller
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 17, 2022 at 6:23 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 4/16/22 13:17, Peter Geis wrote:
> > On Sat, Apr 16, 2022 at 6:08 AM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> Hi Peter,
> >>
> >> On 4/16/22 13:05, Peter Geis wrote:
> >>> +     pcie2x1: pcie@fe260000 {
> >>> +             compatible = "rockchip,rk3568-pcie";
> >>> +             #address-cells = <3>;
> >>> +             #size-cells = <2>;
> >>> +             bus-range = <0x0 0xf>;
> >>> +             assigned-clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
> >>> +                      <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
> >>> +                      <&cru CLK_PCIE20_AUX_NDFT>;
> >>
> >> Why these assigned-clocks are needed? I don't see anything assigned in
> >> this patchset.
> >
> > Ah, those are remnants of early bringup when performance wasn't good
> > and I was manually setting clock rates.
>
> If it's not needed, should it be removed then? Otherwise it looks like
> something is missing in the DT in regards to the assigned clocks.

Yes, it has been removed from the V7.
Thanks!
