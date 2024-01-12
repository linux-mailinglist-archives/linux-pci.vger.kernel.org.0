Return-Path: <linux-pci+bounces-2074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFED82B85F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 01:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D9D1C23695
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793977F1;
	Fri, 12 Jan 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p7YY3Zqe"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB065E;
	Fri, 12 Jan 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Swpd3nH8sLH2WwkLic9FH3brfxhtOQSnmjDNZwdYIyk=; b=p7YY3ZqeCVnn8ILbz2A+vf0mtE
	n2fU1ANIUkpR1Hbm1/QvjJbx4onHZuQ1ow9SfR4ERzi/ErDUtKI4ix5OL3547nYkPedlyDreC9McJ
	8/3zHPubRh3AgNQHMfs2jrLvSlWgEA7jFYmkD6brCTInoN+4vHXk4SJT/cxKRgw6dF2BxgCJCPvUm
	eUI6mMgvO5Hk3SFib+/fROJzA/wSNC6UhNRrV77EK4orcx0S1YyicYn4WxyTE+AFeFHNRa0/lYcWy
	RU1g+JnKwQ8hGcNhrBwurE8opBBLK2kyKZ/gVxygjaJrX1/4Ot3zU1RL7xSL5m629p7Mlr+4pn2Kc
	oEsMZlnA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rO4yJ-001Vbn-1r;
	Fri, 12 Jan 2024 00:00:27 +0000
Message-ID: <86b381d4-17a9-4b68-bd53-aae69ea7ddba@infradead.org>
Date: Thu, 11 Jan 2024 16:00:27 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix kernel-doc issues
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sui Jingfeng <suijingfeng@loongson.cn>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240111162850.2177655-1-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240111162850.2177655-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/11/24 08:28, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix kernel-doc issues reported by
> "find include -name \*pci\* | xargs scripts/kernel-doc -none":
> 
>   include/linux/pci.h:731: warning: Function parameter or member 'pdev' not described in 'pci_is_vga'
>   include/linux/pci-epc.h:154: warning: Function parameter or member 'list_lock' not described in 'pci_epc'
>   include/linux/pci-epf.h:83: warning: expecting prototype for struct pci_epf_event_ops. Prototype was for struct pci_epc_event_ops instead
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/pci-epc.h | 2 +-
>  include/linux/pci-epf.h | 2 +-
>  include/linux/pci.h     | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 5cb694031072..bfe41b03b70c 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -122,7 +122,7 @@ struct pci_epc_mem {
>   * struct pci_epc - represents the PCI EPC device
>   * @dev: PCI EPC device
>   * @pci_epf: list of endpoint functions present in this EPC device
> - * list_lock: Mutex for protecting pci_epf list
> + * @list_lock: Mutex for protecting pci_epf list
>   * @ops: function pointers for performing endpoint operations
>   * @windows: array of address space of the endpoint controller
>   * @mem: first window of the endpoint controller, which corresponds to
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 3f44b6aec477..92d0b71d33d7 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -68,7 +68,7 @@ struct pci_epf_ops {
>  };
>  
>  /**
> - * struct pci_epf_event_ops - Callbacks for capturing the EPC events
> + * struct pci_epc_event_ops - Callbacks for capturing the EPC events
>   * @core_init: Callback for the EPC initialization complete event
>   * @link_up: Callback for the EPC link up event
>   * @link_down: Callback for the EPC link down event
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1a89dc66f89a..eb45087d7e00 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -715,6 +715,7 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
>  
>  /**
>   * pci_is_vga - check if the PCI device is a VGA device
> + * @pdev: PCI device
>   *
>   * The PCI Code and ID Assignment spec, r1.15, secs 1.4 and 1.1, define
>   * VGA Base Class and Sub-Classes:

-- 
#Randy

