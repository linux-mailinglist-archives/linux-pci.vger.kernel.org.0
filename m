Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7855035ED
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 12:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiDPKUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 06:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiDPKT6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 06:19:58 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5476E3FBF6;
        Sat, 16 Apr 2022 03:17:27 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ebf3746f87so102281097b3.6;
        Sat, 16 Apr 2022 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/KYTg2xXUE+fmRA5+xn6FS4kLYWK/is5FVU0I4kM/A=;
        b=bGU/lKJg3HCTQZExsK0yX2bIx9pb/xH8aWrp98pP/p8Zfdy7X87HD+bJ86VC3cXNZ8
         vMsHXh9VqligxGoQFzoqdLF41CUgIlfjqj9ak4ZRFAeel6DN6bnWxrE5Cb/CZsTSqS9i
         Jk8ANhtAL31fGHfVGq5rLGb1EDXXqH3dNN8MyBJwmqnA0KFCTJT3e6VRA14GbitN8Bsl
         zCPvaKgON+nNTaGxsSsKy2jL2nkVtvqGZSP13RVvyc8W1eQwFPI690RO1Z0Dq3H1BYHZ
         cZgeYXJ0hAVE11arMJ4cMKJQc+BoX0KMu8F2FznmlQi+avRbBIKiM0As7xAfXo/ge3Bv
         +zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/KYTg2xXUE+fmRA5+xn6FS4kLYWK/is5FVU0I4kM/A=;
        b=7ez3Fv048W5+0yRvIuKx7mKGxlMLYnrhz3lLQ2awMeQgwjDkZyBa8Lte835FbRjWhz
         0jUw6NrbgvdiZlzJd+60R51hC2RHv3OdCaBkJ0y1YK+C0OlS5vyWX/c32C9TCJvreYDa
         qMhbhj8enB7bJ7GwQesMvnhDKPNHYv+fN7VWVtoXTsE3Gc8u8mU7JXA22+W52xW4K46Y
         cQW4aSVX1fWUNLtP3vJ4cJ4GawAjjs+AU95TYGvvQWqBClqr7MKXMD5UAz/MKljh2q3G
         gyP1zOzTHMbuHZ9j0H4Ep8O5HugauuiveHgEwtp/mlrQ+MZ6Rtnw3oglo+IY/eDcPyFU
         3Rbg==
X-Gm-Message-State: AOAM5307cVI7IlqJfJKaH3FzFArVRUtE5v6igpJ44QgdIrGJ0Xf4PZJP
        Yx4d8Vqh8V7QRB6T+TiSD84NMNIbqgLZCk6yOKZfCrhrHSHigQ==
X-Google-Smtp-Source: ABdhPJzi44FbtdtM04RnhLw45kwZZjiC6lpc6Os76YWzOVKbZyrSGj9uXweJAz5oQSgBMp+XgzF6Xu78RCu8hdSup3w=
X-Received: by 2002:a81:52c8:0:b0:2ec:8fa:ebfd with SMTP id
 g191-20020a8152c8000000b002ec08faebfdmr2421292ywb.502.1650104246578; Sat, 16
 Apr 2022 03:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220416100502.627289-1-pgwipeout@gmail.com> <20220416100502.627289-4-pgwipeout@gmail.com>
 <eadc4422-15bb-0b46-8235-db6e160e8d32@collabora.com>
In-Reply-To: <eadc4422-15bb-0b46-8235-db6e160e8d32@collabora.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 16 Apr 2022 06:17:15 -0400
Message-ID: <CAMdYzYq=nQhwY_4+Y=PM9do_Dcrg1pD-jeD=q36D48ks=WDVgw@mail.gmail.com>
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

On Sat, Apr 16, 2022 at 6:08 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hi Peter,
>
> On 4/16/22 13:05, Peter Geis wrote:
> > +     pcie2x1: pcie@fe260000 {
> > +             compatible = "rockchip,rk3568-pcie";
> > +             #address-cells = <3>;
> > +             #size-cells = <2>;
> > +             bus-range = <0x0 0xf>;
> > +             assigned-clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
> > +                      <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
> > +                      <&cru CLK_PCIE20_AUX_NDFT>;
>
> Why these assigned-clocks are needed? I don't see anything assigned in
> this patchset.

Ah, those are remnants of early bringup when performance wasn't good
and I was manually setting clock rates.
