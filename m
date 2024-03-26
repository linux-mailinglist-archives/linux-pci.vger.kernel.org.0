Return-Path: <linux-pci+bounces-5152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ECA88BBA5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 08:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3115F1F3A0C9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 07:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C21804F;
	Tue, 26 Mar 2024 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHoOJBwA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572213175C
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439359; cv=none; b=V2AupKwVbrVH3SMhUMKRA8C+RdFDuZ8objRiJ7LAjmaa7aKdzCp64QP5ErqXTnXU/wfuyCnCEMmbiX7+phx049hKrbQEMjcSLfOBNyTCLEyHtjIAgmP1B7x+Pe45ImTgqiQKTe/QxjX7gYrmH/J3gECMDOY3VyHm+/AeZYaeUN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439359; c=relaxed/simple;
	bh=mD/uOohmAdwq6qtfbHHxntanqBnx57lMSP/jqCllu9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/xFcGRLysLk/MNM08R+WOd+KDqNsT3svkxh8VQbfA0DHr/mwowGTnLHnyWzrXgsp6NnA17QJtluej2Sp9WUXLB+aOoUiVMv//+jZnCCzw2IX8O1Lxt9BsytWppeVYkahd1r+02V3N/ZcOqiS8YlF2cy+v+Zs2Sn3Yb2cgMzpvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JHoOJBwA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a02c4dffd2so3717317a91.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711439357; x=1712044157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lTWElJB3E3CFBIiAE7FiS8GKRMyRjDaWbtu+LrgbpaY=;
        b=JHoOJBwA5ZBLHCZI3YPwVl91yZ5pd4z/oO5jM3LmMIWyU/cbZggNL44IX3IRtD4ty0
         pSESANEP2+Otj1JOI04YV9CTVARhR5cTXvNcAm12fbXpWZmlQVzHdU12ImNflpfjRlsc
         Ut9J02+qjTMyGDw+eJUkO/nmqUXh9iCND6SYbcWwluh3qMQx4jUXpXpoQlJFNrB5G2KZ
         1J5Cc2GkqCupQ40F/YK3z5ZA0M4YVY94FGehq2FoDNkAnUZsiJd4I8xOmqyCnbPhNsE0
         czlM+cxPYIDcmlNzVu1EmkclSV/P5TdwShoKSDsKkgTSJchqy4tXwUJvzFjz5vDznQf9
         X0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711439357; x=1712044157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTWElJB3E3CFBIiAE7FiS8GKRMyRjDaWbtu+LrgbpaY=;
        b=PUsQ0ooj8ESUAuJnfOiRt88EOUMAJb+OJTVMaYnNoOBzqgHaPPOJ4LSu2Bt/HVv23Y
         Gztlo/mLqyrHbm13QbUEXNnff6LUcoBd8Gu7dHnjbEuVNQ0fv7tDl7e+oCX8r4deSJN/
         ffGpJ6RSIhQhco+kYAICwv0H5jsC6MFInKMd10sjP6555ErqZwDoZI4PtomB7XX1kr8v
         1EQcXsnJyFgr6+X8WcZqWZ3DHxabemJfUiN6hgCGVfBqniw8lh86W7Dnt+/xlMEdbI5B
         uubDENv4pPtRtoK9FUH5XoDws66jaVM1ZJpmNs5r4Lq3pD6AkxsMDd9tknTd+FKpFILu
         LQuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWLilkQpc+YIsyp0Giurr3uTfVlIXIALtJSTqBQw0iShCg57o+PN+vEFl8FnMUQeFFuex0YmKAQR0mfgdCEBxzA9eHfFjTh7jc
X-Gm-Message-State: AOJu0YyjybUPT24C2yYYR4uZyDJycKaqCYSTSO/eXToS/J/N88yy0Uo3
	muQflckq1MBbKfv2wL5VUZRJ+AF/ZkV1+gUXO0ZP4nqhDA/gYl/yq7e/p4Tb/w==
X-Google-Smtp-Source: AGHT+IFnMR21PN0mlfkHlkrPmdV3CmWyEENg9/wVPEmQQIeVbXaJ2uuYk7atQhi5sEPODMYCRFD0pw==
X-Received: by 2002:a17:90a:1c16:b0:2a0:1f2:e3ca with SMTP id s22-20020a17090a1c1600b002a001f2e3camr8943146pjs.36.1711439357212;
        Tue, 26 Mar 2024 00:49:17 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id t22-20020a17090ae51600b002a000f06db4sm11296861pjy.5.2024.03.26.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:49:16 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:19:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 02/11] PCI: endpoint: Decouple EPC and PCIe bus specific
 events
Message-ID: <20240326074907.GD9565@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-2-6134e6c1d491@linaro.org>
 <Zf2tBNctPpIrHeWA@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf2tBNctPpIrHeWA@ryzen>

