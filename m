Return-Path: <linux-pci+bounces-8472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93D4900B54
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABE91C21018
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38319066F;
	Fri,  7 Jun 2024 17:39:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847933C0;
	Fri,  7 Jun 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781989; cv=none; b=oj+EHSUYA5fXDSfXrgR7SSsERkUBOiba8uHym20LsfV/6hpt1tPuK9aIEKtKxLbUOh6aAU57q4BhHmP/Pn6Bh+dCvk1QzlGdXeQHonkDM4C4NTiVb7oinnBE+wVFoKX9MIJD9DrtawtZqB7lv4p17rR4va5HT5/AIOb2vvjDScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781989; c=relaxed/simple;
	bh=hHCLbeJy1KVlxQTrzoliQz/D6nGwI6Jw1hb6bigjbiA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nREafgRSWPdNT6W4apa3KZJAKNgEGkFDpcJPrZqjs7ZKJlbMC/FxmMVC9G9Lqk1DsdOT13pgbDWHNsmNQbeVrMh+BUDQglof1GURB/luCZRHmB3/fp5lyULJySb2/EirvMWF+tG7KdeHdSUw9wXdE/5gXDLeBnc73RiYhLAj+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwpHp0RmGz6J9r5;
	Sat,  8 Jun 2024 01:35:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B05691402CB;
	Sat,  8 Jun 2024 01:39:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 18:39:42 +0100
Date: Fri, 7 Jun 2024 18:39:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Wei Huang <wei.huang2@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <alex.williamson@redhat.com>,
	<gospo@broadcom.com>, <michael.chan@broadcom.com>,
	<ajit.khaparde@broadcom.com>, <somnath.kotur@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <manoj.panicker2@amd.com>,
	<Eric.VanTassell@amd.com>, <vadim.fedorenko@linux.dev>, <horms@kernel.org>,
	<bagasdotme@gmail.com>
Subject: Re: [PATCH V2 6/9] PCI/TPH: Retrieve steering tag from ACPI _DSM
Message-ID: <20240607183941.00005a96@Huawei.com>
In-Reply-To: <20240531213841.3246055-7-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
	<20240531213841.3246055-7-wei.huang2@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 31 May 2024 16:38:38 -0500
Wei Huang <wei.huang2@amd.com> wrote:

> According to PCI SIG ECN, calling the _DSM firmware method for a given
> CPU_UID returns the steering tags for different types of memory
> (volatile, non-volatile). These tags are supposed to be used in ST
> table entry for optimal results.
> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Took a very quick look at this only due to lack of time..

> ---
>  drivers/pci/pcie/tph.c  | 103 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/pci-tph.h |  34 +++++++++++++
>  2 files changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> index 320b99c60365..425935a14b62 100644
> --- a/drivers/pci/pcie/tph.c
> +++ b/drivers/pci/pcie/tph.c
> @@ -158,6 +158,98 @@ static int tph_get_table_location(struct pci_dev *dev, u8 *loc_out)
>  	return 0;
>  }
>  
> +static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
> +			   union st_info *st_tag)
> +{
> +	switch (req_type) {
> +	case PCI_TPH_REQ_TPH_ONLY: /* 8 bit tags */
> +		switch (mem_type) {
> +		case TPH_MEM_TYPE_VM:
> +			if (st_tag->vm_st_valid)
> +				return st_tag->vm_st;
> +			break;
> +		case TPH_MEM_TYPE_PM:
> +			if (st_tag->pm_st_valid)
> +				return st_tag->pm_st;
> +			break;
> +		}
> +		break;
> +	case PCI_TPH_REQ_EXT_TPH: /* 16 bit tags */
> +		switch (mem_type) {
> +		case TPH_MEM_TYPE_VM:
> +			if (st_tag->vm_xst_valid)
> +				return st_tag->vm_xst;
> +			break;
> +		case TPH_MEM_TYPE_PM:
> +			if (st_tag->pm_xst_valid)
> +				return st_tag->pm_xst;
> +			break;
> +		}
> +		break;
> +	default:
> +		pr_err("invalid steering tag in ACPI _DSM\n");
> +		return 0;
Not an error code?  If so need to explain why 0 is the right thing to
return.
> +	}
> +
> +	return 0;
> +}
> +
> +#define MIN_ST_DSM_REV		7
> +#define ST_DSM_FUNC_INDEX	0xf
> +static bool invoke_dsm(acpi_handle handle, u32 cpu_uid, u8 ph,

give that a pci / tph prefix of some type as it's a very generic
name so potential future name clashes likely.

> +		       u8 target_type, bool cache_ref_valid,
> +		       u64 cache_ref, union st_info *st_out)
> +{
> +	union acpi_object in_obj, in_buf[3], *out_obj;

I'm out of time for the day, so not checked this. Will look more
closely in v3.

> +
> +	in_buf[0].integer.type = ACPI_TYPE_INTEGER;
> +	in_buf[0].integer.value = 0; /* 0 => processor cache steering tags */
> +
> +	in_buf[1].integer.type = ACPI_TYPE_INTEGER;
> +	in_buf[1].integer.value = cpu_uid;
> +
> +	in_buf[2].integer.type = ACPI_TYPE_INTEGER;
> +	in_buf[2].integer.value = ph & 3;
> +	in_buf[2].integer.value |= (target_type & 1) << 2;
> +	in_buf[2].integer.value |= (cache_ref_valid & 1) << 3;
> +	in_buf[2].integer.value |= (cache_ref << 32);
> +
> +	in_obj.type = ACPI_TYPE_PACKAGE;
> +	in_obj.package.count = ARRAY_SIZE(in_buf);
> +	in_obj.package.elements = in_buf;
> +
> +	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, MIN_ST_DSM_REV,
> +				    ST_DSM_FUNC_INDEX, &in_obj);
> +
> +	if (!out_obj)
> +		return false;
> +
> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
> +		pr_err("invalid return type %d from TPH _DSM\n",
> +		       out_obj->type);
> +		ACPI_FREE(out_obj);
> +		return false;
> +	}
> +
> +	st_out->value = *((u64 *)(out_obj->buffer.pointer));
> +
> +	ACPI_FREE(out_obj);
> +
> +	return true;
> +}
> +

