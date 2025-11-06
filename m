Return-Path: <linux-pci+bounces-40497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37197C3AC16
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 13:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FEC1AA4077
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A803168E5;
	Thu,  6 Nov 2025 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzqunKb9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52D3164CA;
	Thu,  6 Nov 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429990; cv=none; b=UAX9b13WT0h1lNka9vbjvtpLXyLvkOwQ/vM7L6tL9eGYvyYbkqXCs1UbeTpcBm2BsGkaMfdYC392PzQbj1fLZk4pFLHFDqFWI8S0YpuXkxAWSnt6CJBHpaRxgeyHuhK0hEon+v9Cox023H05fuh7/v8Tw6URrciLu8N9IRYt2Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429990; c=relaxed/simple;
	bh=hkQjCE7pxgSpBzgaoaQJ0H1mEm/rgzPD66JUwQhdzQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifz4q+0IP4nnJByWS4FgGZq33mKuZfNKqemgg3IxRXa5c3IElims1cn/x0jgkbYZlGFb+dQGl4q+BSgecDx0L+aNC16v8aolE0DVC2iEhlo0inPHIoal8S6XQunFJ06WXpqykSImdGLbPn+W8qexNJSzhWLQjmYGYGGjGu2DR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzqunKb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9308BC113D0;
	Thu,  6 Nov 2025 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762429986;
	bh=hkQjCE7pxgSpBzgaoaQJ0H1mEm/rgzPD66JUwQhdzQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzqunKb9fwdZCPmbSh9iVqT5z4iucyO+5MlKlV5waGM0sbf1BXgzKY69CWFchhByS
	 xonBsEvNTS0JOU2CF4RsgmQQ4UNRTb2ZCOpzK3J+RXUUiyQAgUeuLYULjwcSsDJ3ef
	 abqfkzd+m7J1rWoedaNmXRAmaYSS9OZ4GiUjCmEtQyZ/TFGjCxLjTuPS8wIIErpd5L
	 3PDRETv0IHjaEZ570ZDnxBMW+1fjVTGmpPAh0D1eUpBRCFItKkn6ANfmNx46X1actE
	 rOslGkFtUb5n9xNJWRUAHNLyDpSS+cDLmLQGHyJKb2OSyqmG6XzEp/wzUZuluB8y7h
	 y9js/Q28NAKpA==
Date: Thu, 6 Nov 2025 17:22:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, will@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com
Subject: Re: [PATCH 1/3] PCI: host-common: Add an API to check for any device
 under the Root Ports
Message-ID: <znlxzmn74mclx6n3gjz2oordgauygsu5jqs33kc5k34j34b5iq@ntjjj4v7pbpu>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20251106061326.8241-2-manivannan.sadhasivam@oss.qualcomm.com>
 <4aface5d-66eb-41bb-b6f3-ee8ce5d5da6b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aface5d-66eb-41bb-b6f3-ee8ce5d5da6b@oss.qualcomm.com>

On Thu, Nov 06, 2025 at 10:47:48AM +0100, Konrad Dybcio wrote:
> On 11/6/25 7:13 AM, Manivannan Sadhasivam wrote:
> > Some controller drivers need to check if there is any device available
> > under the Root Ports. So add an API that returns 'true' if a device is
> > found under any of the Root Ports, 'false' otherwise.
> > 
> > Controller drivers can use this API for usecases like turning off the
> > controller resources only if there are no devices under the Root Ports,
> > skipping PME_Turn_Off broadcast etc...
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/pci-host-common.c | 21 +++++++++++++++++++++
> >  drivers/pci/controller/pci-host-common.h |  2 ++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> > index 810d1c8de24e..6b4f90903dc6 100644
> > --- a/drivers/pci/controller/pci-host-common.c
> > +++ b/drivers/pci/controller/pci-host-common.c
> > @@ -17,6 +17,27 @@
> >  
> >  #include "pci-host-common.h"
> >  
> > +/**
> > + * pci_root_ports_have_device - Check if the Root Ports under the Root bus have
> > + *				any device underneath
> > + * @dev: Root bus
> > + *
> > + * Return: true if a device is found, false otherwise
> > + */
> > +bool pci_root_ports_have_device(struct pci_bus *root_bus)
> > +{
> > +	struct pci_bus *child;
> > +
> > +	/* Iterate over the Root Port busses and look for any device */
> > +	list_for_each_entry(child, &root_bus->children, node) {
> > +		if (list_count_nodes(&child->devices))
> 
> Is this list ever shrunk? I grepped around and couldn't find where
> that happens
> 

So I digged into this and other 'pci_bus' lists, to my shock, none of list
entries were getting dropped. I'll send out fixes for all of them.

Thanks for catching this historical issue that no one noticed before :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

