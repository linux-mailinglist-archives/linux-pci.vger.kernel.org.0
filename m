Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346C167C5FE
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 09:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbjAZIic (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 03:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbjAZIiW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 03:38:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0015C99;
        Thu, 26 Jan 2023 00:37:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E740E61758;
        Thu, 26 Jan 2023 08:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574E1C433A0;
        Thu, 26 Jan 2023 08:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674722255;
        bh=PqLhUOQQTlWk8n9XzgqpHyL97UOcym9liKJ6unA/kpE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bov/TByAnDKz/9JqsLz5w4GFieNxpApIpgDrenN2/dPbC2ImysjO6x32J0xe8YmZ2
         gJnBKB+DoJhEfoR+rVMiZCxIQxju/oLrMi68y8aZ9EH1EcH/fZ9FPBGq7//1UMlRrQ
         U6eQhZM3biUJLs2dLjgnEY+YsOJQCmRWS1Eys/N8fksU+/lxUhR3Sv9c+xIV5cYeLh
         wZ0rLKpnE5RvGh5P8nz0VptCh/MlzceGdV/jyqSkg/accTUNvNqSf4IpNNPX0XIQGX
         H6UzMjrZtx0PThr416TRnjE37qKWSnZzKdio2UFS9UrjM1lekTLoVn9Wr5SYocpeo0
         hrGtk+nt4YlAQ==
Received: by mail-ed1-f44.google.com with SMTP id m12so1198037edq.5;
        Thu, 26 Jan 2023 00:37:35 -0800 (PST)
X-Gm-Message-State: AFqh2ko1htc9EIbn0apYKHIBgRlzBdiMhdzUll7PZgWwiyIpU3PPcjZa
        DiaBIVQfex0yZqOXdYGXtzH+EfFxPLDTAS2gbcI=
X-Google-Smtp-Source: AMrXdXuGOk5Zy6voeZPegRYAd9AU9YN+lSP2k9jOq9sruLQ5XsXRI9c1jhVS+U21M17G9uXcCSCVOE18KpeGM/XTu6c=
X-Received: by 2002:a05:6402:2946:b0:49e:45a8:4a4b with SMTP id
 ed6-20020a056402294600b0049e45a84a4bmr4893065edb.37.1674722253469; Thu, 26
 Jan 2023 00:37:33 -0800 (PST)
MIME-Version: 1.0
References: <1673847684-31893-1-git-send-email-hongxing.zhu@nxp.com>
 <1673847684-31893-5-git-send-email-hongxing.zhu@nxp.com> <20230126064728.GQ20713@T480>
In-Reply-To: <20230126064728.GQ20713@T480>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Thu, 26 Jan 2023 16:37:21 +0800
X-Gmail-Original-Message-ID: <CAJBJ56+7x9-zMRHQZjzQ9JG-VuR-bLrW9YzM0hX0sGkyQsPk0A@mail.gmail.com>
Message-ID: <CAJBJ56+7x9-zMRHQZjzQ9JG-VuR-bLrW9YzM0hX0sGkyQsPk0A@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] arm64: dts: Add i.MX8MM PCIe EP support
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, kishon@ti.com, kw@linux.com,
        frank.li@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 2:47 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Jan 16, 2023 at 01:41:14PM +0800, Richard Zhu wrote:
> > Add i.MX8MM PCIe EP support.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index 4ee89fdcf59b..8124761f629c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -1293,6 +1293,26 @@ pcie0: pcie@33800000 {
> >                       status = "disabled";
> >               };
> >
> > +             pcie0_ep: pcie_ep@33800000 {
>
> Hyphen is more preferable than underscore in name node.
>
> I fixed it (and the other two patches) up, and applied all DTS patches.

Dropped them, as I just noticed there is v6 of DTS patches being discussed.

Shawn
