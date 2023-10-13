Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392667C8E38
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 22:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjJMUTi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 16:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJMUTi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 16:19:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9783B7;
        Fri, 13 Oct 2023 13:19:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6B6C433C7;
        Fri, 13 Oct 2023 20:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697228376;
        bh=tvtzyW2JqBM8XejJMr6a7ivykq0sPqszsj9fJx+J3FI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PG3cMmrahWdVfIpMsUE4eUKoaeB8cpSGh8WI4UyjCIL6cTSkCxnzdSIxnluhHf2V7
         wzdIO7exDf5StQx1eb1/PCQ8zpyAa805YY5Bjr0x9rHPijW9CG1HfcZ0t+q3J0gk7t
         UX/kusjo1rrbH8doeXR15cpUB9bInOLYjGV8M2jCknx5gP8fWalWyKVMymnFsff5fE
         E2ZTG5OgQLRh2sDmvcxSVLq75bDM+wac09FauQkjCWKNRYLHsEOSScswkpeHnUIXev
         RcQhq6fMTTc/QHotF6zsKUjpoCR53NuA0MPh6CP76YI05XA10GxYMl3VpPv6AuLf9d
         qG4VUhwCbC1Vw==
Date:   Fri, 13 Oct 2023 15:19:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/DPC: Use defines with register fields
Message-ID: <20231013201934.GA1124734@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013112004.4239-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 13, 2023 at 02:20:04PM +0300, Ilpo Järvinen wrote:
> Use defines instead of literals and replace custom masking and shifts
> with FIELD_GET() where it makes sense.
> ...

>  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
> -	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
>  
> -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
> +	ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> +	ctl &= ~PCI_EXP_DPC_CTL_EN_NONFATAL;

This has been a little obtuse from the beginning.

The original clears bits 0, 1, 3, then sets bits 0 and 3.
The new code sets bits 0, 3, then clears bit 1.

These are equivalent, but it's definitely some work to verify it.

I think the point is to enable DPC on ERR_FATAL (but not ERR_NONFATAL)
and to enable DPC interrupts.  What about something like this?

  #define PCI_EXP_DPC_CTL_EN_MASK  0x0003

  ctl &= ~PCI_EXP_DPC_CTL_EN_MASK;
  ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;

>  	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> -	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
>  
> +	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
>  	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
>  		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
>  		 FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
> -- 
> 2.30.2
> 
