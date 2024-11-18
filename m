Return-Path: <linux-pci+bounces-17043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE499D103C
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 12:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E2F1F23761
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 11:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BE8192D80;
	Mon, 18 Nov 2024 11:54:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF01176AA9;
	Mon, 18 Nov 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930866; cv=none; b=eG3syhTDJSWIN0MUusCRISrHnQTmjcueme5zfb24ea4JFPzErRzzUHE4BjN2egsxFEd9Cuqdt5+LBZ5FDUxtjh0dAkA+nvewnAfGKBqJxKJa2PyD8oUSRvhZrOX6DgLU6c7QMAtc8fOnoAPniNu3UndpstB6l1MO/FCRInOLJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930866; c=relaxed/simple;
	bh=vbsFQ4wtDdiSJxS8w7T+TNXEWoASRuInqA3wQIlkhhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZuLsef0JNC0JpxfAnO/gE2ccidKHRmqpFhzworSJwilH7XsYEyR/XVG2KFGiqMI8JHsXUk2jxsj/Vp62RsXgBAbDnHS0EvhkWxTfzB0OmRpGIaPS7YW/zFIuukdHQJAFaQzW9tEV+ZTeHYoPz/PZi5p0qwlqnRd0B4ubHZi0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A8725300034CC;
	Mon, 18 Nov 2024 12:54:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8C0A35FAC42; Mon, 18 Nov 2024 12:54:19 +0100 (CET)
Date: Mon, 18 Nov 2024 12:54:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
	oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v3 15/15] PCI/AER: Enable internal errors for CXL
 upstream and downstream switch ports
Message-ID: <Zzsq6-GN0GFKb3_S@wunner.de>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-16-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113215429.3177981-16-terry.bowman@amd.com>

On Wed, Nov 13, 2024 at 03:54:29PM -0600, Terry Bowman wrote:
> Export the AER service driver's pci_aer_unmask_internal_errors() function
> to CXL namsespace.
         ^^^^^^^^^^
	 namespace

> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
> because it is now an exported function.
[...]
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -949,7 +949,6 @@ static bool is_internal_error(struct aer_err_info *info)
>  	return info->status & PCI_ERR_UNC_INTN;
>  }
>  
> -#ifdef CONFIG_PCIEAER_CXL
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
>   * @dev: pointer to the pcie_dev data structure
> @@ -960,7 +959,7 @@ static bool is_internal_error(struct aer_err_info *info)
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)

Hm, it seems the reason why you're moving pci_aer_unmask_internal_errors()
outside of "ifdef CONFIG_PCIEAER_CXL" is that drivers/cxl/core/pci.c
is conditional on CONFIG_CXL_BUS, whereas CONFIG_PCIEAER_CXL depends
on CONFIG_CXL_PCI.

In other words, you need this to avoid build breakage if CONFIG_CXL_BUS
is enabled but CONFIG_CXL_PCI is not.

I'm wondering (as a CXL ignoramus) why that can happen in the first
place, i.e. why is drivers/cxl/core/pci.c compiled at all if
CONFIG_CXL_PCI is disabled?

Thanks,

Lukas

