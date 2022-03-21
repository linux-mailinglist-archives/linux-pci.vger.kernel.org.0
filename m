Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E674E2F90
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 19:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348934AbiCUSFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 14:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbiCUSFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 14:05:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C015D2AE0D;
        Mon, 21 Mar 2022 11:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72529B818E3;
        Mon, 21 Mar 2022 18:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0394CC340F3;
        Mon, 21 Mar 2022 18:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647885821;
        bh=Cuz7+EZkEiHixqSIWD3I8sz1h+3g1vmvAAAG0nQtAkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WluDve9vmsL5a7vdcnX/pt/oWrTU1M6k+I9oqYNQeXdqet9zhkCHcMhcAzX7h67gM
         IjagZrMQO2zOQr02FqN7iKLBQasc3CAjn/NhQ2je5NnqecqNWkuoZGLohDVrRSkXfm
         VmChv8ew+B5ukMu9jNkTKmuvKoYtSiNtwHCMnBwR2L/gwHTCj/1xx7z/HgxArTwGnV
         QyINaGte1kZXoaJoPt9ljohcGZN27zdw9dhvynlg351yWQIwWmctMqOLOR/yfbCMMK
         b3Xvv58o0Wgt8M0qSj9wA0rhawQxSxK/8HCV+pn2uHsWdEQokmEvWdA2jWBR6BWss3
         rLkO08/MBIaCA==
Received: by mail-ej1-f53.google.com with SMTP id bg10so31466717ejb.4;
        Mon, 21 Mar 2022 11:03:40 -0700 (PDT)
X-Gm-Message-State: AOAM532XDDU5MWfBfAitNS2M49ci7VDXqDRW8QsS8RP7pURExP7NkeHz
        dogU5XqVPUus0c2IuICNy6kVewoDWn8F34vhiA==
X-Google-Smtp-Source: ABdhPJy6XgutRDx7Hw3xrWC3qWO+2ypsH6iZE6Pc0l8uRarmqBZvJt4+vGgD6mVCut3kJjIbWlAyS6Xj1GM7VC+iXwc=
X-Received: by 2002:a17:907:2d8d:b0:6df:a06c:7c55 with SMTP id
 gt13-20020a1709072d8d00b006dfa06c7c55mr19404428ejc.325.1647885819160; Mon, 21
 Mar 2022 11:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220321104843.949645-1-maz@kernel.org> <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
 <87h77rxnyl.wl-maz@kernel.org>
In-Reply-To: <87h77rxnyl.wl-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Mar 2022 13:03:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
Message-ID: <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: xgene: Restore working PCIe functionnality
To:     Marc Zyngier <maz@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        dann frazier <dann.frazier@canonical.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 21, 2022 at 11:36 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 21 Mar 2022 15:17:34 +0000,
> Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Since 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup") wa=
s
> > > merged in the 5.5 time frame, PCIe on the venerable XGene platform ha=
s
> > > been unusable: 6dce5aa59e0b broke both XGene-1 (Mustang and m400) and
> > > XGene-2 (Merlin), while the addition of c7a75d07827a ("PCI: xgene: Fi=
x
> > > IB window setup") fixed XGene-2, but left the rest of the zoo
> > > unusable.
> > >
> > > It is understood that this systems come with "creative" DTs that don'=
t
> > > match the expectations of modern kernels. However, there is little to
> > > be gained by forcing these changes on users -- the firmware is not
> > > upgradable, and the current owner of the IP will deny that these
> > > machines have ever existed.
> >
> > The gain for fixing this properly is not having drivers do their own
> > dma-ranges parsing. We've seen what happens when drivers do their own
> > parsing of standard properties (e.g. interrupt-map).
>
> We have, and we added the required exceptions for the legacy platforms
> that the code base supported until then. We didn't leave things broken
> just because we didn't like the way things were done a long time ago.
>
> > Currently, we don't have any drivers doing their own parsing:
> >
> > $ git grep of_pci_dma_range_parser_init
> > drivers/of/address.c:int of_pci_dma_range_parser_init(struct
> > of_pci_range_parser *parser,
> > drivers/of/address.c:EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
> > drivers/of/address.c:#define of_dma_range_parser_init
> > of_pci_dma_range_parser_init
> > drivers/of/unittest.c:  if (of_pci_dma_range_parser_init(&parser, np)) =
{
> > drivers/pci/of.c:       err =3D of_pci_dma_range_parser_init(&parser, d=
ev_node);
> > include/linux/of_address.h:extern int
> > of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> > include/linux/of_address.h:static inline int
> > of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> >
> > And we can probably further refactor this to be private to drivers/pci/=
of.c.
> >
> > For XGene-2 the issue is simply that the driver depends on the order
> > of dma-ranges entries.
> >
> > For XGene-1, I'd still like to understand what the issue is. Reverting
> > the first fix and fixing 'dma-ranges' should have fixed it. I need a
> > dump of how the IB registers are initialized in both cases. I'm not
> > saying changing 'dma-ranges' in the firmware is going to be required
> > here. There's a couple of other ways we could fix that without a
> > firmware change, but first I need to understand why it broke.
>
> Reverting 6dce5aa59e0b was enough for me, without changing anything
> else.

Meaning c7a75d07827a didn't matter for you. I'm not sure that it would.

Can you tell me what 'dma-ranges' contains on your system?

> m400 probably uses an even older firmware (AFAIR, it was stuck
> with an ancient version of u-boot that HP never updated, while Mustang
> had a few updates). In any case, that DT cannot be changed.

How is Dann changing it then? I assume he's not changing the firmware,
but overriding it. That could be a possible solution.

Do the DT's in the kernel tree correspond to anything anyone is using?
I ask because at some point someone will need to address all the
warnings they have or we should drop the dts files if they aren't
close to reality. The same thing applies to Seattle BTW.

> > Rob
> >
> > P.S. We're carrying ACPI and DT support for these platforms. It seems
> > the few users are using DT, so can we drop the ACPI support? Or do I
> > need to break it first and wait a year? ;)
>
> I'm not sure people on the list are representative of all the users,
> and I didn't realise the plan was "let's break everything we don't
> like and see if someone wakes up" either. That definitely puts things
> in a different perspective.

I wasn't really suggesting breaking things on purpose. However, there
is a cost to keeping code and it would be nice to know what's being
used or not. The cost isn't *that* big, but it is not zero for what's
not many users.

At least for St=C3=A9phane, using ACPI didn't even work. I'm assuming there
is some version of h/w and f/w out there that did work with the ACPI
support in the kernel? That may have never been seen by anyone but APM
and Jon Masters (his Tested-by is on the patch from APM adding ACPI
support). It's not hard to imagine there was a version of firmware
just to shut Jon up.

Rob
