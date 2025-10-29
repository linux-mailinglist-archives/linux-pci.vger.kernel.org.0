Return-Path: <linux-pci+bounces-39673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88766C1C2C6
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09B1E5C24EF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9202D7DCF;
	Wed, 29 Oct 2025 16:26:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEAD2ED870
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755163; cv=none; b=UNXtoQiDCsJiVRYvPqv7UxhnrQBNOgLbOnPRgcvG7kN5pGp+9Ohe8T37lmJqhh8wT9ac0TQKaiok3ASUX0AsxOyYuBRnrZPmHnG3Hl49ArUOdLnaFV1flSmwOK2cSIpynVBC8lDNlr/pSB/OwNIUYBMUHEVWQbCs+mMRWdbYOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755163; c=relaxed/simple;
	bh=Tmw04iOXKw84mtI2MNWI6xhQFe9NTv170hxKowApxV8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBX9su19HUcVR4QLmkXx4COHOB700FEgJRHOosNZEoh10G6T1lTU5kzJoGgSAOVjUP3hZgO9wJnqmXdm2MQRlJJ8Q0kExAP+A9cIRZBYN4UEMtpoyYSVBNURyJ74bffv7eX5rNAgBz/Wm3y6qW0dpOmLLqSElmOsiFng/dGCkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxXZQ34gZz6M4Ph;
	Thu, 30 Oct 2025 00:22:06 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 61868140370;
	Thu, 30 Oct 2025 00:25:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 16:25:56 +0000
Date: Wed, 29 Oct 2025 16:25:55 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>
Subject: Re: [PATCH v7 7/9] PCI/IDE: Add IDE establishment helpers
Message-ID: <20251029162555.00006397@huawei.com>
In-Reply-To: <20251024020418.1366664-8-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
	<20251024020418.1366664-8-dan.j.williams@intel.com>
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

On Thu, 23 Oct 2025 19:04:16 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> There are two components to establishing an encrypted link, provisioning
...



Just one trivial comment.  I'll assume you'll resolve what Aneesh raised.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> new file mode 100644
> index 000000000000..e638f9429bf9
> --- /dev/null
> +++ b/include/linux/pci-ide.h
> @@ -0,0 +1,78 @@


> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index aa54d088129d..302f7bae6c96 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c

>  

> +static struct stream_index *alloc_stream_index(struct ida *ida, u8 max,
> +					       struct stream_index *stream)
> +{
> +	int id;
> +
> +	if (!max)
> +		return NULL;
> +
> +	id = ida_alloc_range(ida, 0, max - 1, GFP_KERNEL);

ida_alloc_max() is perhaps a small readability improvement.

> +	if (id < 0)
> +		return NULL;
> +
> +	*stream = (struct stream_index) {
> +		.ida = ida,
> +		.stream_index = id,
> +	};
> +	return stream;
> +}




