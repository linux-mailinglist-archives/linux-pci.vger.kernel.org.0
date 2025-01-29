Return-Path: <linux-pci+bounces-20552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302BDA22390
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 19:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A4816729B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B0E18F2DD;
	Wed, 29 Jan 2025 18:05:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F71190696;
	Wed, 29 Jan 2025 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173909; cv=none; b=JDrgat8aOfNF9vU9jUEibf8N9Oyvvres+jfVnGur6FlqU61dSB/aSgLueF3hBXhnaXHlvrf9Ci9B8Eymhmg4ZoM0Tq3wekG7tFqORTr83rVmMMxLWX5mnlJH4ZFD8ty2QdxjYqnCLUfWnCxlvJKwr9LgsIZ2U3bl0nwiFNVKeLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173909; c=relaxed/simple;
	bh=aZGxou+o0R4tqkO91xrIH648V+X/6H/44mU0RNpKK/w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgLZP1v95bN5BdKo+VYev5LhxFH4HX7FCOHKTcibSKwiCYCoyCG0x0Gr+4x3PaTUUaS81tb9+3QQPuFrynsxajvdfRY6WIi9od5+FA/VP01pSvO/NOeptxMk3FLMI9KKT60NThll0PMwIbQmWQliwoAF2iOZpo8/Sc57bVrFDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yjqkn6crdz6M4MF;
	Thu, 30 Jan 2025 02:02:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A4759140A35;
	Thu, 30 Jan 2025 02:05:03 +0800 (CST)
Received: from localhost (10.195.34.64) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 29 Jan
 2025 19:05:01 +0100
Date: Wed, 29 Jan 2025 18:04:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 06/16] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe Port devices
Message-ID: <20250129180459.00007e2e@huawei.com>
In-Reply-To: <f9194caf-9dbb-4b2c-b4ac-71bdfda38dc5@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-7-terry.bowman@amd.com>
	<20250114113208.00006d08@huawei.com>
	<f9194caf-9dbb-4b2c-b4ac-71bdfda38dc5@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 28 Jan 2025 14:25:54 -0600
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 1/14/2025 5:32 AM, Jonathan Cameron wrote:
> > On Tue, 7 Jan 2025 08:38:42 -0600
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >  
> >> The AER service driver's aer_get_device_error_info() function doesn't read
> >> uncorrectable (UCE) fatal error status from PCIe Upstream Port devices,
> >> including CXL Upstream Switch Ports. As a result, fatal errors are not
> >> logged or handled as needed for CXL PCIe Upstream Switch Port devices.
> >>
> >> Update the aer_get_device_error_info() function to read the UCE fatal
> >> status for all CXL PCIe devices. Make the change such that non-CXL devices
> >> are not affected.
> >>
> >> The fatal error status will be used in future patches implementing
> >> CXL PCIe Port uncorrectable error handling and logging.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
> > This clashes with Shuai's series adding link healthy checks.
> > Maybe we can reuse that logic to incorporate the condition we
> > care about here?
> >  
> 
> Hi Jonathan, et. al,
> 
> After looking at this closer and considering the situation I believe
> we should remove this patch from the patchset and defer adding these
> changes to log USP AER and RAS UCE.
> 
> I propose we reintroduce this later as a RFC or RFT in a future patchset.
> This will give more needed time for testing.
> 
> The only downside to adding later is in the case of CXL USP fatal UCE. AER and
> RAS will not be logged but this was the AER driver's existing behavior and as a
> result isn't a regression.

If we have doubts and it is complex then sure. Let's do this in stages.

Jonathan

> 
> Your thoughts?
> 
> Regards,
> Terry
> 
> >> ---
> >>  drivers/pci/pcie/aer.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index 62be599e3bee..79c828bdcb6d 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -1253,7 +1253,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
> >>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
> >>  		   type == PCI_EXP_TYPE_RC_EC ||
> >>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
> >> -		   info->severity == AER_NONFATAL) {
> >> +		   info->severity == AER_NONFATAL ||
> >> +		   (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)) {
> >>  
> >>  		/* Link is still healthy for IO reads */
> >>  		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,  
> 
> 


