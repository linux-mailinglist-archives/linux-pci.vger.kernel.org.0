Return-Path: <linux-pci+bounces-4024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECB6867AD6
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEFE1C25075
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F5312C800;
	Mon, 26 Feb 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x92asZzr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED412C547
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962795; cv=none; b=OovVLVqwlkkcjyC0+kjj/xxtnFPXf4tDlXLkt/63SAxpC0DpAd07JDtRU9KPdy/kIi/PWN8gSpI3z2hNJHzgQGSdlFIznXAAaI1vOKL/jAJDR1P0nWhU48TdswKq9t/PaTelygAivowv6RXCgkb6n/DGmctQnpk8tSmhi9ejMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962795; c=relaxed/simple;
	bh=LzSfVYbpwcIiL18jrY1RntgAfMo3GM+npwXu3qQi47E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN6SBAQFdDEUSB3goYfCutIXQphz3ea9gXllnCaUvXN27n6qRqbIX/rGtu045hDoDG+l9FnD3WGwtctDb1U9nFyvLjIibvU2HVBoRoSjYHoBY/I5MeO9YOHALsIC8On2j8zAu+qrPpq929iQQPlvg7YXYu7fEvOpOxLFYSvIh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x92asZzr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d95d67ff45so19698505ad.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 07:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708962791; x=1709567591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+nBVkKUEU1VV5noZ6moMvrYQVjPEZ5C+2vmC/uOqgIU=;
        b=x92asZzrUW+5n//qeklcwltHhx6H2rS5QquHGr8MwTohQtMkP6twG5rJXYLXuE2qsV
         HrMvYGjAGbBOxH0YsFs98yxTjJjyB9t4o7YcsWUpyrrMfaCJR19WPg9Ms42PLPkIQP9v
         tGAejLdJI481Y4NhDTiFXbtGyYO3qY02HI/3iiu39ObDJaiLb0D0+U1EzKQNWMBq3toY
         vS8mEtG6HZJb+PVlpdhg+1UFXplMPk5bUMQK5xitcUnsoCFZ9p+rAzOSq2fmSMBoBuPF
         l3HQb4u10reDfwEvTOkLFGAAkFV99JrT9acUI3kgdfOw02F8HO18El/NRd6c5taF971R
         DSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962791; x=1709567591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nBVkKUEU1VV5noZ6moMvrYQVjPEZ5C+2vmC/uOqgIU=;
        b=MfXA5CvprviyH4OcVxg94xv5dAAsjODNIzInh4yoFTz5JMX0ccF1BtzcxT8HcQxtv/
         mdy5v3LKvURDZMGbv7F6PNs5+b+ykrnMwcF/p2z6qeV5KgPR0iOu/w6RfTVWcl+AbQ75
         pPwD8A7WPPv8PIPDokl0Z8k3AvEpsSPcJmpoUTuQTNVUh07F3KtJ6CnullvGESfO+puP
         TXSjLTownx1AE9p35rzPLnh/lGq5l2UVXvm7maLXaiPeHJJq7y9Y450/7YCWzO+cSyNI
         5vIPAbSPWZuA3y8ntNlQduxOHRoDb1mNkzgwt1NMmZsxMEx8BMl++9Ce1eMN+7rnfNEe
         xD7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwFMF7kLhqpNFncvhXWedDjgV4KJivwrb17A8PUMmCPJ2iD3SFKGKYZTYBELQEDAiwWU58FnTJJxXjGhiUJ4TgSTK0Q22FnYD9
X-Gm-Message-State: AOJu0YwH0Nnek+4WzBpdW1y18ZEc7yT+TsO85OiThi76ZaEsntIpTzHW
	/XGtCvMNO1NaSZMut4a82EiWv59zWSLZblctRplspfLkLifbVxIR0xAwrO11dw==
X-Google-Smtp-Source: AGHT+IHgfiig1fyDt/yDjcKdisT9CVXLdi10ulxpFd80CSn/9rgHC8+NPtl6GzTsl+fdg7Aelwbnaw==
X-Received: by 2002:a17:902:7295:b0:1dc:af82:98b2 with SMTP id d21-20020a170902729500b001dcaf8298b2mr919854pll.43.1708962791446;
        Mon, 26 Feb 2024 07:53:11 -0800 (PST)
Received: from thinkpad ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709026b4700b001dc391cc28fsm4060905plt.121.2024.02.26.07.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:53:10 -0800 (PST)
Date: Mon, 26 Feb 2024 21:23:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH] PCI: dwc: Enable runtime pm of the host bridge
Message-ID: <20240226155305.GJ8422@thinkpad>
References: <20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com>

On Mon, Feb 19, 2024 at 06:51:10PM +0530, Krishna chaitanya chundru wrote:
> Currently controller driver goes to runtime suspend irrespective
> of the child(pci-pci bridge & endpoint driver) runtime state.
> This is because the runtime pm is not being enabled for the host
> bridge dev which maintains parent child relationship.
> 

You should describe the parent-child topology first. Maybe a simple flow like
below will help:

	PCIe Controller
	      |
	PCIe Host bridge
	      |
	PCI-PCI bridge
	      |
	PCIe endpoint

Also explain the fact that since runtime PM is disabled for host bridge, the
state of the child devices under the host bridge is not taken into account by
PM framework for the top level parent, PCIe controller. So PM framework, allows
the controller driver to enter runtime PM irrespective of the state of the
devices under the host bridge. And this causes the topology breakage and also
possible PM issues.

- Mani

> So enable pm runtime for the host bridge, so that controller driver
> goes to suspend only when all child devices goes to runtime suspend.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d5fc31f8345f..57756a73df30 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/pci_regs.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
> @@ -505,6 +506,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (pp->ops->post_init)
>  		pp->ops->post_init(pp);
>  
> +	pm_runtime_set_active(&bridge->dev);
> +	pm_runtime_enable(&bridge->dev);
> +
>  	return 0;
>  
>  err_stop_link:
> 
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240219-runtime_pm_enable-bdc17914bd50
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

