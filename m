Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C17F1DCC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 21:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjKTUJG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 15:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjKTUJE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 15:09:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E37E3;
        Mon, 20 Nov 2023 12:09:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79700C433CB;
        Mon, 20 Nov 2023 20:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700510940;
        bh=C/9ul9eMXOVExx3R6EqLciqztWaUgMTk2Itzl0yF/t8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DNfDy1sQLzJ7rgmUjLORvRdkKs7/QzpQxoT14szxbOHF9ZloKkhvWacR3GeeruERu
         PRcW/qohw++OoCImOiTfnQ1n2eskKG3aY2O93kO+3TuUlXQ1DJ3mI02HVVQd7nsrP2
         nxChs4qRXpUd9WBONIE4PDRI+piAHtdr8iaJxzYOk+RZBLoGXewV5mg2txeNLfq5qT
         YfYZzz4zo8/GWGOj5xhI21hP708BG9Efqe89UcJRWoIT9oXOQ32FNAYuk7JUcO+1ii
         nCkQ3gnNwMrn9akFzPQ90TkdOoxcp1wLOAIBkFtXbw7LvKWUMBRevz+6Aw/igv99nU
         wp0HCyQmavQCg==
Date:   Mon, 20 Nov 2023 14:08:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiantao Zhang <water.zhangjiantao@huawei.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, tjoseph@cadence.com,
        zhangjianrong5@huawei.com
Subject: Re: [PATCH] PCI: controller: Fix calculation error of msix pending
 table offset
Message-ID: <20231120200858.GA211414@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531142442.27576-1-water.zhangjiantao@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 31, 2023 at 10:24:42PM +0800, Jiantao Zhang wrote:
> The interrupts already minus 1 in pci_epc_set_msix() according to pcie
> specification. So we must add 1 otherwise data corruption will happen.

I'm not sure what happened to this.

Can you include a citation to the section of the spec, which will help
reviewers?

Have you observed a crash or similar defect that is fixed by this
patch?  If so, a few details would be useful in the commit log to help
people find this fix.

> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
> Signed-off-by: Jianrong Zhang <zhangjianrong5@huawei.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index b8b655d4047e..ff608c46b8ac 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -310,7 +310,7 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
>  
>  	/* Set PBA BAR and offset.  BAR must match MSIX BAR */
>  	reg = cap + PCI_MSIX_PBA;
> -	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
> +	val = (offset + ((interrupts + 1) * PCI_MSIX_ENTRY_SIZE)) | bir;
>  	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
>  
>  	return 0;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f9182f8d552f..3d078ebe2517 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -417,7 +417,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	dw_pcie_writel_dbi(pci, reg, val);
>  
>  	reg = ep_func->msix_cap + func_offset + PCI_MSIX_PBA;
> -	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
> +	val = (offset + ((interrupts + 1) * PCI_MSIX_ENTRY_SIZE)) | bir;
>  	dw_pcie_writel_dbi(pci, reg, val);
>  
>  	dw_pcie_dbi_ro_wr_dis(pci);
> -- 
> 2.17.1
> 
