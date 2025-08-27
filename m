Return-Path: <linux-pci+bounces-34891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D24B37C57
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FE116EF55
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 07:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46931CA7D;
	Wed, 27 Aug 2025 07:56:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BF2BE7DF;
	Wed, 27 Aug 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281411; cv=none; b=XkJyKXqA67E453vQDMTGCwcEE8jK5YpZLPnZJQmIspVyWlG9QKPtuTXz44s+vrRqqnm0xr5dZVOwJkta+rPA1z0fsGzcwAR1d7BF56AhStLWo5HkR40SJnrLx+aWHlSnPoRS3L+Z2ucJUBW+tZ3xOi1aKi8Uu6dhFCy4b0hHz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281411; c=relaxed/simple;
	bh=alOHmHFAdNLHR6AutQnNHqwWpzPsi4QUibhzMjyyG44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8fJdWqEnRz1w3PaZbCWtkjkqvyir/IsLS5sRAF/uj8qeGDf4UA+7d/kwwqpplfrI51BL5RX3Tt+s2DAocIfUI1q4/B3ltu5TUXdLHtCuUcVHrv876t+dIKIh7nrRx3Uohbt0MF7qawJfN01zVaAQl6RnyfAVJSFojgX1a5Xhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8EFD22C056A3;
	Wed, 27 Aug 2025 09:56:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 671B531BB1F; Wed, 27 Aug 2025 09:56:41 +0200 (CEST)
Date: Wed, 27 Aug 2025 09:56:41 +0200
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
Subject: Re: [PATCH v11 17/23] CXL/AER: Introduce cxl_aer.c into AER driver
 for forwarding CXL errors
Message-ID: <aK66OcdL4Meb0wFt@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-18-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-18-terry.bowman@amd.com>

On Tue, Aug 26, 2025 at 08:35:32PM -0500, Terry Bowman wrote:
> +++ b/drivers/pci/pcie/aer.c
> @@ -1092,51 +1092,6 @@ static bool find_source_device(struct pci_dev *parent,
>  	return true;
>  }
>  
> -#ifdef CONFIG_CXL_RAS
> -
> -/**
> - * pci_aer_unmask_internal_errors - unmask internal errors
> - * @dev: pointer to the pci_dev data structure
> - *
> - * Unmask internal errors in the Uncorrectable and Correctable Error
> - * Mask registers.
> - *
> - * Note: AER must be enabled and supported by the device which must be
> - * checked in advance, e.g. with pcie_aer_is_native().
> - */
> -void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> -{
> -	int aer = dev->aer_cap;
> -	u32 mask;
> -
> -	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> -	mask &= ~PCI_ERR_UNC_INTN;
> -	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> -
> -	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> -	mask &= ~PCI_ERR_COR_INTERNAL;
> -	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> -}
> -EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");

PCI device drivers may have a need to unmask internal errors if they know
that the device is capable of signaling them and their pci_error_handlers
can take care of them.

Hence I'm in favor of keeping pci_aer_unmask_internal_errors() as a helper
in drivers/pci/pcie/aer.c which PCI device drivers may call.

In particular, the "xe" driver would be a potential future user of this
helper.

Thanks,

Lukas

