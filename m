Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9AB621F5F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 23:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKHWcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 17:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKHWcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 17:32:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A691A15A3E;
        Tue,  8 Nov 2022 14:32:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42ED9617CF;
        Tue,  8 Nov 2022 22:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFF5C4314A;
        Tue,  8 Nov 2022 22:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667946753;
        bh=C7cfJNnFHnwN+Dt+RBevE2dF73eXyltwRwAzsZdY/0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hRwIVGcA/z119YdQcE4otRl/Y3HMv6/1zWWvYRwOs5guBXJh2SMBsNXs8iZetc9X9
         N1E5aUqiyNMt0LCstBvFWq0c1cqPuVxP8rNqHQPim1z1Lr9ftMOyyJ/hPGjEBPOq5V
         6RUPb6sOrlpMywK3vZVnfccdhDfYFMWohA+4AxkPOQkCHZeN7BkjlkEmxH0OGRJioA
         U9jATc70EYJ4rGP929dE0UF/3Eea6XaixISj0SSXymTPzj4AHMvs9wcmAUSsljYwrW
         RaWT/YKWWoIfkCSvkqI6LXC6c0GoSt22XH751dM2n6M+px2f7Kp9B+919EOUUa2FKC
         w/9wPsgvl30SQ==
Received: by mail-lj1-f171.google.com with SMTP id c25so23198562ljr.8;
        Tue, 08 Nov 2022 14:32:33 -0800 (PST)
X-Gm-Message-State: ACrzQf0FvKD3vjgLg2MKNZ2PI6hbKW5DFX21Dy96KiNKLddDXX1T+Zyr
        A2+pYgiAJuWF2XUe1kqghUXZ1bqE6O3VsRkwEg==
X-Google-Smtp-Source: AMsMyM79MD2K3KPMVXymYEssotlGplfJ1g3Tr8XMyNdqkAYV8JnBI2uYKzWBlsni9BR1wivgUkvUZa8W2XAfVOuMFMc=
X-Received: by 2002:a2e:9a85:0:b0:275:1343:df71 with SMTP id
 p5-20020a2e9a85000000b002751343df71mr7582015lji.215.1667946751374; Tue, 08
 Nov 2022 14:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-10-Sergey.Semin@baikalelectronics.ru>
 <TYBPR01MB5341E18D15BF78FFD6FA9782D83F9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20221108135218.v3jsla67372wt7ny@mobilestation>
In-Reply-To: <20221108135218.v3jsla67372wt7ny@mobilestation>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Nov 2022 16:32:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLC04=JA6b0ezsm06-SUsEQix=hZLwTgVDuswa_+41qgg@mail.gmail.com>
Message-ID: <CAL_JsqLC04=JA6b0ezsm06-SUsEQix=hZLwTgVDuswa_+41qgg@mail.gmail.com>
Subject: Re: [PATCH v6 09/20] dt-bindings: PCI: dwc: Add interrupts/interrupt-names
 common properties
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 8, 2022 at 7:52 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hi Yoshihiro
>
> On Tue, Nov 08, 2022 at 12:40:54PM +0000, Yoshihiro Shimoda wrote:
> > Hi Serge,
> >
> > > From: Serge Semin, Sent: Tuesday, November 8, 2022 5:49 AM
> > >
> > > Currently the 'interrupts' and 'interrupt-names' properties are defined
> > > being too generic to really describe any actual IRQ interface. Moreover
> > > the DW PCIe End-point devices are left with no IRQ signals. All of that
> > > can be fixed by adding the IRQ-related properties to the common DW PCIe
> > > DT-schemas in accordance with the hardware reference manual. The DW PCIe
> > > common DT-schema will contain the generic properties definitions with just
> > > a number of entries per property, while the DW PCIe RP/EP-specific schemas
> > > will have the particular number of items and the generic resource names
> > > listed.
> > >
> > > Note since there are DW PCI-based vendor-specific DT-bindings with the
> > > custom names assigned to the same IRQ resources we have no much choice but
> > > to add them to the generic DT-schemas in order to have the schemas being
> > > applicable for such devices. These names are marked as vendor-specific and
> > > should be avoided being used in new bindings in favor of the generic
> > > names.
> > >
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > >
> > > ---
> > >
> > > Note without the next dtschema tool fix
> > >
> > > --- a/lib.py 2022-09-29 15:17:13.100033810 +0300
> > > +++ b/lib.py     2022-09-29 15:19:54.886172794 +0300
> >
>
> > JFYI.
> >
> > git am command could not work correctly by this lib.py file:
> > ---
> > Applying: dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
> > error: lib.py: does not exist in index
> > Patch failed at 0001 dt-bindings: PCI: dwc: Add interrupts/interrupt-names common properties
> > ---
> >
> > If I used patch command and skipped the lib.py, it could apply this patch correctly.
>
> Got it. Thanks for the note. I'll either drop this part on the next
> patchset revision (hopefully Rob will do something about that by then)
> or make it less looking like a patch so git am wouldn't be confused.

Now fixed in main branch. Thanks for the report.

Rob
