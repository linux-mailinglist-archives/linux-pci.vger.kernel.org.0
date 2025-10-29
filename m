Return-Path: <linux-pci+bounces-39652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6C2C1B389
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 320FA581704
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF792354712;
	Wed, 29 Oct 2025 13:42:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918C354713
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745331; cv=none; b=cVw34uShxDKcNTN6IVapx6WCgWJ7dCKaQ6J/29l9854YrS4sSEfB1Ab8VFAVcWEU04nskcXrdJT/Kbi0uk6XGq5Evj90HGP7FJx8jIWHYO/FrOu+AluqBBq1tFSKIdJMXgr7iM8+trGLigYnN8wZ9NUGYxPaMyBt++i+cYfWetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745331; c=relaxed/simple;
	bh=6EiUeYwp6JEW9gRRiKZhU1A/+Z+ldm014bop4I8PQUo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRDp2kgsd/XywBFxTybbW603QmZg1OeFC4CFDXj4v/PUJ74b7VG+VQL/RXAmks3lP/9cTnzx+PS5hllz7s3Kt350SK0zFmjuv9yYkWJfycbb8dANo3iTOGqqoMDFOBFuXxkHjdYtBF7rVLSLf19NgBbLM9KCl9zxasJFnZAPT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cxT0p0DtqzHnH4v;
	Wed, 29 Oct 2025 13:41:14 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A14EE140373;
	Wed, 29 Oct 2025 21:42:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 13:42:06 +0000
Date: Wed, 29 Oct 2025 13:42:04 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 2/9] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20251029134204.00005e76@huawei.com>
In-Reply-To: <20251024020418.1366664-3-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
	<20251024020418.1366664-3-dan.j.williams@intel.com>
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

On Thu, 23 Oct 2025 19:04:11 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
> 7.9.26 IDE Extended Capability".
> 
> It is both a standalone port + endpoint capability, and a building block
> for the security protocol defined by "PCIe r7.0 section 11 TEE Device
> Interface Security Protocol (TDISP)". That protocol coordinates device
> security setup between a platform TSM (TEE Security Manager) and a
> device DSM (Device Security Manager). While the platform TSM can
> allocate resources like Stream ID and manage keys, it still requires
> system software to manage the IDE capability register block.
> 
> Add register definitions and basic enumeration in preparation for
> Selective IDE Stream establishment. A follow on change selects the new
> CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
> both a point-to-point "Link Stream" and a Root Port to endpoint
> "Selective Stream", only "Selective Stream" is considered for Linux as
> that is the predominant mode expected by Trusted Execution Environment
> Security Managers (TSMs), and it is the security model that limits the
> number of PCI components within the TCB in a PCIe topology with
> switches.
> 
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Trivial comments only. Just ignore if you like.

> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> new file mode 100644
> index 000000000000..aa54d088129d
> --- /dev/null
> +++ b/drivers/pci/ide.c

> +void pci_ide_init(struct pci_dev *pdev)
> +{
> +	u16 nr_link_ide, nr_ide_mem, nr_streams;
> +	u16 ide_cap;
> +	u32 val;
> +
> +	if (!pci_is_pcie(pdev))
> +		return;
> +
> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	if (!ide_cap)
> +		return;
> +
> +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> +		return;
> +
> +	/*
> +	 * Require endpoint IDE capability to be paired with IDE Root Port IDE
> +	 * capability.
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> +		struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +		if (!rp->ide_cap)
> +			return;
> +	}
> +
> +	if (val & PCI_IDE_CAP_SEL_CFG)
> +		pdev->ide_cfg = 1;
	pdev->ide_cfg = FIELD_GET(PCI_IDE_CAP_SEL_CFG, val);
will give more compact code. Entirely up to you.

> +
> +	if (val & PCI_IDE_CAP_TEE_LIMITED)
> +		pdev->ide_tee_limit = 1;
likewise, could just use FIELD_GET() to save a line.

> +
> +}



