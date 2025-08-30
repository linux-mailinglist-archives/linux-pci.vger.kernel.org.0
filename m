Return-Path: <linux-pci+bounces-35187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD60B3CC2F
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9890018933DB
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A486248F62;
	Sat, 30 Aug 2025 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcVdAa8k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40216DEB1;
	Sat, 30 Aug 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756568690; cv=none; b=TN7UO7Vv/Ew/yO5J3sbivmmgdWvVaV+QBkwZyBRA4gIdSk6ra1kwyDqHneDiVAf1FuDXwcpKo75vhxrH3yCMhGW8fRf/tOCQSO8+9Ck6GyaJsnvoQfqK4YVhsTYwv0ViLktvCWd6/P0pdgE84m0GWuyOIegdiUMCdrtHCsSWNnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756568690; c=relaxed/simple;
	bh=upWvzEwUjdMOVCbvYz/tRccUO5GEwW+mcBy+qoXGoIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFjpqIMJUVpXoggmgy+jsjQF/Tf5dvdOkDBTZ4vraMOdE5VoCxXYuaDa31c12YpP1lSEee1exibQ44kjLFjkrKx7729jpnOiS6am/W/34yuWTjyR9BIsMgiAmgIa9mL0aApuE77fEuwwIkqj8ilqmRxmdOdsJgiVCNfG2igOnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcVdAa8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5A8C4CEEB;
	Sat, 30 Aug 2025 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756568690;
	bh=upWvzEwUjdMOVCbvYz/tRccUO5GEwW+mcBy+qoXGoIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcVdAa8kWXt0ZQVP5kq8pfxnbumxysM4FyT9osJ4MCbeB0QC+j7/c9avCQ5TDO0in
	 3lcx70wmcSHl6J85RHMtHF79CGntyBi9C0guFDN/hGYV/Jv5/lAPTknjUdWCwffq19
	 J0b6/cGRaLQ2IExJRgk6mpUsrhxCxRax7PKI8n3B6IPUd83snbdg/IC8/v/l6KzXkv
	 mB2L0GFwGIHhlGyPlSCyo0St72CGWU6AbFa1mxZLOgTqOERrx/94LbGPRLPjT2dKbP
	 Zc4MPrmGxLz8FuOwvrpirhD2w6OuVwmi6uFUwGZtFOL6V9CpT35XiXRrzQ0wBYhc3p
	 9GzrBaeweEb5w==
Date: Sat, 30 Aug 2025 21:14:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH 2/2] PCI: endpoint: pci-epf-vntb: Add MSI doorbell support
Message-ID: <gkgdzbbq2ykim4gfrkw5qnimdyyxcs3efkt3lot3bh7jmi57he@wxsxp3m3eg6k>
References: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
 <20250815-vntb_msi_doorbell-v1-2-32df6c4bf96c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815-vntb_msi_doorbell-v1-2-32df6c4bf96c@nxp.com>

On Fri, Aug 15, 2025 at 06:20:54PM GMT, Frank Li wrote:
> Add MSI doorbell support to reduce latency between PCI host and EP.
> 
> Before this change:
>   ping 169.254.172.137
>   64 bytes from 169.254.172.137: icmp_seq=1 ttl=64 time=0.575 ms
>   64 bytes from 169.254.172.137: icmp_seq=2 ttl=64 time=1.80 ms
>   64 bytes from 169.254.172.137: icmp_seq=3 ttl=64 time=8.19 ms
>   64 bytes from 169.254.172.137: icmp_seq=4 ttl=64 time=2.00 ms
> 
> After this change:
>   ping 169.254.144.71
>   64 bytes from 169.254.144.71: icmp_seq=1 ttl=64 time=0.215 ms
>   64 bytes from 169.254.144.71: icmp_seq=2 ttl=64 time=0.456 ms
>   64 bytes from 169.254.144.71: icmp_seq=3 ttl=64 time=0.448 ms
> 
> Change u64 db to atomic_64 because difference doorbell may happen at the
> same time.
> 

Only the atomicity of db variable is enough?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
>  1 file changed, 136 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 83e9ab10f9c4fc2b485d5463faa2172500f12999..1c586205835fe9c7c5352e74819bccb4ece84438 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -36,11 +36,13 @@
>   * PCIe Root Port                        PCI EP
>   */
>  
> +#include <linux/atomic.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  
> +#include <linux/pci-ep-msi.h>
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
>  #include <linux/ntb.h>
> @@ -126,12 +128,13 @@ struct epf_ntb {
>  	u32 db_count;
>  	u32 spad_count;
>  	u64 mws_size[MAX_MW];
> -	u64 db;
> +	atomic64_t db;
>  	u32 vbus_number;
>  	u16 vntb_pid;
>  	u16 vntb_vid;
>  
>  	bool linkup;
> +	bool msi_doorbell;
>  	u32 spad_size;
>  
>  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
> @@ -258,9 +261,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  
>  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
>  
> -	for (i = 1; i < ntb->db_count; i++) {
> +	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
>  		if (ntb->epf_db[i]) {
> -			ntb->db |= 1 << (i - 1);
> +			atomic64_or(1 << (i - 1), &ntb->db);
>  			ntb_db_event(&ntb->ntb, i);
>  			ntb->epf_db[i] = 0;
>  		}
> @@ -319,7 +322,24 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  
>  reset_handler:
>  	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
> -			   msecs_to_jiffies(5));
> +			   ntb->msi_doorbell ? msecs_to_jiffies(500) : msecs_to_jiffies(5));
> +}
> +
> +static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
> +{
> +	struct epf_ntb *ntb = data;
> +	int i = 0;
> +
> +	for (i = 1; i < ntb->db_count; i++)
> +		if (irq == ntb->epf->db_msg[i].virq) {
> +			atomic64_or(1 << (i - 1), &ntb->db);
> +			ntb_db_event(&ntb->ntb, i);
> +		}
> +
> +	if (irq == ntb->epf->db_msg[0].virq)
> +		queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler, 0);
> +
> +	return IRQ_HANDLED;
>  }
>  
>  /**
> @@ -500,6 +520,90 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  	return 0;
>  }
>  
> +static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> +					    struct pci_epf_bar *db_bar,
> +					    const struct pci_epc_features *epc_features,
> +					    enum pci_barno barno)
> +{
> +	struct pci_epf *epf = ntb->epf;
> +	dma_addr_t low, high;
> +	struct msi_msg *msg;
> +	size_t sz;
> +	int ret;
> +	int i;
> +
> +	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ntb->db_count; i++) {
> +		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> +				  0, "vntb_db", ntb);
> +
> +		if (ret) {
> +			dev_err(&epf->dev,
> +				"Failed to request doorbell IRQ: %d\n",
> +				epf->db_msg[i].virq);
> +			goto err_request_irq;
> +		}
> +	}
> +
> +	msg = &epf->db_msg[0].msg;
> +
> +	high = 0;
> +	low = (u64)msg->address_hi << 32 | msg->address_lo;

Can you remind me when the 'address_{hi/lo}' pairs are set?

Rest looks OK to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

