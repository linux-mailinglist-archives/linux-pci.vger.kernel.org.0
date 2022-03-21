Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977A74E335A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 23:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiCUWxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 18:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiCUWxa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 18:53:30 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3CD52B2C
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 15:32:46 -0700 (PDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 06F053F1AC
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 22:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647901965;
        bh=XDxK5C2+TSZ+aKZ0Wy4YRhUpCIrlRUVGIVSk2+SABTU=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=tqIgojDWSHJyPdZcyqFpL6o7ZVnZAmuDGRyK9juvO1iBokpBxtaeo4HpmAUj+S/Q6
         JHodkUAHBUxfvJ+Uopa70FxlpAMbPNC9VvbI1Ef63Dh7TNY34kBKHCt3iXArIBlRyf
         XG8MxI9bLmlN7dWkm481SoG0CKw54lCQ+QL9AppckOkEIIKpckEVV2uWpU9G5cGWr8
         +w57c+e4jyPMiJ1Ex3ra7e3bxZAqfVOVsLZ/AxslvWGmrvEHBQfx7v8BNoaQ+f2/R2
         JYW7VTlO+x9H31t9J5KYXSJp6sTvquLnyzqDxlc39wlkt1gmjzv+e4SXYy27n2NLkw
         om9AH1zRK7k0w==
Received: by mail-il1-f200.google.com with SMTP id g2-20020a056e02130200b002c837b25e60so1286371ilr.20
        for <linux-pci@vger.kernel.org>; Mon, 21 Mar 2022 15:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XDxK5C2+TSZ+aKZ0Wy4YRhUpCIrlRUVGIVSk2+SABTU=;
        b=EiLfVnFW3uGcA8XoErj551tNO6NCjK9y/7xKjEDR/SHKRFuwdvw3cH3mfJJg+URTW3
         LMA+3MlNT+gDWaw5UeYjEkxytevI1/Mck4Fm2g9oucRiWBaR0A5FwAXWMIBXR0XqrCa5
         MMWvzMTThpBh9bqSmQazk3Uw8aSj+qXtZlyZL/2eq+FvtGcuGjgCNenNS8FcGwjOVJ4u
         V2jRo5IGOEO9tgsHR+dGhZRpjVH4J88PlpnMmV6RF0vMYhjuFlL6ntQ4MI+Kqn2365Ev
         iptYqx2AEF0y1tmgNq5yOIO/cm5teYSLYGGmM4F/nxHR03RWTGxfRKVEHoOBDwg6PEyR
         /oVw==
X-Gm-Message-State: AOAM530eDoi2FuqGDreYynzR3zg09EDLkBTpzuclv2sNr3KbvzE3hrrR
        nIjK8XHI1DI56AqacGsaHqHc7jq4YFWbvKkOdKOWGrEucPlroRtPPV+FqGQ/1mhk75Kdx048cU1
        SVvbXXugDKmVwf3q2KmPcTDmWQZpFiWcgvbhbDA==
X-Received: by 2002:a05:6e02:5b1:b0:2c6:218d:fb38 with SMTP id k17-20020a056e0205b100b002c6218dfb38mr10945931ils.266.1647901963709;
        Mon, 21 Mar 2022 15:32:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAFr4gjq1K+/JSkE+Bmnd8mMisGuPUNiCR0CRuDg5LKHtX6MOLU2pb1SX/F9E9Vlp34LLMoQ==
X-Received: by 2002:a05:6e02:5b1:b0:2c6:218d:fb38 with SMTP id k17-20020a056e0205b100b002c6218dfb38mr10945920ils.266.1647901963429;
        Mon, 21 Mar 2022 15:32:43 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
        by smtp.gmail.com with ESMTPSA id s10-20020a6b740a000000b006413d13477dsm9219017iog.33.2022.03.21.15.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:32:42 -0700 (PDT)
Date:   Mon, 21 Mar 2022 16:32:40 -0600
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
Message-ID: <Yjj9CLyRdFVWxin0@xps13.dannf>
References: <20220321104843.949645-1-maz@kernel.org>
 <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
 <YjiewB5Nz5CyFuI0@xps13.dannf>
 <Yjii9LUC+u/gmijj@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjii9LUC+u/gmijj@robh.at.kernel.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 21, 2022 at 11:08:20AM -0500, Rob Herring wrote:
> On Mon, Mar 21, 2022 at 09:50:24AM -0600, dann frazier wrote:
> > On Mon, Mar 21, 2022 at 10:17:34AM -0500, Rob Herring wrote:
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
> > > parsing of standard properties (e.g. interrupt-map). Currently, we
> > > don't have any drivers doing their own parsing:
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
> > > dump of how the IB registers are initialized in both cases.
> > 
> > Happy to provide that for the m400 if told how :)
> 
> Something like the below patch. This should be with the 'dma-ranges' 
> DT change and only c7a75d07827a reverted.

https://paste.ubuntu.com/p/RHzBd5jT6v/

Note that networking does come up with this setup. That surprised me
because I thought I'd tested this combo before, but apparently what
I'd tested before was 6dce5aa59e0b reverted + the dtb change:
  https://lore.kernel.org/linux-pci/YgXG838iMrS1l8SC@xps13.dannf/

  -dann


> 8<-------------------------------------------------------------------
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index 0d5acbfc7143..6a435c31f45e 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -78,6 +78,7 @@ static u32 xgene_pcie_readl(struct xgene_pcie *port, u32 reg)
>  
>  static void xgene_pcie_writel(struct xgene_pcie *port, u32 reg, u32 val)
>  {
> +	dev_info(port->dev, "0x%04x <- 0x%08x\n", reg, val);
>  	writel(val, port->csr_base + reg);
>  }
>  
> @@ -508,7 +509,9 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
>  	case 0:
>  		xgene_pcie_set_ib_mask(port, BRIDGE_CFG_4, flags, size);
>  		bar_addr = cfg_base + PCI_BASE_ADDRESS_0;
> +		dev_info(port->dev, "BAR0L <- 0x%08x\n", bar_low);
>  		writel(bar_low, bar_addr);
> +		dev_info(port->dev, "BAR0H <- 0x%08x\n", upper_32_bits(cpu_addr));
>  		writel(upper_32_bits(cpu_addr), bar_addr + 0x4);
>  		pim_reg = PIM1_1L;
>  		break;

