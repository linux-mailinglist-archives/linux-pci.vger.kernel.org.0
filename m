Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA2B64C126
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 01:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbiLNA1D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 19:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiLNA0r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 19:26:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53414B1E8;
        Tue, 13 Dec 2022 16:26:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F710B81609;
        Wed, 14 Dec 2022 00:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B43C433EF;
        Wed, 14 Dec 2022 00:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670977603;
        bh=NDgzNzla8xVcW0uTm0lMUqLVpqM6P7lvLIQIDHm7YwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hv51f69k1nOkqwhvVxLbREu63I/O7Y+KIgmKi81hYB/T91GuYo8bAuLiEJUFSQGSM
         dg42kpX9k2E9HlVKit9ZurnhoiUDRyaBB//FB1AbkTEUBSd3y2VWW6wzAXU9AKE3XA
         g9HMVocOgpwn5qzUivFll8Ki+HeILE2cs26K2W3qM6mGWJzp0VMVM6HY80/9Nxh28p
         9rKGd9c/YS7lvKDtl1z/ceTz3kM3UEftxKAc4j2jHs/KV/3E+rgiw7tzZmd4U76+8Z
         /v4kZM7Sytcm5Il+qUxoXcqnQiMlURELN5b4Dwgcj5uJiSxufbTzWwvB71l6OBNUWm
         VNMmGmDCah4Aw==
Date:   Tue, 13 Dec 2022 18:26:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     mani@kernel.org, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        ntb@lists.linux.dev
Subject: Re: [PATCH v16 7/7] PCI: endpoint: pci-epf-vntb: fix sparse build
 warning at ntb->reg
Message-ID: <20221214002642.GA216337@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102141014.1025893-8-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 02, 2022 at 10:10:14AM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
>   pci-epf-vntb.c:1128:33: sparse:     expected void [noderef] __iomem *base
>   pci-epf-vntb.c:1128:33: sparse:     got struct epf_ntb_ctrl *reg
> 
> Add __iomem type convert in vntb_epf_peer_spad_read() and
> vntb_epf_peer_spad_write().

I don't understand all the bits and pieces here, but I'm a little
dubious about adding all these "(void __iomem *)"casts.  There are
very few of them in drivers/pci/, and I doubt this driver is so unique
that it needs them.

> @@ -1121,7 +1121,7 @@ static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>  	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
>  	u32 val;
> -	void __iomem *base = ntb->reg;
> +	void __iomem *base = (void __iomem *)ntb->reg;
>  
>  	val = readl(base + off + ct + idx * sizeof(u32));
>  	return val;
> @@ -1132,7 +1132,7 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>  	struct epf_ntb_ctrl *ctrl = ntb->reg;
>  	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
> -	void __iomem *base = ntb->reg;
> +	void __iomem *base = (void __iomem *)ntb->reg;
>  
>  	writel(val, base + off + ct + idx * sizeof(u32));

These things look gratuitously different to begin with:

  int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
  int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);

They're doing the same thing, and they should do it the same way.

Since db_data[] and db_offset[] are never referenced except to be
initialized to zero, I'm guessing the point of vntb_epf_spad_read()
and vntb_epf_spad_write() is to read/write things in those arrays?

You access other things in ntb->reg directly by dereferencing a
pointer, e.g.,

  ntb->reg->link_status |= LINK_STATUS_UP;
  addr = ntb->reg->addr;
  ctrl->command_status = COMMAND_STATUS_OK;

Why don't you just compute the appropriate *index* and access the
array directly instead of using readl() and writel()?

Bjorn
