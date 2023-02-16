Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9674F699BB2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 18:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBPR62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 12:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBPR62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 12:58:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D0837737
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 09:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28AEDB8294F
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 17:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEB7C4339B;
        Thu, 16 Feb 2023 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676570304;
        bh=P9l1Xnfxta1wSJ9Ys+tgng6JZFEkLuFQcWtkNkLlGBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Bxrs0zxOPoU9zbeTmOPJS5LFkii4vJ5djqi+Ni/KpV/h7GhiS4FR6gq21fkEwv5VU
         /DrHaspA6GBi8Wd5Y7BZ1T3D6s4v+cVGpV1mEl41DQE6Me6dghUIuOboZI/LGnRo4k
         xHnqPVrumJSNsoopaQHJyBy/Kf0r5YpNR07tq2d8+k14Z/ZgA0WM0Rw2yg8hSO4Zih
         luoKA2eH8Z9D+yVbTwwQnvZO4rgwxbVnZzIElxQD6zHkCjTYouqj8iP40Fpgbk9Kh/
         UnPzMj2RDaoFsuQwdheWgs0FV+JTNvTpDn5lIjkUL9LD+ImoQVaaG9VyS9jfPDBdnk
         ejgFSZ6nXqIFg==
Date:   Thu, 16 Feb 2023 11:58:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        Sergey.Semin@baikalelectronics.ru, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Fix writing wrong value if
 snps,enable-cdm-check
Message-ID: <20230216175822.GA3321300@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216092012.3256440-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 16, 2023 at 06:20:12PM +0900, Yoshihiro Shimoda wrote:
> The "val" of PCIE_PORT_LINK_CONTROL will be reused on the
> "Set the number of lanes". But, if snps,enable-cdm-check" exists,
> the "val" will be set to PCIE_PL_CHK_REG_CONTROL_STATUS.
> Therefore, unexpected register value is possible to be used
> to PCIE_PORT_LINK_CONTROL register if snps,enable-cdm-check" exists.
> So, read PCIE_PORT_LINK_CONTROL register again to fix the issue.
> 
> Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 6d5d619ab2e9..3bb9ca14fb9c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -824,6 +824,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	}
>  
>  	/* Set the number of lanes */
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);

Definitely a bug, thanks for the fix and the Fixes: tag.

But I would like the whole function better if it could be structured
so we read PCIE_PORT_LINK_CONTROL once and wrote it once.  And the
same for PCIE_LINK_WIDTH_SPEED_CONTROL.

Maybe there's a reason PCIE_PL_CHK_REG_CONTROL_STATUS must be written
between the two PCIE_PORT_LINK_CONTROL writes or the two
PCIE_LINK_WIDTH_SPEED_CONTROL writes, I dunno.  If so, a comment there
about why that is would be helpful.

>  	val &= ~PORT_LINK_FAST_LINK_MODE;
>  	val &= ~PORT_LINK_MODE_MASK;
>  	switch (pci->num_lanes) {
> -- 
> 2.25.1
> 