On Fri, Mar 22, 2024 at 05:08:36PM +0100, Niklas Cassel wrote:
> On Thu, Mar 14, 2024 at 08:53:41PM +0530, Manivannan Sadhasivam wrote:
> > Currently, 'struct pci_epc_event_ops' has a bunch of events that are sent
> > from the EPC driver to EPF driver. But those events are a mix of EPC
> > specific events like core_init and PCIe bus specific events like LINK_UP,
> > LINK_DOWN, BME etc...
> > 
> > Let's decouple them to respective structs (pci_epc_event_ops,
> > pci_epc_bus_event_ops) to make the separation clear.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  8 ++++++--
> >  drivers/pci/endpoint/functions/pci-epf-test.c |  8 ++++++--
> >  drivers/pci/endpoint/pci-epc-core.c           | 20 ++++++++++----------
> >  include/linux/pci-epf.h                       | 23 ++++++++++++++++-------
> >  4 files changed, 38 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > index 1c3e4ea76bd2..e5d67aec7574 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > @@ -880,8 +880,11 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
> >  	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
> >  }
> >  
> > -static const struct pci_epc_event_ops pci_epf_mhi_event_ops = {
> > +static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
> >  	.core_init = pci_epf_mhi_core_init,
> > +};
> > +
> > +static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
> >  	.link_up = pci_epf_mhi_link_up,
> >  	.link_down = pci_epf_mhi_link_down,
> >  	.bme = pci_epf_mhi_bme,
> > @@ -903,7 +906,8 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
> >  	epf_mhi->info = info;
> >  	epf_mhi->epf = epf;
> >  
> > -	epf->event_ops = &pci_epf_mhi_event_ops;
> > +	epf->epc_event_ops = &pci_epf_mhi_epc_event_ops;
> > +	epf->bus_event_ops = &pci_epf_mhi_bus_event_ops;
> >  
> >  	mutex_init(&epf_mhi->lock);
> >  
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index fc0282b0d626..751dab5799d5 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -813,8 +813,11 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
> >  	return 0;
> >  }
> >  
> > -static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> > +static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
> >  	.core_init = pci_epf_test_core_init,
> > +};
> > +
> > +static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
> >  	.link_up = pci_epf_test_link_up,
> >  };
> 
> I'm not a big fan of every EPF driver now needing two different
> static const struct pci_*_event_ops.
> 
> Is really:
> static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
> 	.core_init = pci_epf_test_core_init,
> };
> 
> static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
> 	.link_up = pci_epf_test_link_up,
> };
> 
> 
> Better than:
> static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> 	.core_init = pci_epf_test_core_init,
> 	.link_up = pci_epf_test_link_up,
> }
> 
> The callbacks should have sufficiently distinct names that it is obvious
> what it is happening?
> 
> Link up is that the EPC driver tells me that it is link up.
> Init is that the EPF function should initialize the BARs etc.
> 
> I'm not saying that I'm totally against this, but I'm not sure that there
> are so many EPC callbacks that this is needed?
> 

The issue I'm seeing is that these callbacks are serving different purposes. One
is purely EPC specific and another is PCIe Link specific. So mixing them in a
single struct doesn't look good IMO.

And I agree that we will be left with 2 structs, but at least I can see that it
gives a clear representation of the purposes of the callbacks.

- Mani

