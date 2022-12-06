Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33B644DD2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 22:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLFVPW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 16:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLFVPQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 16:15:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9345A05;
        Tue,  6 Dec 2022 13:15:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC9E61903;
        Tue,  6 Dec 2022 21:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE07C433D7;
        Tue,  6 Dec 2022 21:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670361311;
        bh=QsrwkULmCSGGL3KXp7LQHjj62qmPxZ7cMQGjNXHrytU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gVaZuDyChfMqolC3EMzITcIahCmdOBYBYPsE+ouM8MK4tCUYFjpf9W9QSB1BVZnzQ
         GslUmtDAufGU+Te3jRDKayDNrCYoKnGWsRtQra9dLdCC7gtPp+jUHd1hHOxpmchi9Y
         tp6BA8AcuzffPr+TJmJASoYgcmaaUzJm4wldcZaLN3ILU+35lKPpjZcr0ko2k2cFyA
         EIT3OpZcWkysj2q9Vvac5+LGd4m4U4ICXl9aKqk1GS9NU8t597k9LskbfQ2caEjzlJ
         9HKEa2GjE6748ekYIBuH5YTQfDAf6V0SKdARlrJlzmqR7T1Xb62vOGXgY9/xgzLXoo
         oPVCXVlQ5ON/g==
Received: by mail-vs1-f42.google.com with SMTP id c184so15464788vsc.3;
        Tue, 06 Dec 2022 13:15:11 -0800 (PST)
X-Gm-Message-State: ANoB5pk+efxzJl7ngY/kjoV0kDwC8XQ9cQw2gMMfdMOyAFIodS5VauRV
        QQ2i+FfUcTVhixZZWMvpeMkfbX9NKbVuE7R0Ng==
X-Google-Smtp-Source: AA0mqf7o4y8r4F6Icn2YZm1TOiWT+1+sXM/NS1oROlDRjJLLjahgyIBX9VHa2gcsSR+5hapr3z1zvf63AHIsOw4RHuY=
X-Received: by 2002:a67:c40e:0:b0:3b1:4b76:5b44 with SMTP id
 c14-20020a67c40e000000b003b14b765b44mr4681883vsk.53.1670361310470; Tue, 06
 Dec 2022 13:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20221114155333.234496-1-jonathanh@nvidia.com> <20221114155333.234496-2-jonathanh@nvidia.com>
 <Y3ap1o2SbNvFw8Vd@orome> <CAL_JsqKpyn=mWXv4tuS4U8AahNPkL6hpNQCfyRdf9bDY1EqSJg@mail.gmail.com>
 <Y49xg7wptRweHd4I@orome>
In-Reply-To: <Y49xg7wptRweHd4I@orome>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Dec 2022 15:14:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+BxHB8__aN=84R4xpoJtf4_7xHeTkbgPakdNqzywJWw@mail.gmail.com>
Message-ID: <CAL_JsqK+BxHB8__aN=84R4xpoJtf4_7xHeTkbgPakdNqzywJWw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 6, 2022 at 10:44 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Dec 05, 2022 at 05:41:55PM -0600, Rob Herring wrote:
> > On Thu, Nov 17, 2022 at 3:38 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
> > > > From: Vidya Sagar <vidyas@nvidia.com>
> > > >
> > > > Add support for ECAM aperture that is only supported for Tegra234
> > > > devices.
> > > >
> > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> > > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > > ---
> > > > Changes since V2:
> > > > - Avoid duplication of reg items and reg-names
> > > > Changes since V1:
> > > > - Restricted the ECAM aperture to only Tegra234 devices that support it.
> > > >
> > > >  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++--
> > > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
> > > >  2 files changed, 33 insertions(+), 3 deletions(-)
> > >
> > > Both patches applied now.
> >
> > linux-next now fails with this. I suspect it is due to Sergey's
> > changes to the DWC schema.
> >
> > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb:
> > pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> > fixed:
> >         'dbi' was expected
> >         'dbi2' was expected
> >         'ecam' is not one of ['elbi', 'app']
> >         'atu' was expected
> >         'dma' was expected
> >         'phy' was expected
> >         'config' was expected
> >         /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.example.dtb:
> > pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> > fixed:
> >                 'ecam' is not one of ['apb', 'mgmt', 'link', 'ulreg', 'appl']
> >                 'ecam' is not one of ['atu_dma']
> >                 'ecam' is not one of ['smu', 'mpu']
> >         From schema:
> > /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>
> Stephen reported the other day that he wasn't able to resolve this
> conflict in linux-next, so he dropped the ECAM bits. The ECAM patch has
> now propagated to ARM SoC so it can't be easily backed out, but I guess
> we could revert on that tree and instead apply the patch to the DT tree
> and resolve the conflict there.
>
> I guess the better alternative would be to try and resolve the merge
> properly and let Stephen (and Linus) know.

Instead, can you prepare a patch on top of Sergey's adding a 'oneOf'
entry with 'ecam'. As this is a new thing, it should have its own
entry. Then when merging, we just throw out the change from your side.

I'd really prefer that bindings don't go thru the soc tree unless
there's some strong reason. The default is to go via the subsystem
trees. Beyond 'we are running the dtschema checks on all our dts files
and can't have the warnings', I don't know what that would be. I wish
everyone was doing that, but I'm pretty sure most are not.

Rob
