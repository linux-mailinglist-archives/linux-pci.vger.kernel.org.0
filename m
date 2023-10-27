Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA97D9EAA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjJ0RO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjJ0ROq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 13:14:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE2F211E
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 10:04:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1136C43395;
        Fri, 27 Oct 2023 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698426209;
        bh=BfxsvhC4F9lgKCruOEQmZ10Exl7IYgbnsfHRmtm0NuY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OpxFafWsVZ+deFU2cO2DlSnGVClbLbR7ulDy4qEtI9CWagcnrxC7Zi6Zlqo4096C7
         gEPT7WMZtCw1+ejiIByjINtcant62lR6AXG4AWLUUpACJV52BJaePoJoSOIMpGyqDV
         viJ8zql35rjy+7shtvnRzrJvlI0eCratoPEaUmH5GlEC4tT0K3m69yqiHiiaQyfAqD
         mAjHySNjYep/Ps+vVRo2BKk+rSpnTRy3za88jj6//DqukIkuZAZx6r/XL89lno4mHg
         dofQmRlf4hj2nMO9lXx4KB3rV2fP/cuADWcYwyl8nAIQSJG0GULCiJmu3DaywlMwcu
         stFjaRBGsGGHg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507a29c7eefso3319932e87.1;
        Fri, 27 Oct 2023 10:03:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQ2JyWTxc0MKKvsYggW1YNka/4zHuw4yYYtj0k3ybdIHkgjC6/
        SjN4cvLjnEeHvckAB/YguG9wC0slkxA7vPj3gA==
X-Google-Smtp-Source: AGHT+IHJBBVNUhcAD3/MpN0+Oo67eI/jbR6jby2nErXAZsV4eVq8huXsTRKEm6EYfS7MX2n5YAd6TKWUQDnZ1WCgNX0=
X-Received: by 2002:a05:6512:2396:b0:503:343a:829f with SMTP id
 c22-20020a056512239600b00503343a829fmr3152037lfv.23.1698426207053; Fri, 27
 Oct 2023 10:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231027145422.40265-1-nks@flawful.org> <20231027145422.40265-2-nks@flawful.org>
 <CAL_JsqJh6aJb7_qsVnVNEABBg2utf0FPN+qYyOfsF2dAfZpd0w@mail.gmail.com> <ZTvh51PGCBhSjURY@x1-carbon>
In-Reply-To: <ZTvh51PGCBhSjURY@x1-carbon>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 27 Oct 2023 12:03:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKu9VxUrEbvyV0EFi-HhXstitu1sk0jQpbYqTDKY4N3=A@mail.gmail.com>
Message-ID: <CAL_JsqKu9VxUrEbvyV0EFi-HhXstitu1sk0jQpbYqTDKY4N3=A@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: dwc: rockchip: Add mandatory atu reg
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Niklas Cassel <nks@flawful.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 27, 2023 at 11:15=E2=80=AFAM Niklas Cassel <Niklas.Cassel@wdc.c=
om> wrote:
>
> Hello Rob,
>
> On Fri, Oct 27, 2023 at 10:58:28AM -0500, Rob Herring wrote:
> > On Fri, Oct 27, 2023 at 9:56=E2=80=AFAM Niklas Cassel <nks@flawful.org>=
 wrote:
> > >
> > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > >
> > > Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> > > using:
> > >
> > > allOf:
> > >   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > >
> > > and snps,dw-pcie.yaml does have the atu reg defined, in order to be
> > > able to use this reg, while still making sure 'make CHECK_DTBS=3Dy'
> > > pass, we need to add this reg to rockchip-dw-pcie.yaml.
> > >
> > > All compatible strings (rockchip,rk3568-pcie and rockchip,rk3588-pcie=
)
> > > should have this reg.
> > >
> > > The regs in the example are updated to actually match pcie3x2 on rk35=
68.
> >
> > Breaking compatibility on these platforms is okay because ...?
>
> I don't follow, could you please elaborate?

A DT which was valid without 'atu' region is now not valid with this
change. If I'm reading this schema with the change, then not having
'atu' is an error and the OS can treat it as an error. If it does,
then it wouldn't work with existing DTs. You cannot add new required
properties or required entries.

If you can say no users of the affected platforms care (e.g. only you
have a board) or the binding is not yet in use, then it's fine. But
you have to state that justification. I suspect that is not the case
here.

Rob
