Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959704BAC2B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 22:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiBQWAB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 17:00:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiBQWAA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 17:00:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7015DDF2
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 13:59:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36827616C1
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 21:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AF2C340E8;
        Thu, 17 Feb 2022 21:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645135183;
        bh=Wkx9jcTPnRu97eYLAbtJCt3yw1hVr91W+kbL2BoIFKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VsBw31TxytllSUFsJGahargWj83rU9mDrYW1wYSipE7DXria5JpTT/H92UGnHdKPI
         5UH5fGpIRLBd7KHfRNBnfnANCblwGY9nQcJDSeRiZtANqJ9eLDQwpLDJV4O3EJqGYL
         hggq2AvSGqP3sehDrTKRDE81iCV99Q4fJH3s+8YlwqFl3L8rQaDUfepNEjrIIWryYc
         OeGZrvBBOXFpNXB1KdxT+wXvYNIrLPMUMETmW7uSwjV9kgYMtaxYx7M1O1KBph+uMk
         zR8U8rwCk4KTu2xyphqfx9i+KdBVLxghcZ+aYSi26xbpOlkvTm6atLdzXToTdCetqf
         Rua4EaZ948V5Q==
Date:   Thu, 17 Feb 2022 15:59:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     linux-pci@vger.kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lznuaa@gmail.com,
        hongxing.zhu@nxp.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [RFC PATCH 2/4] NTB: epf: Added more flexible memory map method
Message-ID: <20220217215942.GA308686@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215053844.7119-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jon, Dave, Allen, linux-ntb, since you need at least an ack from
the NTB folks; beginning of thread:
https://lore.kernel.org/r/20220215053844.7119-1-Frank.Li@nxp.com]

In subject, s/Added/Add/.

But I don't think it's quite right yet, because this doesn't actually add
any functions.

On Mon, Feb 14, 2022 at 11:38:42PM -0600, Frank Li wrote:
> Supported below memory map method
> 
> bar 0: config and spad data
> bar 2: door bell
> bar 4: memory map windows

s/bar/BAR/
s/spad/?/ (I don't know what this is)

Presumably these BAR numbers apply to some specific hardware?  This
probably should specify *which* hardware.

Please make the commit log say what this patch does.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 48 ++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index b019755e4e21b..3ece49cb18ffa 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -45,7 +45,6 @@
>  
>  #define NTB_EPF_MIN_DB_COUNT	3
>  #define NTB_EPF_MAX_DB_COUNT	31
> -#define NTB_EPF_MW_OFFSET	2
>  
>  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
>  
> @@ -67,6 +66,7 @@ struct ntb_epf_dev {
>  	enum pci_barno ctrl_reg_bar;
>  	enum pci_barno peer_spad_reg_bar;
>  	enum pci_barno db_reg_bar;
> +	enum pci_barno mw_bar;
>  
>  	unsigned int mw_count;
>  	unsigned int spad_count;
> @@ -92,6 +92,8 @@ struct ntb_epf_data {
>  	enum pci_barno peer_spad_reg_bar;
>  	/* BAR that contains Doorbell region and Memory window '1' */
>  	enum pci_barno db_reg_bar;
> +	/* BAR that contains memory windows*/
> +	enum pci_barno mw_bar;
>  };
>  
>  static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
> @@ -411,7 +413,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  		return -EINVAL;
>  	}
>  
> -	bar = idx + NTB_EPF_MW_OFFSET;
> +	bar = idx + ndev->mw_bar;
>  
>  	mw_size = pci_resource_len(ntb->pdev, bar);
>  
> @@ -453,7 +455,7 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  	if (idx == 0)
>  		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
>  
> -	bar = idx + NTB_EPF_MW_OFFSET;
> +	bar = idx + ndev->mw_bar;
>  
>  	if (base)
>  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> @@ -565,6 +567,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>  			    struct pci_dev *pdev)
>  {
>  	struct device *dev = ndev->dev;
> +	size_t spad_sz, spad_off;
>  	int ret;
>  
>  	pci_set_drvdata(pdev, ndev);
> @@ -599,10 +602,16 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>  		goto err_dma_mask;
>  	}
>  
> -	ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
> -	if (!ndev->peer_spad_reg) {
> -		ret = -EIO;
> -		goto err_dma_mask;
> +	if (ndev->peer_spad_reg_bar) {
> +		ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
> +		if (!ndev->peer_spad_reg) {
> +			ret = -EIO;
> +			goto err_dma_mask;
> +		}
> +	} else {
> +		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
> +		spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> +		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
>  	}
>  
>  	ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
> @@ -657,6 +666,7 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  	enum pci_barno peer_spad_reg_bar = BAR_1;
>  	enum pci_barno ctrl_reg_bar = BAR_0;
>  	enum pci_barno db_reg_bar = BAR_2;
> +	enum pci_barno mw_bar = BAR_2;
>  	struct device *dev = &pdev->dev;
>  	struct ntb_epf_data *data;
>  	struct ntb_epf_dev *ndev;
> @@ -671,17 +681,16 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  
>  	data = (struct ntb_epf_data *)id->driver_data;
>  	if (data) {
> -		if (data->peer_spad_reg_bar)
> -			peer_spad_reg_bar = data->peer_spad_reg_bar;
> -		if (data->ctrl_reg_bar)
> -			ctrl_reg_bar = data->ctrl_reg_bar;
> -		if (data->db_reg_bar)
> -			db_reg_bar = data->db_reg_bar;
> +		peer_spad_reg_bar = data->peer_spad_reg_bar;
> +		ctrl_reg_bar = data->ctrl_reg_bar;
> +		db_reg_bar = data->db_reg_bar;
> +		mw_bar = data->mw_bar;
>  	}
>  
>  	ndev->peer_spad_reg_bar = peer_spad_reg_bar;
>  	ndev->ctrl_reg_bar = ctrl_reg_bar;
>  	ndev->db_reg_bar = db_reg_bar;
> +	ndev->mw_bar = mw_bar;
>  	ndev->dev = dev;
>  
>  	ntb_epf_init_struct(ndev, pdev);
> @@ -729,6 +738,14 @@ static const struct ntb_epf_data j721e_data = {
>  	.ctrl_reg_bar = BAR_0,
>  	.peer_spad_reg_bar = BAR_1,
>  	.db_reg_bar = BAR_2,
> +	.mw_bar = BAR_2,
> +};
> +
> +static const struct ntb_epf_data mx8_data = {
> +	.ctrl_reg_bar = BAR_0,
> +	.peer_spad_reg_bar = BAR_0,
> +	.db_reg_bar = BAR_2,
> +	.mw_bar = BAR_4,
>  };
>  
>  static const struct pci_device_id ntb_epf_pci_tbl[] = {
> @@ -737,6 +754,11 @@ static const struct pci_device_id ntb_epf_pci_tbl[] = {
>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
>  		.driver_data = (kernel_ulong_t)&j721e_data,
>  	},
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
> +		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> +		.driver_data = (kernel_ulong_t)&mx8_data,
> +	},
>  	{ },
>  };
>  
> -- 
> 2.24.0.rc1
> 
