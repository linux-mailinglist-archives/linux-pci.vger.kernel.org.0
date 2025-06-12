Return-Path: <linux-pci+bounces-29575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1746AD78D3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB71C3B581C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046D2BCF6C;
	Thu, 12 Jun 2025 17:19:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2D29B8C3;
	Thu, 12 Jun 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748755; cv=none; b=VfjBjhTSg69WmFuNCbgBQMadLGz5wqly9a9gptmYmbZ11FLdSUsaw+nbcgH8+aYEbj4+z3TiwvtxKlYKN7o3dqvrrzPyefVGI6LV5wctRxhBFVyCsfFkyejIOvnCaXB0kKzxZXopgOTvTrOOpG0BrDH+BpayqoA69scaPsxs5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748755; c=relaxed/simple;
	bh=9diNrt8Pzr196WPx6t3PB1xO/h+kmnkbJFNZFeKjP9I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbrpCfV3Ki+rS3rHFG5XjG4be67JdBIMgSh5XhmIFurOGiZoI+3+yajcQAY+8aHU3NPzZvyu38jiRuMtPh23VBF7BhwuH5ezTP/2BUJPbnKiGuZveVAlaZydeUSXBBx97SccbXlNaXFtnRc7oVSNpeZTlEhPGJAGb8EoKxkUP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ8Pw6LPwz6M52S;
	Fri, 13 Jun 2025 01:18:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EA08414038F;
	Fri, 13 Jun 2025 01:19:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 19:19:09 +0200
Date: Thu, 12 Jun 2025 18:19:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <bp@alien8.de>,
	<ming.li@zohomail.com>, <shiju.jose@huawei.com>, <dan.carpenter@linaro.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <kobayashi.da-06@fujitsu.com>,
	<yanfei.xu@intel.com>, <rrichter@amd.com>, <peterz@infradead.org>,
	<colyli@suse.de>, <uaisheng.ye@intel.com>,
	<fabio.m.de.francesco@linux.intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<yazen.ghannam@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v9 16/16] CXL/PCI: Disable CXL protocol error interrupts
 during CXL Port cleanup
Message-ID: <20250612181908.00004f95@huawei.com>
In-Reply-To: <20250603172239.159260-17-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
	<20250603172239.159260-17-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Jun 2025 12:22:39 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> During CXL device cleanup the CXL PCIe Port device interrupts remain
> enabled. This potentially allows unnecessary interrupt processing on
> behalf of the CXL errors while the device is destroyed.
> 
> Disable CXL protocol errors by setting the CXL devices' AER mask register.
> 
> Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().
> 
> Introduce cxl_mask_prot_interrupts() to call pci_aer_mask_internal_errors().
> Add calls to cxl_mask_prot_interrupts() within CXL Port teardown for CXL
> Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
> Endpoints. Follow the same "bottom-up" approach used during CXL Port
> teardown.
> 
> Implement cxl_mask_prot_interrupts() in a header file to avoid introducing
> Kconfig ifdefs in cxl/core/port.c.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

