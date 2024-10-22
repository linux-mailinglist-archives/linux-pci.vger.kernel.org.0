Return-Path: <linux-pci+bounces-15029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D151B9AB492
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5F2285DCB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0048B1BCA07;
	Tue, 22 Oct 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wixNJ2JX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891C1BCA04
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616397; cv=none; b=evgLqFLXHkmlpIqJnyh2uRG+LuWK9MuTjNzqYDBnRbwW0ZT4dInuxW+nJGuHRZz44rkFU2IpF8Sb6wnV3WIN5EvXyMQt8mleqFVm0vP74lPr5eVm47WAXp4hTDCvlKEeTIlM4GJFRbCwvb+iUsUomA9jNhDptmmkIGadUiSETqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616397; c=relaxed/simple;
	bh=NY/4WIGOYWbosC9nYshjQw+85FLhnQpOJ5Wim0TS7rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRPf8IgXAhNghlzYqlTlgHsFoRvpWAW36Fa39cH0bqffY2csQ2Ed1DXB9oZ+RyEbMqpEGGOrOqRzNMV9RA5WjAHAh7Jy5LVQw/gGiHx7YB0qXpS7bSvsh/OhCRK+VaDe0wRr89YXH8lZi6wBSdQI4Fb4Du+Lf41bprDH5Aeowek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wixNJ2JX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cbcd71012so53094465ad.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729616396; x=1730221196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VS3tXfWam2DO1i7ilVLotgRr0xGMHWMFEHP5fSK9K/M=;
        b=wixNJ2JXkKvqUUDovqBXfnhNtL6+HDP+/Y6eB7nOTSCUvVueGTZRd27COtXpH9z5aS
         x44s20YABBLDbtemA7EE8BnR2iQzxYkbikS8KV3/CHciFimLY5Vtq/SqOpmbKAKT106s
         wQbMhcS7VdV2YSyqZepP105s8L9KYLhznt88iUR6iQtsaZvbt9FVaMGjPJjoS4fCb1Q+
         mzgWf9qdZ6uOdJDvcsufzAqFMelrtUbMqNLU5oEhTTL7FrhBmwkZyPuoAocX3p6gfA/K
         oXiMzg4LPPo8WPDa2GZ+2fw2vJbZdFJQ1r6Pb8BpZgwUDDNkgRaN+wOU8DteHALM681U
         sgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729616396; x=1730221196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VS3tXfWam2DO1i7ilVLotgRr0xGMHWMFEHP5fSK9K/M=;
        b=TOAJdPQ30PiZs/YxNwIvGAq5qDD8IE3lCbdj3blwCtrgKRasC+6YXDhYgRvNPLPCCe
         DI6OvvW6x+3P9AlQafFYQnYSNSy9RyEVPj+OCf+YHKgax2ddFhhNMQ+4h1K2jiCXFIxC
         bKxcRRopVFyqVnDknQS08JZBPvdfKZIfI/5joiYEWwnb3iyScp795t0dAX4chEXMaq7t
         LZ/fShbsy25FWr4cR2F7kmT2OcWrtZfZY18dGnJV7eH+pM6qzSw+L47XoUwIFzpoMb9p
         DBd74Ef1xC5v8wbvLtMwlW7K7Gm7SpZm532HX05KQBNl3Lzrqh90plEuMPbR5E6aCN6O
         6E6w==
X-Forwarded-Encrypted: i=1; AJvYcCUWW+JrdceJMEyweQDbgHongRaZIveYeVRQEQOOQ1E8eKM4gG0q7fOgyI5sLwEBkg+12acu8uUxVHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEySOo/gSQ/DQGYq92rDC4T03GCDIc7Fg17G7ne1dVUh/JPPBr
	e8lzhV6YEGXdnn2IHlHWMU7lZxNCsK3z2XuzgRCReejsUe1X80sQLjLRgAS0dw==
X-Google-Smtp-Source: AGHT+IEYx820a1axe7TYA5uJ7U5XpkZcGO8wslMBvWfwxZnRbZqXMJz1tinZzuebUznia7UTdzMS7g==
X-Received: by 2002:a17:902:ea0e:b0:20c:8331:cb6e with SMTP id d9443c01a7336-20f39628369mr1028375ad.19.1729616395600;
        Tue, 22 Oct 2024 09:59:55 -0700 (PDT)
Received: from thinkpad ([36.255.17.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bf197sm45044345ad.150.2024.10.22.09.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:59:55 -0700 (PDT)
Date: Tue, 22 Oct 2024 22:29:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: kw@linux.com, bhelgaas@google.com, lpieralisi@kernel.org,
	frank.li@nxp.com, l.stach@pengutronix.de, robh+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 5/9] PCI: imx6: Make core reset assertion deassertion
 symmetric
Message-ID: <20241022165949.dn6wzgeocond2ia7@thinkpad>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
 <1728981213-8771-6-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1728981213-8771-6-git-send-email-hongxing.zhu@nxp.com>

On Tue, Oct 15, 2024 at 04:33:29PM +0800, Richard Zhu wrote:
> Add apps_reset deassertion in the imx_pcie_deassert_core_reset(). Let it be
> symmetric with imx_pcie_assert_core_reset().
> 

Am I correctly interpreting that this patch adds the *missing* reset deassert
for 'apps reset' line?

If so, then there should be a relevant Fixes tag. Also, there should be some
info about the implications of not deasserting it.

- Mani

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index ca8714c625fe..93e2bcf9aa0a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -770,6 +770,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_deassert(imx_pcie->pciephy_reset);
> +	reset_control_deassert(imx_pcie->apps_reset);
>  
>  	if (imx_pcie->drvdata->core_reset)
>  		imx_pcie->drvdata->core_reset(imx_pcie, false);
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

