Return-Path: <linux-pci+bounces-39805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A152CC1FDA2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 12:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427CF407E24
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91E12D320E;
	Thu, 30 Oct 2025 11:36:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1EC2E03EF
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824191; cv=none; b=B8QUendMNxCfmaABaAW/+y18nZ7kFDRR7Lpcfxhjnn/7d7sekKcl95hTnjok2MLR9lILuGOqsVfJ7vEg6hN0x2hLkXgzBnSzVOoIx0YWjxYrObAluQYdTqpWptdH4+o5c0WUIX8kSdve6fcDAPVis6zc6W+KgYrX/vfNKupn39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824191; c=relaxed/simple;
	bh=RxfnXfbIuV5SZlEZhSlwLRlxz6h6J1EmsVQaP1iQhN0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f58EFN/xHxLT5oiBH/eUFJdHPnMo9fWyJ46jaiOyQ51Lzn44U4Hy/YNqfXo4OrB4/ETlEZbN+FXXkwS2R17cOZDpT5YXYkNxQsritH+XI97UUDzMxl/hcXGM7dTfaMEYf8k1bkGoGNhccoJ+9isYgHxAzdYyGG+6cmVy5vdhcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy25r5v8xz6M4Tx;
	Thu, 30 Oct 2025 19:32:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0177A1402F0;
	Thu, 30 Oct 2025 19:36:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 11:36:24 +0000
Date: Thu, 30 Oct 2025 11:36:22 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Zhenzhong Duan
	<zhenzhong.duan@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 22/27] coco/tdx-host: Implement SPDM session setup
Message-ID: <20251030113622.00001e2b@huawei.com>
In-Reply-To: <20250919142237.418648-23-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-23-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Sep 2025 07:22:31 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Implementation for a most straightforward SPDM session setup, using all
> default session options. Retrieve device info data from TDX Module which
> contains the SPDM negotiation results.
> 
> TDH.SPDM.CONNECT/DISCONNECT are TDX Module Extension introduced
> SEAMCALLs which can run for longer periods and interruptible. But there
> is resource constraints that limit how many SEAMCALLs of this kind can
> run simultaneously. The current situation is One SEAMCALL at a time. [*]
> Otherwise TDX_OPERAND_BUSY is returned. To avoid "broken indefinite"
> retry, a tdx_ext_lock is used to guard these SEAMCALLs.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Various minor things inline.

Thanks,

