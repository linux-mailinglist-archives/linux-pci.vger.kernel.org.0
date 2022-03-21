Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C34E2BBA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 16:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349952AbiCUPTT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349933AbiCUPTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 11:19:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C411174C;
        Mon, 21 Mar 2022 08:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7AB2B8175E;
        Mon, 21 Mar 2022 15:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CB8C340F4;
        Mon, 21 Mar 2022 15:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647875867;
        bh=9+FB8FqiPz2INA3LHeEMbXtjaqxdTmkp1xc/rbUvb8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iY2kM+kk/k9XRIJpOweLDdoV0Qbbb9Le27cicZiqsTWHGuaubJxgJKDF3p7i1Lepy
         FYDMrEVtCCOqmoUNxkbqmfdx5AiTxkKnBIkQk6jzKZs9e9c60k0BWEr+nsvrJHumw3
         SxACHAsrR+7s8jr6tN77OthE9W4ckwlNz898NvR0mYagooAamWfywmFEZMetc7qdD2
         dyjCNBNWdbMZxup0DHanVr8Zw/Mhb+fo52hkPUfVWdHUTUDF7OUxwJcZCwFHSzAqfB
         ssLoyytLEYPe+jy6osPEQVJl6nezkF8xixnZaUIbnwR7xPDdIxNHWawg4zNJnGq2Fs
         vNSK5qRXUR2SA==
Received: by mail-ed1-f42.google.com with SMTP id b24so18220954edu.10;
        Mon, 21 Mar 2022 08:17:47 -0700 (PDT)
X-Gm-Message-State: AOAM530whwR1lYN3L7Ddk6yN4+veqJmt4fcslavZRsLEU6AB8XjqYxrw
        MsuGad9tbPxR2w6ok5zNYX7SfSOLRxYKGtscLA==
X-Google-Smtp-Source: ABdhPJzVOekr/XRMAYz6o3vgNpt77YLnLfN20A1NcI85VtDGlaILC4gRTvIJUrbrtw7CiwFutMg/Nb4GAJ585vY9D/0=
X-Received: by 2002:a05:6402:1d51:b0:418:bd81:78b3 with SMTP id
 dz17-20020a0564021d5100b00418bd8178b3mr22893313edb.46.1647875865787; Mon, 21
 Mar 2022 08:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220321104843.949645-1-maz@kernel.org>
In-Reply-To: <20220321104843.949645-1-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Mar 2022 10:17:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
Message-ID: <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
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
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Since 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup") was
> merged in the 5.5 time frame, PCIe on the venerable XGene platform has
> been unusable: 6dce5aa59e0b broke both XGene-1 (Mustang and m400) and
> XGene-2 (Merlin), while the addition of c7a75d07827a ("PCI: xgene: Fix
> IB window setup") fixed XGene-2, but left the rest of the zoo
> unusable.
>
> It is understood that this systems come with "creative" DTs that don't
> match the expectations of modern kernels. However, there is little to
> be gained by forcing these changes on users -- the firmware is not
> upgradable, and the current owner of the IP will deny that these
> machines have ever existed.

The gain for fixing this properly is not having drivers do their own
dma-ranges parsing. We've seen what happens when drivers do their own
parsing of standard properties (e.g. interrupt-map). Currently, we
don't have any drivers doing their own parsing:

$ git grep of_pci_dma_range_parser_init
drivers/of/address.c:int of_pci_dma_range_parser_init(struct
of_pci_range_parser *parser,
drivers/of/address.c:EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
drivers/of/address.c:#define of_dma_range_parser_init
of_pci_dma_range_parser_init
drivers/of/unittest.c:  if (of_pci_dma_range_parser_init(&parser, np)) {
drivers/pci/of.c:       err = of_pci_dma_range_parser_init(&parser, dev_node);
include/linux/of_address.h:extern int
of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
include/linux/of_address.h:static inline int
of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,

And we can probably further refactor this to be private to drivers/pci/of.c.

For XGene-2 the issue is simply that the driver depends on the order
of dma-ranges entries.

For XGene-1, I'd still like to understand what the issue is. Reverting
the first fix and fixing 'dma-ranges' should have fixed it. I need a
dump of how the IB registers are initialized in both cases. I'm not
saying changing 'dma-ranges' in the firmware is going to be required
here. There's a couple of other ways we could fix that without a
firmware change, but first I need to understand why it broke.

Rob

P.S. We're carrying ACPI and DT support for these platforms. It seems
the few users are using DT, so can we drop the ACPI support? Or do I
need to break it first and wait a year? ;)
