Return-Path: <linux-pci+bounces-35807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD038B517E5
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8957417DD92
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 13:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968202877ED;
	Wed, 10 Sep 2025 13:29:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411D1F03F3;
	Wed, 10 Sep 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510953; cv=none; b=Zkm+WfCUOHr9v2AW45WPSvNBVxNZZseDWRTeLhaJzaHuB7MmCphEgbZ7ak8DyPKct++q62xOdFAmfH6qzhn9SsUnWLhKvjJznXRoXc5iXZw+2ZuJMUrAFxbjImhJPZjKPVwMY/b/w5pXCsCXNBl6A43VuNw+TZ2cXmo27H0Cd7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510953; c=relaxed/simple;
	bh=tOdTP+KhNsuVkhx/qtPZrGHgD4gbeXaG62qOwGAYqF8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksYvBoNvtMP98oM6nXo2nQ2EJLrpIsKYaJF8YbZA5LFBvEe5JDsYynwk3ZYsZgXtAqp0omZC8Xugi4UmD1SmWg2Be+9zadQtzEp9FypVqoewALal6HZPR1t2bO3fGSDJyOOTcdMWar5uMTnjkc2fAPsJH9gON93DQkQ99OG1ORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMM24251Qz6GDBJ;
	Wed, 10 Sep 2025 21:27:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CBE391404FD;
	Wed, 10 Sep 2025 21:29:08 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Sep
 2025 15:29:07 +0200
Date: Wed, 10 Sep 2025 14:29:06 +0100
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
Subject: Re: [PATCH v11 18/23] PCI/AER: Dequeue forwarded CXL error
Message-ID: <20250910142906.000079d6@huawei.com>
In-Reply-To: <20250827013539.903682-19-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
	<20250827013539.903682-19-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 26 Aug 2025 20:35:33 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER driver is now designed to forward CXL protocol errors to the CXL
> driver. Update the CXL driver with functionality to dequeue the forwarded
> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
> error handling processing using the work received from the FIFO.
> 
> Update function cxl_proto_err_work_fn() to dequeue work forwarded by the
> AER service driver. This will begin the CXL protocol error processing with
> a call to cxl_handle_proto_error().
> 
> Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
> and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
> will return a reference counted 'struct pci_dev *'. This will serve as
> reference count to prevent releasing the CXL Endpoint's mapped RAS while
> handling the error. Use scope base __free() to put the reference count.
> This will change when adding support for CXL port devices in the future.
> 
> Implement cxl_handle_proto_error() to differentiate between Restricted CXL
> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
> Maintain the existing RCH handling. Export the AER driver's pcie_walk_rcec()
> allowing the CXL driver to walk the RCEC's secondary bus.
> 
> VH correctable error (CE) processing will call the CXL CE handler. VH
> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
> and pci_clean_device_status() used to clean up AER status after handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

One additional comment.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d775ed37a79b..2c9827690cb3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");

Not seeing this as CXL specific. I don't think the namespace is appropriate.

>  #endif


