Return-Path: <linux-pci+bounces-19725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9E6A105BA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 12:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DE618826EA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 11:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE15234D0E;
	Tue, 14 Jan 2025 11:41:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2785234CFF;
	Tue, 14 Jan 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854918; cv=none; b=GbutCQ+NLPj4+tQ24QTShmqR8/QqtZrfMi9lpICsyDFsOkFwZJLX13Y55FwYivVRP9MVbd0o2RT4xbbBeqf0gvfiGvAkz1uSaZkVwYdRQ6bue1GT+EWWYl6cPcyeh/nttVUmNDbAeSQ3mP/l2tSkrmgXbecjJA+1O6b48ngWOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854918; c=relaxed/simple;
	bh=Q6qliogWXjg2MbJwriu28pbTyzkcywijyTMNrxDX3Nw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ad6hjCKuLx1TIuQb7cQHrmgkxtxmzFHWyL5e2q3iZ7Bn4ZXfiFPmbgKot4NXGoTJ5YbyqBIyw56e0kEnd/5ByZw0Lv+9rQK810pz3/5ZDWT7D/zjQFUuv5P/xVReiOPj9b1BprULAEQaOdK7yx1fyL7TnH5BwYK0v1P5txMciY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXRy15JxGz6M4Mg;
	Tue, 14 Jan 2025 19:40:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 51CCC14022E;
	Tue, 14 Jan 2025 19:41:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 12:41:52 +0100
Date: Tue, 14 Jan 2025 11:41:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 11/16] cxl/pci: Add log message for umnapped
 registers in existing RAS handlers
Message-ID: <20250114114151.0000491d@huawei.com>
In-Reply-To: <20250107143852.3692571-12-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-12-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 7 Jan 2025 08:38:47 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed inorder to help debug CXL error handling. Update
> the CXL driver to log a warning message if the RAS register block is
> unmapped.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5699ee5b29df..8275b3dc3589 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -656,8 +656,10 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  	void __iomem *addr;
>  	u32 status;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>  		return;
> +	}
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> @@ -700,8 +702,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	u32 status;
>  	u32 fe;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>  		return false;
> +	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);