>  static bool msix_nr_in_bounds(struct pci_dev *dev, int msix_nr)
>  {
>  	u16 tbl_sz;
> @@ -441,7 +533,16 @@ bool pcie_tph_get_st(struct pci_dev *dev, unsigned int cpu,
>  		    enum tph_mem_type mem_type, u8 req_type,
>  		    u16 *tag)
Add this function in this patch as it's not used before here and all
the logic is about the _DSM
Note name needs to change though.

>  {
> -	*tag = 0;
> +	union st_info info;
> +
> +	if (!invoke_dsm(root_complex_acpi_handle(dev), cpu, 0, 0, false, 0,
> +			&info)) {
> +		*tag = 0;
> +		return false;
> +	}
> +
> +	*tag = tph_extract_tag(mem_type, req_type, &info);
> +	pr_debug("%s: cpu=%d tag=%d\n", __func__, cpu, *tag);
>  
>  	return true;
>  }
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 4fbd1e2fd98c..79533c6254c2 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -14,6 +14,40 @@ enum tph_mem_type {
>  	TPH_MEM_TYPE_PM		/* persistent memory type */
>  };
>  
> +/*
> + * The st_info struct defines the steering tag returned by the firmware _DSM
> + * method defined in PCI SIG ECN. The specification is available at:
> + * https://members.pcisig.com/wg/PCI-SIG/document/15470.
> +
> + * @vm_st_valid:  8 bit tag for volatile memory is valid
> + * @vm_xst_valid: 16 bit tag for volatile memory is valid
> + * @vm_ignore:    1 => was and will be ignored, 0 => ph should be supplied
> + * @vm_st:        8 bit steering tag for volatile mem
> + * @vm_xst:       16 bit steering tag for volatile mem
> + * @pm_st_valid:  8 bit tag for persistent memory is valid
> + * @pm_xst_valid: 16 bit tag for persistent memory is valid
> + * @pm_ignore:    1 => was and will be ignore, 0 => ph should be supplied
pm_ph_ignore

> + * @pm_st:        8 bit steering tag for persistent mem
> + * @pm_xst:       16 bit steering tag for persistent mem
> + */
> +union st_info {
> +	struct {
> +		u64 vm_st_valid:1,
> +		vm_xst_valid:1,
> +		vm_ph_ignore:1,
> +		rsvd1:5,
> +		vm_st:8,
> +		vm_xst:16,
> +		pm_st_valid:1,
> +		pm_xst_valid:1,
> +		pm_ph_ignore:1,
> +		rsvd2:5,
> +		pm_st:8,
> +		pm_xst:16;
> +	};
> +	u64 value;
> +};
Firstly why in a header? If it did want to be then pci-acpi.h might be reasonable.

> +
>  #ifdef CONFIG_PCIE_TPH
>  int pcie_tph_disable(struct pci_dev *dev);
>  int tph_set_dev_nostmode(struct pci_dev *dev);


