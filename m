Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0240657A195
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiGSOcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbiGSObw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 10:31:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0F1664DA;
        Tue, 19 Jul 2022 07:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCC296179A;
        Tue, 19 Jul 2022 14:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37A7C341CF;
        Tue, 19 Jul 2022 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658240461;
        bh=vCkPQvxXooMW9Jt2ErhKtlqIYXoDpb743ceTSV240Mk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MWdPVbOMRgCQSnh4EnPjuMxedb0MTVypnArvwhukRZ48C+mZqbuQ3OXLOqOyWbiTN
         fUtf1W1BCAL1tAmphXbBElvB7QqXH7Upitiq4FUdIadHgHEjrYcVWJSho0+lucZ2Z8
         YMCLdDXp8g7UzP6IQGnqRwcPFDvcVBunsF2bEt7OZsUANQrBO/Tvl4ynd9s6ZF5Nhw
         EXhMdczORCpax1WiUYZPaZB+hs5tx7xPGZ9OGdFyXIE+tJrH0X5kq4EFEEiK8h/x2p
         K8Ab+mrF5f66Du7c89HE+GXDj/Xz2J2ctcMuPZOhpUxoLlb+R0YyQu+I/xDz4eUcZI
         OMzreFaugD1qw==
Received: by mail-vs1-f46.google.com with SMTP id t127so13514541vsb.8;
        Tue, 19 Jul 2022 07:21:00 -0700 (PDT)
X-Gm-Message-State: AJIora8P6iCcY2t3QlKLhAni53aX52SUazXo88qn+wkx7M52fnutsjX9
        At4Wxvm4OUF8j1/ElJgaqiVqChaV1YHIMamGYw==
X-Google-Smtp-Source: AGRyM1ucY0eDl9SH7mktv57iGcrF+8x0sgPXu3I6aBLdZATjdulxEFv2/bX6DDQMBv8GWpBiy+fAQXoiZuO908Pmp8A=
X-Received: by 2002:a67:d194:0:b0:357:8ea:5554 with SMTP id
 w20-20020a67d194000000b0035708ea5554mr11899285vsi.0.1658240459942; Tue, 19
 Jul 2022 07:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <1658223939-25478-1-git-send-email-hongxing.zhu@nxp.com>
 <1658223939-25478-2-git-send-email-hongxing.zhu@nxp.com> <1658239860.449467.1153347.nullmailer@robh.at.kernel.org>
In-Reply-To: <1658239860.449467.1153347.nullmailer@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 19 Jul 2022 08:20:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+H+ffmmpowHqjknfJ1XavUGpW-rgiUGpCQ=+r0=MVUig@mail.gmail.com>
Message-ID: <CAL_Jsq+H+ffmmpowHqjknfJ1XavUGpW-rgiUGpCQ=+r0=MVUig@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] dt-bindings: imx6q-pcie: Add iMX8MM PCIe EP mode
 compatible string
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Frank Li <frank.li@nxp.com>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 8:11 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 19 Jul 2022 17:45:30 +0800, Richard Zhu wrote:
> > Add i.MX8MM PCIe endpoint mode compatible string.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.

These are obviously not caused by this change, but it's a long list of
warnings and many look like the schema needs to be changed. For
example, this one is obviously a schema problem:

> pcie@33800000: clock-names:3: 'pcie_inbound_axi for imx6sx-pcie, pcie_aux for imx8mq-pcie' was expected

Rob
