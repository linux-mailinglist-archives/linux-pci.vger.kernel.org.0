Return-Path: <linux-pci+bounces-44849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A38D211AE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1EB307CA72
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6D34FF7D;
	Wed, 14 Jan 2026 19:50:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11B34DB4C;
	Wed, 14 Jan 2026 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420255; cv=none; b=jqBMxH7r0jpotvZBcbOk1VSskWjZW8NpqSQGDaJ7PW1m6oafLgCAQvrHrGPSmP9eaIprvwQYhhQAQS9o153qrjYMA73TAWJK7WL4oPaK/zNlOGB4VgJDAORhh9hTH7X5i32BNrglMOjbpFOQpESl34+NWpBkLmKufPyH85PxQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420255; c=relaxed/simple;
	bh=oAQvE/Q4wsOgbTkGRYF6+NfGajvalRCUFNgscBjuCXs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nv7KZ5lpyManphVTu0A8tvR/Z6eHAl6pSTzMzTo3cAkhxbl85jdKFjw27HXBQQAPgsjgJHO6eB+S3U7gqvxn3I5ox31YF3t/IXgsDb58ZxQGwHu6EATMsNa1lgQa6Rt2+UlTb8BHuTswU24cdp+G3yooUvcP47g61Y+ZCjzLQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drxYL4nKyzHnGhG;
	Thu, 15 Jan 2026 03:50:30 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F00540569;
	Thu, 15 Jan 2026 03:50:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 19:50:49 +0000
Date: Wed, 14 Jan 2026 19:50:48 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 18/34] cxl/port: Remove "enumerate dports" helpers
Message-ID: <20260114195048.00004526@huawei.com>
In-Reply-To: <20260114182055.46029-19-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-19-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:39 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Now that cxl_switch_port_probe() no longer walks potential dports, because
> they are enumerated dynamically on descendant endpoint arrival, remove the
> dead code.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

Patch description doesn't match patch. 

> 
> ---
> 
> Changes in v13 -> v14:
> - New patch
> ---
>  drivers/cxl/core/pci.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b838c59d7a3c..0305a421504e 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -71,6 +71,14 @@ struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_dport_by_dev, "CXL");
>  
> +struct cxl_walk_context {
> +	struct pci_bus *bus;
> +	struct cxl_port *port;
> +	int type;
> +	int error;
> +	int count;
> +};
> +
>  static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> @@ -820,14 +828,6 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>  	return 0;
>  }
>  
> -struct cxl_walk_context {
> -	struct pci_bus *bus;
> -	struct cxl_port *port;
> -	int type;
> -	int error;
> -	int count;
> -};
> -
>  static int count_dports(struct pci_dev *pdev, void *data)
>  {
>  	struct cxl_walk_context *ctx = data;


