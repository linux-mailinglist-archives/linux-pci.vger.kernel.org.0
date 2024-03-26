Return-Path: <linux-pci+bounces-5160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8888A88BC76
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 09:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4D2295952
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3373DAC01;
	Tue, 26 Mar 2024 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzHUVZki"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26724FBFC
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441888; cv=none; b=kUT7wx2uiQpvM7t3h3mIbsuK8+3FmAbBMrporoe70nMdJcTmzrK+D/b3M/BXMnNUJuIExTCaIm3RP7NGtPpTqNxLcTM2tIG5qvJIzdQiLtA0BvvYFEJGONK4rHlxWiaybTvOD5AfPYAyi0/C46xJjWOl5Z0mV5UaMZlS27dhaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441888; c=relaxed/simple;
	bh=0p/k1LhhENO+sDKA11lnA3dTaFWhfD2UYutHXoZHjlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSK19r4C6u0Tnfl88MT18glUS+uyiES3chSq+KpopKkfzKOYRKF24lCxFXLE9dhETEahCa5MJw720uTiV3e/WIVt4EXysKAy/U26I/yuh3Q9TfLcRwzKEw2kC4fU9lwBrmu7Vk1FbMw7eJbs4IbY796Eed2+H5oZe/ZdLfjp5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jzHUVZki; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso3133406a12.2
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711441886; x=1712046686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=olq3c4ICYu8vMrLr/rSJ5M+os6RTTRhmU7ECsIBnEgQ=;
        b=jzHUVZkiBQ9HKjvjqJHwwngFtjCPcCbzKcfagdyEpxFlBIgWntueHGmeSriKy1VGUM
         I4f2kfLVFmXP3vDpPtSgAjRjujoPRxBboOHXKsMDftwn2UDVv0krbjhfBOx+peZVOt0A
         K3AF0DT8W/3nOb4hfb/eCWQh7xXgrrV+W1IZnNhq7HDKaT/8SUXEY9vT9lwKXnYmmCN6
         QhlsuntZFcJibTiunzak/5+LXxabK5OnHPJeahYsCJKLLwZrneWnILYoF2Cw9oMUB7Uo
         Ih9uWNnz4VmjnXmvQIuIdtlFRzE9/9sU1Noq1ZKGovFm/hMj4khsKmza0wynjSRpJ7XO
         5Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711441886; x=1712046686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olq3c4ICYu8vMrLr/rSJ5M+os6RTTRhmU7ECsIBnEgQ=;
        b=MeszwcK06+pS4pypbs7RKqwuxRUAOkKqcNyGWG/AGb/iD1KQgTze0dE6RHcEsqAnLW
         0lDuNrD6tbl6lgsVBL9KxfFDxlPyueIjpF7xwNbhfR3VZIbB2Oh7RobS3tHHIoN92rZE
         v71bQRGhsZrZCGFAg3/MenRBnQLP6fvPy3sngFWSRbQAXM+B0WJ/LP917ipcJTufHwy7
         n8UK+ZIqVk9ARoOVa/iSd53yKUBOn+uY4a2eRBcQDAgNLwUw5XSsp8qtD/GdsPsXGO4q
         ikPN208KCGeJPDYI7yMvFKTrIdajxQTahCnRUIDzKSVrwxCuY+4nLXtkwLydGP21lFPd
         Ihrg==
X-Forwarded-Encrypted: i=1; AJvYcCXop35VnWXHFnTAYjiDYBuPf9Ie52EvFWBBZt3092BEEtPzv8Uwz2eKQ6MnXGZf1qQ78GdbVj66By27OxfTHdy+6+lwl8EEOR2N
X-Gm-Message-State: AOJu0YwmHEdmyBkti/8ODGGrHIW3hxrrPsHy+R3Ag2aVTOoHoBjerhAk
	EWCwGz9Wyw16f1U+qUtsVBdf3+GBANHv+RAktOxmDMlYFjd8jbPPAxBqUZ0PKQ==
