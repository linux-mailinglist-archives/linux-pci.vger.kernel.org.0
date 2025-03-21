Return-Path: <linux-pci+bounces-24340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FCCA6BB32
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA2EA7A593C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 12:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2A22A4E2;
	Fri, 21 Mar 2025 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uY374mxh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22335225387
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561532; cv=none; b=OqGt7ctbuRXXu5/FXnFLEwyNOHUZr+I7R/F29OhtfYFc5I9WJtOyWJGFzPtNRAOFhq2smB+1KPdFF7Egu27y5EFAgdyANKge7j6rYw8FwFFTM05FQUoMMm3iI/SQMfrdIF6but/fYdyWrUO6RV4DIxKXdZ65mFqFIqmWV8CxByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561532; c=relaxed/simple;
	bh=omo7++uwL5aCKwwOkOgkXq3mk5bdOuv6RRCIHDEgpqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl8ufLLZvl5HQCFG1xVJ6tiXS9Lme3xjPtzJ/KD6vfzEmi/KUG0m/gbfwQ6Q//teEmWdyD8wPY+Ixn/g3WG7c3eveeduAfFzuOkb8DR/hKLkYr/EYCiLaS7tEKHHtG4jU6EFCI7nrxPvHzP5zXuiPH+NZqwh+8Acgk0Gih3AW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uY374mxh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223a7065ff8so2255875ad.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742561528; x=1743166328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oSMguLk/NY450VoESU9bEhEakSFxqQn+/7jPnZETdtQ=;
        b=uY374mxhDrUDIgLWQ5UadBLdebV+utlaJSWfKuMydnsBiA+cV1UKAvCDdbznlvJ+Dr
         XU5uZRIYGBEVifrnW3pLn/fqV9DfUzBpVh/KQQtXuezu3DVE1U96RT11D+7kkNahwJDg
         dij4jobtUTldX86xjF3dewyZetUGiYU3Gl+v7yH5mEia/eBFVt2gZXeuah/TNLThFX0V
         vN5eag6sfHdilcMCO8f22bM5u8Ji9V1Acor7DLvTqo7qP6cX9FU8rBRvgA060SyOuTsN
         Sb90r5JMrPY88shRjp5r90m0qJtLMeNMqmHaO/s3C9kQzb4oj3fBZU8mlxDWhz3vyVyP
         C1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742561528; x=1743166328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSMguLk/NY450VoESU9bEhEakSFxqQn+/7jPnZETdtQ=;
        b=fr1baOqvIHuirjrKZATI39z7Jy39OK0+Q550+4K2Dglad/RDAuDoE0pKU2pJdraLoH
         Vf6dkz/v2HJ3vOnNHoa7IF2A+HTgMFPdiPkkidWecXMbS78oQCfw8B0HrGICSR9hOjlf
         wGE76f75wcB78ohzlrOKTpfPOkpDXZsUOR33XJYLD2zYr2DSGRsCEKpl7B8N72aMCmRl
         tSzjFRDkqVXuQ7IqH6wYE5W+qX2sNwnlV4+I/FubudRuieiPdeBarISGo0o6EX47yx1o
         ifF7U0dzxVCPc13SDr397BWQJc9eLvS3wa5t4mRNaOq0uzFUjiTQJLXWt1VpBJzIojcl
         MHWg==
X-Forwarded-Encrypted: i=1; AJvYcCVOXVTf/BqDbIDRTIpmcaFvx1JvRG1f708w6slypTXwW0afE06ODzclrj/SHxY9CcQy23layumMCmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2RR2+xMWROdjknDK3C0sfFzsEPdAaGzj4J08kUoV2RrjvImz
	J8zBr6wtEj1nfMPpOwGOW/npHryyjR2Xda9v2AqCldQI3uzcHQyevhD6ZNonug==
X-Gm-Gg: ASbGnct8j8friBOIgNDfp+xTiNwC9cbsxEGeVukJz0XKFhKeQe7U0fl3FMzmxPDMR5V
	dM0GZSgbMGG3jxV76KG8i9V7HNDHKX4N+L+a8utEX8H/MhQRW4d0KZZoEVN9dxhif2sdPuOLyxz
	Na4VLybcvHoO1/k6yVpv/5MQEqFjdXTnXgK8P/eep8ZMIvVh1XCPnmc0xlTfIbJHo03cKDsCBd0
	yCNTS7YSMaxpPsXeDcg1bW2HvunWgC8cuFmfxP/+z+UAITgu0ArL8K/3lWfhwlc/v11KLiMQ5Fn
	5k0lEArxafsmpEWaGaXVUjiQ7FKZumWogzEj0ArNhBR2ft+CXyA4rHVJ1EKZ/r1eEvoN
X-Google-Smtp-Source: AGHT+IF0zPLlYeMl5R+KmmcWKZ5uqrU4n7zgCXtfPnd8npBg8qglifut7iSMwIOZCm1K+7HdX/RMMA==
X-Received: by 2002:a17:90b:53d0:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-3030fd36f80mr6475642a91.0.1742561528376;
        Fri, 21 Mar 2025 05:52:08 -0700 (PDT)
