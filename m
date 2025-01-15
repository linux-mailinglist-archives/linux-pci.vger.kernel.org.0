Return-Path: <linux-pci+bounces-19884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D1A122D7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766B9165542
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C723F266;
	Wed, 15 Jan 2025 11:41:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E024025B;
	Wed, 15 Jan 2025 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941264; cv=none; b=kITK7N1zz9QnZM1OUpQW7aLBa9z9dP+SnwnwBbrHyC9DgQdhKr+RSSdaEgHyg+y7GqnPhz9Lm320mg6tyZQAsCvz+ST54F1z/P7q1ZUWqGYco+2n4+y3E9XsZhgkAzQXA8wd8sEQnx0WQ3iGgWtQZXTlpeWYIA6PQPq+OX0IlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941264; c=relaxed/simple;
	bh=0UvVrp5ys7d+x3PAsgUSytnXVdNAcM/C/5ZKYZ95F+E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVntIKLuUOidSPM5SlxX8NYHCafFjQiYcVmFpiUMLWYvCulfRLrWyqxaooGjHYUFGsOnI6gn+HPScnr8FHfTFpMfxe6OfhQW1clAGxaOhPEzG6j5wIP6djU/kcpTGQxgPr+7Sxzb7aLFm+Vf6dcDSk9WUWhTQnV/u9pMnmB7N7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY3tW0R2qz6M4Lm;
	Wed, 15 Jan 2025 19:39:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D803140257;
	Wed, 15 Jan 2025 19:41:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 15 Jan
 2025 12:40:59 +0100
Date: Wed, 15 Jan 2025 11:40:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
CC: Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 09/16] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
Message-ID: <20250115114057.00003b3e@huawei.com>
In-Reply-To: <ca86563a-f75b-474d-8211-c7a86e5f5790@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-10-terry.bowman@amd.com>
	<6786df12594c5_186d9b294ba@iweiny-mobl.notmuch>
	<73855ef4-7540-486f-9a4d-e73cfd286216@amd.com>
	<6786f5845635d_195f0e29413@iweiny-mobl.notmuch>
	<ca86563a-f75b-474d-8211-c7a86e5f5790@amd.com>
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

On Tue, 14 Jan 2025 17:49:44 -0600
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 1/14/2025 5:38 PM, Ira Weiny wrote:
> > Bowman, Terry wrote:  
> >>
> >>
> >> On 1/14/2025 4:02 PM, Ira Weiny wrote:  
> >>> Terry Bowman wrote:  
> >>>> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
> >>>>
> >>>> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
> >>>> pointer to the CXL Upstream Port's mapped RAS registers.
> >>>>
> >>>> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
> >>>> register mapping. This is similar to the existing
> >>>> cxl_dport_init_ras_reporting() but for USP devices.
> >>>>
> >>>> The USP may have multiple downstream endpoints. Before mapping AER
> >>>> registers check if the registers are already mapped.
> >>>>
> >>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >>>> ---
> >>>>  drivers/cxl/core/pci.c | 15 +++++++++++++++
> >>>>  drivers/cxl/cxl.h      |  4 ++++
> >>>>  drivers/cxl/mem.c      |  8 ++++++++
> >>>>  3 files changed, 27 insertions(+)
> >>>>
> >>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >>>> index 1af2d0a14f5d..97e6a15bea88 100644
> >>>> --- a/drivers/cxl/core/pci.c
> >>>> +++ b/drivers/cxl/core/pci.c
> >>>> @@ -773,6 +773,21 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> >>>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> >>>>  }
> >>>>  
> >>>> +void cxl_uport_init_ras_reporting(struct cxl_port *port)
> >>>> +{
> >>>> +	/* uport may have more than 1 downstream EP. Check if already mapped. */
> >>>> +	if (port->uport_regs.ras)
> >>>> +		return;
> >>>> +
> >>>> +	port->reg_map.host = &port->dev;
> >>>> +	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
> >>>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> >>>> +		dev_err(&port->dev, "Failed to map RAS capability.\n");
> >>>> +		return;  
> >>> Why return here?  Actually I think 8/16 had the same issue now that I see
> >>> this.
> >>>
> >>> Other than that:
> >>>
> >>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >>>
> >>> [snip]  
> >> If RAS registers fail mapping then exit to avoid CXL Port error handler initialization.
> >> The CXL Port error handlers rely on RAS registers for logging and without mapped RAS
> >> registers the error handlers will return immediately.  
> > Sorry I was not clear and I should not have clipped the text so much.  You
> > return in a block which is at the end of the function:
> >
> >
> > +void cxl_uport_init_ras_reporting(struct cxl_port *port)
> > +{
> > +       /* uport may have more than 1 downstream EP. Check if already mapped. */
> > +       if (port->uport_regs.ras)
> > +               return;
> > +
> > +       port->reg_map.host = &port->dev;
> > +       if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
> > +                                  BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> > +               dev_err(&port->dev, "Failed to map RAS capability.\n");
> > +               return;
> > +       }
> > +}
> >
> > So no need for this specific statement?
> >
> > Ira  
> 
> I wrote it this way to add the handler initialization (after the return) in later patch
> without a diff removal. But, your correct, I can remove the 'return' statement in this patch
> and add in later patch without cluttering the diff.
> 
> Thanks. I'll make the change.
> 
Leave it as it stands.  I'm sure Ira doesn't mind given the additions later.
I'd prefer we keep things clean across the series.

Jonathan

> Regards,
> Terry
> 
> 
> 