X-Google-Smtp-Source: AGHT+IHtoMC7gZjACz6BwKikNJvkPyf4PHy7IjHtpJDxFX2XV5b1LT2atdwI0nh1TZWtzfB+uRNceQ==
X-Received: by 2002:a05:6a20:9186:b0:1a3:bdd1:67d5 with SMTP id v6-20020a056a20918600b001a3bdd167d5mr9259501pzd.39.1711441886051;
        Tue, 26 Mar 2024 01:31:26 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001e0a61cb886sm6062951plk.120.2024.03.26.01.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:31:25 -0700 (PDT)
Date: Tue, 26 Mar 2024 14:01:18 +0530
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
Subject: Re: [PATCH 06/11] PCI: endpoint: Introduce EPC 'deinit' event and
 notify the EPF drivers
Message-ID: <20240326083118.GH9565@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-6-6134e6c1d491@linaro.org>
 <Zf2taTZH7rEmsXKe@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf2taTZH7rEmsXKe@ryzen>

On Fri, Mar 22, 2024 at 05:10:17PM +0100, Niklas Cassel wrote:
> On Thu, Mar 14, 2024 at 08:53:45PM +0530, Manivannan Sadhasivam wrote:
> > As like the EPC 'init' event, that is used to signal the EPF drivers about
> > the EPC initialization, let's introduce 'deinit' event that is used to
> > signal EPC deinitialization.
> > 
> > The EPC deinitialization applies only when any sort of fundamental reset
> > is supported by the endpoint controller as per the PCIe spec.
> > 
> > Reference: PCIe Base spec v5.0, sections 4.2.4.9.1 and 6.6.1.
> > 
> > Currently, some EPC drivers like pcie-qcom-ep and pcie-tegra194 support
> > PERST# as the fundamental reset. So the 'deinit' event will be notified to
> > the EPF drivers when PERST# assert happens in the above mentioned EPC
> > drivers.
> > 
> > The EPF drivers, on receiving the event through the deinit() callback
> > should reset the EPF state machine and also cleanup any configuration that
> > got affected by the fundamental reset like BAR, DMA etc...
> > 
> > This change also warrants skipping the cleanups in unbind() if already done
> > in deinit().
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  1 +
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |  1 +
> >  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 19 +++++++++++++++++++
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 17 +++++++++++++++--
> >  drivers/pci/endpoint/pci-epc-core.c           | 25 +++++++++++++++++++++++++
> >  include/linux/pci-epc.h                       |  1 +
> >  include/linux/pci-epf.h                       |  2 ++
> >  7 files changed, 64 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 50b1635e3cbb..e4b742355d57 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -501,6 +501,7 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
> >  {
> >  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> >  
> > +	pci_epc_deinit_notify(pci->ep.epc);
> 
> Why not just move pci_epc_deinit_notify() in to dw_pcie_ep_cleanup() ?
> (So that we don't need to add pci_epc_deinit_notify() to all EPC drivers
> with PERST?)
> 

This is mostly done to keep similarity with dw_pcie_ep_init_notify(). Even
though it is a helper, it explicitly says that the function sends init
notification. Otherwise, it will confuse developers on who is calling the
deinit_notify(). I believe there is already enough mess to confuse the
newcomers ;)

- Mani

