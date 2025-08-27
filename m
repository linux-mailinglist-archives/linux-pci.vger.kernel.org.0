Return-Path: <linux-pci+bounces-34924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E475B38574
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34FC67A9BD9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 14:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793F0C8EB;
	Wed, 27 Aug 2025 14:51:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5F0481B1;
	Wed, 27 Aug 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306282; cv=none; b=RGpj2rgGH1KsA0NSyMuo2nyywspFo2U+XFbwkce+C4ST0Sw5PLguDegdDz2+fNy8nNmxvlRouzhGNcGirVnOXi+Egsogtvo7y4tDtjWXSoNYIa4pT8G23O385drCX4fenGu/GX5iG9rTHnvEijua4rS1Ly5YdueaiQGeALjt5AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306282; c=relaxed/simple;
	bh=E3bUXW81Tmt3vOjZf9lQJxwtMcwR1OWFVi6k+I+lI3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfymd494WGAVzes1tNviloVvh1PSctPUcbLIjhqa45wwETZtC7DbwW7szFdqxqNfcEO7cA2OUSQOv1er068WGsAolTo2z9WUWD1OKDIjw35zYjQTLupyJGauUhGHjbUzBaFaKXxOTs/T9kvN3JTG9PeoC37+1pQTatw9VMg9US4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id C3D7D2C06F49;
	Wed, 27 Aug 2025 16:51:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A3EDF4E5525; Wed, 27 Aug 2025 16:51:15 +0200 (CEST)
Date: Wed, 27 Aug 2025 16:51:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v11 07/23] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Message-ID: <aK8bY0epS6OStdfr@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-8-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-8-terry.bowman@amd.com>

On Tue, Aug 26, 2025 at 08:35:22PM -0500, Terry Bowman wrote:
> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
> accessible to other subsystems.
> 
> Change DVSEC name formatting to follow the existing PCI format in
> pci_regs.h. The current format uses CXL_DVSEC_XYZ. Change to be PCI_DVSEC_CXL_XYZ.
[...]
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1225,9 +1225,61 @@
>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> -#define PCI_DVSEC_CXL_PORT				3
> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +/* Compute Express Link (CXL r3.2, sec 8.1)
> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> + * registers on downstream link-up events.
> + */
> +
> +#define PCI_DVSEC_HEADER1_LENGTH_MASK  GENMASK(31, 20)
> +
> +/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
> +#define PCI_DVSEC_CXL_DEVICE					0
> +#define	  PCI_DVSEC_CXL_CAP_OFFSET	       0xA
> +#define	    PCI_DVSEC_CXL_MEM_CAPABLE	       BIT(2)
> +#define	    PCI_DVSEC_CXL_HDM_COUNT_MASK       GENMASK(5, 4)
> +#define	  PCI_DVSEC_CXL_CTRL_OFFSET	       0xC
> +#define	    PCI_DVSEC_CXL_MEM_ENABLE	       BIT(2)
> +#define	  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)     (0x18 + (i * 0x10))
> +#define	  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)      (0x1C + (i * 0x10))
> +#define	    PCI_DVSEC_CXL_MEM_INFO_VALID       BIT(0)
> +#define	    PCI_DVSEC_CXL_MEM_ACTIVE	       BIT(1)
> +#define	    PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK    GENMASK(31, 28)
> +#define	  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)     (0x20 + (i * 0x10))
> +#define	  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)      (0x24 + (i * 0x10))
> +#define	    PCI_DVSEC_CXL_MEM_BASE_LOW_MASK    GENMASK(31, 28)

Is it legal to use BIT() in a uapi header?

We've only allowed use of GENMASK() in uapi headers since 2023 with
commit 3c7a8e190bc5 ("uapi: introduce uapi-friendly macros for GENMASK").

But there is no uapi header in the kernel tree defining BIT().

I note that include/uapi/cxl/features.h has plenty of occurrences of BIT()
since commit 9b8e73cdb141 ("cxl: Move cxl feature command structs to user
header"), which went into v6.15.

ndctl contains a bitmap.h header defining BIT(), I guess that's why this
wasn't perceived as a problem so far:
https://github.com/pmem/ndctl/raw/main/util/bitmap.h

However existing user space applications including <linux/pci_regs.h>
may not have a BIT() definition and I suspect your change above will
break the build of those applications.

Thanks,

Lukas

