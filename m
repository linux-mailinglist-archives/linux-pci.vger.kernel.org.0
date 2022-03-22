Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29DE4E47FB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Mar 2022 22:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiCVVCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiCVVBy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 17:01:54 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC549FA6;
        Tue, 22 Mar 2022 14:00:26 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id w17-20020a056830111100b005b22c584b93so13361441otq.11;
        Tue, 22 Mar 2022 14:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWrxir0SCucnCeRksK5ciUanQNtfuZVTYICxGR86kfU=;
        b=OfjV47PRyefKJ6oV8LpQwwHaqfr6XfiViI0Q8vEBGKDNxjPUmOLsWw6nXiQ8zLBDwU
         NEfvsBZ+QJUdnj+srUsm3z54NLf9YmqH+++tZaOwNUZhLl8qg1u/ZZGv1hsE131iQNWZ
         i97zQcMJVr6ev70b1DNSeuQ7+YTbCge6V0dnNDObK8neUFXe2VIg0aHN3FRdHR1gm41M
         FHGbWTD2IOfOnwElaKbA4xrR8n8FJfJvG5pRH0lewaBOh3B9V98Wpb32ais1qxyqalS0
         AwvfjsvrGh3USIKzaAeeGJcfXXe4prBJYJ3aJF28bsZZOhoX575rf803jTpah7FfyvHS
         crIw==
X-Gm-Message-State: AOAM531HyO1fnifqsR792QBWdJzO9qj0m2kqY5oEf/unHYxXmTeuYlR3
        vfgWJMJic86v3Abf/+foK/hIAhymzw==
X-Google-Smtp-Source: ABdhPJySomTvR7UHgMNwORSbREz8D4fKteTz8sVVbudUJNOk/baydeHAjdQ5mX6dr0LBd2AdAP6wtw==
X-Received: by 2002:a9d:70da:0:b0:5b2:4dcf:fc74 with SMTP id w26-20020a9d70da000000b005b24dcffc74mr10484475otj.376.1647982825779;
        Tue, 22 Mar 2022 14:00:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bc36-20020a05682016a400b003240a532a1csm8388702oob.29.2022.03.22.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 14:00:24 -0700 (PDT)
Received: (nullmailer pid 2498482 invoked by uid 1000);
        Tue, 22 Mar 2022 21:00:22 -0000
Date:   Tue, 22 Mar 2022 16:00:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     dann frazier <dann.frazier@canonical.com>
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
Message-ID: <Yjo45hHe7eBrD/Ff@robh.at.kernel.org>
References: <20220321104843.949645-1-maz@kernel.org>
 <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
 <YjiewB5Nz5CyFuI0@xps13.dannf>
 <Yjii9LUC+u/gmijj@robh.at.kernel.org>
 <Yjj9CLyRdFVWxin0@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjj9CLyRdFVWxin0@xps13.dannf>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 21, 2022 at 04:32:40PM -0600, dann frazier wrote:
> On Mon, Mar 21, 2022 at 11:08:20AM -0500, Rob Herring wrote:
> > On Mon, Mar 21, 2022 at 09:50:24AM -0600, dann frazier wrote:
> > > On Mon, Mar 21, 2022 at 10:17:34AM -0500, Rob Herring wrote:
> > > > On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > Since 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup") was
> > > > > merged in the 5.5 time frame, PCIe on the venerable XGene platform has
> > > > > been unusable: 6dce5aa59e0b broke both XGene-1 (Mustang and m400) and
> > > > > XGene-2 (Merlin), while the addition of c7a75d07827a ("PCI: xgene: Fix
> > > > > IB window setup") fixed XGene-2, but left the rest of the zoo
> > > > > unusable.
> > > > >
> > > > > It is understood that this systems come with "creative" DTs that don't
> > > > > match the expectations of modern kernels. However, there is little to
> > > > > be gained by forcing these changes on users -- the firmware is not
> > > > > upgradable, and the current owner of the IP will deny that these
> > > > > machines have ever existed.
> > > > 
> > > > The gain for fixing this properly is not having drivers do their own
> > > > dma-ranges parsing. We've seen what happens when drivers do their own
> > > > parsing of standard properties (e.g. interrupt-map). Currently, we
> > > > don't have any drivers doing their own parsing:
> > > > 
> > > > $ git grep of_pci_dma_range_parser_init
> > > > drivers/of/address.c:int of_pci_dma_range_parser_init(struct
> > > > of_pci_range_parser *parser,
> > > > drivers/of/address.c:EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
> > > > drivers/of/address.c:#define of_dma_range_parser_init
> > > > of_pci_dma_range_parser_init
> > > > drivers/of/unittest.c:  if (of_pci_dma_range_parser_init(&parser, np)) {
> > > > drivers/pci/of.c:       err = of_pci_dma_range_parser_init(&parser, dev_node);
> > > > include/linux/of_address.h:extern int
> > > > of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> > > > include/linux/of_address.h:static inline int
> > > > of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> > > > 
> > > > And we can probably further refactor this to be private to drivers/pci/of.c.
> > > > 
> > > > For XGene-2 the issue is simply that the driver depends on the order
> > > > of dma-ranges entries.
> > > > 
> > > > For XGene-1, I'd still like to understand what the issue is. Reverting
> > > > the first fix and fixing 'dma-ranges' should have fixed it. I need a
> > > > dump of how the IB registers are initialized in both cases.
> > > 
> > > Happy to provide that for the m400 if told how :)
> > 
> > Something like the below patch. This should be with the 'dma-ranges' 
> > DT change and only c7a75d07827a reverted.
> 
> https://paste.ubuntu.com/p/RHzBd5jT6v/
> 
> Note that networking does come up with this setup. That surprised me
> because I thought I'd tested this combo before, but apparently what
> I'd tested before was 6dce5aa59e0b reverted + the dtb change:
>   https://lore.kernel.org/linux-pci/YgXG838iMrS1l8SC@xps13.dannf/

That doesn't make sense. I just noticed there's an error in what I 
told you to do for dma-ranges. I fixed the wrong cell as it should be:

- dma-ranges = <0x42000000 0x40 0x00 0x40 0x00 0x40 0x00 0x00 0x00 0x79000000 0x00 0x79000000 0x00 0x800000>;
+ dma-ranges = <0x42000000 0x40 0x00 0x40 0x00 0x40 0x00 0x42000000 0x00 0x79000000 0x00 0x79000000 0x00 0x800000>;

Rob
