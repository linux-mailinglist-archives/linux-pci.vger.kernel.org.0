Return-Path: <linux-pci+bounces-14820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1279A2A64
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 19:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A6D1F29245
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A891DF758;
	Thu, 17 Oct 2024 17:08:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438841DE2C8;
	Thu, 17 Oct 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184901; cv=none; b=qMTf1rDh/XYomYWldWXQrc8YThJuHqTzYOm76nEnMMmBE8RbG6Q3+1uzsBx5BnEYwmql/f2g3Tjm1BfmQiM+YEEbHghhvE/LzHL8azQJuehh44Y1UnZSwQC43nXA3mq5KVGRIUencCzr2AWtftx6ueh02hVaiRI3DIbEgSVzf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184901; c=relaxed/simple;
	bh=j93455ZXaGgpi6kTTtELZ3GhwIidte/wJbX20pcw7TY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrZkkEez8w5D3SB5pD0YTafdA0stRarL9EbrPGT55/rN/z0eg0EPDcznKwrVwM/RAetOCmdaL6yAfzpI/3UgHe0SfigqjasDPyUPye7jgXwPk+Ld3u1CNiIKL4yB1l1qTNq/93ZH2h9k9eahoPVfPqk7ITJFwdelyqib0K07JyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTvLQ2bRPz6D9K8;
	Fri, 18 Oct 2024 01:03:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 31D9D14011A;
	Fri, 18 Oct 2024 01:08:14 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 19:08:13 +0200
Date: Thu, 17 Oct 2024 18:08:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Bowman, Terry" <kibowman@amd.com>
CC: Terry Bowman <Terry.Bowman@amd.com>, <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 07/15] cxl/aer/pci: Add CXL PCIe port uncorrectable
 error recovery in AER service driver
Message-ID: <20241017180811.0000306a@Huawei.com>
In-Reply-To: <c756f2e4-2fa8-413a-b6b8-2f3ca8ec27a5@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-8-terry.bowman@amd.com>
	<20241016175426.0000411e@Huawei.com>
	<ac5f05ec-5017-4ac7-b238-b90585e7a5bc@amd.com>
	<20241017144315.0000074c@Huawei.com>
	<c756f2e4-2fa8-413a-b6b8-2f3ca8ec27a5@amd.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 11:21:36 -0500
"Bowman, Terry" <kibowman@amd.com> wrote:

