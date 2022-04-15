Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B4502FA3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 22:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351636AbiDOURj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351201AbiDOUR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 16:17:26 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C931F3A727;
        Fri, 15 Apr 2022 13:14:56 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ebf4b91212so92360807b3.8;
        Fri, 15 Apr 2022 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QfGuix9eHPmBVHieE98IkajLKskzJOMJS9YG04aHQEc=;
        b=iGv/flgytSZZleWCwY3NfgAeABaSuaArYoDgbbyezprnLZw33y0kzKJpeR9Gx9v9j8
         yFRmIdUedGm0HRsRtV32in/5wzKY3OEwLQz0XdDCGaSuyHnCwh72egU+U4iwYcbW9th9
         ZKICA5oZfdknC+kjfvqFyYCN3GWi4iRmsOk63DjRkDu+7T/iy/EytvEQwti6DLvBD5EM
         qrgBDVWoJ/xAybNrqyt7gzEuEQiprAYuNDk0mr8bIFllnk7Bs/wkqO/jKC/DCEGuEmnx
         evxd5S5zqC0gxcUIul8XvHC2vxr4NXxCVHg+Ns2XXdM+3Mz5FuN2MbmRBzdVzZtJIrjw
         /TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfGuix9eHPmBVHieE98IkajLKskzJOMJS9YG04aHQEc=;
        b=GIRTo4EgQX8BgbcW5mrGfGh2vuOLmINIeAfDavAdO7Wgfoqq0WsC68S3ghqSNq//Nh
         W47MeCBBtiLh828MxYVzOceyq4lOtX4m3I75OLegdx0cc0/T5eQqdN8XemxEoD/8cmBC
         9BRMkGinYVB/17z1kf2H7sIMKEfcmoBHb8JPg39BCQLUJ2Cw6zR/C33FM0ohrejj6pFx
         SwRl4mubmCWm9Kli/3MYypTvSQj/mDy8XZKXSUcaxvNlQVk0u42b/rEkQXzBKoGfJi1W
         ZvpKtUONyAZjOrhp8KX90ksWJSVwYCejX7Xp1KsXQewUhowEd5P3/uDBdQzLIzZIQ32T
         L4LQ==
X-Gm-Message-State: AOAM530M6ebdzPDSzsdJhhu8OWtORJOdRUPVbl2Mg1DZCt7lRFA5DnZ2
        fZnwe65ETFCxpsnBKS1wAfOrs1ohbOnj/TahYRE=
X-Google-Smtp-Source: ABdhPJzcXxbnRTmhCv9tZrtZ2aIi9BPp22b40umIvHYfXdY0pL99IaBj4TVrT7UkE5UtWBG4pMeIorfwsGjNVX/TrWw=
X-Received: by 2002:a81:3a8f:0:b0:2e8:7e2c:95a5 with SMTP id
 h137-20020a813a8f000000b002e87e2c95a5mr589827ywa.241.1650053695984; Fri, 15
 Apr 2022 13:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220413133731.242870-1-pgwipeout@gmail.com> <20220413133731.242870-2-pgwipeout@gmail.com>
 <Ylhfr51RME+YAjOG@robh.at.kernel.org>
In-Reply-To: <Ylhfr51RME+YAjOG@robh.at.kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 15 Apr 2022 16:14:43 -0400
Message-ID: <CAMdYzYpwKE3cCPZfDehnN0Lv1k7DstUh2y4PoEv6=6e6ejAtSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pci: remove fallback from Rockchip
 DesignWare binding
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
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

On Thu, Apr 14, 2022 at 1:53 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Apr 13, 2022 at 09:37:28AM -0400, Peter Geis wrote:
> > The snps,dw-pcie binds to a standalone driver.
> > It is not fully compatible with the Rockchip implementation and causes a
> > hang if it binds to the device.
> >
> > Remove this binding as a valid fallback.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > index 142bbe577763..8dc11fed8a3c 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > @@ -32,7 +32,6 @@ properties:
> >    compatible:
> >      items:
> >        - const: rockchip,rk3568-pcie
> > -      - const: snps,dw-pcie
>
> With this, you no longer need 'select' so please drop it too.

Thanks! Will do.

>
> >
> >    reg:
> >      items:
> > @@ -110,7 +109,7 @@ examples:
> >          #size-cells = <2>;
> >
> >          pcie3x2: pcie@fe280000 {
> > -            compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
> > +            compatible = "rockchip,rk3568-pcie";
> >              reg = <0x3 0xc0800000 0x0 0x390000>,
> >                    <0x0 0xfe280000 0x0 0x10000>,
> >                    <0x3 0x80000000 0x0 0x100000>;
> > --
> > 2.25.1
> >
> >
