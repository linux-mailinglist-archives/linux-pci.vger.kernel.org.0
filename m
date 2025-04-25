Return-Path: <linux-pci+bounces-26767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD8CA9CDAC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942029C3758
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E088218C008;
	Fri, 25 Apr 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQYG55EC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B812C544
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596938; cv=none; b=Gf0ok1QvbqHW8q311evbQIHSdHU/i4GnWCXzs9d0C1Qf68L6Uf2x6WIPGAJ9pCJ7PD5Gr8B2QRK+8ubsZXNgC2WRCZoAO2j2wPv9cGDAloYwC3QUbLvgS3/TMJXPq1/3WZd4J0UkqIOVOOM+fFmYFIH5W9m25d28DgWyhne7hUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596938; c=relaxed/simple;
	bh=DgZXHclJOkx6g9lcO5qu3kZxuqYewO9zEwjAgW0mWLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7sZvXxBMzZD3mIuHEPP6ol7cjHpQw88/9aYtmcXVFxsZDDYHGS6RmTwEJO912CRZEB5Mno/232GaCnly6/Z5Qf3816jxfpuO+DBFbMjRx9Jd5uscUIusKxsSq5wDpDjK6MD+/vLp4bkUlPAW5mzGrtAKgBbVhGhMDJkrD3V+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQYG55EC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so2394572a91.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745596935; x=1746201735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Od8v9uuxXAfd7uGKx+1reVesYOTCW7WP8EaaxY94+tg=;
        b=eQYG55EC+dcfC5h9A4Pc3HSshs+cSL8AniB17QjT0kSQsLT6QYPGVIHKPPIVBMFTWH
         l1BR/bvRLyynOjNpGnIs5qe/iFP/6weS2T6pwjkAaYzYae98zwYA+os9EliBHGcuWFoD
         Ail3wqkGNKZxqj5a9lf9CMoNmtdW9dWbJdq7dqb+DDfRyTIgn/dBwUq+XDmgOnn+oz9C
         j9tsEBRLNWOp75pkUgvvJ8huahfdyH6kRjT6RKOwN1NXYSRCquajI76SwboSnI1W26dm
         zBI0lb6gh/aHmx3LHE0d1ZzDedebUkAZ+CbSERFtYR1637135ptT+VPary2wEpdUM6uV
         hfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745596935; x=1746201735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Od8v9uuxXAfd7uGKx+1reVesYOTCW7WP8EaaxY94+tg=;
        b=kscFUttF/ozWN221wp2yJAnLUkwQ/aei7ltDhx1xuchEl/7+NPG9RaemG31qqZUgna
         Ag7/MOmBE6TcXuMaPrtqGvsjTgcAIXlDOIY6MMFNinXwIEmmyJQkZpxgYk8iuBIORZGS
         4T/leQR4rmVr2xiuprqZR6Urrb1hjVlfJx7uyr+g9ZV7mXdZ23pAxpp8J/4ejH+/aNml
         vI5SNgmDCF3D0kwEl+/o+2hUNhmx3LqWe8hCF39yc2b0rNJQ9LZtT6pYz22myglXB80C
         uo1xLBnxE0c8iJxkG6Nd3wiYYbXG0egpSIFh++bmZ0tCuMskWZqM4sJz/Wu8hyD+MIK1
         SlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuUvgmNTMKJNub6mj3csJTwLVdRn1+RC0qxdAoRziFl3TQ4NaEDVcI2QceYKNGlZXZJZQ78hvqdSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvtSJggEdBKdYt5MT7FhEd2A+DlgjxtRO98YwybNY4hHaKAPV9
	aycyX57i8+LOabC8Q1oC+dWEv0QyA/U5oKS8cx3sFcNn0pZ4GTMr9CzidHyatJ7aDQj5jBOImUc
	=
X-Gm-Gg: ASbGncv4hHprFyEoWBmMjef8BvVfzTBRaZN5ieMZy93JYDnoy87R09jpFjaUj3XgQ1g
	7c5bFeQwoZk7Qsb99tLIgEMlxIYqE9siC88Y4hgFeLhI78h6P2P8hHGi0/dq+tuaRhSZxlT3cDB
	8bJpzy9/kToj1jWp/6v89fjcAnJwn+5hhbx2r3NYeqlWn2nJ1EKBtleCiLJTPdriDqs41PNMzOK
	Fr8uo3Wy7jeFItw5Z5gREDkxoSEyTfhDAvSssQwXwt1Eus6+fQbgiM8eiFcpeLHGpoy53BLBe9N
	aTkKJ4H3Iv70x1A/+13rIJ+QIFFQxfA6GHVrMhhx7Bp/flSIiH2c
X-Google-Smtp-Source: AGHT+IHdQ4Ba18bl0q2QrVTsaExU1b+SHdhITO9CRQcmytTANa1AqTjF3k17LH9+AYX+x/7+IPAHdg==
X-Received: by 2002:a17:90b:264b:b0:2ff:58e1:2bc9 with SMTP id 98e67ed59e1d1-309f7e679aamr4543956a91.25.1745596934960;
        Fri, 25 Apr 2025 09:02:14 -0700 (PDT)
Received: from thinkpad ([120.56.201.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f784ac3fsm1806254a91.45.2025.04.25.09.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:02:14 -0700 (PDT)
Date: Fri, 25 Apr 2025 21:32:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v2 03/10] PCI: dwc: Implement .pre_scale_bus_bw() &
 .post_scale_bus_bw hook
Message-ID: <6zuyux2emotjxouvo36ijojz4xel7x7aozyem55pmd3xvpbgjs@6abrkkzj3bib>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
 <20250313-mhi_bw_up-v2-3-869ca32170bf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-mhi_bw_up-v2-3-869ca32170bf@oss.qualcomm.com>

On Thu, Mar 13, 2025 at 05:10:10PM +0530, Krishna Chaitanya Chundru wrote:
> Add support for pre_scale_bus_bw() & post_scale_bus_bw() function op's.
> Add support for DWC glue drivers to register for these ops.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 21 +++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ffaded8f2df7..4da4df62c3f8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -697,10 +697,31 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>  
> +static int dw_pcie_pre_scale_bus_bw(struct pci_bus *bus, int target_speed)
> +{
> +	struct dw_pcie_rp *pp = bus->sysdata;
> +	int ret = 0;
> +
> +	if (pp->ops->pre_scale_bus_bw)
> +		ret = pp->ops->pre_scale_bus_bw(pp, target_speed);
> +
> +	return ret;
> +}
> +
> +static void dw_pcie_post_scale_bus_bw(struct pci_bus *bus, int current_speed)
> +{
> +	struct dw_pcie_rp *pp = bus->sysdata;
> +
> +	if (pp->ops->pre_scale_bus_bw)
> +		pp->ops->post_scale_bus_bw(pp, current_speed);
> +}
> +
>  static struct pci_ops dw_pcie_ops = {
>  	.map_bus = dw_pcie_own_conf_map_bus,
>  	.read = pci_generic_config_read,
>  	.write = pci_generic_config_write,
> +	.pre_scale_bus_bw = dw_pcie_pre_scale_bus_bw,
> +	.post_scale_bus_bw = dw_pcie_post_scale_bus_bw,

Please do not add these multi level ops without necessity. Just populate the
callbacks in qcom_pcie_host_init(). DWC has nothing to do with these callbacks.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

