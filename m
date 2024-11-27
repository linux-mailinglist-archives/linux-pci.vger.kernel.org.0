Return-Path: <linux-pci+bounces-17424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E089DAC34
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 18:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5079BB2308C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 17:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB86200BB4;
	Wed, 27 Nov 2024 17:05:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8981F8F1A;
	Wed, 27 Nov 2024 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732727126; cv=none; b=qti1HAqi6N8qHoGO5njZR1G+tMyjBF0FvrgEZWkyT0jlNnSHUJUv1NHkQHqpuQ6MDoEkQogtQt6oT3JHVZ1BuTc3rWNAI34cdfLhPigr9/vNeCi2BZIvCSUTI0Xt6IehkeUSo9xsbfGxk4l4+LmiEZJVJliNS0or1IehF3smRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732727126; c=relaxed/simple;
	bh=ercSyPeyYpT/8fKtZokf9SXq+xP8iulo3R4DX9zRtGQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDn0zJ0OGj2SZs1bWttwDCebLb2/Qjhg7reIGfMstpHyXrvLDtdasxH1X10TlGOEwURP3cBtONS3dbfbW6Xl8V+IJNS9WzCq8eXHsnjd8FWdjQnnr2c4TsAqVDtjRHZ1uq/0Q/pDl7fJFueR7NYJz/e9AH2QMxRK+RuJihiz7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xz5Qk6Mptz6D9Cw;
	Thu, 28 Nov 2024 01:04:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 43FC7140390;
	Thu, 28 Nov 2024 01:05:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 27 Nov
 2024 18:05:19 +0100
Date: Wed, 27 Nov 2024 17:05:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: Lukas Wunner <lukas@wunner.de>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <ming4.li@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>, "Shuai
 Xue" <xueshuai@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 06/15] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe port devices
Message-ID: <20241127170518.00003966@huawei.com>
In-Reply-To: <c7c9d417-5c32-4354-825e-58f736726114@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
	<20241113215429.3177981-7-terry.bowman@amd.com>
	<ZzcVzpCXk2IpR7U3@wunner.de>
	<c7c9d417-5c32-4354-825e-58f736726114@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 21 Nov 2024 14:24:17 -0600
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 11/15/2024 3:35 AM, Lukas Wunner wrote:
> > On Wed, Nov 13, 2024 at 03:54:20PM -0600, Terry Bowman wrote:  
> >> The AER service driver's aer_get_device_error_info() function doesn't read
> >> uncorrectable (UCE) fatal error status from PCIe upstream port devices,
> >> including CXL upstream switch ports. As a result, fatal errors are not
> >> logged or handled as needed for CXL PCIe upstream switch port devices.
> >>
> >> Update the aer_get_device_error_info() function to read the UCE fatal
> >> status for all CXL PCIe port devices. Make the change to not affect
> >> non-CXL PCIe devices.
> >>
> >> The fatal error status will be used in future patches implementing
> >> CXL PCIe port uncorrectable error handling and logging.  
> > [...]  
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -1250,7 +1250,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
> >>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
> >>  		   type == PCI_EXP_TYPE_RC_EC ||
> >>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
> >> -		   info->severity == AER_NONFATAL) {
> >> +		   info->severity == AER_NONFATAL ||
> >> +		   (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)) {
> >>  
> >>  		/* Link is still healthy for IO reads */
> >>  		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,  
> > Just a heads-up, there's another patch pending by Shuai Xue (+cc)
> > which touches the same code lines.  It re-enables error reporting
> > for PCIe Upstream Ports (as well as Endpoints) under certain
> > conditions:
> >
> > https://lore.kernel.org/all/20241112135419.59491-3-xueshuai@linux.alibaba.com/
> >
> > That was originally disabled by Keith Busch (+cc) with commit
> > 9d938ea53b26 ("PCI/AER: Don't read upstream ports below fatal errors").
> >
> > There's some merge conflict potential here if your series goes into
> > the cxl tree and Shuai's patch into the pci tree in the next cycle.
> >
> > Thanks,
> >
> > Lukas  
> Thanks Lukas I took a look at the patchset and reached out to Shuai (you're CC'd). Sorry, I thought
> I responded here earlier.

I'm guessing we might not need this change if we can base querying on the
link being good.  If the error is on the CXL protocol side, the link should
still be fine I think?

Jonathan

> 
> Regards,
> Terry


