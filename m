Return-Path: <linux-pci+bounces-34895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073D2B37CC7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D401620195C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EAA322537;
	Wed, 27 Aug 2025 08:04:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A4321440;
	Wed, 27 Aug 2025 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281857; cv=none; b=uRH8FfHtDMM1UECNbRgnMTmV17+WqYOtMzfNdbcvbeGCQz2k39aFEyQ4KB2BDbZN4Of+QrgPPRjKmeCA9af5SfvnbITgXDdrqHno9dNkS+/OJTqBLLHJfTR9sq+RMpgKOrWLFoxPUS/ldieulsI9YkR3K6zKJzPWqMddg7QH8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281857; c=relaxed/simple;
	bh=n0zDqzZ+eBL7YvTjjyDNeUAVyS9ZeyopEqgPUeoikgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF52tAMJ/iIuhFc6Udh0XecHHo/4ChnOdN5nBc/sYioX53KKz1eX5BWvpp6ms4CYr5e/EMIOWr0XqoEe32y/M1E/UPWImxGoo7YmFqqjQFXb1gEt7G3f/SiEJ7l/I29/DVCQ5wdBqMVxXM6xWdDkvjC9rcFu64Y6MQMCQxXDHxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2E6292C00094;
	Wed, 27 Aug 2025 10:04:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F401A3FB86B; Wed, 27 Aug 2025 10:04:12 +0200 (CEST)
Date: Wed, 27 Aug 2025 10:04:12 +0200
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
Subject: Re: [PATCH v11 20/23] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
Message-ID: <aK67_CP7l7c7CSPp@wunner.de>
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-21-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827013539.903682-21-terry.bowman@amd.com>

On Tue, Aug 26, 2025 at 08:35:35PM -0500, Terry Bowman wrote:
> +++ b/include/linux/pci.h
> @@ -2760,6 +2760,17 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
>  void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  #endif
>  
> +#if defined(CONFIG_PCIEAER)
> +pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
> +				      enum pci_ers_result new);
> +#else
> +static inline pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
> +						    enum pci_ers_result new)
> +{
> +	return PCI_ERS_RESULT_NONE;
> +}
> +#endif
> +
>  #include <linux/dma-mapping.h>
>  
>  #define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)

Would it be possible for you to just declare a local version of
pci_ers_merge_result() within drivers/cxl/ which is encapsulated by
"#ifndef CONFIG_PCIEAER"?

That would avoid the need to make this public in include/linux/pci.h.

Thanks,

Lukas

