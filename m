Return-Path: <linux-pci+bounces-19013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0408F9FC143
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 19:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F5B16562A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E31D8DFB;
	Tue, 24 Dec 2024 18:28:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07617BED0;
	Tue, 24 Dec 2024 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735064927; cv=none; b=CuuxxPUetdMS9RHaYI7VSihJOnWXUGJftShEVR6E690UTp930Z1l3XUooURAhVXuMS8RDWMcLjobdN+uTj/LYZThTtPBEfAG0esA7FyLMdAtqvfX3S/8reZFIaWwrLgiUDDwPq8kdMF0nsZq8knCA9B5JfyYpOcWYru28SPLKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735064927; c=relaxed/simple;
	bh=faL405LjuQH6Gw3kcQrq/t/WuVBMPrID+wpzSADaBDA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7ntvMLNAXmStc6mwjzho4SXxJbca5G3lcB+FYMVwGKFkERwY0LFNGM23khDfreRG0ay5+lDMDBTUQ1kLLTk9AqNLOkVGmGHHjPh1nW4VfdoJDxrlzsXgPal7a4nEFvY5gN8geYs7ijIqhzW8JjOLnZ26MFVa9fg1fWzQtLwwis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHjwc1zX0z6K5ql;
	Wed, 25 Dec 2024 02:24:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CAED8140B73;
	Wed, 25 Dec 2024 02:28:41 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 19:28:40 +0100
Date: Tue, 24 Dec 2024 18:28:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 06/15] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe Port devices
Message-ID: <20241224182837.000020ae@huawei.com>
In-Reply-To: <20241211234002.3728674-7-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
	<20241211234002.3728674-7-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Dec 2024 17:39:53 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver's aer_get_device_error_info() function doesn't read
> uncorrectable (UCE) fatal error status from PCIe Upstream Port devices,
> including CXL Upstream Switch Ports. As a result, fatal errors are not
> logged or handled as needed for CXL PCIe Upstream Switch Port devices.
> 
> Update the aer_get_device_error_info() function to read the UCE fatal
> status for all CXL PCIe devices. Make the change such that non-CXL devices
> are not affected.
> 
> The fatal error status will be used in future patches implementing
> CXL PCIe Port uncorrectable error handling and logging.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
This seems fine to me, though interacts with the link healthy change
you pointed me at from Shuai Xue.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pcie/aer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d75886174969..c1eb939c1cca 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1250,7 +1250,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>  		   type == PCI_EXP_TYPE_RC_EC ||
>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
> -		   info->severity == AER_NONFATAL) {
> +		   info->severity == AER_NONFATAL ||
> +		   (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)) {
>  
>  		/* Link is still healthy for IO reads */
>  		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,


