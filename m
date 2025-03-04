Return-Path: <linux-pci+bounces-22838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD11A4DF57
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 14:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255613B4068
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454C02045B8;
	Tue,  4 Mar 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhDlBARi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB72045AE
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095200; cv=none; b=cD2/8vJkRY0MPuufmBEUe9RDpSOIkJk2fFcWYAnp2hJuxdxtNRcUAo3fqPdiz5goYb2Tz2iB8oZaDTw62n/myz1fNz4LprF4YAYbzxAOXPJ2b380qOHvbXTRC/AA3zN6nYGZ+XFtyjZs0asmAKdWduSDiKoeKyAYhJf+rtmQHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095200; c=relaxed/simple;
	bh=JvIzTzx9bNAT9dTkwz9wJO3WMvtIvRTqt7LZsstIXms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avlgZkF8HHZgfWOMPQ4+FfbIp+NcSVsfTSkZ1pbE8ORYgTr+GI0+J+yePyRiVLZ7wjwUEiU2r+mGNCP9shFuyPZil466YTOE6QEdufJkCTSficXKFLls1+8wABNXcatNMu4rUy/YBL5DxtsLC+EaIGz1OuEtZh7s5LC9I2QK8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EhDlBARi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2238d965199so48562615ad.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 05:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741095198; x=1741699998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3qLR77tna3KlWSQd6zNZ6y+8asGhaaD5n37dc3k5ZDg=;
        b=EhDlBARiHZ7sm0Scekwrzd7PCPAckZYK2uMArP5GJ5LDbvaKu+vHHeSdvouYnbxgVN
         DnsXWYWEVTqLwX37Ye94z/q3Upd5KMG+KKsmtupPdRWCwxYES1gEHf7wPkC4M6+4BX6U
         hlxiZT10bW0/tZAQm85snsGchINv7BX/yuwpOA8pQQp68QiZjYMHKuVgQr19EAu43eHQ
         7VMss69M1MPOc5rEwPK3gZ/U3EXjvms/br5SprLKiQbCtjz2O3tr/o6kyw9hmbgen9vb
         6rYyiIuRqOHUb1pFvjIkXgg5KmTdJPdq9beCIc/SuypLIVHqGzZpXtnk6ukwJYRIynQ9
         +LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741095198; x=1741699998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qLR77tna3KlWSQd6zNZ6y+8asGhaaD5n37dc3k5ZDg=;
        b=fAEFWVC6AIFVc+5t8e7e2a5Lb4HNw95n3vP3m4v7KF008De1Htevcmv3ujILshFpKK
         HnUfvZlIbXjS7ggPSUmTSN5arO2dpa+PitpjNGN6T6dt2Uew6inB7GUQCp8fyC6GKsP0
         9vxJXa/vxHc8Z7iWVGgPkgdpBuzVc3NPzoarj0wKnZnp/3avDQtT0eUczObzFyJJU3Gu
         12dK3MGii9JHa1XDi/vUq6oK/t0XEA07waFWNs2bq4KnygXITlTK7Ppmzu8L4boFx4rW
         sEmHy6xxWgMoGL+qTMoNhPSGGM6VywmdeTX7OeWQ83K+Mf+OBsFi5c6+BWTJQrEuSL7Q
         /wwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3FRwofe7dR+NRUsq4lwVYRE1AP8BRAnMSXp3L6quTIy1uU+Sj0OpFXESltxMbqANzO1P6Hx/KSIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9e3b6d48haDfAF49OZAyHQLjzN2CiTe5xii2M3NxsqqUh56F
	EFUkOR4QjkgtG/gi1qVyHElyiHG7zaTlNe3PgAParwVwrRpD4c/pW1XON+t+yw==
X-Gm-Gg: ASbGnctDTD3VjR4TXq73wgIfrLZ4W8ewSk8+BYJC0mQ9a6qVO+JNN7sAop/2suoPHaG
	8sQxyUlUWKruR/6PyLdmz3CwGpGdBGt4fj9euPJJs9dq6GbXj/76QdysPBPvE9eUFn0vB0kgYNu
	0Uj7Z9/Z3wdpDOnKzJUORE6fDXpjpoIE2YlbpCOpmO2phhbK09aW+rV1Hp+qHjOQ1x3/hqYaRPD
	DvCdDS2XmLkccjHBm+sxDpiFlrJh8Aysn0oL/fXW0j2mPisP/emeRQdfMuqic1vz0/s37Um+xV9
	J3peXjAnFqsDAHe8tN/TjQ6FeTiITXEJlP7iAKQ8ye1LKX+r7zQnE0k=
X-Google-Smtp-Source: AGHT+IHF6tXmS5YA0nVLt+px5dErJnwlnsN7HgkRQHD9Cn5z48DU2q6k2zrG7Enx21WGbLqujcN0nQ==
X-Received: by 2002:a17:903:2b0b:b0:223:2aab:462c with SMTP id d9443c01a7336-22368fbe99bmr265499305ad.15.1741095197919;
        Tue, 04 Mar 2025 05:33:17 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9dacsm95662135ad.83.2025.03.04.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:33:17 -0800 (PST)
Date: Tue, 4 Mar 2025 19:03:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Message-ID: <20250304133312.hmn54f77pmg27tuo@thinkpad>
References: <20250227042454.907182-1-sai.krishna.musham@amd.com>
 <20250227042454.907182-3-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227042454.907182-3-sai.krishna.musham@amd.com>

On Thu, Feb 27, 2025 at 09:54:54AM +0530, Sai Krishna Musham wrote:
> Add GPIO-based control for the PCIe Root Port PERST# signal.
> 
> According to section 2.2 of the PCIe Electromechanical Specification
> (Revision 6.0), PERST# signal has to be deasserted after a delay of
> 100 ms (T_PVPERL) to ensure proper reset sequencing during PCIe
> initialization.
> 
> Adapt to use the GPIO framework and make reset optional to keep DTB
> backward compatibility.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> This patch depends on the following patch series.
> https://lore.kernel.org/all/20250217072713.635643-3-thippeswamy.havalige@amd.com/
> 
> Changes for v3:
> - Use PCIE_T_PVPERL_MS define.
> 
> Changes for v2:
> - Make the request GPIO optional.
> - Correct the reset sequence as per PERST#
> - Update commit message
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..558f1d602802 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -6,6 +6,8 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
> @@ -568,8 +570,24 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct pci_host_bridge *bridge;
>  	struct resource_entry *bus;
> +	struct gpio_desc *reset_gpio;
>  	int err;
>  
> +	/* Request the GPIO for PCIe reset signal */
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio)) {
> +		dev_err(dev, "Failed to request reset GPIO\n");
> +		return PTR_ERR(reset_gpio);
> +	}
> +
> +	/* Assert the reset signal */
> +	gpiod_set_value(reset_gpio, 1);
> +
> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	/* Deassert the reset signal */
> +	gpiod_set_value(reset_gpio, 0);
> +

You should deassert the PERST# only after the power and refclk are stable. Even
though this driver is not initializing any resources, it makes sense to move the
assert + deassert logic at the very end of xilinx_cpm_pcie_init_port() as this
function sounds like the once initializing the PCIe port.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

