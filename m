Return-Path: <linux-pci+bounces-40260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B7C32715
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91CB34E41C5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC032570F;
	Tue,  4 Nov 2025 17:50:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6BD320CD5;
	Tue,  4 Nov 2025 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278639; cv=none; b=WXjrb8dlbR+SrLxViIvAzM/thChc/GV2txRx4LfOvues3uUWHJfP16LgOcf5Mxi10xNRMayuWEGd4wYUjVuZpYMsn57e5rFjgPSqE+Hk8T4Y9ObeIsvX1wqbbSiibKqXImBK0hednwDzjx0qN5+pBJADr9H00kFda9Jr9vCobgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278639; c=relaxed/simple;
	bh=UtlVrxy883V1hG2LfRvq9ax29Y9BDYy7HWSo9rJffTM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sp+qfKYxeJhQbQgcnNyp0cBJF1J97Lem6aWPyO/bufcnOI/jDawYWJItQh0pwbvBWiBmUq8NNKB3fyyj+Zr9zFA0ydsZUPFC0xqRlRuqNfLWg1IUottyVQ67hePjsRXIi7XccWuvbDDyEnTYNbTYoq/7/myuZW79KiZ7dMRIaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1GFK1QdlzJ467F;
	Wed,  5 Nov 2025 01:50:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EE0D1402A4;
	Wed,  5 Nov 2025 01:50:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 17:50:31 +0000
Date: Tue, 4 Nov 2025 17:50:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 01/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Message-ID: <20251104175030.00002268@huawei.com>
In-Reply-To: <20251104170305.4163840-2-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-2-terry.bowman@amd.com>
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

On Tue, 4 Nov 2025 11:02:41 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> accessible to other subsystems. Move these to uapi/linux/pci_regs.h.
> 
> Change DVSEC name formatting to follow the existing PCI format in
> pci_regs.h. The current format uses CXL_DVSEC_XYZ and the CXL defines must
> be changed to be PCI_DVSEC_CXL_XYZ to match existing pci_regs.h. Leave
> PCI_DVSEC_CXL_PORT* defines as-is because they are already defined and may
> be in use by userspace application(s).
> 
> Update existing usage to match the name change.
> 
> Update the inline documentation to refer to latest CXL spec version.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
Hi Terry,

A few minor things inline.

I'll assume you'll resolve those for next version and as they are
really minor
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..53a49bb32514 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5002,7 +5002,9 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>  	if (!dvsec)
>  		return false;
>  
> -	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> +	rc = pci_read_config_word(dev,
> +				  dvsec + PCI_DVSEC_CXL_PORT_CTL,
> +				  &reg);
Looks like left over from before where that define got longer?
Shouldn't still be here given the two lines are (I think?) identical other
than some premature line wrapping.
>  	if (rc || PCI_POSSIBLE_ERROR(reg))
>  		return false;
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 07e06aafec50..279b92f01d08 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1244,9 +1244,64 @@
>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> -#define PCI_DVSEC_CXL_PORT				3
> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +/* Compute Express Link (CXL r3.2, sec 8.1)
Follow local comment style.
/*
 * Compute Express Link (CXL r3.2, sec 8.1)
 *...

> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> + * registers on downstream link-up events.
> + */


> +/* CXL 3.2 8.1.8: PCIe DVSEC for Flex Bus Port */
> +#define PCI_DVSEC_CXL_FLEXBUS_PORT				7
> +#define  PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET			0xE

I wonder if you should keep the _PORT in the naming for consistency.
These are also new defines rather than moves / renames.  I wonder if it
makes sense to bury them in this patch. Instead bring them in where they
are used?  That will also make it more obvious why only a fairly random
looking subset of this structure is used.


> +#define   PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK		_BITUL(0)
> +#define   PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK			_BITUL(2)
> +
> +/* CXL 3.2 8.1.9: Register Locator DVSEC */
> +#define PCI_DVSEC_CXL_REG_LOCATOR				8
> +#define  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1_OFFSET		0xC
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BIR_MASK			__GENMASK(2, 0)
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID_MASK		__GENMASK(15, 8)
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW_MASK		__GENMASK(31, 16)
>  
>  #endif /* LINUX_PCI_REGS_H */


