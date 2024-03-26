Return-Path: <linux-pci+bounces-5154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8274F88BBD1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 08:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64301C31A7F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 07:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD30132C23;
	Tue, 26 Mar 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQT2vt1v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493B132811
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439925; cv=none; b=HPufPvPm2vzdX9poCc1D5FWwFMUVet3YUx5x44NAGbRJxcdiGJKsOj+TgxrEjdDla8eTcPpgDeA/tU8GDLNPVDkZXr1g/L9+OlxJH9wB0QOO5RsNhcUl6ursUHW3SMl4DPOC/ch0hbqqmRihRaF+CjZnVLMEv54sdyPkLuctVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439925; c=relaxed/simple;
	bh=U3xCdkOz3Y6db80cb2T+j82R67/2org97QFbp/aelS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewOb22XFlQe/TGh/77R8v/S3EgdPzWfcqLvrUI0OQGg+vxDNrWfK66XsbGvJ6jfKIeOcg2Jjp/cPZNqZ1hj3W2BhaPRJJFSzzKa1nx6f6Xz/5ezGQTnzSYpAKWmTDQ7k7nHxn2RxOHa22SLL4uVMd32vXzDG9FDRaWyvp2DdULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iQT2vt1v; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ea7f2d093aso3410014b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711439922; x=1712044722; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0ei96n8N9QJh0d9X1yKZBGiIbUh+v5D+5m1+0jv93vk=;
        b=iQT2vt1v94gSjh7pqRMx7PT/panzVAw8nHQMABDHdK1vsNvZ+x9CugU55icmytu974
         Oq1GDgjNgwy4ZIU7HSerm4ulLIzU7M2YQwphuCuIYjcdzJPu2ZBCGGo9gkeYCeGUZBmc
         MQ5MsXZoPE00QWHRNzCe+G9gVkeFGg/azZ9wpwjnHL8t3yOGEnz5A2WjKtPQmlYin5Qr
         f6wtXrVmzzo8pXiOsU7QJp9vOuVZ9a3oKzGEQXzEHYCDIFpjzYOzdxwbCRNfGM0ZZJwP
         VDPAHz/biKqEpK7Uv/8MsO1eR8qk9+XVUtnk+mCPDyps7tdutRX7MMCvV1rzl0N5idPU
         n1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711439922; x=1712044722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ei96n8N9QJh0d9X1yKZBGiIbUh+v5D+5m1+0jv93vk=;
        b=aq+bijYKv8xvgujoKcvNZKLVst5N3NPL3/rr4qyDOl7HChi2HAm1jS6uRtr5uojF7w
         FHd9JtR+sx6uTQaGxXmIaKOwP++js/kImCh/JZwAdUcJkVbxNACX5IclHzWk1TOGBFlq
         cWc9F4yJmOHl26bcM9qDv5MJR0WDKtUZWkk5iOsrbheJTUDyHaoiD8D4BGwQEB7yKsV1
         Ukaqn3Vd37Kv+ZtU5yGx5vFCN3epCg8EmBX1GnTZCJo+XYLFezlsFRgF+FA0b12KeZ2b
         YToOQirlSsbvo/HwNp/eQYqot90+icYj/yJZ4wy3VThvXC9mrdQgP5jbQWP47jbKRhPh
         4mmA==
X-Forwarded-Encrypted: i=1; AJvYcCVVGt07O9O2L/J84XyAbjZZmSqtXURolbWoDHbsSmq7rVcp/R8khg1+6PzdulxPkFuNj5FN9oHhJ+BTFY6bQX46Eh6V9pS0vNBi
X-Gm-Message-State: AOJu0YwEpW/vXZTLscpkfyokQ+OcO1dVPDawf9wfh9X2aVw5dLod54z4
	5j4PVkOvcemcGypiHRQjCena73FT9yH8KcD58j9s7281/Xym6V7qsrS7ANJiNg==
