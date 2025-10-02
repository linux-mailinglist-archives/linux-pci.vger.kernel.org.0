Return-Path: <linux-pci+bounces-37422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17CFBB3E2C
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 14:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846C31679AC
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B723101A9;
	Thu,  2 Oct 2025 12:28:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D94201017;
	Thu,  2 Oct 2025 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408085; cv=none; b=s1DQhfBcFLCX30+8e9aIS4oZG+tBqblBaIsn73KSZNzGV4XnaraAztfLmuAdJbkzuKyfVvPsPxAghXGpB9GwHqtq8uYuUt1pzoK+JDAyC3HrWER3GE3IxXXN/5gaeKvuSxyEaCNULYWTWbREk+5jvCApvTCd1gEegpQ7qPj+Jh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408085; c=relaxed/simple;
	bh=T5UwiR4dMBrZ3D7lTmuVkPkQNoJ5IcfALnYS/MfaMPI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+/j6jRl/0A550c0CaogzpjVFTTOsbwBd8Q4i0pi5BUh46Vn8OKXbQLokO0L6NiTIjIK/qBPMv18cCjZONFvAt/pFDLev97Wf8+PXEYXHJT6klOx60OmUmVaC1jKxpNGxgDAncxBlk0Q/TSA+PpRoosoZnwsXbTfGLZy0F1Heyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccrc76T6nz6L4sN;
	Thu,  2 Oct 2025 20:25:43 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CC445140426;
	Thu,  2 Oct 2025 20:27:59 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 13:27:58 +0100
Date: Thu, 2 Oct 2025 13:27:56 +0100
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
Subject: Re: [PATCH v12 19/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <20251002132756.00003fe1@huawei.com>
In-Reply-To: <20250925223440.3539069-20-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
	<20250925223440.3539069-20-terry.bowman@amd.com>
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

On Thu, 25 Sep 2025 17:34:34 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL devices handle protocol errors via driver-specific callbacks rather
> than the generic pci_driver::err_handlers by default. The callbacks are
> implemented in the cxl_pci driver and are not part of struct pci_driver, so
> cxl_core must verify that a device is actually bound to the cxl_pci
> module's driver before invoking the callbacks (the device could be bound
> to another driver, e.g. VFIO).
> 
> However, cxl_core can not reference symbols in the cxl_pci module because
> it creates a circular dependency. This prevents cxl_core from checking the
> EP's bound driver and calling the callbacks.
> 
> To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
> build it as part of the cxl_core module. Compile into cxl_core using
> CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone cxl_pci
> module, consolidates the cxl_pci driver code into cxl_core, and eliminates
> the circular dependency so cxl_core can safely perform bound-driver checks
> and invoke the CXL PCI callbacks.
> 
> Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
> parameter is bound to a CXL driver instance. This will be used in future
> patch when dequeuing work from the kfifo.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
Description is nice and clear on the necessity so fair enough.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

