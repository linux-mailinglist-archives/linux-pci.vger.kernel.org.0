Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971394E492B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Mar 2022 23:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiCVWbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiCVWbM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 18:31:12 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60221140D1
        for <linux-pci@vger.kernel.org>; Tue, 22 Mar 2022 15:29:44 -0700 (PDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C87693F1D2
        for <linux-pci@vger.kernel.org>; Tue, 22 Mar 2022 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647988181;
        bh=cnbYZcT/chufKQ1TGghRbnv4bvQ/2ZkPw6HGNZNayUo=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=t+PXg2t5lohDrtdMgKUZIY2Xnq2Ldq19VPjyRIW4BDtoFste+4cuxkMBFpql+ouX/
         mjpv/vt+qsJXTxQa9xusOQxIv0o14N1zeVX5Fq0q47WGaBWKGksRCSGO7oEUOjjnwu
         94Q4Gu1gPG8HGARp4Vnn3o1Mn1js6M2cPWNDhMmGPpHdt6WrKldFE5f9J1U2yPIQCI
         a1XgOYQwaDyzJcKcvZgV732pVqLNKaHI3D1DL3OJlP5s4kMgz24eVca9Jfjzn3/gPH
         bZYw8T0ZwdRQGp2kVM8R9QRNn9m4NS/SgCZKtz90gkFwCzWKBIQvOSy2cYhwiFoPPv
         9G5w0f8zzAecA==
Received: by mail-io1-f69.google.com with SMTP id f5-20020a6be805000000b00649b9faf257so3602791ioh.9
        for <linux-pci@vger.kernel.org>; Tue, 22 Mar 2022 15:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cnbYZcT/chufKQ1TGghRbnv4bvQ/2ZkPw6HGNZNayUo=;
        b=lRZWszI3K8iCwo+8e1uI38PIqh5Xaou+ypJasbjCIS34tyCbpbEvrYUjmWi8yL/O6c
         WTliti4Im+TSTBzug/g2ovZrWi+iphgoQExJgmXH4peZTybrmgqpM4Qt6T1/yBa/WEJy
         CRsEuXy4tiQV2sPx8fZElnvLW3F3rzWsuzkCAGGkS9gRQq5vDL39NcFzt320OFltRKa4
         MmcWv+hT/NkRgqlc6coHQDOJ5/hqFRXJJKqGObBSTB86EjAn5oPI6nSzd5MCjFN/a2kT
         yu9iE+znAR0XwHM9psxxKf6/eqTE6cfRlKtWnWYC0wlieri4nslbDLpXpuDdVW8kSBKd
         4AMQ==
X-Gm-Message-State: AOAM533/FNE9aNYcuQHPeMThLdUOlaO8053VB3J5r6Rwlgk1mWKC6erI
        Ppxm72L8C9lB51KX9xYfYjDo0zyHSTYDqbvGm+B9falSvM0oybBghQwi/QX0Kk61kMh+H1HKYS3
        KYmPPwiCKUpuZLmaBh63/HmtOQfoMJaYBIOcIng==
X-Received: by 2002:a92:de0e:0:b0:2c8:294f:90c1 with SMTP id x14-20020a92de0e000000b002c8294f90c1mr5844480ilm.180.1647988180612;
        Tue, 22 Mar 2022 15:29:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh7EQ0r1Jvgx0svv/2HgYTF0DSYKIpqc5DZmSsE56CarYrcVmEBWZhNb6w+sN95HJsGmtURg==
X-Received: by 2002:a92:de0e:0:b0:2c8:294f:90c1 with SMTP id x14-20020a92de0e000000b002c8294f90c1mr5844467ilm.180.1647988180306;
        Tue, 22 Mar 2022 15:29:40 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d9483000000b00640d3d4acabsm9904796ioj.44.2022.03.22.15.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 15:29:39 -0700 (PDT)
Date:   Tue, 22 Mar 2022 16:29:37 -0600
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
Message-ID: <YjpN0TLOnE+czSt+@xps13.dannf>
References: <20220321104843.949645-1-maz@kernel.org>
 <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
 <YjiewB5Nz5CyFuI0@xps13.dannf>
 <Yjii9LUC+u/gmijj@robh.at.kernel.org>
 <Yjj9CLyRdFVWxin0@xps13.dannf>
 <Yjo45hHe7eBrD/Ff@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjo45hHe7eBrD/Ff@robh.at.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 22, 2022 at 04:00:22PM -0500, Rob Herring wrote:
> On Mon, Mar 21, 2022 at 04:32:40PM -0600, dann frazier wrote:
> > On Mon, Mar 21, 2022 at 11:08:20AM -0500, Rob Herring wrote:
> > > On Mon, Mar 21, 2022 at 09:50:24AM -0600, dann frazier wrote:
> > > > On Mon, Mar 21, 2022 at 10:17:34AM -0500, Rob Herring wrote:
> > > > > On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > >
> > > > > > Since 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup") was
> > > > > > merged in the 5.5 time frame, PCIe on the venerable XGene platform has
> > > > > > been unusable: 6dce5aa59e0b broke both XGene-1 (Mustang and m400) and
> > > > > > XGene-2 (Merlin), while the addition of c7a75d07827a ("PCI: xgene: Fix
> > > > > > IB window setup") fixed XGene-2, but left the rest of the zoo
> > > > > > unusable.
> > > > > >
> > > > > > It is understood that this systems come with "creative" DTs that don't
> > > > > > match the expectations of modern kernels. However, there is little to
> > > > > > be gained by forcing these changes on users -- the firmware is not
> > > > > > upgradable, and the current owner of the IP will deny that these
> > > > > > machines have ever existed.
> > > > > 
> > > > > The gain for fixing this properly is not having drivers do their own
> > > > > dma-ranges parsing. We've seen what happens when drivers do their own
> > > > > parsing of standard properties (e.g. interrupt-map). Currently, we
> > > > > don't have any drivers doing their own parsing:
> > > > > 
> > > > > $ git grep of_pci_dma_range_parser_init
> > > > > drivers/of/address.c:int of_pci_dma_range_parser_init(struct
> > > > > of_pci_range_parser *parser,
> > > > > drivers/of/address.c:EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
> > > > > drivers/of/address.c:#define of_dma_range_parser_init
> > > > > of_pci_dma_range_parser_init
> > > > > drivers/of/unittest.c:  if (of_pci_dma_range_parser_init(&parser, np)) {
> > > > > drivers/pci/of.c:       err = of_pci_dma_range_parser_init(&parser, dev_node);
> > > > > include/linux/of_address.h:extern int
> > > > > of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> > > > > include/linux/of_address.h:static inline int
> > > > > of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> > > > > 
> > > > > And we can probably further refactor this to be private to drivers/pci/of.c.
> > > > > 
> > > > > For XGene-2 the issue is simply that the driver depends on the order
> > > > > of dma-ranges entries.
> > > > > 
> > > > > For XGene-1, I'd still like to understand what the issue is. Reverting
> > > > > the first fix and fixing 'dma-ranges' should have fixed it. I need a
> > > > > dump of how the IB registers are initialized in both cases.
> > > > 
> > > > Happy to provide that for the m400 if told how :)
> > > 
> > > Something like the below patch. This should be with the 'dma-ranges' 
> > > DT change and only c7a75d07827a reverted.
> > 
> > https://paste.ubuntu.com/p/RHzBd5jT6v/
> > 
> > Note that networking does come up with this setup. That surprised me
> > because I thought I'd tested this combo before, but apparently what
> > I'd tested before was 6dce5aa59e0b reverted + the dtb change:
> >   https://lore.kernel.org/linux-pci/YgXG838iMrS1l8SC@xps13.dannf/
> 
> That doesn't make sense. I just noticed there's an error in what I 
> told you to do for dma-ranges. I fixed the wrong cell as it should be:
> 
> - dma-ranges = <0x42000000 0x40 0x00 0x40 0x00 0x40 0x00 0x00 0x00 0x79000000 0x00 0x79000000 0x00 0x800000>;
> + dma-ranges = <0x42000000 0x40 0x00 0x40 0x00 0x40 0x00 0x42000000 0x00 0x79000000 0x00 0x79000000 0x00 0x800000>;

OK, thanks Rob. Here's an updated log:

  https://paste.ubuntu.com/p/FmSTbM6Zq3/

  -dann
