Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94175EB20
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 08:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjGXGCl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 02:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGXGCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 02:02:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBC6E6D
        for <linux-pci@vger.kernel.org>; Sun, 23 Jul 2023 23:02:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8832C60F30
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 06:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7D8C433C8;
        Mon, 24 Jul 2023 06:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690178550;
        bh=r8nmwuSaeRU0OoImBip+RhqN6cjWEU3cFXc11nPCgqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kC8FDpuVgVqco3uETkSKDR/h1ICFimDoXDeEnaRpSCLQejs7l0KyUcbA9S0+Aj6ca
         Zaa4kpyKLCiz7WeU3jXRNtySVJPaeua5X/k7N9W4t4BISXHM+6XKkJ7ybWHoqplPJq
         q90OBCc7OpLA+/DVu4ig18sem5BAhLsQ2ajYVUj/RZ2ox0+/RW8Ns19xGA8JDjGctd
         huCOnyuvGjPtfM9wJX7g8OynZLEv/M4QhE6n35WtvEULHGKLc5y3Uza3pflUaCkLOe
         x/VgHHp+Yt5PIDDxvK/2J95YytZ1+wVnt1aHMaOutucjczwOCz8LV4uPy5bSf1ta/C
         f0LwODdCypYwQ==
Date:   Mon, 24 Jul 2023 11:32:17 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        mhi@lists.linux.dev, ntb@lists.linux.dev
Subject: Re: [PATCH 3/5] PCI: endpoint: pci-epf-ntb: Constify pci_epf_ops
Message-ID: <20230724060217.GE2370@thinkpad>
References: <20230722230848.589428-1-lars@metafoo.de>
 <20230722230848.589428-3-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230722230848.589428-3-lars@metafoo.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 22, 2023 at 04:08:46PM -0700, Lars-Peter Clausen wrote:
> The pci_epf_ops struct for the PCI endpoint ntb driver is never modified.
> Mark it as const so it can be placed in the read-only section.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 9aac2c6f3bb9..630181469720 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -2099,7 +2099,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
>  	return 0;
>  }
>  
> -static struct pci_epf_ops epf_ntb_ops = {
> +static const struct pci_epf_ops epf_ntb_ops = {
>  	.bind	= epf_ntb_bind,
>  	.unbind	= epf_ntb_unbind,
>  	.add_cfs = epf_ntb_add_cfs,
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
