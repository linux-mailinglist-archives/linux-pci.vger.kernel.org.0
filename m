Return-Path: <linux-pci+bounces-15632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1526C9B67FB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EAC1C21640
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32559213EFB;
	Wed, 30 Oct 2024 15:37:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B022139A8;
	Wed, 30 Oct 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302637; cv=none; b=kXYE3L+J5YU+D/4E/Bba/OtBsUAXEBXudt3QpKnK7IT0m5zpyuf60I3R8iHpeB35fapQnCJ9l2HV4k+uCoOVAyCVl+ddwT/M70fmZFy/gIoEereKcxhAQxw+fPsv38jrrz13iTMcU5HlyU6VMRakA/296LrULtZEdSOEPwVkV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302637; c=relaxed/simple;
	bh=PIpJkJ1iSVh/VJTjPjEj26Ptv2Y+3Be1BtZThLonA2A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYOHOWvspQqAFbmiPhn+ljlGkb9Bj+PWmagQfdohnjPhUShwyocMV3vciL3p/3FHhAhBj50C/o3eCPRGlRRpl4dLqaNgpaXjb00fE17UlvDvr9KGb0MaeusWLkMxlmyU3jKeyaKcV8f9CUukxo2jS9Wx+2IuLF7miBcfk0QKSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xdrn35vkpz6HJgF;
	Wed, 30 Oct 2024 23:35:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4841C140A35;
	Wed, 30 Oct 2024 23:37:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 16:37:09 +0100
Date: Wed, 30 Oct 2024 15:37:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 06/14] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe port devices
Message-ID: <20241030153708.000001a0@Huawei.com>
In-Reply-To: <20241025210305.27499-7-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-7-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Oct 2024 16:02:57 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver's aer_get_device_error_info() function doesn't read
> uncorrectable (UCE) fatal error status from PCIe upstream port devices,
> including CXL upstream switch ports. As a result, fatal errors are not
> logged or handled as needed for CXL PCIe upstream switch port devices.
> 
> Update the aer_get_device_error_info() function to read the UCE fatal
> status for all CXL PCIe port devices.
> 
> The fatal error status will be used in future patches implementing
> CXL PCIe port uncorrectable error handling and logging.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

I assume this was previously not done because the upstream port
requires a healthy link and maybe the error indicates we don't have one.

So I'd imagine this change may have a bad effect on PCIe devices
even if we know it's fine CXL ones in the case of certain protocol errors.

Also, does the error log stuff that follows make much sense for
an upstream port?

> ---
>  drivers/pci/pcie/aer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 1d3e5b929661..d772f123c6a2 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1250,6 +1250,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>  		   type == PCI_EXP_TYPE_RC_EC ||
>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
> +		   type == PCI_EXP_TYPE_UPSTREAM ||
>  		   info->severity == AER_NONFATAL) {
>  
>  		/* Link is still healthy for IO reads */


