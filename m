Return-Path: <linux-pci+bounces-42708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73192CA9BE3
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 01:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D7F23035E56
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 00:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996501DFE26;
	Sat,  6 Dec 2025 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUi9/ri4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA319CD1D;
	Sat,  6 Dec 2025 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764981076; cv=none; b=LfiTAaGrZpuo4QXiS3Akej10i5iyXw/0C57FoGX8thwmMXkgFe+oUv4nxZwOzGZrgGsFmT6Sc3e+WpQKfjfqTBoLYNSEiQqp/BqPewzplPGLLDcs9R18pQGCugg1OGxGylnR1klaGAzT59lJyrvr8Ph8WtYjxQRlQiEfnbeUGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764981076; c=relaxed/simple;
	bh=dUEW0ZulWKWnLhGuilZWMIGfEL5JDcW1WGKdeRdEEyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g599kCRDgomAuF8FnURhp1pXBGEFB/TlNnA0pusiNpvFm7m2bP2LxzhvzvNGD19NPOd+DIzEEsTpfhunVRrKIiw8S58pXfNBOV9dyLt2lf37jRIScKs7iLg2tduw7SnTQeqKaswxktXiYuJTDgZniXfxB2jB0gQJeMsBgI2qH6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUi9/ri4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B96C4CEF1;
	Sat,  6 Dec 2025 00:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764981075;
	bh=dUEW0ZulWKWnLhGuilZWMIGfEL5JDcW1WGKdeRdEEyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BUi9/ri4Vl0uBOw5L/ias4CqvyiLgqk42EdIiB6lFi0XzyzdhBrLwtaI2YDnBD7+M
	 l5XdClpxvkA51R7taRT75iDG+i0i33UzUX5Wtk/CN3fkoBXKEk9xgf85R7wuEd0Rge
	 O/JlflEFnHo+FuAkyB9DKNIfE5Vv+Y3DJWR2Y5A/9DB7C0fxxhNE0YJDIKZcQJp84v
	 AcnWoxZkz0B13MCvrNJ2i/1qzr54BwHPjRwqTIZ+OK65HKXofckosrTJyQKLalVypE
	 DTvlf/XEP2DbsXr4KaGZfo9KfL9m5qu2kt9+qUNDpivas5IaUfOFQk5PBOvWIFJfSE
	 h6PCtGMDTnWSQ==
Date: Fri, 5 Dec 2025 18:31:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 01/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
Message-ID: <20251206003114.GA3299517@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104001001.3833651-2-terry.bowman@amd.com>

On Mon, Nov 03, 2025 at 06:09:37PM -0600, Terry Bowman wrote:
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

> +++ b/drivers/pci/pci.c
> @@ -5002,7 +5002,9 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
>  	if (!dvsec)
>  		return false;
>  
> -	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> +	rc = pci_read_config_word(dev,
> +				  dvsec + PCI_DVSEC_CXL_PORT_CTL,
> +				  &reg);

Stray change.

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
> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> + * registers on downstream link-up events.
> + */
> +
> +#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)

Looks like a functional duplicate of PCI_DVSEC_HEADER1_LEN().

Why __GENMASK() instead of GENMASK()?  I don't know the purpose of
__GENMASK(), but I see other include/uapi/ files using GENMASK().
Maybe they're wrong?

Same questions for _BITUL() below.

> +/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
> +#define PCI_DVSEC_CXL_DEVICE			0
> +#define  PCI_DVSEC_CXL_CAP_OFFSET		0xA
> +#define   PCI_DVSEC_CXL_MEM_CAPABLE		_BITUL(2)
> +#define   PCI_DVSEC_CXL_HDM_COUNT_MASK		__GENMASK(5, 4)
> +#define  PCI_DVSEC_CXL_CTRL_OFFSET		0xC
> +#define   PCI_DVSEC_CXL_MEM_ENABLE		_BITUL(2)
> +#define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> +#define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> +#define   PCI_DVSEC_CXL_MEM_INFO_VALID		_BITUL(0)
> +#define   PCI_DVSEC_CXL_MEM_ACTIVE		_BITUL(1)
> +#define   PCI_DVSEC_CXL_MEM_SIZE_LOW_MASK	__GENMASK(31, 28)
> +#define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> +#define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> +#define   PCI_DVSEC_CXL_MEM_BASE_LOW_MASK	__GENMASK(31, 28)

