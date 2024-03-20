Return-Path: <linux-pci+bounces-4950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48987881088
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C912AB23536
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06CD39FFB;
	Wed, 20 Mar 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLQQpcSm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98E3D551
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933065; cv=none; b=J/nHErgTP/uQFNDAx3pHJulaGo+zKIs8yQ8qcxikutR9aVsanbC01TUUMDR1i585KPU27z9y9Wc6NLl58CCW/sJGkseACuDEsPZr0O+lN8y2nmrLfm1rJHaz55aNe5KoYEuX9S39kzHvKtnVco/1Mni60N/1iZNBRGxhQPBcGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933065; c=relaxed/simple;
	bh=0Vi1KV07BIo9fcH6LV4fiwCETDkpwVuh1gq2NaDmShg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHpW3rIuqNSh6r4tic/Yc+Vm2UvWukE/CimgAMIwGh6WFScSZ5CkfrM6DSms4AiU0nOnGn2/huQAI7oqqlk2f/HCOBKalF65am0tPtwD4H6C39qBoxBdwLhVBv9MoYW7eJ10mNQktst1rq1OMhfSNkLjhu3W/XLBwwYS42vZQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLQQpcSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46616C433F1;
	Wed, 20 Mar 2024 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710933065;
	bh=0Vi1KV07BIo9fcH6LV4fiwCETDkpwVuh1gq2NaDmShg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLQQpcSmiJcfOimwUP0OitkujYBwUV0Rx5v9ahCgNRnZFAdyRZnzjQsWyp1nbgYLd
	 0mMkZ5zQ8EMIrE/nFQpGlRybkH5PEAwtsB54kPu+wYPxZ2jnsEgAoz+jQm1CXpCfTM
	 6yXZ9Qm92/vWvpEJrhO5KIDf5DRuUuA/yf/hpGF3M3Xk8Oydaj0+EeW53zxP7dVxmf
	 j+0RHn+GDe8ICvDouB8JIquvBXw/RZ/bttogAGml6KnC5+cOH0hB5hYTECQUhJoKf7
	 K2ydzoXskwqLJ0LPPghvbop4/d9s1FyiJyK3LmRTF5X/LZTaaah8kCuTJGBt/rNkJw
	 2s++g1MZnoVSg==
Date: Wed, 20 Mar 2024 12:11:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 6/9] PCI: endpoint: pci-epf-test: Clean up
 pci_epf_test_unbind()
Message-ID: <ZfrERHdc1Iz7kAPI@ryzen>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-7-cassel@kernel.org>
 <20240315054255.GF3375@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315054255.GF3375@thinkpad>

On Fri, Mar 15, 2024 at 11:12:55AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 13, 2024 at 11:57:58AM +0100, Niklas Cassel wrote:
> > Clean up pci_epf_test_unbind() by using a continue if we did not allocate
> > memory for the BAR index. This reduces the indentation level by one.
> > 
> > This makes pci_epf_test_unbind() more similar to pci_epf_test_set_bar().
> > 
> 
> I've proposed to move the clear_bar and free_space code to separate helper
> functions in my series [1]. If this series gets merged first (it really makes
> sense), then this patch can be dropped now.

I've been a bit busy this week, hopefully I will have time to review your two
outstanding series before the end of the week.

I do think that this series is smaller and less complex than your two series,
so if you ask me, I think it would make sense if this series (the respin of
this series) goes first.


Kind regards,
Niklas

> 
> - Mani
> 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 91bbfcb1b3ed..fbe14c7232c7 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -690,20 +690,18 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
> >  {
> >  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> >  	struct pci_epc *epc = epf->epc;
> > -	struct pci_epf_bar *epf_bar;
> >  	int bar;
> >  
> >  	cancel_delayed_work(&epf_test->cmd_handler);
> >  	pci_epf_test_clean_dma_chan(epf_test);
> >  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> > -		epf_bar = &epf->bar[bar];
> > +		if (!epf_test->reg[bar])
> > +			continue;
> >  
> > -		if (epf_test->reg[bar]) {
> > -			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
> > -					  epf_bar);
> > -			pci_epf_free_space(epf, epf_test->reg[bar], bar,
> > -					   PRIMARY_INTERFACE);
> > -		}
> > +		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
> > +				  &epf->bar[bar]);
> > +		pci_epf_free_space(epf, epf_test->reg[bar], bar,
> > +				   PRIMARY_INTERFACE);
> >  	}
> >  }
> >  
> > -- 
> > 2.44.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

