Return-Path: <linux-pci+bounces-28235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E1ABFCE3
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 20:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9D51BA14BD
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 18:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A282B28313D;
	Wed, 21 May 2025 18:34:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAD1A238F;
	Wed, 21 May 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747852461; cv=none; b=Rakw71qM/ujBol2WLXU4F6yxmeMSXHFoBYkZX00v1a5iaThrmcv2BcMHFick3NB4CWz/gNj991Br8DR3AGnbfIWuSfuvxF6LcvfSOrIdDKdFNAEEpv/HjDhZ8+nH/SgV4LlYuuIsu01vVi6Jp7azOGJVYKULK53HHfnJ/A7K3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747852461; c=relaxed/simple;
	bh=cVcb+HY9Nrvbsv5Qtmi2xhRaCYXYDMYqPJnXyGAmF6c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6hSx82NeLiqD3+EogGuVqw8kORasAwvECyQhvotkuZ45SqAJSXaPwguRKVhK0MBH1rjHWD22WRMhfamK3xSz0KP5j8ojxPL8egbo97o7mrCFbTlsVnl3r0f+bgkYhclH8cUzEbq6Owe92AbDVoDlGWpWy+CqgFV7I94DaTmaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2g1b60CPz6GC2Q;
	Thu, 22 May 2025 02:29:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D7EB1402F7;
	Thu, 22 May 2025 02:34:15 +0800 (CST)
