Return-Path: <linux-pci+bounces-40337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2894C3500F
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 11:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B963467B41
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56F630ACF4;
	Wed,  5 Nov 2025 09:58:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1C30AAA6
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336718; cv=none; b=SXLlEBfEa3plhY5dG50i4JzdFuzpPzN0APAiUKLuDEnSk2GPX6B2AUZFv++AmqhfqGsQWSOzCFA/vi+ZKougOo4ZcX8b16X/IDOaj8ETVuro9dQe9jdsMnHKTBPmqMtex+TNrxvq7i15pRCt8mFs27ZBdlBR9ERtLQEvEPU6QmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336718; c=relaxed/simple;
	bh=xhNdJyN7AZiwLi4Z1ohVMtL5ge8wLkv5mOX4hdS8AGc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIbwKRo9u4vmjmZGh86VSB+m6ALeNa/TUAbnRiCQoDaBGZWW6aZ5uzWg0ZRtvQfevMPBDH4qiMB3u1jM3FXaiEqfuyqR/qYT9eIzcNau/WAwjEKa2ba1A2UPjJTExfNytIzZRMxovvEnmSAjl7hI6Jt5pV6u1q4SHh9a9wEU7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1gfB0Hblz6HJWQ;
	Wed,  5 Nov 2025 17:54:42 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id F3DBD1400E8;
	Wed,  5 Nov 2025 17:58:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 09:58:33 +0000
Date: Wed, 5 Nov 2025 09:58:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>, Arto Merilainen <amerilainen@nvidia.com>
Subject: Re: [PATCH 2/6] PCI/IDE: Add Address Association Register setup for
 downstream MMIO
Message-ID: <20251105095832.00000871@huawei.com>
In-Reply-To: <20251105040055.2832866-3-dan.j.williams@intel.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
	<20251105040055.2832866-3-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue,  4 Nov 2025 20:00:51 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> The address ranges for downstream Address Association Registers need to
> cover memory addresses for all functions (PFs/VFs/downstream devices)
> managed by a Device Security Manager (DSM). The proposed solution is get
> the memory (32-bit only) range and prefetchable-memory (64-bit capable)
> range from the immediate ancestor downstream port (either the direct-attach
> RP or deepest switch port when switch attached).
> 
> Similar to RID association, address associations will be set by default if
> hardware sets 'Number of Address Association Register Blocks' in the
> 'Selective IDE Stream Capability Register' to a non-zero value. TSM drivers
> can opt-out of the settings by zero'ing out unwanted / unsupported address
> ranges. E.g. TDX Connect only supports prefetachable (64-bit capable)
> memory ranges for the Address Association setting.
> 
> If the immediate downstream port provides both a memory range and
> prefetchable-memory range, but the IDE partner port only provides 1 Address
> Association Register block then the TSM driver can pick which range to
> associate, or let the PCI core prioritize memory.
> 
> Note, the Address Association Register setup for upstream requests is still
> uncertain so is not included.
> 
> Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
> Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/pci-ide.h |  27 ++++++++++
>  include/linux/pci.h     |   5 ++
>  drivers/pci/ide.c       | 115 ++++++++++++++++++++++++++++++++++++----
>  3 files changed, 138 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index d0f10f3c89fc..55283c8490e4 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -28,6 +28,9 @@ enum pci_ide_partner_select {
>   * @rid_start: Partner Port Requester ID range start
>   * @rid_end: Partner Port Requester ID range end
>   * @stream_index: Selective IDE Stream Register Block selection
> + * @mem_assoc: PCI bus memory address association for targeting peer partner

The text above about TDX only support prefetchable to me suggestions this
is optional so should be marked so like pref_assoc?

> + * @pref_assoc: (optional) PCI bus prefetchable memory address association for
> + *		targeting peer partner
>   * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
>   *		    address and RID association registers
>   * @setup: flag to track whether to run pci_ide_stream_teardown() for this
> @@ -38,11 +41,35 @@ struct pci_ide_partner {
>  	u16 rid_start;
>  	u16 rid_end;
>  	u8 stream_index;
> +	struct pci_bus_region mem_assoc;
> +	struct pci_bus_region pref_assoc;
>  	unsigned int default_stream:1;
>  	unsigned int setup:1;
>  	unsigned int enable:1;
>  };


> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index da5b1acccbb4..d7fc741f3a26 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c


> @@ -385,6 +408,61 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
>  }
>  
> +#define SEL_ADDR1_LOWER GENMASK(31, 20)
> +#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
> +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)			\
> +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |		\
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,		\
> +		    FIELD_GET(SEL_ADDR1_LOWER, (base))) |	\
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,		\
> +		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))

Whilst complex, if it is only going to get one use, I'd just put the
complexity inline.  If it's getting lots of use in later patches then
fair enough having this macro.

> +
> +static void mem_assoc_to_regs(struct pci_bus_region *region,
> +			      struct pci_ide_regs *regs, int idx)
> +{
> +	regs->addr[idx].assoc1 =
> +		PREP_PCI_IDE_SEL_ADDR1(region->start, region->end);
> +	regs->addr[idx].assoc2 = FIELD_GET(SEL_ADDR_UPPER, region->end);
> +	regs->addr[idx].assoc3 = FIELD_GET(SEL_ADDR_UPPER, region->start);
> +}

>  /**
>   * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
>   * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> @@ -398,22 +476,34 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
>  void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
>  {
>  	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	struct pci_ide_regs regs;
>  	int pos;
> -	u32 val;
>  
>  	if (!settings)
>  		return;
>  
> +	pci_ide_stream_to_regs(pdev, ide, &regs);

If I were being super fussy, I'd suggest doing the factor out to a structure
+ helper as a precursor patch then just add the new stuff here.
meh. I'm not that bothered but it would slightly simply review.

I'm not entirely convinced by the helper as a readability improvement
but don't hate it.


> +
>  	pos = sel_ide_offset(pdev, settings);
>  
> -	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
> -	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, regs.rid1);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, regs.rid2);
>  
> -	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> -	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
> -	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
> +	for (int i = 0; i < regs.nr_addr; i++) {
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i),
> +				       regs.addr[i].assoc1);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i),
> +				       regs.addr[i].assoc2);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i),
> +				       regs.addr[i].assoc3);
> +	}
>  
> -	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +	/* clear extra unused address association blocks */
> +	for (int i = regs.nr_addr; i < pdev->nr_ide_mem; i++) {
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
> +	}