> Hi Jonathan,
> 
> On 10/17/2024 8:43 AM, Jonathan Cameron wrote:
> > On Wed, 16 Oct 2024 13:07:37 -0500
> > Terry Bowman <Terry.Bowman@amd.com> wrote:
> >   
> >> Hi Jonathan,
> >>
> >> On 10/16/24 11:54, Jonathan Cameron wrote:  
> >>> On Tue, 8 Oct 2024 17:16:49 -0500
> >>> Terry Bowman <terry.bowman@amd.com> wrote:
> >>>      
> >>>> The current pcie_do_recovery() handles device recovery as result of
> >>>> uncorrectable errors (UCE). But, CXL port devices require unique
> >>>> recovery handling.
> >>>>
> >>>> Create a cxl_do_recovery() function parallel to pcie_do_recovery(). Add CXL
> >>>> specific handling to the new recovery function.
> >>>>
> >>>> The CXL port UCE recovery must invoke the AER service driver's CXL port
> >>>> UCE callback. This is different than the standard pcie_do_recovery()
> >>>> recovery that calls the pci_driver::err_handler UCE handler instead.
> >>>>
> >>>> Treat all CXL PCIe port UCE errors as fatal and call kernel panic to
> >>>> "recover" the error. A panic is called instead of attempting recovery
> >>>> to avoid potential system corruption.
> >>>>
> >>>> The uncorrectable support added here will be used to complete CXL PCIe
> >>>> port error handling in the future.
> >>>>
> >>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
> >>>
> >>> Hi Terry,
> >>>
> >>> I'm a little bothered by the subtle difference in the bus walks
> >>> in here vs the existing cases. If we need them, comments needed
> >>> to explain why.
> >>>      
> >>
> >> Yes, I will add more details in the commit message about "why".
> >> I added explanation following your below comment.
> >>  
> >>> If we are going to have separate handling, see if you can share
> >>> a lot more of the code by factoring out common functions for
> >>> the pci and cxl handling with callbacks to handle the differences.
> >>>      
> >>
> >> Dan requested separate paths for the PCIe and CXL recovery. The intent,
> >> as I understand, is to isolate the handling of PCIe and CXL protocol
> >> errors. This is to create 2 different classes of protocol errors.  
> > Function call chain wise I'm reasonably convinced that might be a good
> > idea.  But not code wise if it means we end up with more hard to review
> > code.
> >   
> >>  
> >>> I've managed to get my head around this code a few times in the past
> >>> (I think!) and really don't fancy having two subtle variants to
> >>> consider next time we get a bug :( The RC_EC additions hurt my head.
> >>>
> >>> Jonathan  
> >>
> >> Right, the UCE recovery logic is not straightforward. The code can  be
> >> refactored to take advantage of reuse. I'm interested in your thoughts
> >> after I have provided some responses here.
> >>  
> >>>      
> >>>>   static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> >>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> >>>> index 31090770fffc..de12f2eb19ef 100644
> >>>> --- a/drivers/pci/pcie/err.c
> >>>> +++ b/drivers/pci/pcie/err.c
> >>>> @@ -86,6 +86,63 @@ static int report_error_detected(struct pci_dev *dev,
> >>>>   	return 0;
> >>>>   }
> >>>>   
> >>>> +static int cxl_report_error_detected(struct pci_dev *dev,
> >>>> +				     pci_channel_state_t state,
> >>>> +				     enum pci_ers_result *result)
> >>>> +{
> >>>> +	struct cxl_port_err_hndlrs *cxl_port_hndlrs;
> >>>> +	struct pci_driver *pdrv;
> >>>> +	pci_ers_result_t vote;
> >>>> +
> >>>> +	device_lock(&dev->dev);
> >>>> +	cxl_port_hndlrs = find_cxl_port_hndlrs();  
> >>>
> >>> Can we refactor to have a common function under this and report_error_detected()?
> >>>      
> >>
> >> Sure, this can be refactored.
> >>
> >> The difference between cxl_report_error_detected() and report_error_detected() is the
> >> handlers that are called.
> >>
> >> cxl_report_error_detected() calls the CXL driver's registered port error handler.
> >>
> >> report_error_recovery() calls the pcie_dev::err_handlers.
> >>
> >> Let me know if I should refactor for common code here?  
> > 
> > It certainly makes sense to do that somewhere in here.  Just have light
> > wrappers that provide callbacks so the bulk of the code is shared.
> >   
> 
> Ok, Ill start on that. I have a v2 ready to-go without the reuse changes.
> You want me to wait on sending v2 till it has reuse refactoring?

I'd imagine we might have some time after v2, so go ahead - experiments
with refactoring can come later.


> >>>> + */
> >>>> +static void cxl_walk_bridge(struct pci_dev *bridge,
> >>>> +			    int (*cb)(struct pci_dev *, void *),
> >>>> +			    void *userdata)
> >>>> +{
> >>>> +	cb(bridge, userdata);
> >>>> +	if (bridge->subordinate)
> >>>> +		pci_walk_bus(bridge->subordinate, cb, userdata);  
> >>> The difference between this and pci_walk_bridge() is subtle and
> >>> I'd like to avoid having both if we can.
> >>>      
> >>
> >> The cxl_walk_bridge() was added because pci_walk_bridge() does not report
> >> CXL errors as needed. If the erroring device is a bridge then pci_walk_bridge()
> >> does not call report_error_detected() for the root port itself. If the bridge
> >> is a CXL root port then the CXL port error handler is not called. This has 2
> >> problems: 1. Error logging is not provided, 2. A result vote is not provided
> >> by the root port's CXL port handler.  
> > 
> > So what happens for PCIe errors on the root port?  How are they reported?
> > What I'm failing to understand is why these should be different.
> > Maybe there is something missing on the PCIe side though!
> > That code plays a game with what bridge and I thought that was there to handle
> > this case.
> >   
> 
> PCIe errors (not CXL errors) on a root port will be processed as they are today.
Sure, I was just failing to understand why the code didn't need to check
for error_detected on the root port, but the CXL code does.

> 
> An AER error is treated as a CXL error if *all* of the following are met:
> - The AER error is not an internal error
>     - Check is in AER's is_internal_error(info) function.
> - The device is not a CXL device
>     - Check is in AER's handles_cxl_errors() function.
> 
> Root port device PCIe error processing will not call the the pci_dev::err_handlers::error_detected().
> because of the walk_bridge() implementation. The result vote to direct handling
> is determined by downstream devices. This has probably been Ok until now because ports have been
> fairly vanilla and standard until CXL.

Ah. Got it - Root ports didn't have the handler.
So is there any harm in making them run it? (well not as they don't have it -
actually they do.  There is one in portdrv)
That way the two codes look more similar.  Also, does this mean there were
runtime pm and other calls that didn't hit the root port for PCIe that should have
done?

Comes back to I don't want too complex bits of code.  I'm fine with changing
the PCIe one to add new handling needed for CXL.

Just to be clear I'm fine with totally separate call paths just with lots
of code reuse.   That may mean a few precursor patches touching only the
PCIe code to make it fit for reuse.

Jonathan



> 
> 
> >>  
> >>>> +}
> >>>> +
> >>>>   pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >>>>   		pci_channel_state_t state,
> >>>>   		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
> >>>> @@ -276,3 +355,74 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >>>>   
> >>>>   	return status;
> >>>>   }
> >>>> +
> >>>> +pci_ers_result_t cxl_do_recovery(struct pci_dev *bridge,
> >>>> +				 pci_channel_state_t state,
> >>>> +				 pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
> >>>> +{
> >>>> +	struct pci_host_bridge *host = pci_find_host_bridge(bridge->bus);
> >>>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> >>>> +	int type = pci_pcie_type(bridge);
> >>>> +
> >>>> +	if ((type != PCI_EXP_TYPE_ROOT_PORT) &&
> >>>> +	    (type != PCI_EXP_TYPE_RC_EC) &&
> >>>> +	    (type != PCI_EXP_TYPE_DOWNSTREAM) &&
> >>>> +	    (type != PCI_EXP_TYPE_UPSTREAM)) {
> >>>> +		pci_dbg(bridge, "Unsupported device type (%x)\n", type);
> >>>> +		return status;
> >>>> +	}
> >>>> +  
> >>>
> >>> Would similar trick to in pcie_do_recovery work here for the upstream
> >>> and downstream ports use pci_upstream_bridge() and for the others pass the dev into
> >>> pci_walk_bridge()?
> >>>      
> >>
> >> Yes, that would be a good starting point to begin reuse refactoring.
> >> I'm interested in getting yours and others feedback on the separation of the
> >> PCI and CXL protocol errors and how much separation is or not needed.  
> > 
> > Separation may make sense (I'm still thinking about it) for separate passes
> > through the topology and separate callbacks / handling when an error is seen.
> > What I don't want to see is two horribly complex separate walking codes if
> > we can possibly avoid it.  Long term to me that just means two sets of bugs
> > and problem corners instead of one.
> > 
> > Jonathan
> >   
> 
> I understand. I will look to make changes here for reuse.
> 
> Regards,
> Terry
> 


