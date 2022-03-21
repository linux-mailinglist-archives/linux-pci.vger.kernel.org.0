Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26984E3223
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 22:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiCUVIG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 17:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiCUVIB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 17:08:01 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E00F19CCDB
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 14:06:35 -0700 (PDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7E3363F1C9
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647896793;
        bh=PH1bVwJW+65ZSg7ht8UKbv2/JhG2Jc27AqWMKxMcUUs=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=v2Pf/TMp2Bx/d966rcN7a3d+na287rj4pBvLDWaD8Xi6eU4klRJIWqdLxFhZ6WZGY
         MI5dKZlE5O5hdHLSuJfoFsroLDmAvcPN5jxLR/rkkSLb4uBGG0p37gOQqWMkVPlOdV
         MU+MwleWHIY0VI8FvXZVjGPB4lHa4Wmf7ec2zmducEMQ6JB7IC/9kh87ZSGQN0LnHu
         DF4VvEVvu7McCYAO4XX/WNnG6j5x5GywjF69N/5Yo+nzonSvXX3Yzs/jTUKE8aLnrd
         CvI5tF9+OEXeYzZ0HLiJfVEWg0FgJYQGY+wH6suo/WPSJ0ECVqyflYazq5wivkRebG
         NEFfU5TkdKy+g==
Received: by mail-il1-f200.google.com with SMTP id j25-20020a056e02219900b002c81019b2fdso2729165ila.16
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 14:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PH1bVwJW+65ZSg7ht8UKbv2/JhG2Jc27AqWMKxMcUUs=;
        b=YlocF9PMq17BrOw0kC9e+jqhKA1v6StWNrSDZg1xVi/+sN4sTqjdOjh4/6nty9MKvV
         YndqS5eWcLVxmi+sUOpfdrErpx84OozP94CZbMU0ehBMJmzR0ZzL6mqGQFeq4RY4/Ghx
         sC7UXVEWhZ1dbmwRqsQdw03qx2Sg/3gcneYrBLbJgtx4mjVrxUYD6C50thzNJMfbNF6D
         ZFr36COilgrVQ/YfEykUDKqz4LQJ85urcf5m4cXgGnulJoUBifHSCOgdQFcH5hB10Iid
         eKBepHSVOQzWpa5tz1jlNsYnhNRRSRnBKfYhAFRiTMcAKyOROY02rY8dTjlFa2I4rQu/
         kglg==
X-Gm-Message-State: AOAM5322ilErp7yTUVP/5i0Kfg5+d2UOUR6S08sPVhAx+iFbpZSVM7r7
        2Olbqm43VXGviUR160+Lsp2HRjRmGchQLI/Go16qA2JCiYSsoer+Gh7UlvW/vk84YgORvis/cmy
        BRmKRc/zSRrGTRk5sJy8YvNwj8SR/+ibJmiYkQA==
X-Received: by 2002:a05:6638:dd3:b0:317:c9aa:b38f with SMTP id m19-20020a0566380dd300b00317c9aab38fmr12574952jaj.9.1647896792318;
        Mon, 21 Mar 2022 14:06:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdCB1f1uWvBZbayneSeyhrKeKVm216UoVjGHBb0qaQFHuwW3HlwiAEwvBUMRl9d0SpCqZ5Gw==
X-Received: by 2002:a05:6638:dd3:b0:317:c9aa:b38f with SMTP id m19-20020a0566380dd300b00317c9aab38fmr12574930jaj.9.1647896792018;
        Mon, 21 Mar 2022 14:06:32 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
        by smtp.gmail.com with ESMTPSA id m2-20020a056e021c2200b002c837530587sm1069585ilh.60.2022.03.21.14.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 14:06:31 -0700 (PDT)
Date:   Mon, 21 Mar 2022 15:06:29 -0600
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
Message-ID: <Yjjo1emkGKPpaYY2@xps13.dannf>
References: <20220321104843.949645-1-maz@kernel.org>
 <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
 <87h77rxnyl.wl-maz@kernel.org>
 <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 21, 2022 at 01:03:27PM -0500, Rob Herring wrote:
> On Mon, Mar 21, 2022 at 11:36 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Mon, 21 Mar 2022 15:17:34 +0000,
> > Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > Since 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup") was
> > > > merged in the 5.5 time frame, PCIe on the venerable XGene platform has
> > > > been unusable: 6dce5aa59e0b broke both XGene-1 (Mustang and m400) and
> > > > XGene-2 (Merlin), while the addition of c7a75d07827a ("PCI: xgene: Fix
> > > > IB window setup") fixed XGene-2, but left the rest of the zoo
> > > > unusable.
> > > >
> > > > It is understood that this systems come with "creative" DTs that don't
> > > > match the expectations of modern kernels. However, there is little to
> > > > be gained by forcing these changes on users -- the firmware is not
> > > > upgradable, and the current owner of the IP will deny that these
> > > > machines have ever existed.
> > >
> > > The gain for fixing this properly is not having drivers do their own
> > > dma-ranges parsing. We've seen what happens when drivers do their own
> > > parsing of standard properties (e.g. interrupt-map).
> >
> > We have, and we added the required exceptions for the legacy platforms
> > that the code base supported until then. We didn't leave things broken
> > just because we didn't like the way things were done a long time ago.
> >
> > > Currently, we don't have any drivers doing their own parsing:
> > >
> > > $ git grep of_pci_dma_range_parser_init
> > > drivers/of/address.c:int of_pci_dma_range_parser_init(struct
> > > of_pci_range_parser *parser,
> > > drivers/of/address.c:EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
> > > drivers/of/address.c:#define of_dma_range_parser_init
> > > of_pci_dma_range_parser_init
> > > drivers/of/unittest.c:  if (of_pci_dma_range_parser_init(&parser, np)) {
> > > drivers/pci/of.c:       err = of_pci_dma_range_parser_init(&parser, dev_node);
> > > include/linux/of_address.h:extern int
> > > of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> > > include/linux/of_address.h:static inline int
> > > of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> > >
> > > And we can probably further refactor this to be private to drivers/pci/of.c.
> > >
> > > For XGene-2 the issue is simply that the driver depends on the order
> > > of dma-ranges entries.
> > >
> > > For XGene-1, I'd still like to understand what the issue is. Reverting
> > > the first fix and fixing 'dma-ranges' should have fixed it. I need a
> > > dump of how the IB registers are initialized in both cases. I'm not
> > > saying changing 'dma-ranges' in the firmware is going to be required
> > > here. There's a couple of other ways we could fix that without a
> > > firmware change, but first I need to understand why it broke.
> >
> > Reverting 6dce5aa59e0b was enough for me, without changing anything
> > else.
> 
> Meaning c7a75d07827a didn't matter for you. I'm not sure that it would.
> 
> Can you tell me what 'dma-ranges' contains on your system?
> 
> > m400 probably uses an even older firmware (AFAIR, it was stuck
> > with an ancient version of u-boot that HP never updated, while Mustang
> > had a few updates). In any case, that DT cannot be changed.
> 
> How is Dann changing it then? I assume he's not changing the firmware,
> but overriding it. That could be a possible solution.

Correct, I'm just overriding it for testing. I'm using the pxelinux
emulation provided by the m400's u-boot, which supports an FDT field:

---------
$ cat /srv/tftp/pxelinux.cfg/default
DEFAULT default

LABEL default
  KERNEL uImage
  APPEND initrd=uInitrd console=ttyS0,9600n8r ro root=LABEL=cloudimg-rootfs
  FDT m400.dtb
---------

This loads the specified file into ${fdt_addr_r}, overriding the blob
that the firmware had already loaded there.

> Do the DT's in the kernel tree correspond to anything anyone is
> using?

Upstream apm-mustang.dtb is what Ubuntu uses for Mustang boards w/
u-boot firmware. That used to work fine, but I haven't tried lately.

  -dann
