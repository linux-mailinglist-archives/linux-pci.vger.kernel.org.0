Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13EC4E2CD5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 16:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiCUPv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 11:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbiCUPv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 11:51:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B4C9F397
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 08:50:30 -0700 (PDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 76F003F499
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647877829;
        bh=amAeexB40qeQuUsgEFDBLhcLC0MO2/MpF5kxBkxTRmI=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=XFCpwt7tCAZlBPG+AZ0usNVyFZJujaZlgsN7eV/aNU8ZUxl7LZ1WkxywUhhI57HQ8
         TiJEqyDUcWs6elIvE4kOGILr+cUQWbnsac7l25h68IFqmrsoLhVZ2mzddidZDPY4TB
         K3L0s3ecxyqwNRyndX3nLYmcwnd/dWesFJu04wwpkcB44lX7ktW5oJPi0J67OZqY3O
         S3bgM1n66VRoRMxZR5EyvHb3WSD9fEgk0xiVFb50rfoZiH828qnHUZ5pf81jVb2obk
         gs7oMkbiqv/xscO1paYA2lM2ZVUklBgUbPLkFyn5HkeIX9PPA8QnDEgzYV0V/eqP1R
         FrOdrlXXj6OEg==
Received: by mail-il1-f199.google.com with SMTP id m16-20020a928710000000b002c7be7653d1so7679956ild.4
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 08:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amAeexB40qeQuUsgEFDBLhcLC0MO2/MpF5kxBkxTRmI=;
        b=Dw7l863YM7srFXWgAlm8ICewqPxE4iSMNwJc2ikg4y12z+JAqfJQROhpe2zrX9OjGg
         taEH+mQu76JnyhHb42JaEmIebscWWiZqn5FRtlNEsoUiPTXq5A9JXDVjF7973saHTyrI
         ELp3FsbM7HhfDyla8N2hoi9d4Teh+9PyGqmFWkyscV10MlJSvmCYKoZ+jKwcPM1WIcQU
         krlwsU3//fFWEqtJXEpKUxIJ4+iNEt+kPpKOS9NUBLV2ak+5uSrd7z9q/6a2coJTEeUf
         a84CIKiR5lWzutFVWkFpsYjOOArQinT9Wfvu1QdkNapIYf7DkZsIKod36zbvS+0huJRQ
         RI9Q==
X-Gm-Message-State: AOAM532hMlil4B49DkPxKLpmDl67/z9PnwIrn7ZaDD8q9lbiR4OsMkc6
        TkuJQFwi6saWCmqol5E78JBKSFFahvXh9yC7q205I0x0QockFr0BdQULF0yVH3hWlUAq6eOz7Ke
        pngFpXtk2C8INxYk2nOFR58w/+xpOLf/5YbJ3Kg==
X-Received: by 2002:a92:ca4a:0:b0:2c8:301e:3624 with SMTP id q10-20020a92ca4a000000b002c8301e3624mr1747925ilo.301.1647877828245;
        Mon, 21 Mar 2022 08:50:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5zI7dbe8PgtCdpDk52EDFpaKY1vg7MjzSrWomIEbD/IHHzCyZhQG2tfBo94Rl9x/jY457wA==
X-Received: by 2002:a92:ca4a:0:b0:2c8:301e:3624 with SMTP id q10-20020a92ca4a000000b002c8301e3624mr1747912ilo.301.1647877828016;
        Mon, 21 Mar 2022 08:50:28 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
        by smtp.gmail.com with ESMTPSA id q197-20020a6b8ece000000b00648d615e80csm8501663iod.41.2022.03.21.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:50:27 -0700 (PDT)
Date:   Mon, 21 Mar 2022 09:50:24 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 0/2] PCI: xgene: Restore working PCIe functionnality
Message-ID: <YjiewB5Nz5CyFuI0@xps13.dannf>
References: <20220321104843.949645-1-maz@kernel.org>
 <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 21, 2022 at 10:17:34AM -0500, Rob Herring wrote:
> On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > Since 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup") was
> > merged in the 5.5 time frame, PCIe on the venerable XGene platform has
> > been unusable: 6dce5aa59e0b broke both XGene-1 (Mustang and m400) and
> > XGene-2 (Merlin), while the addition of c7a75d07827a ("PCI: xgene: Fix
> > IB window setup") fixed XGene-2, but left the rest of the zoo
> > unusable.
> >
> > It is understood that this systems come with "creative" DTs that don't
> > match the expectations of modern kernels. However, there is little to
> > be gained by forcing these changes on users -- the firmware is not
> > upgradable, and the current owner of the IP will deny that these
> > machines have ever existed.
> 
> The gain for fixing this properly is not having drivers do their own
> dma-ranges parsing. We've seen what happens when drivers do their own
> parsing of standard properties (e.g. interrupt-map). Currently, we
> don't have any drivers doing their own parsing:
> 
> $ git grep of_pci_dma_range_parser_init
> drivers/of/address.c:int of_pci_dma_range_parser_init(struct
> of_pci_range_parser *parser,
> drivers/of/address.c:EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
> drivers/of/address.c:#define of_dma_range_parser_init
> of_pci_dma_range_parser_init
> drivers/of/unittest.c:  if (of_pci_dma_range_parser_init(&parser, np)) {
> drivers/pci/of.c:       err = of_pci_dma_range_parser_init(&parser, dev_node);
> include/linux/of_address.h:extern int
> of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> include/linux/of_address.h:static inline int
> of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> 
> And we can probably further refactor this to be private to drivers/pci/of.c.
> 
> For XGene-2 the issue is simply that the driver depends on the order
> of dma-ranges entries.
> 
> For XGene-1, I'd still like to understand what the issue is. Reverting
> the first fix and fixing 'dma-ranges' should have fixed it. I need a
> dump of how the IB registers are initialized in both cases.

Happy to provide that for the m400 if told how :)

  -dann

> I'm not
> saying changing 'dma-ranges' in the firmware is going to be required
> here. There's a couple of other ways we could fix that without a
> firmware change, but first I need to understand why it broke.

