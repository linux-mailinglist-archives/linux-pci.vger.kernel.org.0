Return-Path: <linux-pci+bounces-38575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1891BBECCC8
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 11:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A04C19C550E
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A612284883;
	Sat, 18 Oct 2025 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gp/wSoqa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF327F72C
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760780964; cv=none; b=Rw5I+TlC5a808X8in81cwC1EZJL7IVXW8A7lvstssgNqIAGwhbUik/SJJWujWcXjVGaIgxEAA+l2QIgquq3HKI1j2tf8l8D78U7OBEuf6vNeXRlIelMe7clUtXLuI+TCLwnOdNMgRabQf4Jo4AwJiuGQBCGMhuwC1ozgxSxx9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760780964; c=relaxed/simple;
	bh=aBrzw1BnOAqm6Mv2zDnLYL50/v6f/umcO6E955ZpIuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjjrRDVyZKw3fh2BHBWWy0PD2fQQvD8a8qfGILunkQn9xeVi7fu9GbX1s6btIS7rtdkiFa0keWc1wOh5ghD3JagWFa8r6lGfothNjfspR81IwRKEMedt36vrJXqHOhEJaVa23T9RzjsKQUM30m/igOVU20BCHXMBeYQHVcbNeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gp/wSoqa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so26417665e9.1
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760780961; x=1761385761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LJ1k9LDoSOqmBSAsuY78K6WJBTUTLHwdE0LZYjE4bkk=;
        b=Gp/wSoqaX5yfOGvI0KHhZuqmHzwPmG3YHcTFh77Q/XbXU55R3vXwRcUYQzD5oTDZ0B
         Lvud5gtAjtHKuabXdph34CMQ16LX6H110RljqAddb0ZXkyEZqtq/FSVaewqbJ+K8zC8e
         gP3Sfno2q/IEzkuMstw5OmgNLTV+kKuAnax8R911IrnbjSTUm7tmY7tx951RSsLKVK4U
         7TLeyy9zBnKeKn9rHDMwR7j+G/Z69BzZFVCqvkx3cdF6MPxjf3A30LltcN4wbB1QVk4U
         AsKi+U75YcDCJGyh66Av0JhVabhT03YO/+kPGbfV8u15c7GfNuIeR+WWk52hr9Wg0Icv
         QrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760780961; x=1761385761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ1k9LDoSOqmBSAsuY78K6WJBTUTLHwdE0LZYjE4bkk=;
        b=fcWFd2NrQkgdHO3xJ5SpVu8W4kyNJKsybnzO9QMlAPg9jvmk6QK4QkV2pE0+tWgNun
         DxxFvtBv3QyLB5vOKoJ6fV5h60BusXbvlLggYpwxqbQC0wOdtsEwKt/EddzaBL61kzjC
         dFFdRRkFMXrRwZNj+X/6xLTmFFApBxPdYFXDHh6vLxx12bNxJ5Pzx9LLW0TPS+VNInD8
         nE2bm7QmFdOP2EOt5LH2Kk59Eph8zvob9iGQixQVPI8LeukO0GbHZ2y6rwt8fYCs+SzF
         /MrF0eEFYPUBdfxx/6w6/0fQ76K5Gi5UtMWOFjtkrvUiKLV334Yb+exTCkWPa+PBllU8
         31GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbn9BvaWcYN3xbpoh6TN4U9A7ZAvlGOTbiRczAswC1A1CcNNXWUPB38YeGX42xYh3XBzAbDbr0l80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnsdsMiUqUzKMztzuIK9ODnY1RiwfdSc2VicSvhcynYcG5e+l+
	xYoe1OrwsTpLSZKx7mBDMfIFgNkzcJ38zj3DHFKF69usyoOQT1GHWNB60HAeGFULJQo=
X-Gm-Gg: ASbGncvkFeqI3h3Q6cokpgsJ1ajfQSebriN+VB8tQKWg3m+ScVRfovi977bmdZ/X1FV
	iG8RZUjsRsiMgKoFMdcTpSL853uUE8Oms4F2YmskSrGzzXgOEfaJ1HQ0QojRH2lL+EYzSxNBxfr
	gI3rFf6g4Cr5Evn1NA68luRyXVbL8wdNLfCnMo2tdF5GlqAsFvYvghGSnxIxgJQrXT20Mz/p4gh
	9C3iLEOUP7sdNJsIikA2MhPnlZweD++pd/KuH8rvPx2huvzIqDuYCP0WEm+Fb3XBW+PNyLVERPL
	ZVxiwCf9JvmZdWh67RIdiIwqnBg/O3XmDP4rdSYiWLOOgdaZv+v3tiLXK1nPpw2h6vn5Mg8HHF0
	ItDr0EIJ8mIlhTvDHaTbDuF42griK7ROU9QmglF3hw9rPaNTc52gSpYODP1uBx7tiIe1ngoSh+2
	0Jn/cmiQ==
X-Google-Smtp-Source: AGHT+IF4PmKFPPexasdAngpm6lCQGA4zlUjMCH/pf+rmfZzvnzRywedipAIMxVKthaY73oX1yJKtZQ==
X-Received: by 2002:a05:600c:190f:b0:470:feb2:e968 with SMTP id 5b1f17b1804b1-471178b125amr50060315e9.15.1760780960846;
        Sat, 18 Oct 2025 02:49:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3d4csm3936689f8f.19.2025.10.18.02.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:49:20 -0700 (PDT)
Date: Sat, 18 Oct 2025 12:49:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>,
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] PCI: j721e: Use devm_clk_get_optional_enabled()
 to get the clock
Message-ID: <aPNineCsVgUyD6xW@stanley.mountain>
References: <20251014113234.44418-1-linux.amoon@gmail.com>
 <20251014113234.44418-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014113234.44418-3-linux.amoon@gmail.com>

On Tue, Oct 14, 2025 at 05:02:28PM +0530, Anand Moon wrote:
> Use devm_clk_get_optional_enabled() helper instead of calling
> devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> the error handling and makes the code more compact. This changes removes
> the unnecessary clk variable and assigns the result of the
> devm_clk_get_optional_enabled() call directly to pcie->refclk.
> This makes the code more concise and readable without changing the
> behavior.
> 
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v1: Drop explicit clk_disable_unprepare — handled by devm_clk_get_optional_enabled
>     Since devm_clk_get_optional_enabled internally manages clk_prepare_enable and
>     clk_disable_unprepare as part of its lifecycle, the explicit call to
>     clk_disable_unprepare is redundant and can be safely removed.
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 9c7bfa77a66e..ed8e182f0772 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -479,7 +479,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	struct cdns_pcie_ep *ep = NULL;
>  	struct gpio_desc *gpiod;
>  	void __iomem *base;
> -	struct clk *clk;
>  	u32 num_lanes;
>  	u32 mode;
>  	int ret;
> @@ -603,18 +602,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  			goto err_get_sync;
>  		}
>  
> -		clk = devm_clk_get_optional(dev, "pcie_refclk");
> -		if (IS_ERR(clk)) {
> -			ret = dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n");
> -			goto err_pcie_setup;
> -		}
> -
> -		ret = clk_prepare_enable(clk);
> -		if (ret) {
> +		pcie->refclk = devm_clk_get_optional_enabled(dev, "pcie_refclk");
> +		if (IS_ERR(pcie->refclk)) {
>  			ret = dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");

This isn't correct.  It's assigning ret to itself when it should be
assigning PTR_ERR(pcie->refclk) to ret.

regards,
dan carpenter


