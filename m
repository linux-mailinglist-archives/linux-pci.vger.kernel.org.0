Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABF9575365
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiGNQue (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiGNQuS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 12:50:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895976C112
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 09:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F52FB8273B
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 16:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D61C34114;
        Thu, 14 Jul 2022 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657817248;
        bh=vH585PKw1ShdkYDpuWBM8Zq7DWdstUT0sjtX8lGBknc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QfHV4/JKfNX+wWpi4A5rWhEwT1xddKc1YDMRsVaAPC9R1LecW9urj0ZMkDRmAQ5CI
         LHcNdEeMtQgNVTZeEtqgh3sHabKskL4oJcfnL5gWBaL8Ugpc3Wd0lweViyxzIj5DaY
         H7lb1Sipd0G3s6xsDEtPs+U6vzynWZPZNxO7w3foUig0IHfXB3va222jvJjeVUjMxM
         dmG4r/YbGHipEEHuYm0+byMSBCUKP63erT/B89qLXw84SdWIN8F4+v3fLV84CLozUi
         22EC5Fth8Dc1dVZxMq9j/moNCqXAY6CtkrNTHqeqdNUTY+61HUAtTvxveDQaZ8mEBw
         DZSH4fTJC6LAg==
Date:   Thu, 14 Jul 2022 11:47:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liang He <windhl@126.com>
Cc:     jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        linmq006@gmail.com
Subject: Re: [PATCH] pci: controller: brcmstb: Move of_node_put() out of 'if'
 in brcm_pcie_probe
Message-ID: <20220714164726.GA1021692@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704065501.275677-1-windhl@126.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 04, 2022 at 02:55:01PM +0800, Liang He wrote:
> Commit 3a87cb8f6a ("Fix refcount leak in brcm_pcie_probe()") adds
> of_node_put() for of_parse_phandle() in fail path but not adds it
> correctly in normal path. We should move the second of_node_put()
> out of the 'if(pci_msi_enabled() && msi_np == pcie->np)'.
> 
> Fixes: 3a87cb8f6a ("Fix refcount leak in brcm_pcie_probe()")
> Co-authored-by: Miaoqian Lin <linmq006@gmail.com>
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  Patched file has been compiled test in next branch.
> 
>  drivers/pci/controller/pcie-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 48a7148376d4..80e19d053e9f 100755
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1413,8 +1413,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  			of_node_put(msi_np);
>  			goto fail;
>  		}
> -		of_node_put(msi_np);
>  	}
> +	of_node_put(msi_np);

Can we just move the of_parse_phandle() and related checking into
brcm_pcie_enable_msi()?  It can return success without doing anything
if !pci_msi_enabled() or msi_np != pcie_np.

If you don't want to do that, please just send a revised version of
3a87cb8f6a72 ("PCI: brcmstb: Fix refcount leak in brcm_pcie_probe()").
That's not upstream yet, and I don't want to clutter the git history
with a fix of a fix.

>  	bridge->ops = pcie->type == BCM7425 ? &brcm_pcie_ops32 : &brcm_pcie_ops;
>  	bridge->sysdata = pcie;
> -- 
> 2.25.1
> 