> How many will there be after this series?
> Four? .init, .deinit, .link_up, .link_down ?
> 
> I would vote to keep all callbacks in the same struct for now,
> but you are the maintainer.
> 
> 
> >  
> > @@ -959,7 +962,8 @@ static int pci_epf_test_probe(struct pci_epf *epf,
> >  
> >  	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
> >  
> > -	epf->event_ops = &pci_epf_test_event_ops;
> > +	epf->epc_event_ops = &pci_epf_test_epc_event_ops;
> > +	epf->bus_event_ops = &pci_epf_test_bus_event_ops;
> >  
> >  	epf_set_drvdata(epf, epf_test);
> >  	return 0;
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index ba2ff037dfa6..f602f08a11a2 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -697,8 +697,8 @@ void pci_epc_linkup(struct pci_epc *epc)
> >  	mutex_lock(&epc->list_lock);
> >  	list_for_each_entry(epf, &epc->pci_epf, list) {
> >  		mutex_lock(&epf->lock);
> > -		if (epf->event_ops && epf->event_ops->link_up)
> > -			epf->event_ops->link_up(epf);
> > +		if (epf->bus_event_ops && epf->bus_event_ops->link_up)
> > +			epf->bus_event_ops->link_up(epf);
> >  		mutex_unlock(&epf->lock);
> >  	}
> >  	mutex_unlock(&epc->list_lock);
> > @@ -723,8 +723,8 @@ void pci_epc_linkdown(struct pci_epc *epc)
> >  	mutex_lock(&epc->list_lock);
> >  	list_for_each_entry(epf, &epc->pci_epf, list) {
> >  		mutex_lock(&epf->lock);
> > -		if (epf->event_ops && epf->event_ops->link_down)
> > -			epf->event_ops->link_down(epf);
> > +		if (epf->bus_event_ops && epf->bus_event_ops->link_down)
> > +			epf->bus_event_ops->link_down(epf);
> >  		mutex_unlock(&epf->lock);
> >  	}
> >  	mutex_unlock(&epc->list_lock);
> > @@ -749,8 +749,8 @@ void pci_epc_init_notify(struct pci_epc *epc)
> >  	mutex_lock(&epc->list_lock);
> >  	list_for_each_entry(epf, &epc->pci_epf, list) {
> >  		mutex_lock(&epf->lock);
> > -		if (epf->event_ops && epf->event_ops->core_init)
> > -			epf->event_ops->core_init(epf);
> > +		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
> > +			epf->epc_event_ops->core_init(epf);
> >  		mutex_unlock(&epf->lock);
> >  	}
> >  	epc->init_complete = true;
> > @@ -772,8 +772,8 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
> >  {
> >  	if (epc->init_complete) {
> >  		mutex_lock(&epf->lock);
> > -		if (epf->event_ops && epf->event_ops->core_init)
> > -			epf->event_ops->core_init(epf);
> > +		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
> > +			epf->epc_event_ops->core_init(epf);
> >  		mutex_unlock(&epf->lock);
> >  	}
> >  }
> > @@ -797,8 +797,8 @@ void pci_epc_bme_notify(struct pci_epc *epc)
> >  	mutex_lock(&epc->list_lock);
> >  	list_for_each_entry(epf, &epc->pci_epf, list) {
> >  		mutex_lock(&epf->lock);
> > -		if (epf->event_ops && epf->event_ops->bme)
> > -			epf->event_ops->bme(epf);
> > +		if (epf->bus_event_ops && epf->bus_event_ops->bme)
> > +			epf->bus_event_ops->bme(epf);
> >  		mutex_unlock(&epf->lock);
> >  	}
> >  	mutex_unlock(&epc->list_lock);
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 77b146e0f672..1271e1e00bbd 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -68,14 +68,21 @@ struct pci_epf_ops {
> >  };
> >  
> >  /**
> > - * struct pci_epc_event_ops - Callbacks for capturing the EPC events
> > - * @core_init: Callback for the EPC initialization complete event
> > - * @link_up: Callback for the EPC link up event
> > - * @link_down: Callback for the EPC link down event
> > - * @bme: Callback for the EPC BME (Bus Master Enable) event
> > + * struct pci_epc_event_ops - Callbacks for capturing the EPC specific events
> > + * @core_init: Callback for the EPC initialization event
> >   */
> >  struct pci_epc_event_ops {
> >  	int (*core_init)(struct pci_epf *epf);
> > +};
> > +
> > +/**
> > + * struct pci_epc_bus_event_ops - Callbacks for capturing the PCIe bus specific
> > + *                               events
> > + * @link_up: Callback for the PCIe bus link up event
> > + * @link_down: Callback for the PCIe bus link down event
> > + * @bme: Callback for the PCIe bus BME (Bus Master Enable) event
> > + */
> > +struct pci_epc_bus_event_ops {
> >  	int (*link_up)(struct pci_epf *epf);
> >  	int (*link_down)(struct pci_epf *epf);
> >  	int (*bme)(struct pci_epf *epf);
> > @@ -149,7 +156,8 @@ struct pci_epf_bar {
> >   * @is_vf: true - virtual function, false - physical function
> >   * @vfunction_num_map: bitmap to manage virtual function number
> >   * @pci_vepf: list of virtual endpoint functions associated with this function
> > - * @event_ops: Callbacks for capturing the EPC events
> > + * @epc_event_ops: Callbacks for capturing the EPC events
> > + * @bus_event_ops: Callbacks for capturing the PCIe bus events
> >   */
> >  struct pci_epf {
> >  	struct device		dev;
> > @@ -179,7 +187,8 @@ struct pci_epf {
> >  	unsigned int		is_vf;
> >  	unsigned long		vfunction_num_map;
> >  	struct list_head	pci_vepf;
> > -	const struct pci_epc_event_ops *event_ops;
> > +	const struct pci_epc_event_ops *epc_event_ops;
> > +	const struct pci_epc_bus_event_ops *bus_event_ops;
> >  };
> >  
> >  /**
> > 
> > -- 
> > 2.25.1
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

