Return-Path: <linux-pci+bounces-44828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29120D20E96
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2065F3012969
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF852F39B8;
	Wed, 14 Jan 2026 18:54:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255DE296BB7;
	Wed, 14 Jan 2026 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416848; cv=none; b=eN8Y2xs+1OGAk3Zb2A880cB42rZB8Vh+Cngt4ebXRzDKxc6ANs/zN19puGm2rKjeumPWnB8EJsOQOApqRPMcPZx7i16m+hDcHa4S0KdJQ+XETgf4stxZcUPjwj+a/2M4TvIPyYBzxe4G03M9pYwbuPBT2qhz4AbLagjKbDMY8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416848; c=relaxed/simple;
	bh=CDzycKl3gIbYnjrtZu4eqbf8j9nsh6c92tgxGOhRrxc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RF0INZaq39XQS6gJLoPBxas2jJ5PGJbRl0VOfgqOflNFs/b4DM0PZ1/rVRF/AXYgsMx4ZlQ5YmvS/hLwNP7Dtg2YBwdwy4HpMMPOj7aXJr4M1Yxzr2MInI0X8HBauQ2zGKAFJgdJuo62sdbOQRHbogmJDNClRO6cvyDk4aRHpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drwHm3jfWzHnGd1;
	Thu, 15 Jan 2026 02:53:40 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EC48440563;
	Thu, 15 Jan 2026 02:54:00 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 18:53:59 +0000
Date: Wed, 14 Jan 2026 18:53:58 +0000
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
Subject: Re: [PATCH v14 02/34] PCI: Update CXL DVSEC definitions
Message-ID: <20260114185358.00004dce@huawei.com>
In-Reply-To: <20260114182055.46029-3-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-3-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:20:23 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL DVSEC definitions were recently moved into uapi/pci_regs.h, but the
> newly added macros do not follow the file's existing naming conventions.
> The current format uses CXL_DVSEC_XYZ, while the new CXL entries must
> instead use the PCI_DVSEC_CXL_XYZ prefix to match the conventions already
> established in pci_regs.h.
> 
> The new CXL DVSEC macros also introduce _MASK and _OFFSET suffixes, which
> are not used anywhere else in the file. These suffixes lengthen the
> identifiers and reduce readability. Remove _MASK and _OFFSET from the
> recently added definitions.
> 
> Additionally, remove PCI_DVSEC_HEADER1_LENGTH, as it duplicates the existing
> PCI_DVSEC_HEADER1_LEN() macro.
> 
> Update all existing references to use the new macro names.
> 
> Finally, update the inline documentation to reference the latest revision
> of the CXL specification.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ---
> 
> Changes in v13->v14:
> - New patch. Split from previous patch such that there is now a separate
>   move patch and a format fix patch.
> - Formatting update requested (Bjorn)
> - Remove PCI_DVSEC_HEADER1_LENGTH_MASK because it duplicates
>   PCI_DVSEC_HEADER1_LEN() (Bjorn)
> - Add Dan's review-by

A couple of name choices don't quite work to my reading. 
I care more about the _DEVICE_ one than the other.

If consensus is that it is fine with out then I could probably be
persuaded.

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 6c4b6f19b18e..662582bdccf0 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h


> +/* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
> +#define PCI_DVSEC_CXL_DEVICE				0
> +#define  PCI_DVSEC_CXL_CAP				0xA

Why drop the _DEVICE_ bit of these I'd kind of expect
#define  PCI_DVSEC_CXL_DEVICE_CAP
to indicate which DVSEC it is in.



> +#define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
> +#define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define  PCI_DVSEC_CXL_CTRL				0xC
> +#define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
> +#define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
> +#define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
> +#define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
> +#define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
> +#define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))
> +#define   PCI_DVSEC_CXL_MEM_BASE_LOW			__GENMASK(31, 28)
>  

> +/* CXL r4.0, 8.1.4: Non-CXL Function Map DVSEC */
> +#define PCI_DVSEC_CXL_FUNCTION_MAP			2
> +
> +/* CXL r4.0, 8.1.5: Extensions DVSEC for Ports */
> +#define PCI_DVSEC_CXL_PORT				3
> +#define  PCI_DVSEC_CXL_PORT_CTL				0x0c
> +#define   PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +
> +/* CXL r4.0, 8.1.6: GPF DVSEC for CXL Port */
> +#define PCI_DVSEC_CXL_PORT_GPF				4

Nothing like ambiguous naming in the CXL spec as the
following fields sound like they are in the CXL_PORT dvsec
but they aren't.  Well the spec avoids it with GPF_FOR_PORT
but we don't want to go there.  I wonder...
PCI_DVSEC_CXL_PORTGPF maybe to avoid that?

Sigh. It's probably not worth it and does look horrible, so stick
with these.

> +#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_1_CONTROL		0x0C
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_BASE	__GENMASK(3, 0)
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_1_TMO_SCALE	__GENMASK(11, 8)
> +#define  PCI_DVSEC_CXL_PORT_GPF_PHASE_2_CONTROL		0xE
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_BASE	__GENMASK(3, 0)
> +#define   PCI_DVSEC_CXL_PORT_GPF_PHASE_2_TMO_SCALE	__GENMASK(11, 8)
> +
> +/* CXL r4.0, 8.1.7: GPF DVSEC for CXL Device */
> +#define PCI_DVSEC_CXL_DEVICE_GPF			5
> +
> +/* CXL r4.0, 8.1.9: Register Locator DVSEC */
> +#define PCI_DVSEC_CXL_REG_LOCATOR			8
> +#define  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1		0xC
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BIR			__GENMASK(2, 0)
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_ID		__GENMASK(15, 8)
> +#define   PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW	__GENMASK(31, 16)
>  
>  #endif /* LINUX_PCI_REGS_H */


