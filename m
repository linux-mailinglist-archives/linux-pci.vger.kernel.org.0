Return-Path: <linux-pci+bounces-2985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E4D846AD3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 09:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563001C2540A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E5554BD5;
	Fri,  2 Feb 2024 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gm91MX46"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AC18C3B
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863032; cv=none; b=V/mD6Ysbe0um2eBwvBnYteLJZp9vVaOV/7IFt5gWvEzOeXA/iXgBsJN+pFGysk5P+LlT+xY1WrS93/V41tfJ+AGvo2yshxwMfuBN//+/Q4edeJqx/bYMi1/T/ddze/IK3EE0q9stYtdMUmjheU8qbOdX+0sb6Qc0RYTlOcjYAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863032; c=relaxed/simple;
	bh=Czyfyr+8UKrQ+XX6ruEHTKv5D+HXacJ7bTJvUHfQlFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQu6uNfQcPdRSNqVKlPNzdy/+i9Gr4IkhPlGfHNQ8TOk/e8HXVOknmVeXmDxgaR/NCNKcvMbKfrjb9btYITW5limh1IgzZO5Hgzgy3+yP2906D8GgPln9HQiwJO56U9V7XvMpL3N8JgQDJHIiy1A3lk6qN+Mvsefa2sf0LA59xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gm91MX46; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bba50cd318so1467321b6e.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Feb 2024 00:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706863028; x=1707467828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bSVa4tdnarzL2RCty+6WSO/tCFxJU0zF/PeB4CCvMzU=;
        b=gm91MX46JKYbjXDDKYtTf1SQzg2lSvQOJioWoHky2+951OEem4+ZDtuclFBP+kNAGJ
         HudO2qIoVjdN41D5fBS9pFTLD6C2oQ/QEydTjqWNpPs0aZoHP4I+1fSAC1/e3YqrIbgl
         /ItGMyoMoEYd21wtleUT58jTdEOSu2tkAGUy3kSAlHVOHo2yXHGQ8sDvemUau8IOEnVm
         D4GHjdEzrquA7aJulsdM3v88kUEsEcsDwXFRMiLQ1UX/e2eVhZUT5/MBqFvYfJc0BF1Z
         ukMFHmgFRPfLFrPi4j675986IKqQ8ryiJnLXgwfmG7PvueE1znR0gg4fsYn3iFZI3IH4
         /7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863028; x=1707467828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSVa4tdnarzL2RCty+6WSO/tCFxJU0zF/PeB4CCvMzU=;
        b=ZOCsWgXqRIAMsRGl54lrsUvUQOhKJNmcGubdt3nqFrcuVrr6ovhYuv7/gFdzyhYSVY
         rw89l3CNaaVdeS8297uTf1gui2g0AxjyJFwLMlFgwHsPyhaFMXifYYrv4ikbYnhHAMHN
         xszwtrLCexAEBIMmoi8kY1m2dGgfk5rN3A8Lh64Icntxe8kntttDzBm23gZfh3SFdg6b
         GxkI3HRHrB5SbMaGSMVgipBm1jbqPfp2nO5P1nws1Oq0U+R4M0MT2IPKBvLbl9U2hEy7
         ecuZcLG17GqWGKDW/rLyEX+UTR0f926ijRokUpCcUQ1ljfcu7ORIZu1kZgfcg1ApjZRt
         Z83A==
X-Gm-Message-State: AOJu0YxISXoQSsXkm6PfEE05d46TkN7xgNwdXhV1kSwgpn66E4CODHhl
	NH0ABM97ZZXnyKv+xmKrW+2ac++CqjNlI78/vSU7WsVEuEscFOuIKrWuR1ao8w==
X-Google-Smtp-Source: AGHT+IGPn26W49Y/fv0406NegzmywFht1rc4/4sVvSA2xSWRrwV8LyXlXjr6gVQA5zWJm3hYY+2P2Q==
X-Received: by 2002:a05:6808:1a8c:b0:3be:5d77:cfa7 with SMTP id bm12-20020a0568081a8c00b003be5d77cfa7mr7226958oib.1.1706863028549;
        Fri, 02 Feb 2024 00:37:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWTL1PQAzxV0geR3WrgESJkz78kNMxmsYVbPIJbqltu/GulAojCJxjGumkUXdnOo1LrWQvIcQCDj5QQuoRAJrqrtt33m1Uk6GK510HfYKN2iC/Hla7bOdQx+UWR3U0Kmwlgn0zPdiFg98KhF6pmTYlMi08LO+KIK5ERvScCAhrBI3OK5LT01n1wjSJ7hC9VLQS2tD0Gb78QcQXxB/ju4B62VsdjMyN9BOSxq0cDTDLCFL7sO5RBXGxQs6aAdfqqYIYkIjshpISuPjhCShbLd/iO/M0XTOxJREtJp8OTjB6uvznF3bZpOda+
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id g3-20020a62e303000000b006d9a6a9992dsm1044148pfh.123.2024.02.02.00.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:37:08 -0800 (PST)
Date: Fri, 2 Feb 2024 14:07:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: refactor pci_epf_alloc_space()
Message-ID: <20240202083701.GC2961@thinkpad>
References: <20240130193214.713739-1-cassel@kernel.org>
 <20240130193214.713739-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130193214.713739-2-cassel@kernel.org>

On Tue, Jan 30, 2024 at 08:32:09PM +0100, Niklas Cassel wrote:
> Refactor pci_epf_alloc_space() to take epc_features as a parameter.
> This is a preparation patch needed for further cleanups.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 5 ++---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
>  drivers/pci/endpoint/pci-epf-core.c           | 6 ++++--
>  include/linux/pci-epf.h                       | 4 +++-
>  5 files changed, 12 insertions(+), 9 deletions(-)
> 

[...]

> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 2c32de667937..e44f4078fe8b 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -251,14 +251,16 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
>   * @epf: the EPF device to whom allocate the memory
>   * @size: the size of the memory that has to be allocated
>   * @bar: the BAR number corresponding to the allocated register space
> - * @align: alignment size for the allocation region
> + * @epc: the features provided by the EPC specific to this endpoint function
>   * @type: Identifies if the allocation is for primary EPC or secondary EPC
>   *
>   * Invoke to allocate memory for the PCI EPF register space.
>   */
>  void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> -			  size_t align, enum pci_epc_interface_type type)
> +			  const struct pci_epc_features *epc_features,

s/epc/epc_features

- Mani

-- 
மணிவண்ணன் சதாசிவம்