X-Google-Smtp-Source: AGHT+IFz/oPx9WopcTjERuotcpV7GtWEpMwMOVPLqcsvgxQg6MYrAOsudE1j4AmrmZhsiVdq3PIv2A==
X-Received: by 2002:a05:6a00:391b:b0:6e6:b68a:86f8 with SMTP id fh27-20020a056a00391b00b006e6b68a86f8mr435524pfb.14.1711439921739;
        Tue, 26 Mar 2024 00:58:41 -0700 (PDT)
Received: from thinkpad ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id fb16-20020a056a002d9000b006e5c464c0a9sm5339740pfb.23.2024.03.26.00.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:58:41 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:28:34 +0530
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
Subject: Re: [PATCH 04/11] PCI: epf-test: Refactor pci_epf_test_unbind()
 function
Message-ID: <20240326075834.GF9565@thinkpad>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-4-6134e6c1d491@linaro.org>
 <Zf2tH67WRvOGK7-O@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf2tH67WRvOGK7-O@ryzen>

On Fri, Mar 22, 2024 at 05:09:03PM +0100, Niklas Cassel wrote:
> On Thu, Mar 14, 2024 at 08:53:43PM +0530, Manivannan Sadhasivam wrote:
> > Move the pci_epc_clear_bar() and pci_epf_free_space() code to respective
> > helper functions. This allows reusing the helpers in future commits.
> > 
> > This also requires moving the pci_epf_test_unbind() definition below
> > pci_epf_test_bind() to avoid forward declaration of the above helpers.
> > 
> > No functional change.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 63 ++++++++++++++++++---------
> >  1 file changed, 42 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 1dae0fce8fc4..2fac36553633 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -686,27 +686,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
> >  			   msecs_to_jiffies(1));
> >  }
> >  
> > -static void pci_epf_test_unbind(struct pci_epf *epf)
> > -{
> > -	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > -	struct pci_epc *epc = epf->epc;
> > -	struct pci_epf_bar *epf_bar;
> > -	int bar;
> > -
> > -	cancel_delayed_work(&epf_test->cmd_handler);
> > -	pci_epf_test_clean_dma_chan(epf_test);
> > -	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> > -		epf_bar = &epf->bar[bar];
> > -
> > -		if (epf_test->reg[bar]) {
> > -			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
> > -					  epf_bar);
> > -			pci_epf_free_space(epf, epf_test->reg[bar], bar,
> > -					   PRIMARY_INTERFACE);
> > -		}
> > -	}
> > -}
> > -
> >  static int pci_epf_test_set_bar(struct pci_epf *epf)
> >  {
> >  	int bar, add;
> > @@ -746,6 +725,22 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
> >  	return 0;
> >  }
> >  
> > +static void pci_epf_test_clear_bar(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > +	struct pci_epc *epc = epf->epc;
> > +	struct pci_epf_bar *epf_bar;
> > +	int bar;
> > +
> > +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> > +		epf_bar = &epf->bar[bar];
> > +
> > +		if (epf_test->reg[bar])
> > +			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
> > +					  epf_bar);
> > +	}
> > +}
> > +
> >  static int pci_epf_test_epc_init(struct pci_epf *epf)
> >  {
> >  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > @@ -885,6 +880,22 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >  	return 0;
> >  }
> >  
> > +static void pci_epf_test_free_space(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > +	struct pci_epf_bar *epf_bar;
> > +	int bar;
> > +
> > +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> > +		epf_bar = &epf->bar[bar];
> > +
> > +		if (epf_test->reg[bar]) {
> > +			pci_epf_free_space(epf, epf_test->reg[bar], bar,
> > +					   PRIMARY_INTERFACE);
> > +		}
> 
> Nit: No need for braces here. (Just like you don't have braces in
> pci_epf_test_clear_bar()).
> 
> Like you said in the other thread, this commit clashes with changes done
> in my series.
> 

I think I should just rebase this series on top of yours.

> However, except for the small nit, the commit looks good:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
>

Thanks!
 
- Mani

-- 
மணிவண்ணன் சதாசிவம்

