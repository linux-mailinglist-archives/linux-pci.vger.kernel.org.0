Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB9614A18
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 12:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKAL6K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 07:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiKAL6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 07:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6158D5B;
        Tue,  1 Nov 2022 04:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43B7660B86;
        Tue,  1 Nov 2022 11:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FA8C433C1;
        Tue,  1 Nov 2022 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667303873;
        bh=V66qf+tHQ9219jONjNqAXnIeYGJ0k/AvWJv5NGgdXO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3o+soYW8TSNRRL1jH3HLy3psntlvnYPIIWjoBDww52WX29AtzTsY7Kktl9XYkevC
         EMflBoTerfMkNRRlzq/rBYfPAesC1mHA/1LTbYPTXbeeTLcT/gVLsWNk6m8+K6Vj+p
         Xb2VPat35VaDHanXMo2k+Dk2LIYyd3Y/q6M+4Nalp9c5baiDRRwZdOgaZK9l7V/9Ae
         R649TMv+oR4Z39IbdAfaHBxn+LTtpMarwgdB9OBm9Xw3kpOyQ/6wI0yJxN56JfP8bi
         HAJrq/OywhgQSKbXfEES9IB3/tbUAtVc2/zIsL4ONKrchvW/o71gr+IBDvQXiRORto
         EHm13obiXgjIg==
Date:   Tue, 1 Nov 2022 17:27:32 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: Re: [PATCH v14 3/7] PCI: endpoint: pci-epf-vntb: fix call
 pci_epc_mem_free_addr at err path
Message-ID: <20221101115732.GG54667@thinkpad>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
 <20221028155703.318928-4-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221028155703.318928-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 28, 2022 at 11:56:59AM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> Replace pci_epc_mem_free_addr() with pci_epf_free_space() at error handle
> path to match pci_epf_alloc_space().
> 
> Signed-off-by: Frank Li <frank.li@nxp.com>

If this is a fix, then Fixes tag needs to be included.

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 1863006cc36c..191924a83454 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -571,7 +571,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	return ret;
>  
>  err_alloc_peer_mem:
> -	pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
> +	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
>  	return -1;
>  }
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
