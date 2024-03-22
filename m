Return-Path: <linux-pci+bounces-4986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAA6886A5C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 11:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CAB1C23230
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3717575;
	Fri, 22 Mar 2024 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZtK7vSK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445E2335B5
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103499; cv=none; b=p/L0o3E8ulPkB04N2ovgJXyimxuVQbSkF2Xv04p9Qx6x4Qs2201XUvK1L9BBr1odmTAA+lC97nHcFSJfZbw19ivKBTEd7bDFVe6rirNkAgXuUl7pC5vp8/Q8Tivio49l8R8wszvJgnb3LCRqQf73jzNlvMMs77X8UYWChgXaeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103499; c=relaxed/simple;
	bh=Mqj9/+3E3FLOifl3UfUfKrhKbcCrWvZO2XToaERc6Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTQ37EUBDiAaahkdyWug9CD3P4OKL2eqzfMre93I8E/S9YfZfn2RO58ITvUD+PeQYdsKg/8vXlQCjkzpIFLcBIZvaG1BKKh54FsXTOEyImMPEl8i1v9d+aDywvrk9aFCNsJA5mCp7gdY1S1oRWC7T54yWwx0PlmNJf1wJd3+SIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZtK7vSK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e04ac200a6so14453235ad.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 03:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711103497; x=1711708297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Y7afBn+/cVaRxjFXtefiC0oc3q+xjwKNQnPq34zFF8=;
        b=jZtK7vSK44tsDdFbYWeFAvQrm9RRfld8IpomVqnT+A5a3CSwWdxOyo01eaZjJ3q8L6
         QelyLG4NeKIZqj76cLoQbNae/UEXSm4xLqZ+TdP1zbfJ5fokc1Cm+IDjlusg+fhUAcG3
         OxX/hM0b8xzw2QjhvENuqZ1qCcnWF/P46jXpBr66rZLqnLZrwXFM9XFGBD6TEwrQT/Fi
         81desP2BAU74oq/pSv+I52xsKzfSCtjxrDYVXH6lUSFuTmJ9n0RPBwcnz/slIvT1XbR1
         Zz8fgSloi5+qaSpbs7a12r/LCnSF5Tkg+8GEgzY+D0qMvZZZPpUcqVYzbGKbLrrCX/iW
         gjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711103497; x=1711708297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y7afBn+/cVaRxjFXtefiC0oc3q+xjwKNQnPq34zFF8=;
        b=GDUTSCHc4r+2FkkYFmd4lWCZ0iBm3EZgA5+uEbUYnYxNWvfrr2c3eMcXV6qSCs1w29
         DtaWnqXjGw4WpafVKCyaXc0wIgeFcGnFc+ROu+TokWk9rpUY5rYeE95t0NAqE/3YOXQw
         k9VPjFD197ezJxruqJKTY5LaBcpwx+P4Pvru719xmS+9T9Kw9NHt3swCbptimQZLqUOI
         0IS8B3wbh3kXNA0Xjg30yZsNeYAtiC3lSvcFeYin8lOMj8Fv2xQcmqf6w9C1qoaJnXZd
         LKcfXj+bj0Goq+SehLskkv4FcD7Sg8i+x9fWTfseuqz36NwbA7NOFKhtAGxFLo5HWPqO
         RaHA==
X-Forwarded-Encrypted: i=1; AJvYcCX7gVozDs/BkpGpbqDSlNKh+9SP1gxWJOzcfXZPaOf1U3cHhw9TlKKDcHDSCtXYmSJWH1U2ZUK9Q+nicYbuESO/nDkkjm+W5CJf
X-Gm-Message-State: AOJu0YxVkEgCcFiYc6VCUewV+CKMfQyHL9Mfi8Lwhgu69JiREhNR0YNl
	Wu6nqRowVs4sSzJp8BeCZrzyr/F+2ZbrYexM/dqRb3AXtoyCflsCf6Z8Z/Z6Bg==
X-Google-Smtp-Source: AGHT+IEAv1kn1k6exee+vbSuie6h8vKiYmoip4yOGQrTucKT/kUKd/irvSAIIC8u6L4lksMcO/Gq5Q==
X-Received: by 2002:a17:902:f691:b0:1df:fff5:b61c with SMTP id l17-20020a170902f69100b001dffff5b61cmr2777836plg.14.1711103497263;
        Fri, 22 Mar 2024 03:31:37 -0700 (PDT)
Received: from thinkpad ([2409:40f4:101a:4667:2dab:fb9d:47a0:28fe])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d05300b001dcf91da5c8sm1557049pll.95.2024.03.22.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:31:36 -0700 (PDT)
Date: Fri, 22 Mar 2024 16:01:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/7] PCI: endpoint: pci-epf-test: Simplify
 pci_epf_test_set_bar() loop
Message-ID: <20240322103132.GB3638@thinkpad>
References: <20240320113157.322695-1-cassel@kernel.org>
 <20240320113157.322695-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320113157.322695-5-cassel@kernel.org>

On Wed, Mar 20, 2024 at 12:31:51PM +0100, Niklas Cassel wrote:
> Simplify the loop in pci_epf_test_set_bar().
> If we allocated memory for the BAR, we need to call set_bar() for that
> BAR, if we did not allocated memory for that BAR, we need to skip.
> It is as simple as that. This also matches the logic in
> pci_epf_test_unbind().
> 
> A 64-bit BAR will still only be one allocation, with the BAR succeeding
> the 64-bit BAR being null.
> 
> While at it, remove the misleading comment.
> A EPC .set_bar() callback should never change the epf_bar->flags.
> (E.g. to set a 64-bit BAR if we requested a 32-bit BAR.)
> 
> A .set_bar() callback should do what we request it to do.
> If it can't satisfy the request, it should return an error.
> 
> If platform has a specific requirement, e.g. that a certain BAR has to
> be a 64-bit BAR, then it should specify that by setting the .only_64bit
> flag for that specific BAR in epc_features->bar[], such that
> pci_epf_alloc_space() will return a epf_bar with the 64-bit flag set.
> (Such that .set_bar() will receive a request to set a 64-bit BAR.)
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 21 ++++---------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 0a83a1901bb7..faf347216b6b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -709,31 +709,18 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  
>  static int pci_epf_test_set_bar(struct pci_epf *epf)
>  {
> -	int bar, add;
> -	int ret;
> -	struct pci_epf_bar *epf_bar;
> +	int bar, ret;
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> -	const struct pci_epc_features *epc_features;
>  
> -	epc_features = epf_test->epc_features;
> -
> -	for (bar = 0; bar < PCI_STD_NUM_BARS; bar += add) {
> -		epf_bar = &epf->bar[bar];
> -		/*
> -		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> -		 * if the specific implementation required a 64-bit BAR,
> -		 * even if we only requested a 32-bit BAR.
> -		 */
> -		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> -
> -		if (epc_features->bar[bar].type == BAR_RESERVED)
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +		if (!epf_test->reg[bar])
>  			continue;
>  
>  		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
> -				      epf_bar);
> +				      &epf->bar[bar]);
>  		if (ret) {
>  			pci_epf_free_space(epf, epf_test->reg[bar], bar,
>  					   PRIMARY_INTERFACE);
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

