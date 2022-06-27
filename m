Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22FA55D9D7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiF0U3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbiF0U3F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 16:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBBD110F;
        Mon, 27 Jun 2022 13:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE0B36176A;
        Mon, 27 Jun 2022 20:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6C5C34115;
        Mon, 27 Jun 2022 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361740;
        bh=nMxs8Nw/BcSltBccXR04SvWCkdWBXpnOIAzxfKoZJu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vH/JVG4fH1kNDyOgKtfw+e+iM5yy4rmJr6ULbnYzduzZRfHOBlPJgAm1t2cZyFHSC
         dQLlfz+Irh+rPvNsWocB9kieI6qgfW3Fzbn7CSERTvFMGVviySnzZnFtEosPMh7Nuf
         dW2HEuHSk1lmR10CSi3WEMDXpCwK+dHzQ+dizwNFnNCg/YRXOpH7Ot8tnhHLPDyJ+7
         izr3OIyxJNMvrvmAZfec93O4pTXRAvNg0PcWuWYw93Al9ncaEfKI4iRR8sziTzEs77
         7Gp94ch+pXs45+UJeMTFeTbfMJW65OJotb2M2t1l6OoLn5A48Rt720r2G6uEE5qBMw
         7yxHL76LT+H0g==
Date:   Mon, 27 Jun 2022 15:28:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Jon Mason <jdmason@kudzu.us>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] NTB: EPF: set pointer addr to null using NULL
 rather than 0
Message-ID: <20220627202858.GA1776067@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623165709.77229-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 05:57:09PM +0100, Colin Ian King wrote:
> The pointer addr is being set to null using 0. Use NULL instead.
> 
> Cleans up sparse warning:
> warning: Using plain integer as NULL pointer

Another one for Jon; fixes this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ff32fac00d97

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ebf7e243eefa..fb31c868af6a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -605,7 +605,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  
>  		ntb->epf->bar[barno].barno = barno;
>  		ntb->epf->bar[barno].size = size;
> -		ntb->epf->bar[barno].addr = 0;
> +		ntb->epf->bar[barno].addr = NULL;
>  		ntb->epf->bar[barno].phys_addr = 0;
>  		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
>  				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> -- 
> 2.35.3
> 
