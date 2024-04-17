Return-Path: <linux-pci+bounces-6342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B08A7CC2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 09:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBAE1C20E97
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 07:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC1C6A33B;
	Wed, 17 Apr 2024 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHPwHfOD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1F657DE
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337534; cv=none; b=Pa0DcD+RVaIgr/E8hu/LVRxD/mYZVyrItylxsm5XwT4ukiS/HisK8eDzHawKfzuj9+lXifOcw62MUMRGQbfVnkg0QenzBVxgWC176hKKdb1eVE/IyiPQOstdJzwU7OgIyyy3GOIs3OSvYXA3BqjDpSFeS5JIee3g87bEyiAKndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337534; c=relaxed/simple;
	bh=bPEa0MkxN7S2larn21dK+8bkmH9iV2RJi0htA1d/rBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuhDQ8Yfbq5yJWXlPya1kCw8RpI8kyrB1zEY2m1sAqjNpSKEjae7V0+GP+jgQvwm+ROSgGDYz5cFrPv1omOHI29huQ9qhqFG1a8OihAtq6PAqlQ0XQVU1jdeiThAJ7nxSzcL8pijRnixcnUW2lprRvh263+iMwayalRem2LCbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GHPwHfOD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a53a4a283eso4367386a91.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 00:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713337531; x=1713942331; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT6tFhvCySxWh9JfwI+ew2P3H0H+myzNUarVTSp+pTw=;
        b=GHPwHfODLy+t5EHgMZzCnTCW66IoAfDPVnLeKv4Sx5HELRxYyrh7DcV9f5xpcUGI1c
         TOLV47kOzcPzbAC8VflvLs9KsjVlfEm8nkitQCsHexYbyMz+YcHySrP1u+soRHL7Ql8O
         juhqN3KlOcBs7Q/4uI/NEsdE/3oekQ0eYQgxEtQpjmM2oQb8+wMJpHH0jwdEaXFhmc/k
         M8vzsZHFj6FwD6V6yPjo9EjgejN8t0CzYrnt5yFwQe5O2baHcQbIrc9vyGMSzyJ6TgzQ
         v9yw5JyuUP17Plofd1NiGs85WkAnnJMhjrmkB4aMAuWRfmijnTafyQgemQxmTWWRuswz
         /JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713337531; x=1713942331;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nT6tFhvCySxWh9JfwI+ew2P3H0H+myzNUarVTSp+pTw=;
        b=oBNL7GllmCoieSkAQJxrAuipwwhdTMuRbGRHTyMV37ytefRN4JBMWM5aPYSzhH13gA
         aaQQ/JhrmtujcFlT0Cw5qTNWMFe4gXKrHn7cxoa14BAS4KWygTShlZUsWHPrmTQVPJX3
         oZOJsf1V7O8T0YG50LgQxhaCz8Ckq7vEiGlXcamkgCUZxFiKpNBAvZfbH3f+uHUxHoOO
         LSqqJ6iQ7rXINRA5YwlEE7BWhYtTxKp1qZLAsGSf1xXJjgB3TanQLBBU2fJjTdFjnCVa
         RpmiRAA4OJW6oqEJxFYxlR+TJlfz/zclgX2AmKTBevVDI0/ZwoJscA3OYryh0XiQcF/4
         e8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCX3w2XbcIPJDii73533FH0eUKCCldg/zvG8SvNAsu6jGE4OSHf+/W9kF3f+VC2PAG5ukk0vlwn4snJBRbEU2gTnhcmDqBw860eW
X-Gm-Message-State: AOJu0YwNZ3RJu3VlAJC9p2VhwAx9hDHdJYSL4Wnv/h+TbiL4FcBrNXvm
	K/JJsdvx3nCp3rcwepa9eBasQvY9E9SIG3D8v3wfjTOPxLqysPofKR2nJVsNoQ==
X-Google-Smtp-Source: AGHT+IGAJTHf5aNDmeLGgicc5pedNPBoDApozmgw0H37DWBqBhEOgFpy2m6jFPd4h60UnfNZs6FWAA==
X-Received: by 2002:a17:90b:1b4b:b0:2a2:73e9:c3bf with SMTP id nv11-20020a17090b1b4b00b002a273e9c3bfmr14427402pjb.20.1713337530516;
        Wed, 17 Apr 2024 00:05:30 -0700 (PDT)
Received: from thinkpad ([120.60.54.9])
        by smtp.gmail.com with ESMTPSA id in17-20020a17090b439100b002a20c0dcebbsm699083pjb.31.2024.04.17.00.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:05:30 -0700 (PDT)
Date: Wed, 17 Apr 2024 12:35:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] PCI: qcom: Add support for IPQ9574
Message-ID: <20240417070517.GA3894@thinkpad>
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
 <20240409190833.3485824-5-mr.nuke.me@gmail.com>
 <dca1e891-cfde-4e95-864e-419934d385e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dca1e891-cfde-4e95-864e-419934d385e5@linaro.org>

On Wed, Apr 10, 2024 at 01:50:26PM +0200, Konrad Dybcio wrote:
> 
> 
> On 4/9/24 21:08, Alexandru Gagniuc wrote:
> > Add support for the PCIe on IPQ9574. The main difference from ipq6018
> > is that the "iface" clock is not necessarry. Add a special case in
> > qcom_pcie_get_resources_2_9_0() to handle this.
> > 
> > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 14772edcf0d3..10560d6d6336 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1101,15 +1101,19 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
> >   	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> >   	struct dw_pcie *pci = pcie->pci;
> >   	struct device *dev = pci->dev;
> > -	int ret;
> > +	int ret, num_clks = ARRAY_SIZE(res->clks) - 1;
> > -	res->clks[0].id = "iface";
> > +	res->clks[0].id = "rchng";
> >   	res->clks[1].id = "axi_m";
> >   	res->clks[2].id = "axi_s";
> >   	res->clks[3].id = "axi_bridge";
> > -	res->clks[4].id = "rchng";
> > -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> > +	if (!of_device_is_compatible(dev->of_node, "qcom,pcie-ipq9574")) {
> > +		res->clks[4].id = "iface";
> > +		num_clks++;
> 
> Or use devm_clk_bulk_get_optional and rely on the bindings to sanity-check.
> 
> Mani, thoughts?
> 

I'd prefer to use devm_clk_bulk_get_all() and just rely on DT schema to do the
validation. There was a patch hanging in my branch for some time and I sent it
now: https://lore.kernel.org/linux-pci/20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

