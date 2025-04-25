Return-Path: <linux-pci+bounces-26755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B5A9C9FC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 15:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869DA7A47A1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543A01BC3F;
	Fri, 25 Apr 2025 13:18:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995EE1805A;
	Fri, 25 Apr 2025 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587137; cv=none; b=p6qGDyUVQbs9Y67Tj6gUxe794WPIo/vIsgPaXXnQQ3E3PTPGHxGqzBNrL5c/J7h9NB0fOcccRnxpo5JHXGtpgCdkfR1skaJguYYFm9qmGQZ9ZVQXt08gVwvm75JnT2mUYqIRD5PLZ/g5m3JEXlrC0rqVAfmkcvFd6WtKiFpVjkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587137; c=relaxed/simple;
	bh=GkamC2rWovlJbCByU0gcXkWzvk2KsH8qmuNFe/IrxiA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m++DsDnZ522Yn+HMzW/fyspuSpp3KhI9cvmMIgxj/tPOCq0zxKbH9ZInxOsUEMRuf0V+B710XmegZUr+iI+iqEMpbEkumEYhnWP+yLqDy54qQtEVndhsEIiGD1tag36PQ40DQy8YWpIgo6r8hVY9fjRhcIwrYvAgQF+enn0XTWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZkYGQ5ZpHz6M4Hf;
	Fri, 25 Apr 2025 21:14:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 39DD71404F5;
	Fri, 25 Apr 2025 21:18:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Apr
 2025 15:18:50 +0200
Date: Fri, 25 Apr 2025 14:18:49 +0100
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
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error
 to CXL driver
Message-ID: <20250425141849.00003c92@huawei.com>
In-Reply-To: <e473fbc9-8b46-4e76-8653-98b84f6b93a6@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-5-terry.bowman@amd.com>
	<20250423160443.00006ee0@huawei.com>
	<e473fbc9-8b46-4e76-8653-98b84f6b93a6@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 24 Apr 2025 09:17:45 -0500
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 4/23/2025 10:04 AM, Jonathan Cameron wrote:
> > On Wed, 26 Mar 2025 20:47:05 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >  
> >> The AER service driver includes a CXL-specific kfifo, intended to forward
> >> CXL errors to the CXL driver. However, the forwarding functionality is
> >> currently unimplemented. Update the AER driver to enable error forwarding
> >> to the CXL driver.
> >>
> >> Modify the AER service driver's handle_error_source(), which is called from
> >> process_aer_err_devices(), to distinguish between PCIe and CXL errors.
> >>
> >> Rename and update is_internal_error() to is_cxl_error(). Ensuring it
> >> checks both the 'struct aer_info::is_cxl' flag and the AER internal error
> >> masks.
> >>
> >> If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
> >> as done in the current AER driver.
> >>
> >> If the error is a CXL-related error then forward it to the CXL driver for
> >> handling using the kfifo mechanism.
> >>
> >> Introduce a new function forward_cxl_error(), which constructs a CXL
> >> protocol error context using cxl_create_prot_err_info(). This context is
> >> then passed to the CXL driver via kfifo using a 'struct work_struct'.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
> > Hi Terry,
> >
> > Finally got back to this.  I'm not following how some of the reference
> > counting in here is working.  It might be fine but there is a lot
> > taking then dropping device references - some of which are taken again later.
> >  
> >> @@ -1082,10 +1094,44 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> >>  	pci_info(rcec, "CXL: Internal errors unmasked");
> >>  }
> >>  
> >> +static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
> >> +{
> >> +	int severity = info->severity;  
> > So far this variable isn't really justified.  Maybe it makes sense later in the
> > series?  
> 
> This is used below in call to cxl_create_prot_err_info().
Sure, but why not just do

if (cxl_create_prot_error_info(pdev, info->severity, &wd.err_info)) {

There isn't anything modifying info->severity in between so that local
variable is just padding out the code to no real benefit.


> 
> >> +		pci_err(pdev, "Failed to create CXL protocol error information");
> >> +		return;
> >> +	}
> >> +
> >> +	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);  
> > Also this one.  A reference was acquired and dropped in cxl_create_prot_err_info()
> > followed by retaking it here.  How do we know it is still about by this call
> > and once we pull it off the kfifo later?  
> 
> Yes, this is a problem I realized after sending the series.
> 
> The device reference incr could be changed for all the devices to the non-cleanup
> variety. Then would add the reference incr in the caller after calling cxl_create_prot_err_info().
> I need to look at the other calls to to cxl_create_prot_err_info() as well.
> 
> In addition, I think we should consider adding the CXL RAS status into the struct cxl_prot_err_info.
> This would eliminate the need for further accesses to the CXL device after being dequeued from the
> fifo. Thoughts?

That sounds like a reasonable solution to me.

Jonathan