Received: from localhost (10.195.34.206) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 20:34:14 +0200
Date: Wed, 21 May 2025 19:34:12 +0100
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
Message-ID: <20250521193412.000067b3@huawei.com>
In-Reply-To: <46c962de-a691-4e67-9af6-5765225633ae@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-5-terry.bowman@amd.com>
	<20250423160443.00006ee0@huawei.com>
	<e473fbc9-8b46-4e76-8653-98b84f6b93a6@amd.com>
	<20250425141849.00003c92@huawei.com>
	<8042c08a-42f0-49d5-b619-26bfc8e6f853@amd.com>
	<20250520120446.000022b2@huawei.com>
	<46c962de-a691-4e67-9af6-5765225633ae@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 20 May 2025 08:21:18 -0500
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 5/20/2025 6:04 AM, Jonathan Cameron wrote:
> > On Thu, 15 May 2025 16:52:15 -0500
> > "Bowman, Terry" <terry.bowman@amd.com> wrote:
> >  
> >> On 4/25/2025 8:18 AM, Jonathan Cameron wrote:  
> >>> On Thu, 24 Apr 2025 09:17:45 -0500
> >>> "Bowman, Terry" <terry.bowman@amd.com> wrote:
> >>>    
> >>>> On 4/23/2025 10:04 AM, Jonathan Cameron wrote:    
> >>>>> On Wed, 26 Mar 2025 20:47:05 -0500
> >>>>> Terry Bowman <terry.bowman@amd.com> wrote:
> >>>>>      
> >>>>>> The AER service driver includes a CXL-specific kfifo, intended to forward
> >>>>>> CXL errors to the CXL driver. However, the forwarding functionality is
> >>>>>> currently unimplemented. Update the AER driver to enable error forwarding
> >>>>>> to the CXL driver.
> >>>>>>
> >>>>>> Modify the AER service driver's handle_error_source(), which is called from
> >>>>>> process_aer_err_devices(), to distinguish between PCIe and CXL errors.
> >>>>>>
> >>>>>> Rename and update is_internal_error() to is_cxl_error(). Ensuring it
> >>>>>> checks both the 'struct aer_info::is_cxl' flag and the AER internal error
> >>>>>> masks.
> >>>>>>
> >>>>>> If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
> >>>>>> as done in the current AER driver.
> >>>>>>
> >>>>>> If the error is a CXL-related error then forward it to the CXL driver for
> >>>>>> handling using the kfifo mechanism.
> >>>>>>
> >>>>>> Introduce a new function forward_cxl_error(), which constructs a CXL
> >>>>>> protocol error context using cxl_create_prot_err_info(). This context is
> >>>>>> then passed to the CXL driver via kfifo using a 'struct work_struct'.
> >>>>>>
> >>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>      
> >>>>> Hi Terry,
> >>>>>
> >>>>> Finally got back to this.  I'm not following how some of the reference
> >>>>> counting in here is working.  It might be fine but there is a lot
> >>>>> taking then dropping device references - some of which are taken again later.
> >>>>>      
> >>>>>> @@ -1082,10 +1094,44 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> >>>>>>  	pci_info(rcec, "CXL: Internal errors unmasked");
> >>>>>>  }
> >>>>>>  
> >>>>>> +static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
> >>>>>> +{
> >>>>>> +	int severity = info->severity;      
> >>>>> So far this variable isn't really justified.  Maybe it makes sense later in the
> >>>>> series?      
> >>>> This is used below in call to cxl_create_prot_err_info().    
> >>> Sure, but why not just do
> >>>
> >>> if (cxl_create_prot_error_info(pdev, info->severity, &wd.err_info)) {
> >>>
> >>> There isn't anything modifying info->severity in between so that local
> >>> variable is just padding out the code to no real benefit.
> >>>
> >>>    
> >>>>>> +		pci_err(pdev, "Failed to create CXL protocol error information");
> >>>>>> +		return;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);      
> >>>>> Also this one.  A reference was acquired and dropped in cxl_create_prot_err_info()
> >>>>> followed by retaking it here.  How do we know it is still about by this call
> >>>>> and once we pull it off the kfifo later?      
> >>>> Yes, this is a problem I realized after sending the series.
> >>>>
> >>>> The device reference incr could be changed for all the devices to the non-cleanup
> >>>> variety. Then would add the reference incr in the caller after calling cxl_create_prot_err_info().
> >>>> I need to look at the other calls to to cxl_create_prot_err_info() as well.
> >>>>
> >>>> In addition, I think we should consider adding the CXL RAS status into the struct cxl_prot_err_info.
> >>>> This would eliminate the need for further accesses to the CXL device after being dequeued from the
> >>>> fifo. Thoughts?    
> >>> That sounds like a reasonable solution to me.
> >>>
> >>> Jonathan    
> >> Hi Jonathan,  
> > Hi Terry,
> >
> > Sorry for delay - travel etc...
> >  
> >> Is it sufficient to rely on correctly implemented reference counting implementation instead
> >> of caching the RAS status I mentioned earlier?
> >>
> >> I have the next revision coded to 'get' the CXL erring device's reference count in the AER
> >> driver before enqueuing in the kfifo and then added a reference count 'put' in the CXL driver
> >> after dequeuing and handling/logging. This is an alternative to what I mentioned earlier reading
> >> the RAS status and caching it. One more question: is it OK to implement the get and put (of
> >> the same object) in different drivers?  
> > It's definitely unusual.  If there is anything similar to point at I'd be happier than
> > this 'innovation' showing up here first. 
> >  
> >> If we need to read and cache the RAS status before the kfifo enqueue there will be some other
> >> details to work through.  
> > This still smells like the cleaner solution to me, but depends on those details..
> >
> > Jonathan  
> 
> In this case I believe we will need to move the CE handling (RAS status reading and clearing) before
> the kfifo enqueue. I think this is necessary because CXL errors may continue to be received and we
> don't want their status's combined when reading or clearing. I can refactor cxl_handle_ras()/
> cxl_handle_cor_ras() to return the RAS status value and remove the trace logging (to instead be
> called after kfifo dequeue).
> 
> This leaves the UCE case. It's worth mentioning the UCE flow is different than the the CE case
> because it uses the top-bottom traversal starting at the erring device. Correct me if I'm wrong
> this would be handled before the kfifo as well. The handling and logging in the UCE case are
> baked together. The UCE flow would therefore need to include the trace logging during handling.
> 
> Another flow is the PCI EP errors. The PCIe EP CE and UCE handlers remain and can call the
> the refactored cxl_handle_ras()/cxl_handle_cor_ras() and then trace log afterwards. This is no
> issue.
> 
> This leaves only CE trace logging to be called after the kfifo dequeue. This is what doesn't
> feel right and wanted to draw attention to.
> 
> All this to say: very little work will be done after the kfifo dequeue. Most of the work in
> the kfifo implementation would be before the kfifo enqueuing in the CXL create_prot_error_info()
> callback. I am concerned the balance of work done before and after the kfifo enqueue/dequeue
> will be very asymmetric with little value provided from the kfifo.
> 
As per the discord chat - if you look up the device again from BDF or similar and get this
info once you have right locks post kfifo all should be fine as any race will be easy
to resolve by doing nothing if the driver has gone away.

Jonathan

> -Terry
> 


