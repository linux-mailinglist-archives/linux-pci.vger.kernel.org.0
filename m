Return-Path: <linux-pci+bounces-9012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D8C910268
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6081C21ABE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C64B1AB535;
	Thu, 20 Jun 2024 11:21:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73621AB52F;
	Thu, 20 Jun 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882510; cv=none; b=oh1zh6Y7eZjwglBoQq+X2081GoRB1qs/5r/wXdO8uBX18HRtPDf9jHDo5TtxRmiO0L/LW3tNGBOsVrFQZJWAO1oST+viq73C28kD0aNmflfWHb/iiZYJbACeijMWSWycHC3y7acIE1ABVKveULDJ8tkcgomTMi16Mtb2BWIVh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882510; c=relaxed/simple;
	bh=U0kwcyz9v99F81JpNcMNKchuWwka57MsNC+7Ka7V14s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfVzUqzu0UVceAUf6fk9u33vIHGIKP0R+fQIRlR7itpeSXIqUSM2DFYxKWVlHiXMLjcxltmJuMmWkPHaLu9kVmNoVyPNHPwY3qOM+6mR2wnDcyj8ty4mJxclfOHXZmRY4TQUpnH6/1L/mynWP3nJjr5W0rq36IT0trXiQLG33jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4dNm1v3sz6JBHX;
	Thu, 20 Jun 2024 19:21:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F4059140D1D;
	Thu, 20 Jun 2024 19:21:45 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 12:21:45 +0100
Date: Thu, 20 Jun 2024 12:21:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] PCI/AER: Update AER driver to call root port
 and downstream port UCE handlers
Message-ID: <20240620122144.00000faa@Huawei.com>
In-Reply-To: <20240617200411.1426554-2-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-2-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 15:04:03 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver does not currently call a handler for AER
> uncorrectable errors (UCE) detected in root ports or downstream
> ports. This is not needed in most cases because common PCIe port
> functionality is handled by portdrv service drivers.
> 
> CXL root ports include CXL specific RAS registers that need logging
> before starting do_recovery() in the UCE case.
> 
> Update the AER service driver to call the UCE handler for root ports
> and downstream ports. These PCIe port devices are bound to the portdrv
> driver that includes a CE and UCE handler to be called.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 705893b5f7b0..a4db474b2be5 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -203,6 +203,26 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  
> +	/*
> +	 * PCIe ports may include functionality beyond the standard
> +	 * extended port capabilities. This may present a need to log and
> +	 * handle errors not addressed in this driver. Examples are CXL
> +	 * root ports and CXL downstream switch ports using AER UIE to
> +	 * indicate CXL UCE RAS protocol errors.
> +	 */
> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    type == PCI_EXP_TYPE_DOWNSTREAM) {
> +		struct pci_driver *pdrv = dev->driver;
> +
> +		if (pdrv && pdrv->err_handler &&
> +		    pdrv->err_handler->error_detected) {
> +			const struct pci_error_handlers *err_handler;
> +
> +			err_handler = pdrv->err_handler;
> +			status = err_handler->error_detected(dev, state);

This status is going to get overridden by one of the pci_walk_bridge()
calls.  Should it be kept around and acted on, or dropped silently?
(I'd guess no for silent!).

> +		}
> +	}
> +
>  	/*
>  	 * If the error was detected by a Root Port, Downstream Port, RCEC,
>  	 * or RCiEP, recovery runs on the device itself.  For Ports, that


