Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2976855DE84
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiF0U2D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 16:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241275AbiF0U1I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 16:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539D31C92B;
        Mon, 27 Jun 2022 13:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0C6261760;
        Mon, 27 Jun 2022 20:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DFCC34115;
        Mon, 27 Jun 2022 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361626;
        bh=ZrO7ZxD6CZrzBEiHbXQNlyeA1JpOhkqhlJ6JhbdaKkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nGKopElfco9srP0aolIuSPoGiOTISZ5JXFwJfpg0QagqihMPf7SfD3K/+thtHutvb
         K4enZrewIOyHm8fCstsRhRhcq277bFqmgEYy/vCoqZ4VnseN/yvtsDwxqqqef2bolr
         3Km4lTx4Ulmx6JF/ul1lbbafomlEy+N1qI4xi8Ht/CdogfQnZnbu8md+iZMUCnHHO+
         ndecuYff/67fCKBUKlaprGW2zgt5X0jHONvvOR3zoIV2PutPtQqmksA7R1rvdoyGnG
         FpFHzNtU5B9/97tBtMQccdhqyT+jwdU/kN6l/BHwsJst8Nle234gsorNQ+qcPjQb51
         wCw+UZuJBdpZg==
Date:   Mon, 27 Jun 2022 15:27:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Jon Mason <jdmason@kudzu.us>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Frank.Li@nxp.com, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com
Subject: Re: [PATCH -next v2] PCI: endpoint: pci-epf-vntb: fix error handle
 in epf_ntb_mw_bar_init()
Message-ID: <20220627202704.GA1775928@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625021516.431473-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 25, 2022 at 10:15:16AM +0800, Yang Yingliang wrote:
> In error case of epf_ntb_mw_bar_init(), memory window BARs should be
> cleared, so add 'num_mws' parameter in epf_ntb_mw_bar_clear() and
> calling it in error path to clear the BARs. Also add missing error
> code when pci_epc_mem_alloc_addr() fails.

Another one for Jon, since ff32fac00d97 appeared in -next via his
tree

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ff32fac00d97

> Fixes: ff32fac00d97 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>   add error label err_set_bar and move pci_epc_clear_bar() to it
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 20 ++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ebf7e243eefa..ee9fee167d48 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -567,6 +567,8 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	return -1;
>  }
>  
> +static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
> +
>  /**
>   * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
>   *   allocated in peers outbound address space
> @@ -625,13 +627,21 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  							      &ntb->vpci_mw_phy[i],
>  							      size);
>  		if (!ntb->vpci_mw_addr[i]) {
> +			ret = -ENOMEM;
>  			dev_err(dev, "Failed to allocate source address\n");
> -			goto err_alloc_mem;
> +			goto err_set_bar;
>  		}
>  	}
>  
>  	return ret;
> +
> +err_set_bar:
> +	pci_epc_clear_bar(ntb->epf->epc,
> +			  ntb->epf->func_no,
> +			  ntb->epf->vfunc_no,
> +			  &ntb->epf->bar[barno]);
>  err_alloc_mem:
> +	epf_ntb_mw_bar_clear(ntb, i);
>  	return ret;
>  }
>  
> @@ -640,12 +650,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>   * @ntb: NTB device that facilitates communication between HOST and vHOST
>   *
>   */
> -static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb)
> +static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  {
>  	enum pci_barno barno;
>  	int i;
>  
> -	for (i = 0; i < ntb->num_mws; i++) {
> +	for (i = 0; i < num_mws; i++) {
>  		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
>  		pci_epc_clear_bar(ntb->epf->epc,
>  				  ntb->epf->func_no,
> @@ -774,7 +784,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  	return 0;
>  
>  err_write_header:
> -	epf_ntb_mw_bar_clear(ntb);
> +	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  err_mw_bar_init:
>  	epf_ntb_db_bar_clear(ntb);
>  err_db_bar_init:
> @@ -794,7 +804,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
>  {
>  	epf_ntb_db_bar_clear(ntb);
> -	epf_ntb_mw_bar_clear(ntb);
> +	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  }
>  
>  #define EPF_NTB_R(_name)						\
> -- 
> 2.25.1
> 
