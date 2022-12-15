Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E641F64D496
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 01:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLOAWs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Dec 2022 19:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOAWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2022 19:22:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3EA33D;
        Wed, 14 Dec 2022 16:22:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C2850CE1BA1;
        Thu, 15 Dec 2022 00:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6100C433EF;
        Thu, 15 Dec 2022 00:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671063759;
        bh=bfB8V50v6OcR7ZKFZ6fJTBBezlJ1YwPl/3pfyrMdzjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e+nHh8DS7jyVJaTjxiIW3DYJySB04gadKq0YxmAHlZKAeIwj37SzydSBa+ijOEqb7
         fMzBss16lbHgJ4ZuGPv+vD4gHLUHeoEMi71khI0fcCXi0s8xXsAP7P/B9xKDG0iTqN
         Oe+IdC8D4yCnezrIq1i55ttO5LD5E0zb2TSLNcGF0no2/1VYBH9AuLi86LhcuOASbo
         3ZxQLdcMbI6V/CD3KgrJlFWyd3j+5x8FywhSpN1Ost8MsdD05lKvuwXbtbGiULN1Pb
         sFvB+/njA9BbYffVuRIEoYGpjPqnWN9lSgFxI6Xi12BZjSSH0oTTgyz1XwgjeGt2bc
         QvIEVJT/oHWqQ==
Received: by mail-vk1-f182.google.com with SMTP id o136so4005282vka.2;
        Wed, 14 Dec 2022 16:22:39 -0800 (PST)
X-Gm-Message-State: ANoB5pnC0Cxvi7AsAbQGKq6HCo4jCuYpM2tbGERgR1snNSh5qBF+9m3N
        YeBGXyvUiRhWIsDN92PpUcitwVNdndHe5w/LPw==
X-Google-Smtp-Source: AA0mqf6etgVsXqu0YC4dE4uscO5REGQ0oBZ9xZMPswn/iiFA51bJm1Nia0JZZqQjZPLEB3WFBuvouxs8CsL2NW1PZj8=
X-Received: by 2002:a1f:2c01:0:b0:3c1:1c3b:c4d9 with SMTP id
 s1-20020a1f2c01000000b003c11c3bc4d9mr876106vks.19.1671063758777; Wed, 14 Dec
 2022 16:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20221213233050.GA218218@bhelgaas> <CAHk-=whC3-Q_-gt3NU8cfY4ivs2CsaON8Ci0aiD6qvT1xzVL=g@mail.gmail.com>
In-Reply-To: <CAHk-=whC3-Q_-gt3NU8cfY4ivs2CsaON8Ci0aiD6qvT1xzVL=g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Dec 2022 18:22:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Y1CN4BMhB-FXFunr1rFs62QEMi_zj3zmvjXrksCQ0sA@mail.gmail.com>
Message-ID: <CAL_Jsq+Y1CN4BMhB-FXFunr1rFs62QEMi_zj3zmvjXrksCQ0sA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 14, 2022 at 12:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Dec 13, 2022 at 3:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > You will see a merge conflict in
> > Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml between these:
> >
> >   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")
> >   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common properties")
> >
> > 5c3741492d2e is already in your tree via arm-soc, and 4cc13eedb892 is in
> > this pull request.  The resolution I suggest is to use 4cc13eedb892, which
> > means we'll lose the addition of "ecam" from 5c3741492d2e.
>
> Heh. I only read this part once I had already resolved that thing differently.
>
> I dunno, I used my own - possibly bad - judgment to add a case for
> that 'ecam' thing under the vendor-specific list.
>
> That was very much a "monkey see, monkey do" resolution, so some DT
> person should check it out and possibly make fun of me and my dubious
> ancestry. Rob? Thierry?

Good job writing valid json-schema! :) It's close enough and better
than just dropping which caused warnings. It is Tegra only ATM, but
anyone else that sets up an ECAM region should use the same name.

Rob
