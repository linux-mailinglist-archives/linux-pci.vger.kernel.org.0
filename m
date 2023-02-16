Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9299F699DE0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 21:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBPUhm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 15:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPUhm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 15:37:42 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 678E0196AA
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 12:37:38 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 1B935E0EAB;
        Thu, 16 Feb 2023 23:37:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=E2fJ7hfpYjoXw/IkH60+
        vo7am/SiFz3HlimHJ9lYhd0=; b=l/kPfjgfMLQV8FpWWJ9/rvHXU/XedeBEuIjg
        QoiNOF2aKrHrljKcb13WlNDL+6OQ0Pck/gi09v3rtoqbuQmp4cHP4EiXNpKazYGb
        LVQ/6PyozULGMl76gMqmVyBTnJxPf36wNjZp1mrZg7dFZA6j991saY9xuvEm8H6x
        ToshrNs=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id DFE9FE0E1C;
        Thu, 16 Feb 2023 23:37:35 +0300 (MSK)
Received: from mobilestation (10.8.30.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 16 Feb 2023 23:37:34 +0300
Date:   Thu, 16 Feb 2023 23:37:34 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: Fix writing wrong value if
 snps,enable-cdm-check
Message-ID: <20230216203734.k5spjvu2z7pdy7kv@mobilestation>
References: <20230216092012.3256440-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230216092012.3256440-1-yoshihiro.shimoda.uh@renesas.com>
X-Originating-IP: [10.8.30.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

You turned to be a one day ahead of me submitting the fix. Thanks
anyway. My mistake.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

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
>  	val &= ~PORT_LINK_FAST_LINK_MODE;
>  	val &= ~PORT_LINK_MODE_MASK;
>  	switch (pci->num_lanes) {
> -- 
> 2.25.1
> 
> 

