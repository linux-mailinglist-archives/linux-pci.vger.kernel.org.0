Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FC667D03D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 16:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjAZPb1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 10:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjAZPb0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 10:31:26 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD04237;
        Thu, 26 Jan 2023 07:31:25 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso928837oti.10;
        Thu, 26 Jan 2023 07:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BOOLjJP/DVblUUBITFT/Clnx2J0qjci9FP4191B8GGA=;
        b=kfF4oJ+7bDkiArH9VCNhiOZA3zJMx5SUjUkq6wS1uNb4NBxvFpate7JTlgBQlrmhxo
         h+D5YRvrEAVDq1X9fq8VekKEmJsG/GADiCKx5F0VmzQcWD5rrC2f2PGrDIVTNG0goeUH
         0RfZmLKKqVgRCgXER1Af5Crae/ibLMNO0PQPSqlMBKKGsr7PZ1SKkzPan1e03NVAumV3
         RNdOtSkToPSxofnR9sTgpc5N4miEasySuU85O5vaFgEZokGyrppqYD0N6nvD5JJeH8Gp
         /rlktDvejDB7LyzqLKOVPyTbnEsTsH/cNLqHceRSmKE+eT4g7n44mEEjVathpvQEZRXq
         Xo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOOLjJP/DVblUUBITFT/Clnx2J0qjci9FP4191B8GGA=;
        b=s3ocqHND2ovSijO+otkj1ufaNdmlJlk0O7bUuP5nhEtJFw0dtkAQBMJz1gdGFqOnn2
         8MHoDfTXdhDg56hm1U6HqTD/ZIGMuHJz2bW3GjHufZlq2W/rpwYfof8afRjZactugy0F
         Lv1vh5GcgFJ2JqOZyTvCiqLyM0pSeR32jnlySK6nhHWk2ibI37Jje1GjxDSjTOXhKJup
         NyjS9gLGtvODX4W6zHnPaW5cTOpJknpD2IYSmXxFk4/RQ+0q/E91gsX8pbihcUlr7gy6
         UNWNXa6cvh7OVFr3BNpRgbNZiPSZJeM+AMs36/VYiW18Uu3pATHD0dtouA1hT7FL1H2M
         OL7A==
X-Gm-Message-State: AFqh2kraajoD+D66I88pTKFo5ebMmlJoqQqrLlYpa5hXoRPDHRwqCzs1
        VlNXA0zgGeEIkKIra+a8PScJDrJcDjTw7Py9upU=
X-Google-Smtp-Source: AMrXdXs24UA4hWdUcc+JZpfPajaLzyE82/X+DFx/CAWvYBhnwLQJBTNQV5FDORmaHJTNtDsDeQV6v71Z2a3QyyCTvS8=
X-Received: by 2002:a9d:6654:0:b0:670:97d8:b140 with SMTP id
 q20-20020a9d6654000000b0067097d8b140mr2059389otm.164.1674747084920; Thu, 26
 Jan 2023 07:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
 <20230126135049.708524-6-rick.wertenbroek@gmail.com> <6a54a51b-cf1a-c601-275f-00f825fcec5d@linaro.org>
In-Reply-To: <6a54a51b-cf1a-c601-275f-00f825fcec5d@linaro.org>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Thu, 26 Jan 2023 16:30:48 +0100
Message-ID: <CAAEEuhpOjSUhiQFxKwkhiwDNtmRzzUXmGYKMuHWePJF-Q7R9dQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] PCI: rockchip: Added dtsi entry for PCIe endpoint controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        wenrui.li@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 4:23 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/01/2023 14:50, Rick Wertenbroek wrote:
> > Added missing PCIe endpoint controller entry in the device tree. This
> > entry is documented in :
> > Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
>
> There is no such file

Sorry but the file exists see :
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt?h=v6.0.19
It also exists in 6.1 :
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt?h=linux-6.1.y

>
> > The status is disabled by default, so it will not be loaded unless
> > explicitly chosen to.
>
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
>

Sorry about this, you are right, I'll fix it for the next iteration.
Thank you

> >
> > Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 25 ++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > index 9d5b0e8c9..5f7251118 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > @@ -265,6 +265,31 @@ pcie0_intc: interrupt-controller {
> >               };
> >       };
> >
> > +     pcie0_ep: pcie-ep@f8000000 {
> > +             compatible = "rockchip,rk3399-pcie-ep";
>
> reg is usually second property...
> > +             #address-cells = <3>;
> > +             #size-cells = <2>;
> Best regards,
> Krzysztof
>