> Regardless:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> >  	dw_pcie_ep_cleanup(&pci->ep);
> >  	qcom_pcie_disable_resources(pcie_ep);
> >  	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index e02deb31a72d..3e6e08b321fb 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1715,6 +1715,7 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
> >  	if (ret)
> >  		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
> >  
> > +	pci_epc_deinit_notify(pcie->pci.ep.epc);
> >  	dw_pcie_ep_cleanup(&pcie->pci.ep);
> >  
> >  	reset_control_assert(pcie->core_rst);
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > index 4e4300efd9d7..83de96119718 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > @@ -748,6 +748,24 @@ static int pci_epf_mhi_epc_init(struct pci_epf *epf)
> >  	return 0;
> >  }
> >  
> > +static void pci_epf_mhi_epc_deinit(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > +	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
> > +	struct pci_epf_bar *epf_bar = &epf->bar[info->bar_num];
> > +	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
> > +	struct pci_epc *epc = epf->epc;
> > +
> > +	if (mhi_cntrl->mhi_dev) {
> > +		mhi_ep_power_down(mhi_cntrl);
> > +		if (info->flags & MHI_EPF_USE_DMA)
> > +			pci_epf_mhi_dma_deinit(epf_mhi);
> > +		mhi_ep_unregister_controller(mhi_cntrl);
> > +	}
> > +
> > +	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
> > +}
> > +
> >  static int pci_epf_mhi_link_up(struct pci_epf *epf)
> >  {
> >  	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > @@ -882,6 +900,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
> >  
> >  static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
> >  	.init = pci_epf_mhi_epc_init,
> > +	.deinit = pci_epf_mhi_epc_deinit,
> >  };
> >  
> >  static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 8f1e0cb08814..84cd47ebac22 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -804,6 +804,15 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
> >  	return 0;
> >  }
> >  
> > +static void pci_epf_test_epc_deinit(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > +
> > +	cancel_delayed_work(&epf_test->cmd_handler);
> > +	pci_epf_test_clean_dma_chan(epf_test);
> > +	pci_epf_test_clear_bar(epf);
> > +}
> > +
> >  static int pci_epf_test_link_up(struct pci_epf *epf)
> >  {
> >  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > @@ -816,6 +825,7 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
> >  
> >  static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
> >  	.init = pci_epf_test_epc_init,
> > +	.deinit = pci_epf_test_epc_deinit,
> >  };
> >  
> >  static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
> > @@ -954,10 +964,13 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> >  static void pci_epf_test_unbind(struct pci_epf *epf)
> >  {
> >  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > +	struct pci_epc *epc = epf->epc;
> >  
> >  	cancel_delayed_work(&epf_test->cmd_handler);
> > -	pci_epf_test_clean_dma_chan(epf_test);
> > -	pci_epf_test_clear_bar(epf);
> > +	if (epc->init_complete) {
> > +		pci_epf_test_clean_dma_chan(epf_test);
> > +		pci_epf_test_clear_bar(epf);
> > +	}
> >  	pci_epf_test_free_space(epf);
> >  }
> >  
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 5a522b2842e2..26378a9a56a7 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -779,6 +779,31 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);
> >  
> > +/**
> > + * pci_epc_deinit_notify() - Notify the EPF device about EPC deinitialization
> > + * @epc: the EPC device whose deinitialization is completed
> > + *
> > + * Invoke to notify the EPF device that the EPC deinitialization is completed.
> > + */
> > +void pci_epc_deinit_notify(struct pci_epc *epc)
> > +{
> > +	struct pci_epf *epf;
> > +
> > +	if (IS_ERR_OR_NULL(epc))
> > +		return;
> > +
> > +	mutex_lock(&epc->list_lock);
> > +	list_for_each_entry(epf, &epc->pci_epf, list) {
> > +		mutex_lock(&epf->lock);
> > +		if (epf->epc_event_ops && epf->epc_event_ops->deinit)
> > +			epf->epc_event_ops->deinit(epf);
> > +		mutex_unlock(&epf->lock);
> > +	}
> > +	epc->init_complete = false;
> > +	mutex_unlock(&epc->list_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_deinit_notify);
> > +
> >  /**
> >   * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
> >   *			  the BME event from the Root complex
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index adee6dbe4e45..976b2212e872 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -199,6 +199,7 @@ void pci_epc_linkup(struct pci_epc *epc);
> >  void pci_epc_linkdown(struct pci_epc *epc);
> >  void pci_epc_init_notify(struct pci_epc *epc);
> >  void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf);
> > +void pci_epc_deinit_notify(struct pci_epc *epc);
> >  void pci_epc_bme_notify(struct pci_epc *epc);
> >  void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
> >  			enum pci_epc_interface_type type);
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index ff8304e72f8e..52f69eaf505d 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -70,9 +70,11 @@ struct pci_epf_ops {
> >  /**
> >   * struct pci_epc_event_ops - Callbacks for capturing the EPC specific events
> >   * @init: Callback for the EPC initialization event
> > + * @deinit: Callback for the EPC deinitialization event
> >   */
> >  struct pci_epc_event_ops {
> >  	int (*init)(struct pci_epf *epf);
> > +	void (*deinit)(struct pci_epf *epf);
> >  };
> >  
> >  /**
> > 
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

