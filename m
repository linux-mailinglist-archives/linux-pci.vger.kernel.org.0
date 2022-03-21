Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979F74E2D2E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 17:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350684AbiCUQJz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 12:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350698AbiCUQJv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 12:09:51 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB7A289B8;
        Mon, 21 Mar 2022 09:08:24 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id z8so16692359oix.3;
        Mon, 21 Mar 2022 09:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCOTznouFD+iWjgYbDVoQOww7ryqponRKYWNROGxryg=;
        b=661k3fO36NOv1fvvvx8yLnymdt4NT0+73nAvxySHskd/ZQoa7dWRub+SKplOXMefU8
         GPSChkGMKOQenY24fRlgtQ3d7KDKZAVMV9ishgGbCvVvMJC1uK2cTHVtpHPdFBVLQUU3
         SKKrmSJRvoypOymb0a3e89UTm9R3rY9dcIT3hDCU9Oetg36VkU/6Xd0kxNmdbVma6CHh
         eh/uWTQ3XfzZt7TkycPeeFM44QGD3pTIf7I71nneGhWbBv8Tpl257lssNoJVsYclSu0p
         nJWaJ6+90aW+L9dz5uEA9uH4aYq9F3Ykmi2LRmxeAoBZPbaDOG1XoRuXmaXdmbL+uU6o
         bzbA==
X-Gm-Message-State: AOAM533GRal4ZtTx5F2C5or1xYMXqmjy2GQT1FsevSE///5tqAbPNltq
        Ik/SshpdjdQ0nfFEYAkkZA==
X-Google-Smtp-Source: ABdhPJzCmplBnS1Fq/DfzqLFnp+aV9kDSRQR0Nhlx5kiGHG7agyTuRCc95XbpeqzGNkB/w+tdoAibA==
X-Received: by 2002:aca:3643:0:b0:2ec:cb84:c5ba with SMTP id d64-20020aca3643000000b002eccb84c5bamr14905569oia.183.1647878904067;
        Mon, 21 Mar 2022 09:08:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bc36-20020a05682016a400b003240a532a1csm6859115oob.29.2022.03.21.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:22 -0700 (PDT)
Received: (nullmailer pid 139178 invoked by uid 1000);
        Mon, 21 Mar 2022 16:08:20 -0000
Date:   Mon, 21 Mar 2022 11:08:20 -0500
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
Message-ID: <Yjii9LUC+u/gmijj@robh.at.kernel.org>
References: <20220321104843.949645-1-maz@kernel.org>
 <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
 <YjiewB5Nz5CyFuI0@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjiewB5Nz5CyFuI0@xps13.dannf>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 21, 2022 at 09:50:24AM -0600, dann frazier wrote:
> On Mon, Mar 21, 2022 at 10:17:34AM -0500, Rob Herring wrote:
> > On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Since 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup") was
> > > merged in the 5.5 time frame, PCIe on the venerable XGene platform has
> > > been unusable: 6dce5aa59e0b broke both XGene-1 (Mustang and m400) and
> > > XGene-2 (Merlin), while the addition of c7a75d07827a ("PCI: xgene: Fix
> > > IB window setup") fixed XGene-2, but left the rest of the zoo
> > > unusable.
> > >
> > > It is understood that this systems come with "creative" DTs that don't
> > > match the expectations of modern kernels. However, there is little to
> > > be gained by forcing these changes on users -- the firmware is not
> > > upgradable, and the current owner of the IP will deny that these
> > > machines have ever existed.
> > 
> > The gain for fixing this properly is not having drivers do their own
> > dma-ranges parsing. We've seen what happens when drivers do their own
> > parsing of standard properties (e.g. interrupt-map). Currently, we
> > don't have any drivers doing their own parsing:
> > 
> > $ git grep of_pci_dma_range_parser_init
> > drivers/of/address.c:int of_pci_dma_range_parser_init(struct
> > of_pci_range_parser *parser,
> > drivers/of/address.c:EXPORT_SYMBOL_GPL(of_pci_dma_range_parser_init);
> > drivers/of/address.c:#define of_dma_range_parser_init
> > of_pci_dma_range_parser_init
> > drivers/of/unittest.c:  if (of_pci_dma_range_parser_init(&parser, np)) {
> > drivers/pci/of.c:       err = of_pci_dma_range_parser_init(&parser, dev_node);
> > include/linux/of_address.h:extern int
> > of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> > include/linux/of_address.h:static inline int
> > of_pci_dma_range_parser_init(struct of_pci_range_parser *parser,
> > 
> > And we can probably further refactor this to be private to drivers/pci/of.c.
> > 
> > For XGene-2 the issue is simply that the driver depends on the order
> > of dma-ranges entries.
> > 
> > For XGene-1, I'd still like to understand what the issue is. Reverting
> > the first fix and fixing 'dma-ranges' should have fixed it. I need a
> > dump of how the IB registers are initialized in both cases.
> 
> Happy to provide that for the m400 if told how :)

Something like the below patch. This should be with the 'dma-ranges' 
DT change and only c7a75d07827a reverted.

8<-------------------------------------------------------------------
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 0d5acbfc7143..6a435c31f45e 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -78,6 +78,7 @@ static u32 xgene_pcie_readl(struct xgene_pcie *port, u32 reg)
 
 static void xgene_pcie_writel(struct xgene_pcie *port, u32 reg, u32 val)
 {
+	dev_info(port->dev, "0x%04x <- 0x%08x\n", reg, val);
 	writel(val, port->csr_base + reg);
 }
 
@@ -508,7 +509,9 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
 	case 0:
 		xgene_pcie_set_ib_mask(port, BRIDGE_CFG_4, flags, size);
 		bar_addr = cfg_base + PCI_BASE_ADDRESS_0;
+		dev_info(port->dev, "BAR0L <- 0x%08x\n", bar_low);
 		writel(bar_low, bar_addr);
+		dev_info(port->dev, "BAR0H <- 0x%08x\n", upper_32_bits(cpu_addr));
 		writel(upper_32_bits(cpu_addr), bar_addr + 0x4);
 		pim_reg = PIM1_1L;
 		break;
