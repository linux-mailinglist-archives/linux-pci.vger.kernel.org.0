Return-Path: <linux-pci+bounces-4949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA5881070
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9502B23D01
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E273B29D;
	Wed, 20 Mar 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDhdqYzI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58F3B298
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932905; cv=none; b=knxkquxeae8MMHvlYltJ8PXJV862Vn8YM2ZL1gEgQlh1wdTcAAA4WVrw3pIlfk0KEw+qkUAD6Ub79yM9z6bRb4Gyb4rfulQDL/+8tmp1Z3rqJr7BX3xP8lrChAkZEA8R9cSdSAGfMp5FlMcaYpfvh7ursIJR5Zt+WXYB9bAtPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932905; c=relaxed/simple;
	bh=DkOnaWGB73TJBKkkuy16qIWC7CFg5RqE++B4C5xBZ0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNklheftJmNCCbjVTn+LsM2tLjPqW52UWGV3MxtfjKVfKDceflN4Kl9T4wAwsa+2/OwaK47AHXRjsDtgpEiV7vtQbvOFXqmVKBkvRObLYjSeNBCUd/tb6SOviRBE3fsXfem6FjevbdW9EDihB3qroBY3coW0MvVgxgjpQ5hoRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDhdqYzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C45C433C7;
	Wed, 20 Mar 2024 11:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710932905;
	bh=DkOnaWGB73TJBKkkuy16qIWC7CFg5RqE++B4C5xBZ0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDhdqYzIbvyJkg8giYgchbLqRXoORm8TBonBLew7IM+zC6iyGs37jshPpvj60jujp
	 8gcqFn5TaAmg/YLGZNf4BQEGqo/+fYwWnbJMb32LKOUlgfgC1wMKGZDdfupBfozQZZ
	 YZk2MTpprkimc5VDPgLzvKsLeNUvO7L8avDptpoNqLA0e0RUATg2CfBSN7gY5Lwadg
	 46uOacqcZe6Yb+hP1oN6v93IZ4fnIzHxxCeVbXQEFJZd97MWrpCxJczuDB+70ox4i8
	 ojPUIIkICtFT2I48AQGk6+AbcIsSKjMXyXKo/880n42o8PZ9ksFQlqx0p+GCWRUC4j
	 PF3T+rEqbngYQ==
Date: Wed, 20 Mar 2024 12:08:20 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 5/9] PCI: endpoint: pci-epf-test: Simplify
 pci_epf_test_set_bar() loop
Message-ID: <ZfrDpEICLk4BXI1V@ryzen>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-6-cassel@kernel.org>
 <20240315053903.GE3375@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315053903.GE3375@thinkpad>

On Fri, Mar 15, 2024 at 11:09:03AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 13, 2024 at 11:57:57AM +0100, Niklas Cassel wrote:
> > Simplify the loop in pci_epf_test_set_bar().
> > If we allocated memory for the BAR, we need to call set_bar() for that
> > BAR, if we did not allocated memory for that BAR, we need to skip.
> > It is as simple as that. This also matches the logic in
> > pci_epf_test_unbind().
> > 
> > A 64-bit BAR will still only be one allocation, with the BAR succeeding
> > the 64-bit BAR being null.
> > 
> > While at it, remove the misleading comment.
> > A EPC .set_bar() callback should never change the epf_bar->flags.
> > (E.g. to set a 64-bit BAR if we requested a 32-bit BAR.)
> > 
> > A .set_bar() callback should do what we request it to do.
> > If it can't satisfy the request, it should return an error.
> > 
> 
> That's a valid assumption. But...
> 
> > If platform has a specific requirement, e.g. that a certain BAR has to
> > be a 64-bit BAR, then it should specify that by setting the .only_64bit
> > flag for that specific BAR in epc_features->bar[], such that
> > pci_epf_alloc_space() will return a epf_bar with the 64-bit flag set.
> > (Such that .set_bar() will receive a request to set a 64-bit BAR.)
> > 
> 
> Looks like pcie-cadence-ep is setting the PCI_BASE_ADDRESS_MEM_TYPE_64 flag if
> the requested size is >2GB (I don't know why 2GB instead of 4GB in the first
> place).

That is dead code that will never be able to execute.

Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
is invalid if 64-bit flag is not set") it has been impossible to get the
.set_bar() callback with a BAR size > 2 GB.

Yes, 2GB!
The author of f25b5fae29d4 is an idiot (yes, it is me).
Anyway, the code itself in that commit is doing the right thing...

2GB is the maximum size of a 32-bit BAR.

So, since the the code in pcie-cadence-ep is dead code, I don't see
any problem with this commit.


Kind regards,
Niklas


> 
> - Mani
> 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 21 ++++---------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 20c79610712d..91bbfcb1b3ed 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -709,31 +709,18 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
> >  
> >  static int pci_epf_test_set_bar(struct pci_epf *epf)
> >  {
> > -	int bar, add;
> > -	int ret;
> > -	struct pci_epf_bar *epf_bar;
> > +	int bar, ret;
> >  	struct pci_epc *epc = epf->epc;
> >  	struct device *dev = &epf->dev;
> >  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> >  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> > -	const struct pci_epc_features *epc_features;
> > -
> > -	epc_features = epf_test->epc_features;
> >  
> > -	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
> > -		epf_bar = &epf->bar[bar];
> > -		/*
> > -		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> > -		 * if the specific implementation required a 64-bit BAR,
> > -		 * even if we only requested a 32-bit BAR.
> > -		 */
> > -		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> > -
> > -		if (epc_features->bar[bar].type == BAR_RESERVED)
> > +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> > +		if (!epf_test->reg[bar])
> >  			continue;
> >  
> >  		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
> > -				      epf_bar);
> > +				      &epf->bar[bar]);
> >  		if (ret) {
> >  			pci_epf_free_space(epf, epf_test->reg[bar], bar,
> >  					   PRIMARY_INTERFACE);
> > -- 
> > 2.44.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

