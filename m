Return-Path: <linux-pci+bounces-19400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF218A03DCA
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590731886CD4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6455193062;
	Tue,  7 Jan 2025 11:32:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A141DF73A;
	Tue,  7 Jan 2025 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249569; cv=none; b=DsfSrHpFyRKNUhqEm0yxgIAWNojfR8G0yUUtoLwxhwfeqLfinCfEgKS7P15HeSQ7U3iGH4+jCRBaV7tMoyBW9jJFjsL/PkV+gfdiintf7mukc5lgl2c+SSaPKZk2NIoSyrf99WcCAUpqE5WYYcROvJr3wDqhzLZkxcHLOJHwioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249569; c=relaxed/simple;
	bh=InF2jrVlsuucDKWesCnUio0WNs/om6qiMKJm/t4LKTo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZoCYV/gEQIxA91DxlYTNn8FF3mL7dmVzpKuk7+nB5SgJ5n0w4GyelKTiC9QCv6Soc9OEYAhI5lmi2k83MiJk+puZkOoD5TgkvG/UhA1GDJfOo2kGGWUJeNtbSltbV3fGftCZQvkCgqa1ATWLJM8kGi1tV07BXsI+Nod7Km67bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YS81Q5yLPz6JBBN;
	Tue,  7 Jan 2025 19:28:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 34C6D1409EA;
	Tue,  7 Jan 2025 19:32:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 7 Jan
 2025 12:32:42 +0100
Date: Tue, 7 Jan 2025 11:32:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <PradeepVineshReddy.Kodamati@amd.com>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v4 14/15] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
Message-ID: <20250107113240.00003eda@huawei.com>
In-Reply-To: <0d552424-150e-4b92-8326-0fe6387e0ce6@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
	<20241211234002.3728674-15-terry.bowman@amd.com>
	<20241224185000.00001a5f@huawei.com>
	<0d552424-150e-4b92-8326-0fe6387e0ce6@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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

On Thu, 26 Dec 2024 11:07:13 -0600
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 12/24/2024 12:50 PM, Jonathan Cameron wrote:
> > On Wed, 11 Dec 2024 17:40:01 -0600
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >  
> >> pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
> >> The handlers can't be set in the pci_driver static definition because the
> >> CXL PCIe Port devices are bound to the portdrv driver which is not CXL
> >> driver aware.
> >>
> >> Add cxl_assign_port_error_handlers() in the cxl_core module. This
> >> function will assign the default handlers for a CXL PCIe Port device.
> >>
> >> When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
> >> pci_driver::cxl_err_handlers must be set to NULL indicating they should no
> >> longer be used.
> >>
> >> Create cxl_clear_port_error_handlers() and register it to be called
> >> when the CXL Port device (cxl_port or cxl_dport) is destroyed.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> ---
> >>  drivers/cxl/core/pci.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 40 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index 3294ad5ff28f..9734a4c55b29 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -841,8 +841,38 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
> >>  	return __cxl_handle_ras(&pdev->dev, ras_base);
> >>  }
> >>  
> >> +static const struct cxl_error_handlers cxl_port_error_handlers = {
> >> +	.error_detected	= cxl_port_error_detected,
> >> +	.cor_error_detected = cxl_port_cor_error_detected,
> >> +};
> >> +
> >> +static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
> >> +{
> >> +	struct pci_driver *pdrv;
> >> +
> >> +	if (!pdev || !pdev->driver)
> >> +		return;
> >> +
> >> +	pdrv = pdev->driver;  
> > What stops a race here?  It's fiddly to remove that driver but
> > it can be done.  At least I think we are messing withe portdrv
> > but this is such a fiddly stack I'm not 100% sure.
> >  
> >> +	pdrv->cxl_err_handler = &cxl_port_error_handlers;
> >> +}
> >> +
> >> +static void cxl_clear_port_error_handlers(void *data)
> >> +{
> >> +	struct pci_dev *pdev = data;
> >> +	struct pci_driver *pdrv;
> >> +
> >> +	if (!pdev || !pdev->driver)
> >> +		return;
> >> +
> >> +	pdrv = pdev->driver;  
> > Likewise. Smells like a possible race.
> >  
> >> +	pdrv->cxl_err_handler = NULL;
> >> +}
> >> +  
> 
> I can add a get_device()/put_device() for both cxl_clear_port_error_handlers() and cxl_assign_port_error_handlers() to prevent operating on a recently destroyed pci_dev. Is that sufficient? Regards, Terry

Probably (by which I mean I think it is, but haven't checked in detail)

Jonathan
> >>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
> >>  {
> >> +	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
> >> +
> >>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
> >>  	if (port->uport_regs.ras)
> >>  		return;
> >> @@ -853,6 +883,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
> >>  		dev_err(&port->dev, "Failed to map RAS capability.\n");
> >>  		return;
> >>  	}
> >> +
> >> +	cxl_assign_port_error_handlers(pdev);
> >> +	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
> >>  
> >> @@ -864,6 +897,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
> >>  {
> >>  	struct device *dport_dev = dport->dport_dev;
> >>  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
> >> +	struct pci_dev *pdev = to_pci_dev(dport_dev);
> >>  
> >>  	dport->reg_map.host = dport_dev;
> >>  	if (dport->rch && host_bridge->native_aer) {
> >> @@ -880,6 +914,12 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
> >>  		dev_err(dport_dev, "Failed to map RAS capability.\n");
> >>  		return;
> >>  	}
> >> +
> >> +	if (dport->rch)
> >> +		return;
> >> +
> >> +	cxl_assign_port_error_handlers(pdev);
> >> +	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
> >>    
> 


