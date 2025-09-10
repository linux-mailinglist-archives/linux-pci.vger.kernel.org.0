Return-Path: <linux-pci+bounces-35805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F6FB517A6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818DD4660DB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352431079B;
	Wed, 10 Sep 2025 13:10:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643C1F2BA4;
	Wed, 10 Sep 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509853; cv=none; b=SwpXPvExH+I/xLG8xUxtThOzUfPwH/j/u94Ypt9rwP5rJonpcO/6+mlQc049y7AXwW4ZOEPk/FK6sgO1AslwcCbBwBqqDMoSgYjOXYDGLWd0MnUFP+/pIUjG6SoixMm4YH+6VQtnQAseQwzPfgdm4Tqm+akcAI9p8xmU5yOA3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509853; c=relaxed/simple;
	bh=2IKU3/wPYlWgbnl3BXbKFtcmrAn1ItZ/g8wkddjUr38=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qP2HgYnvez8QqoejtdhjpH12SXQ6M+sEQMNqGKkRaG3Zy29ZMW9aDrBmooOQk3JAMmxVJfitlzR2UqCxosNFiL8aRwyZ7XEuEawlngS4MiZeJBwapCgtgBR3BfJMC2FZclmyjFI5PL7VKOqz2hb3E7LLevu5yZ6Pw1MNdRETN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMLbF1n3Sz6LDHY;
	Wed, 10 Sep 2025 21:08:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A372B140114;
	Wed, 10 Sep 2025 21:10:47 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Sep
 2025 15:10:46 +0200
Date: Wed, 10 Sep 2025 14:10:45 +0100
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
Subject: Re: [PATCH v11 08/23] PCI/CXL: Introduce pcie_is_cxl()
Message-ID: <20250910141045.00003a2d@huawei.com>
In-Reply-To: <20250827013539.903682-9-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
	<20250827013539.903682-9-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 26 Aug 2025 20:35:23 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL and AER drivers need the ability to identify CXL devices.
> 
> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
> presence is used because it is required for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> CXL.cache and CXl.mem status.
> 
> In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
> the parent downstream device. This will make certain the correct state
> is cached.
> 
> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Trivial comment inline.

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index b03244d55aea..252c06402b13 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1274,6 +1274,9 @@
>  
>  /* CXL 3.2 8.1.8: PCIe DVSEC for Flex Bus Port */
>  #define PCI_DVSEC_CXL_FLEXBUS_PORT				7
> +#define	  PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET			0xE
> +#define	    PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK		BIT(0)
> +#define	    PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK		BIT(2)
>  
Whilst there is some logic in using tabs, the existing content
of this file uses spaces between define and name - even when indent is
large enough a tab gives same answer.  We should stick to that local style.

>  /* CXL 3.2 8.1.9: Register Locator DVSEC */
>  #define PCI_DVSEC_CXL_REG_LOCATOR				8


