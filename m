Return-Path: <linux-pci+bounces-4590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD94874783
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 06:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4AE1F23060
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 05:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6C0171A4;
	Thu,  7 Mar 2024 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpsk6wZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82A81F;
	Thu,  7 Mar 2024 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709787983; cv=none; b=XJbjwshVFK1WKqf8q7DyM85TVEH2Fix8SPirnM79WWx3haZoe6btgzI7mn3H6hFo50B5ssdmUVwKUCkYAYPzT7awoOT5JAIyMkoVzn6BKjepI/5w9CgPZ0FbIP3hmehyceoQm/u3QiVialXYZrVGWH93MjxkUcfFqaMt/pBQfP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709787983; c=relaxed/simple;
	bh=nhirl8E79VD7l3fSml+GRqae5Bq4nYEARjir2Aay5rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVGh2UjL/DOR7OhV+pDjGXIYBsuT0q3o+9SEg2IAiq2Pq5ZC9peQtFoRDNgu4fbZQKnsKeG0IEdZ+xCXo+Uup6LpGxvl6HPegFJJiXihLNMw1uAFm7UmkxteF+FidCSqNl/X4OZg5xcIml4QO7HvExTpQX9d7Cw7E1O6fy4niLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpsk6wZP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709787982; x=1741323982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nhirl8E79VD7l3fSml+GRqae5Bq4nYEARjir2Aay5rQ=;
  b=kpsk6wZP2ZgFhPZstlrfAoVmWd4L99uTtuuHEC79rT3dY0lP422uXsUq
   vwxkHef5fIS2x7uUxZXGrGWmpmMYnQnRjLUk9iGj1Tg+pXQXGiP6p1ohR
   212QB7GsUb09OZ4PJhacntnH65eP81J+SSo9CcmN4teKp8PGhjkKQwSka
   0LGjN2oYpxMGQLklhuIj/lC4GEuNmI9uBVzE3eef2+9Py2VxoaTeTq8JK
   /eidO3LbmZNT4qfRtghaVBuBsCNEA9SybcazWFp5xphwbS0kyh5ZaBlPO
   fbZVFK9slKDjts0qdbLWzTaCZsas1e620nYJk6XiG1bLDHZle63mchO54
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4609016"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4609016"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 21:06:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14547133"
Received: from dpwomacx-mobl1.amr.corp.intel.com (HELO [10.209.25.153]) ([10.209.25.153])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 21:06:21 -0800
Message-ID: <32ac2ee6-26b1-4f37-bd88-db1ef2a31267@linux.intel.com>
Date: Wed, 6 Mar 2024 21:06:20 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel v3] PCI/DOE: Support discovery version 2
Content-Language: en-US
To: Alexey Kardashevskiy <aik@amd.com>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lukas Wunner <lukas@wunner.de>
References: <20240307022006.3657433-1-aik@amd.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240307022006.3657433-1-aik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/6/24 6:20 PM, Alexey Kardashevskiy wrote:
> PCIe r6.1, sec 6.30.1.1 defines a "DOE Discovery Version" field in
> the DOE Discovery Request Data Object Contents (3rd DW) as:
>
> 15:8 DOE Discovery Version – must be 02h if the Capability Version in
> the Data Object Exchange Extended Capability is 02h or greater.

Does this change fix any functional issue? If yes, please add Fixes:
tag and probably CC stable?

>
> Add support for the version on devices with the DOE v2 capability.
>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
Change wise looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Changes:
> v3:
> * updated subject line
> * dropped "DISCOVER_" from the new field macro
>
> v2:
> * added the section number to the commit log
> ---
>  include/uapi/linux/pci_regs.h |  1 +
>  drivers/pci/doe.c             | 11 ++++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a39193213ff2..fbca743b2b86 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1144,6 +1144,7 @@
>  #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
>  
>  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 61f0531d2b1d..c94c2b0767f3 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -381,11 +381,13 @@ static void pci_doe_task_complete(struct pci_doe_task *task)
>  	complete(task->private);
>  }
>  
> -static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u16 *vid,
>  			     u8 *protocol)
>  {
>  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> -				    *index);
> +				    *index) |
> +			 FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER,
> +				    (capver >= 2) ? 2 : 0);
>  	__le32 request_pl_le = cpu_to_le32(request_pl);
>  	__le32 response_pl_le;
>  	u32 response_pl;
> @@ -419,13 +421,16 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
>  {
>  	u8 index = 0;
>  	u8 xa_idx = 0;
> +	u32 hdr = 0;
> +
> +	pci_read_config_dword(doe_mb->pdev, doe_mb->cap_offset, &hdr);
>  
>  	do {
>  		int rc;
>  		u16 vid;
>  		u8 prot;
>  
> -		rc = pci_doe_discovery(doe_mb, &index, &vid, &prot);
> +		rc = pci_doe_discovery(doe_mb, PCI_EXT_CAP_VER(hdr), &index, &vid, &prot);
>  		if (rc)
>  			return rc;
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


