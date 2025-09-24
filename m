Return-Path: <linux-pci+bounces-36885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B9B9B74E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 20:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C93179186
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6766D23A98E;
	Wed, 24 Sep 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFAm77gf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CA8834;
	Wed, 24 Sep 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738157; cv=none; b=rbXSLWMCmjBwsJOxn8kvp8RKEmH471zXg3ll+r5DgfH3Y7QAZhTyGsddI+mFc27ShhNGMCzTtIWH7XSF0fB4FlqX9J08azAKSKT6q7xZ7rse6UKn/xYreJdM7ajZ9IkXJX/oLm1fpUvkBz+/kauYQc9vgqaoqTsSlidS9pmWQVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738157; c=relaxed/simple;
	bh=2b/LWMnsO2J1FjXmPze+F7AJ0aqzSAOQ/28PhZ3Io24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwLBiLXMEwkZcdcLbk5JTDNt07aoStWRpQhK6GnpTqnEstlmylaWjC867MQYxNYpZSf28cxeSeA/fxbq/S51vTEPXMUYtUg/Bf+N1D6h/z9hve3kYp/gh5Os6yRK8qMLIJTDSqXhcOA7PMmhrZCuiVNnHoqky4LLIs5+jyIVXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFAm77gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BCBC4CEE7;
	Wed, 24 Sep 2025 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758738156;
	bh=2b/LWMnsO2J1FjXmPze+F7AJ0aqzSAOQ/28PhZ3Io24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFAm77gf73wgLpMVHWWCMk1Eq7gfUsDnVg7Cg6HNjaHtFQaUwnyBndbrldxgPVqHQ
	 ZzGDB3+WS/WBRZNIGOrooGH+M4D0JksDsvTZn0myHKjhCmJsO4qZDvkh49mIdjh6gX
	 qpa48IV7v4Mk+DiPkbSb1pUkv+QL4bHp+J2Xnar71V+f8nezoSpqtwJje8jByvb50N
	 nYo03Zr1f5Gw+V+uCZDODovjg7bz+6BmpaxBhmlBi3A7au1+XEt2s6bDWqE5QPA6LZ
	 a9a/j4de2f6dQNFDjaLk8nF/s4HsrEccLcf9GzEVwD7W/tBPJEDMBJlmMLa12b7mWg
	 YcDgGvJl/wfBg==
Date: Wed, 24 Sep 2025 23:52:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Add MSI doorbell
 support
Message-ID: <ejhs6fb2nmfhnjswhrvd7iwyddwvvr5nv6bu7dt4aypbiecyfb@wza667q2x4qp>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
 <20250915-vntb_msi_doorbell-v2-3-ca71605e3444@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915-vntb_msi_doorbell-v2-3-ca71605e3444@nxp.com>

On Mon, Sep 15, 2025 at 06:22:46PM -0400, Frank Li wrote:
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
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - update api pci_epf_set_inbound_space
> - atomic_64 should be enough, which just record doorbell events, which is
> similar with W1C irq status register.
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
>  1 file changed, 136 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 83e9ab10f9c4fc2b485d5463faa2172500f12999..06c13f26db1c6e55d23769e98e2cfd80da693a20 100644
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

So doorbell 0 is supposed to trigger the command handler? Is it documented
somewhere?

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
> +
> +	for (i = 0; i < ntb->db_count; i++) {
> +		struct msi_msg *msg = &epf->db_msg[i].msg;
> +		dma_addr_t addr = (u64)msg->address_hi << 32 | msg->address_lo;
> +
> +		low = min(low, addr);
> +		high = max(high, addr);
> +	}
> +
> +	sz = high - low + sizeof(u32);
> +
> +	ret = pci_epf_set_inbound_space(epf, sz, barno,
> +					epc_features, 0, low);

Should this new API be used in pci-epf-test also?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

