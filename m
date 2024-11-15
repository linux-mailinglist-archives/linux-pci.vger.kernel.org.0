Return-Path: <linux-pci+bounces-16827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 625989CD9C2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FABB24181
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA11187FE8;
	Fri, 15 Nov 2024 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLTdpFn+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061118785D
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655042; cv=none; b=KAA6Y6RTwF1mfgZ2hLoDNiy+rZlvvBqxoI/4aQxNsMWcxjP7LEpti2lGAfDbTnuObmyvveSsG3EUYHNlwJBfJXIv+Ym3vzcIJbLO7/5L60nV4W4NvxezSMA+IW88miTqLnWxRfh+oZ6fF4Ad6q8wxEEtWEHLML0GBf5nISJOl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655042; c=relaxed/simple;
	bh=CLekJhZV26W4QjUdjO1GmEQq9zGMyZX6n8NItb//Rqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTSV/kebT8nfWD8v8elgzwDzRTuWmhqlzcdnBWeHredTw9kG/L8+zD+EcQUdh6cAe1yHASwlAnFKweiGS7bMu8JUDs2DhuooQRUOshL9AOu2EDE8T/5olRWALNwZkq1/ROa8QW130/mIfzavdKHOL6a5bhhcdicmMjjUlHq/ueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uLTdpFn+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ea0bd709c0so1052435a91.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 23:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731655041; x=1732259841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gsz5jRvCR/yiZ0wis8iU8Gb8eCp/4LmvdSJpH2W47Yw=;
        b=uLTdpFn+DrV/DKsTkrS2drphO4SFoQt1MJVIVG5SlZGYsIwJOtb7EL8nvW/YGq1Ze2
         7ysAAEWGusO6PHLnoGgRQrcpCfxPlGAD70UpIvAIp2moq65d1GoZ9ub8Fuu8LupyGr9m
         OqthkXhDuZ0UYHsQJsJUkrfPxfHptvsaIsYSbfyor9kT/OXqegqz8PG/8Hhckj2KUnsN
         Hnph+26TtEFHbRQqpZSt1xbk2W6Ylz2KYljGnxlmEqwn1r2ylWLUVjI/CdVFLHsa1pVn
         6M5/XmeMVu1mhdQS5dnd6lHDJpfaBMiIgmLkqEpkqdvbcz5ZAT8uE2ZtuYlKS+U9REra
         jFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655041; x=1732259841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsz5jRvCR/yiZ0wis8iU8Gb8eCp/4LmvdSJpH2W47Yw=;
        b=tmzbjZ9WlB6ML72Sg+33V+uUMS658zKE/JxmZuMXjTjzTOICG3EnSHKwyr/Ivavxfy
         gjtoLLU5laA7QjZFubYpG08LuEOHFqJf+LLIh3HKoHoC82xm2nld32hGkF/xWtTLxArc
         9C/L46h6b8+J9hEcWXyY3MbP9YlZ9X4+d9bdhjGQRTKiOeqbIaoiUpnyayn4hcCqFkOP
         tBblJVVVb5Oe/ppDOGabFILQcOhWE9jMjqlgz2ZhsnygeutEb6eXxV4ALsx24IZ4qoB+
         +jTo6NNdK9nhTHJ0Y6yyObvuJmf1y2kX7Ue085YNFktjpdDPTRVNzZDqcn6RHgBUfs+z
         z4TA==
X-Forwarded-Encrypted: i=1; AJvYcCXN9jAnUywGSfjxFoCrlUQaKupYbx5WsejAK0VbhPQrfWNaF+i8LvLBXvh+ivJ5y0nl2QaWHtV5wJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtpa37yo0nvRyV9Ei+oOogXujzSCIlijQySbhubl15NuHrc9pV
	SHAjFvSFZhRLllUSWmvFSJEN3jobid44IGSQ1NXFq9Nk71TeTg4N/s0RYoEUvg==
X-Google-Smtp-Source: AGHT+IHTf29QqYruBqey4TpSYqbKF7UQC/DJE+teHJW7VZpyneERQ0LqsCT4V+Xp98m4K3keDZcRiQ==
X-Received: by 2002:a17:90b:33c6:b0:2e2:cf63:224c with SMTP id 98e67ed59e1d1-2ea1559723bmr2130928a91.35.1731655040672;
        Thu, 14 Nov 2024 23:17:20 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm6618765ad.106.2024.11.14.23.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:17:20 -0800 (PST)
Date: Fri, 15 Nov 2024 12:47:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Use of_property_present() for non-boolean
 properties
Message-ID: <20241115071708.nh6tnscmq5khr46o@thinkpad>
References: <20241104190714.275977-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104190714.275977-1-robh@kernel.org>

On Mon, Nov 04, 2024 at 01:07:13PM -0600, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c7290..d2291c3ceb8b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -474,8 +474,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	if (pci_msi_enabled()) {
>  		pp->has_msi_ctrl = !(pp->ops->msi_init ||
> -				     of_property_read_bool(np, "msi-parent") ||
> -				     of_property_read_bool(np, "msi-map"));
> +				     of_property_present(np, "msi-parent") ||
> +				     of_property_present(np, "msi-map"));
>  
>  		/*
>  		 * For the has_msi_ctrl case the default assignment is handled
> -- 
> 2.45.2
> 

-- 
மணிவண்ணன் சதாசிவம்

