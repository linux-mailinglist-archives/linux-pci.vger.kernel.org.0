Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CE728611
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjFHRPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjFHRPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 13:15:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32032269A;
        Thu,  8 Jun 2023 10:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C272B64F81;
        Thu,  8 Jun 2023 17:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D494BC433EF;
        Thu,  8 Jun 2023 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686244509;
        bh=4wyq5feJyGC1xVBcTZ/Mti/s0RME8bXOsMag48IzS5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XTu/6CbFHIlPGMsivoT/edMq3lP0JFtqLA2e4ijvZTyXI+rXPp30vZH5LPiAlfpWT
         ugJrxfdgowagoYMwEL/U9+Kg/EBvzLktvSgkh/LEkNCyopOwy3PKxXLtppLkmBlsBE
         UdSMxg86UJRbEhFWwiqyETZkIUd/+/UBqCVtGROzszLOA/BEkDSbtAgovo6eSjSGZI
         TJ1908tHQzPGj3lDCD9pebdDBwxu2F6b80AfEn/ZLa2SseYdN4tEaRSkjYf94bPayd
         1S0JP5aOo2mZDEF3c0j4lfBEO0yx/fmTo1/iqDaEMdTeuNBVOS7JYXMrNDQq+b0Gtn
         xqUBgfOfFcFsA==
Date:   Thu, 8 Jun 2023 12:15:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: mediatek-gen3: Stop acquiring spinlocks in
 {suspend,resume}_noirq
Message-ID: <20230608171507.GA1204894@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504113509.184633-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 04, 2023 at 01:35:08PM +0200, AngeloGioacchino Del Regno wrote:
> In mtk_pcie_suspend_noirq() and mtk_pcie_resume_noirq() we are,
> respectively, disabling and enabling generation of interrupts and
> then saving and restoring the enabled interrupts register: since
> we're using noirq PM callbacks, that can be safely done without
> holding any spin lock.

Tangent: it's annoying that pcie-mediatek.c and pcie-mediatek-gen3.c
use identical "mtk_pcie_suspend_noirq()" names.  That makes browsing
harder than it needs to be.  But I see that you refer to
mediatek-gen3.

> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -963,8 +963,6 @@ static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
>  {
>  	int i;
>  
> -	raw_spin_lock(&pcie->irq_lock);
> -
>  	pcie->saved_irq_state = readl_relaxed(pcie->base + PCIE_INT_ENABLE_REG);
>  
>  	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
> @@ -973,16 +971,12 @@ static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
>  		msi_set->saved_irq_state = readl_relaxed(msi_set->base +
>  					   PCIE_MSI_SET_ENABLE_OFFSET);
>  	}
> -
> -	raw_spin_unlock(&pcie->irq_lock);
>  }

Jianjun added mtk_pcie_irq_save() and mtk_pcie_irq_restore() with
d537dc125f07 ("PCI: mediatek-gen3: Add system PM support").  

I suggest looking at other drivers and structuring mediatek-gen3
similarly, including using similar function names.  No other drivers
have a .*_pcie_irq_save() function.  Several have .*_pcie_host_init(),
and some of those do include some IRQ setup.

Bjorn