Jonathan
> ---
>  arch/x86/include/asm/tdx_errno.h      |   2 +
>  drivers/virt/coco/tdx-host/tdx-host.c | 275 +++++++++++++++++++++++++-
>  2 files changed, 276 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/tdx_errno.h b/arch/x86/include/asm/tdx_errno.h
> index 6a5f183cf119..86d011cb753e 100644
> --- a/arch/x86/include/asm/tdx_errno.h
> +++ b/arch/x86/include/asm/tdx_errno.h
> @@ -27,6 +27,8 @@
>  #define TDX_EPT_WALK_FAILED			0xC0000B0000000000ULL
>  #define TDX_EPT_ENTRY_STATE_INCORRECT		0xC0000B0D00000000ULL
>  #define TDX_METADATA_FIELD_NOT_READABLE		0xC0000C0200000000ULL
> +#define TDX_SPDM_SESSION_KEY_REQUIRE_REFRESH	0xC0000F4500000000ULL
> +#define TDX_SPDM_REQUEST			0xC0000F5700000000ULL
>  
>  /*
>   * TDX module operand ID, appears in 31:0 part of error code as
> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> index 0d052a1acf62..258539cf0cdf 100644
> --- a/drivers/virt/coco/tdx-host/tdx-host.c
> +++ b/drivers/virt/coco/tdx-host/tdx-host.c

> +
> +static void tdx_spdm_delete(struct tdx_link *tlink)
> +{
> +	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
> +	unsigned int nr_released;
> +	u64 released_hpa, r;
> +
> +	r = tdh_spdm_delete(tlink->spdm_id, tlink->spdm_mt, &nr_released, &released_hpa);
> +	if (r) {
> +		pci_err(pdev, "fail to delete spdm\n");
> +		goto leak;
> +	}
> +
> +	if (tdx_page_array_ctrl_release(tlink->spdm_mt, nr_released, released_hpa)) {
> +		pci_err(pdev, "fail to release metadata pages\n");
> +		goto leak;
> +	}
> +
> +	goto out;
> +
> +leak:
> +	tdx_page_array_ctrl_leak(tlink->spdm_mt);
> +out:
> +	tlink->spdm_mt = NULL;
I'd do a separate error handling block so
	}
	link->spdm_mt = NULL;
	return;

leak:
	tdx_page_array_ctrl_leak(tlink->spdm_mt);
	tlink->spdm_mt = NULL;
	
> +}

>  
> +DEFINE_FREE(tdx_spdm_session_teardown, struct tdx_link *, if (_T) tdx_spdm_session_teardown(_T))
> +
>  static int tdx_spdm_session_setup(struct tdx_link *tlink)
>  {
> -	return -EOPNOTSUPP;
> +	unsigned int nr_pages = tdx_sysinfo->connect.spdm_max_dev_info_pages;
> +	int ret;
> +
> +	struct tdx_link *__tlink __free(tdx_spdm_session_teardown) = tlink;

Similar comment as before.  To me using __free without a constructor is rather non intuitive.

> +	ret = tdx_spdm_create(tlink);
> +	if (ret)
> +		return ret;
> +

If you drop the __free on above, factor out from here as a separate
helper and you can just do an if (ret) teardown after that call.

> +	struct tdx_page_array *dev_info __free(tdx_page_array_free) =
> +		tdx_page_array_create(nr_pages, true);
> +	if (!dev_info)
> +		return -ENOMEM;
> +
> +	ret = tdx_spdm_session_connect(tlink, dev_info);
> +	if (ret)
> +		return ret;
> +
> +	tlink->dev_info_data = tdx_dup_array_data(dev_info,
> +						  tlink->dev_info_size);
> +	if (!tlink->dev_info_data)
> +		return -ENOMEM;
> +
> +	tlink = no_free_ptr(__tlink);
> +
> +	return 0;
>  }
>  
>  static void tdx_ide_stream_teardown(struct tdx_link *tlink)
> @@ -160,11 +392,26 @@ static void tdx_link_disconnect(struct pci_dev *pdev)
>  	__tdx_link_disconnect(tlink);
>  }
>  
> +struct spdm_config_info_t {
> +	u32 vmm_spdm_cap;
> +#define SPDM_CAP_HBEAT          BIT(13)
> +#define SPDM_CAP_KEY_UPD        BIT(14)
> +	u8 spdm_session_policy;
> +	u8 certificate_slot_mask;
> +	u8 raw_bitstream_requested;
> +	u8 reserved[];
Given the only use in here that I can immediately spot is on the
stack with nothing in reserved (so zero size) + you then memcpy that into
another buffer, why bother having reserved in this declaration?
> +} __packed;
> +
>  static struct pci_tsm_ops tdx_link_ops;
>  
>  static struct pci_tsm *tdx_link_pf0_probe(struct tsm_dev *tsm_dev,
>  					  struct pci_dev *pdev)
>  {
> +	const struct spdm_config_info_t spdm_config_info = {
> +		/* use a default configuration, may require user input later */
> +		.vmm_spdm_cap = SPDM_CAP_KEY_UPD,
> +		.certificate_slot_mask = 0xff,
> +	};
>  	int rc;
>  
>  	struct tdx_link *tlink __free(kfree) =
> @@ -176,6 +423,29 @@ static struct pci_tsm *tdx_link_pf0_probe(struct tsm_dev *tsm_dev,
>  	if (rc)
>  		return NULL;
>  
> +	tlink->func_id = tdisp_func_id(pdev);
> +
> +	struct page *in_msg_page __free(__free_page) =
> +		alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!in_msg_page)
> +		return NULL;
> +
> +	struct page *out_msg_page __free(__free_page) =
> +		alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!out_msg_page)
> +		return NULL;
> +
> +	struct page *spdm_conf __free(__free_page) =
> +		alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!spdm_conf)
> +		return NULL;
> +
> +	memcpy(page_address(spdm_conf), &spdm_config_info, sizeof(spdm_config_info));
> +
> +	tlink->in_msg = no_free_ptr(in_msg_page);
> +	tlink->out_msg = no_free_ptr(out_msg_page);
> +	tlink->spdm_conf = no_free_ptr(spdm_conf);
> +
>  	return &no_free_ptr(tlink)->pci.base_tsm;
>  }
>  
> @@ -183,6 +453,9 @@ static void tdx_link_pf0_remove(struct pci_tsm *tsm)
>  {
>  	struct tdx_link *tlink = to_tdx_link(tsm);
>  
> +	__free_page(tlink->in_msg);
> +	__free_page(tlink->out_msg);
> +	__free_page(tlink->spdm_conf);
Trivial but I'd prefer to see these freed in reverse order of allocation
of where they are set. Just makes reviewing a tiny bit easier as the code
evolves.

>  	pci_tsm_pf0_destructor(&tlink->pci);
>  	kfree(tlink);
>  }


