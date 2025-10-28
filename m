Return-Path: <linux-pci+bounces-39543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C61C1558C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 16:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F76B502529
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BCB2765F5;
	Tue, 28 Oct 2025 15:06:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C40347C7;
	Tue, 28 Oct 2025 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663977; cv=none; b=LghpjzBkJH0hk2qFj6xuyxXlUgZM01dMvu5rar7zDE/BLEtzA2VX/UpJ60kqCY5shD8xupA+Aa3x07WoGGSa9qsdnV+LwTh2Xc46nm0vuvl6q5iFBvItFCFZa4+caWYgYEYsDqilGWLRP+hDEzcVtp+S19c+SA4hWEcP6bl5Dwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663977; c=relaxed/simple;
	bh=sNA4WvDPZ9rXd2p7HVDY5zRedZA+31ismdsnvs+8Pk4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIdGQI0481zjVFbznskOcKibBwplg2NUe//Tq+9bT552yz2LfrRly4TCJ59pDwcoblwrntIE4OH6NkxG3Ree6xDY7Goqz9IJd+6zsn1F2jzyOif73AHbogdTteA2rEPqI/KybSMWzgAJyG7u12pCcGCaeAF+F+RO4LyYoTIuRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cwtwK5QvlzHnH6K;
	Tue, 28 Oct 2025 15:05:21 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 80A2F140370;
	Tue, 28 Oct 2025 23:06:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 15:06:10 +0000
Date: Tue, 28 Oct 2025 15:06:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav
 Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	"Alison Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Sunil V L <sunilvl@ventanamicro.com>, Xiaofei Tan <tanxiaofei@huawei.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Huacai Chen
	<chenhuacai@kernel.org>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, Arnd Bergmann <arnd@arndb.de>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Guo
 Weikang" <guoweikang.kernel@gmail.com>, Xin Li <xin@zytor.com>, Will Deacon
	<will@kernel.org>, Huang Yiwei <quic_hyiwei@quicinc.com>, Gavin Shan
	<gshan@redhat.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6n?=
 =?ISO-8859-1?Q?ig?= <u.kleine-koenig@baylibre.com>, Li Ming
	<ming.li@zohomail.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Karolina Stolarek
	<karolina.stolarek@oracle.com>, Jon Pan-Doh <pandoh@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Shiju Jose <shiju.jose@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 6/6 v6] ACPI: extlog: Trace CPER CXL Protocol Error
 Section
Message-ID: <20251028150609.000023bf@huawei.com>
In-Reply-To: <20251023122612.1326748-7-fabio.m.de.francesco@linux.intel.com>
References: <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
	<20251023122612.1326748-7-fabio.m.de.francesco@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 23 Oct 2025 14:25:41 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> When Firmware First is enabled, BIOS handles errors first and then it makes
> them available to the kernel via the Common Platform Error Record (CPER)
> sections (UEFI 2.10 Appendix N). Linux parses the CPER sections via one of
> two similar paths, either ELOG or GHES. The errors managed by ELOG are
> signaled to the BIOS by the I/O Machine Check Architecture (I/O MCA).
> 
> Currently, ELOG and GHES show some inconsistencies in how they report to
> userspace via trace events.
> 
> Therefore, make the two mentioned paths act similarly by tracing the CPER
> CXL Protocol Error Section (UEFI v2.10, Appendix N.2.13).
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Just one small question.   With that addressed, 
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 2731ba3a0799..3f527b0c6509 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -105,6 +105,12 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
>  }
>  
> +void cxl_cper_ras_handle_prot_err(struct cxl_cper_prot_err_work_data *wd)

Why do we need this wrapper?  The name is a bit more general, so if you
do need it, then why not instead just rename cxl_cper_handle_prot_err()

> +{
> +	cxl_cper_handle_prot_err(wd);
> +}
> +EXPORT_SYMBOL_GPL(cxl_cper_ras_handle_prot_err);
> +
>  static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  {
>  	struct cxl_cper_prot_err_work_data wd;
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index 94081aec597a..a37eef112411 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -340,4 +340,6 @@ cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
>  }
>  #endif
>  
> +void cxl_cper_ras_handle_prot_err(struct cxl_cper_prot_err_work_data *wd);
> +
>  #endif /* _LINUX_CXL_EVENT_H */


