Return-Path: <linux-pci+bounces-14664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971909A0FB1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBBE282A42
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E022B12DD8A;
	Wed, 16 Oct 2024 16:29:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACC210183;
	Wed, 16 Oct 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096148; cv=none; b=fLnR6x939sBt2Bz3UpLQnHA8QY5QDuDBxHlXBwvi0h00aOpo6k1LfAjmgg1p7apcN0JqE4WJ6nTZma5n2c13CvpCxDTtyhwxYIcrx5WG+GBAhQrcB4J6/6FW4PPlBn6oDq81GH8H/wRK8YPJVzbzyMAVSuJ1eBIOv5b+1SyBpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096148; c=relaxed/simple;
	bh=m03GgYfpjhsbMSm0//osAxU4REPjr4beIsD/5qr/bus=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQOIL9L3Oij8CGxyEKri27gyvVKZ3ZGEbw31DH7ze7B+FQ2nqT7WOiLO3RrNHwXaebb8IgOB5WlSR9dpe/JWsOxgRhD4FLmND+FK+8+RfgrLIz1b4W9NdoV+Wmf/04zWBoS9447Zixh1VYSU0pPN/FjvvnJf+J7D5dXUuHW3On0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTGc74yg5z6JB1g;
	Thu, 17 Oct 2024 00:28:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CF221400DB;
	Thu, 17 Oct 2024 00:29:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 18:29:00 +0200
Date: Wed, 16 Oct 2024 17:28:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 05/15] cxl/aer/pci: Update AER driver to read UCE fatal
 status for all CXL PCIe port devices
Message-ID: <20241016172859.00004209@Huawei.com>
In-Reply-To: <20241008221657.1130181-6-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-6-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Oct 2024 17:16:47 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver's aer_get_device_err_info() function does not
> read uncorrectable (UCE) fatal error status from PCIe upstream port
> devices. As a result, fatal errors are not logged or handled as needed
> for CXL PCIe upstream switch port devices.

I wonder why not?  Is this the first ever upstream port to
report an uncorrectable error (that didn't mean the link was
down) or is there something more subtle going on.

PCI folk, this one looks like it might cause problems to me.

> 
> Update the aer_get_device_err_info() function to read the UCE fatal
error_info()

> status for all CXL PCIe port devices.
> 
> The fatal error status will be used in future patches implementing
> CXL PCIe port error handling and logging.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/pci/pcie/aer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 1c996287d4ce..9b2872c8e20d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1282,6 +1282,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>  		   type == PCI_EXP_TYPE_RC_EC ||
>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
> +		   type == PCI_EXP_TYPE_UPSTREAM ||
>  		   info->severity == AER_NONFATAL) {
>  
>  		/* Link is still healthy for IO reads */
So this comment makes me worried.  In general case the fatal
error may mean we can't talk to the USP?

Jonathan