Received: from thinkpad ([2409:40f4:22:5799:90ea:bfc4:b1d2:dda2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf6360besm5897432a91.43.2025.03.21.05.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:52:07 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:22:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Message-ID: <20250321125201.2r6zcxwkivt7t6s3@thinkpad>
References: <20250318092648.2298280-1-sai.krishna.musham@amd.com>
 <20250318092648.2298280-3-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318092648.2298280-3-sai.krishna.musham@amd.com>

On Tue, Mar 18, 2025 at 02:56:48PM +0530, Sai Krishna Musham wrote:
> Add PCIe IP reset along with GPIO-based control for the PCIe Root
> Port PERST# signal. Synchronizing the PCIe IP reset with the PERST#
> signal's assertion and deassertion avoids Link Training failures.
> 
> Add clear firewall after Link reset for CPM5NC.
> 
> Adapt to use GPIO framework and make reset optional to maintain
> backward compatibility with existing DTBs.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes for v4:
> - Add PCIe PERST# support for CPM5NC.
> - Add PCIe IP reset along with PERST# to avoid Link Training Errors.
> - Remove PCIE_T_PVPERL_MS define and PCIE_T_RRS_READY_MS after
>   PERST# deassert.
> - Move PCIe PERST# assert and deassert logic to
>   xilinx_cpm_pcie_init_port() before cpm_pcie_link_up(), since
>   Interrupts enable and PCIe RP bridge enable should be done after
>   Link up.
> - Update commit message.
> 
> Changes for v3:
> - Use PCIE_T_PVPERL_MS define.
> 
> Changes for v2:
> - Make the request GPIO optional.
> - Correct the reset sequence as per PERST#
> - Update commit message
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 66 +++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index d0ab187d917f..fd1fee2f614b 100644
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
> @@ -21,6 +23,13 @@
>  #include "pcie-xilinx-common.h"
>  
>  /* Register definitions */
> +#define XILINX_CPM_PCIE0_RST		0x00000308
> +#define XILINX_CPM5_PCIE0_RST		0x00000318
> +#define XILINX_CPM5_PCIE1_RST		0x0000031C
> +#define XILINX_CPM5NC_PCIE0_RST		0x00000324
> +
> +#define XILINX_CPM5NC_PCIE0_FW		0x00001140
> +
>  #define XILINX_CPM_PCIE_REG_IDR		0x00000E10
>  #define XILINX_CPM_PCIE_REG_IMR		0x00000E14
>  #define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
> @@ -99,6 +108,7 @@ struct xilinx_cpm_variant {
>  	u32 ir_status;
>  	u32 ir_enable;
>  	u32 ir_misc_value;
> +	u32 cpm_pcie_rst;
>  };
>  
>  /**
> @@ -106,6 +116,8 @@ struct xilinx_cpm_variant {
>   * @dev: Device pointer
>   * @reg_base: Bridge Register Base
>   * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> + * @crx_base: CPM Clock and Reset Control Registers Base
> + * @cpm5nc_base: CPM5NC Control and Status Registers Base
>   * @intx_domain: Legacy IRQ domain pointer
>   * @cpm_domain: CPM IRQ domain pointer
>   * @cfg: Holds mappings of config space window
> @@ -118,6 +130,8 @@ struct xilinx_cpm_pcie {
>  	struct device			*dev;
>  	void __iomem			*reg_base;
>  	void __iomem			*cpm_base;
> +	void __iomem			*crx_base;
> +	void __iomem			*cpm5nc_base;
>  	struct irq_domain		*intx_domain;
>  	struct irq_domain		*cpm_domain;
>  	struct pci_config_window	*cfg;
> @@ -478,9 +492,42 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
>  static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
>  	const struct xilinx_cpm_variant *variant = port->variant;
> +	struct device *dev = port->dev;
> +	struct gpio_desc *reset_gpio;
> +
> +	/* Request the GPIO for PCIe reset signal */
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio)) {
> +		dev_err(dev, "Failed to request reset GPIO\n");
> +		return;
> +	}
> +
> +	/* Assert the reset signal */
> +	gpiod_set_value(reset_gpio, 1);
>  
> -	if (variant->version == CPM5NC_HOST)
> +	/* Assert the PCIe IP reset */
> +	writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
> +
> +	/* Controller specific delay */
> +	udelay(50);
> +
> +	/* Deassert the PCIe IP reset */
> +	writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rst);
> +
> +	/* Deassert the reset signal */
> +	gpiod_set_value(reset_gpio, 0);
> +	mdelay(PCIE_T_RRS_READY_MS);
> +
> +	if (variant->version == CPM5NC_HOST) {
> +		/* Clear Firewall */

On top of Krzk's review:

What does this 'firewall' mean? Clearly, not something defined in the PCIe spec.
Also, you made it independent of PERST# line. So is it really needed for
platforms not supporting PERST#?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

