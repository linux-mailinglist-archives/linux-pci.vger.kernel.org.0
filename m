Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6940660F58D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 12:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiJ0Kmv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 06:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiJ0Kmu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 06:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774B17DF61;
        Thu, 27 Oct 2022 03:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D8DF62285;
        Thu, 27 Oct 2022 10:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BF3C433B5;
        Thu, 27 Oct 2022 10:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666867367;
        bh=waQiYVNsE5pL9GEJ8DPj4IjUhC/thrnPEqbg9j/HH+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dr+hSVG7jsB3+OXqWl9ONo9Q5EyopeKuPaUAtDpoJnI+yfv4h/m9YZ/ukYgOQn/Ek
         OWg8cR3ZhtE1RXCHqgBvKUVY8ewYQPPENZtdHJNCPK40TKxXXograuRpwyiL6URFQR
         J0749ItTFYEx3KaUrBbnuLKRbtnuFNTvrBy60XLjXmMvmA3EAqEWl5b5qQiUsEDfri
         e8A6CHi/r46/NvOirAP67mCsYe3GI4NeScqTBGEpT++USZTvVVIgpg2Un54LGtgH4B
         3kBiXuuLqhSOmTYs37P4IShctdLSy7SmQBvyEUIBwNUIJ3hzbc4Ni+fmxz/6pvuWWz
         bkXwntu8KoVCQ==
Date:   Thu, 27 Oct 2022 12:42:40 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     imx@lists.linux.dev, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
        "open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 6/6] PCI: endpoint: pci-epf-vntb: fix sparse build
 warning
Message-ID: <Y1pgoPAH/BZ46gif@lpieralisi>
References: <20221007191326.193079-1-Frank.Li@nxp.com>
 <20221007191326.193079-8-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007191326.193079-8-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 07, 2022 at 03:13:26PM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> Using  epf_db[i] instead of readl() because epf_db is located in local
> memory and allocated by dma_alloc_coherent().
> 
> Sparse build warning when there are not __iomem at readl().
> Added __iomem force type convert in vntb_epf_peer_spad_read\write()
> and vntb_epf_spad_read\write(). This require strong order at read and
> write.

This commit log is unreadable sorry and this patch fixes multiple things
and even rearrange local variables in a way that is completely
unrelated to the patch aim itself.

If you are fixing sparse warning reports the warnings and fix them
one by one.

Could you please pay attention to these details ? I don't have time
to do it for you, sorry.

Thanks,
Lorenzo

> Signed-off-by: Frank Li <frank.li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 27 +++++++++----------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 54616281da9e..9f1ec6788e51 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -136,7 +136,7 @@ struct epf_ntb {
>  
>  	struct epf_ntb_ctrl *reg;
>  
> -	void __iomem *epf_db;
> +	u32 *epf_db;
>  
>  	phys_addr_t vpci_mw_phy[MAX_MW];
>  	void __iomem *vpci_mw_addr[MAX_MW];
> @@ -257,12 +257,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
>  
>  	for (i = 1; i < ntb->db_count; i++) {
> -		if (readl(ntb->epf_db + i * sizeof(u32))) {
> -			if (readl(ntb->epf_db + i * sizeof(u32)))
> -				ntb->db |= 1 << (i - 1);
> -
> +		if (ntb->epf_db[i]) {
>  			ntb_db_event(&ntb->ntb, i);
> -			writel(0, ntb->epf_db + i * sizeof(u32));
> +			ntb->epf_db[i] = 0;
>  		}
>  	}
>  
> @@ -529,13 +526,15 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
> -	u32 align;
>  	struct device *dev = &ntb->epf->dev;
> -	int ret;
>  	struct pci_epf_bar *epf_bar;
> -	void __iomem *mw_addr;
>  	enum pci_barno barno;
> -	size_t size = sizeof(u32) * ntb->db_count;
> +	void *mw_addr;
> +	size_t size;
> +	u32 align;
> +	int ret;
> +
> +	size = sizeof(u32) * ntb->db_count;
>  
>  	epc_features = pci_epc_get_features(ntb->epf->epc,
>  					    ntb->epf->func_no,
> @@ -1123,7 +1122,7 @@ static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>  	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
>  	u32 val;
> -	void __iomem *base = ntb->reg;
> +	void __iomem *base = (void __iomem *)ntb->reg;
>  
>  	val = readl(base + off + ct + idx * sizeof(u32));
>  	return val;
> @@ -1134,7 +1133,7 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>  	struct epf_ntb_ctrl *ctrl = ntb->reg;
>  	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
> -	void __iomem *base = ntb->reg;
> +	void __iomem *base = (void __iomem *)ntb->reg;
>  
>  	writel(val, base + off + ct + idx * sizeof(u32));
>  	return 0;
> @@ -1145,7 +1144,7 @@ static u32 vntb_epf_peer_spad_read(struct ntb_dev *ndev, int pidx, int idx)
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>  	struct epf_ntb_ctrl *ctrl = ntb->reg;
>  	int off = ctrl->spad_offset;
> -	void __iomem *base = ntb->reg;
> +	void __iomem *base = (void __iomem *)ntb->reg;
>  	u32 val;
>  
>  	val = readl(base + off + idx * sizeof(u32));
> @@ -1157,7 +1156,7 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>  	struct epf_ntb_ctrl *ctrl = ntb->reg;
>  	int off = ctrl->spad_offset;
> -	void __iomem *base = ntb->reg;
> +	void __iomem *base = (void __iomem *)ntb->reg;
>  
>  	writel(val, base + off + idx * sizeof(u32));
>  	return 0;
> -- 
> 2.34.1
> 
