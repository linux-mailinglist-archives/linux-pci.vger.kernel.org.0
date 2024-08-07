Return-Path: <linux-pci+bounces-11416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C594A257
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 10:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D142F1C2254D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87A51917FE;
	Wed,  7 Aug 2024 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAaSd8VK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E118FC9B;
	Wed,  7 Aug 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017829; cv=none; b=aQXkrqQPA7NJnEBObgEwe1oALbffafmaHNoM2h0W1BNuL+58ITUJTzlWVf5GlvQNrr9wxsYPQd3eGUKsOzr0kx/W98PMqh6JvqxMtLwDI+ypcA+jWAW+csSEq0e4U14OOgvWNaN39lCbilOeVH8WJ52A5vhZvR8LKipBWNQXQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017829; c=relaxed/simple;
	bh=b4C+teTlX4VXiQEQ6YAO9R4P6kuTihJ71+3zw2R4QKo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RFCuuQhxqTEOkt4Oe/MdXH/3M0WzblVYMxADLvgtXftcatSpgf6LvoYJRBb7mdkO0nsNF5+VdFpCTdj7UdHlKhcL1RiNJ93Sq3dnXe21CgoobHkalFBmBgGtgoNINTtNDG30v8BmFyuFarjpBSlpWX8Okn2z+bhztY5thrik2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAaSd8VK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723017828; x=1754553828;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b4C+teTlX4VXiQEQ6YAO9R4P6kuTihJ71+3zw2R4QKo=;
  b=BAaSd8VKrQ3BUNk4/YVZnt785upJK5Zl06Sfp9SYrEpT4E6bdvWI+nw/
   6eCl/6tM15xEv35sulUacI5n4ev53SBe/pU6OMRIu9vHLhu69m5WbOV6g
   +fDbtz4o0OnZUUHBSW/UQzgaUEgcDXnFQWxcoFX99tQpHBsm3TChefd/3
   nVh8VQRXDk3KDbWcApRjIu15qEt01kTXmMWtV5L76oN64FYwd+WGUqWJ+
   GNKfUOzLYU6n+fhu6yqYU4P/0tCAWUhjaP27WG/LUDGfUyIzJSnOpZdss
   MNCCA6ViR3IMT/ADU6D5E1ypdem9EXpbsH/m+ml89SzS5mq1ViE0as66S
   g==;
X-CSE-ConnectionGUID: ExbEeEQUSvO59Naw4Pwpmg==
X-CSE-MsgGUID: 7LUgySv5S12gqsXR+/yoWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38530421"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="38530421"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 01:03:47 -0700
X-CSE-ConnectionGUID: R3ls7Dy/S9Gjll9jCGPCiA==
X-CSE-MsgGUID: UM7PQNqnSLenO9oUI4OI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="56722533"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 01:03:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 7 Aug 2024 11:03:38 +0300 (EEST)
To: Alistair Francis <alistair23@gmail.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    Jonathan.Cameron@huawei.com, Lukas Wunner <lukas@wunner.de>, 
    alex.williamson@redhat.com, christian.koenig@amd.com, kch@nvidia.com, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, logang@deltatee.com, 
    LKML <linux-kernel@vger.kernel.org>, chaitanyak@nvidia.com, 
    rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v15 2/4] PCI/DOE: Rename Discovery Response Data Object
 Contents to type
In-Reply-To: <20240806230118.1332763-2-alistair.francis@wdc.com>
Message-ID: <cbc54dfb-6699-ae15-f40e-d3b5969fc806@linux.intel.com>
References: <20240806230118.1332763-1-alistair.francis@wdc.com> <20240806230118.1332763-2-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 7 Aug 2024, Alistair Francis wrote:

> PCIe r6.1 (which was published July 24) describes a "Vendor ID", a
> "Data Object Type" and "Next Index" as the fields in the DOE
> Discovery Response Data Object. The DOE driver currently uses
> both the terms type and prot for the second element.
> 
> This patch renames all uses of the DOE Discovery Response Data Object
> to use type as the second element of the object header, instead of
> type/prot as it currently is.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 94c00996e633..795e49304ae4 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1146,9 +1146,12 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
>  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
> -#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE		0x00ff0000

This change (removal of the old define) is inside UAPI header, so it does 
seem something that is not allowed.

>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
> +/* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
> +
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
> 

-- 
 i.


