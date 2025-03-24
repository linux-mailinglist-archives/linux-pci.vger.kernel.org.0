Return-Path: <linux-pci+bounces-24492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CEAA6D56E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2287A223B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA94E25C6E9;
	Mon, 24 Mar 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ekm6eI9P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B5192D97
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802595; cv=none; b=Gz8NVQQIn3WU9GHVCJw/lGS3v3rbV3RFhHrXqg5PdB+a1BpGjOeNm5L+sky7qM78bzOf4Urpxs16vJzVqve2hvkIQI8gJObPNfKS3hY+Sa4Rg+WIsohcHNS/kPvc3a36Fk6eDKGCJudTSXRsdFp46annlSR3hKrA8QFPdAo3QhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802595; c=relaxed/simple;
	bh=kf6Dpou0qvvq/JrbaYu6/CG7QiVtVvfca8SqFGwvzoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOAYtGOi6JSAN3SL6Te0yjoENoD9ynr+Gye0V+INKwLSt025RkI33tN60bBz0HoCah6Q/yKrW75Sw/IfhB4tOXwegJHDzZXea8t046mLtR22mF8ks99oOQQ9LWtU3PPNiNy7k9zZzYdDQhaJ2kGI8kQXdkFdyGnNphf6bZzBjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ekm6eI9P; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227b650504fso13603445ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 00:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742802593; x=1743407393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NFIRmNQe7n7uEi96DoOu2jHTdAOyT40YGGUa5QoKur8=;
        b=Ekm6eI9PQWAqpzZS7zMo/BSwLKgAIY4in2okwaf764m9QE+Y0H8Z13HvHuhdaafhAY
         F2yiOUgvcsLRaO/I1uFj+Jc75tX3Cy2h3Ll/0O9fv863Mls9blAeJ7F7ubE0Ax4AsljI
         QqMQv9HjuGUdPxz0MKwAPx7+XEzMfxluuDiVK3on1qsJcg+LOEYezJD64o7W/s+JNkWs
         OOfgrNfXkzIMcEn3lvjInrV1VHHzd5UIadTyESuWfY8p4dt6I8tX72ikQrE5mz8445Gh
         B0c9ocAw0EYaFVuiR67nxzgj2RaRwginoFXrCmQIxI8u2quIZHrRdS45IOUD8xKS7Z6V
         eLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802593; x=1743407393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFIRmNQe7n7uEi96DoOu2jHTdAOyT40YGGUa5QoKur8=;
        b=vffd5hwDvAltwE28ik9GNqlqtCLK3HiH5bJ4bxhHlttx00aqKFfEGky8UMln+SNAvE
         1M2+smwJTYEmWqKcBu/7C9nR6UYB0wklwflwhasGegCZ8gRn1rgsdU7/eI8+9+xfEwWe
         CCXUIKB/IDXejuEfqqqBU2fDkoo1jcnFJnGLkvWatyKMStihFbmrnmEQLHbrp9eTlBuR
         SftHU/X9f/FfT+qb+c6E0BkhvisOxldKikzrV71NDXV09xveU5CTqIJWdF5ZEKjp8RLf
         pV/4wUkR5WDB/r/cejCBAyesqekEbXcKDlKw9faTj4ti3E22A3xFMPwdLDO9ZQVjAFrI
         tdfQ==
X-Gm-Message-State: AOJu0Yw5Wd6uqHuADC7vU4wkKIZTT/58XXAWfwqjBb0Ijms8RbLXwpJ9
	vMaPiXGQpUajC1FgnH0Aj+y5eFgMw0ownAT93kHOUms3lh3PBTkgM715nfkp/g==
X-Gm-Gg: ASbGncvafLdS9FClCWjekAQ2jnn+u/B0amXWSPXzTcyjJdwJUq11jR8QKy/ypAleS0Q
	fm7fB6ErpLWZBGyxlcGNk0UJ+is7Oww+xmvhKxICzElUpMG5ZMdw7RxIFuRpRqVaL1Wj89ujebc
	Su7aVvkXFz6dFeL6EivXnU6yP/8zJsy0Cz311CCS5qXCnt166DVz5et4nBOvi8wPfrlx390E2mG
	mQRE/dmx/67qSeb+oWKJDuociwEY/XdenjjlMSZAvSwRASQCugd6pgZup3lu25GoNdZEn6633Za
	R22pjqNidszKekSBsTb8i/UJbH7D6sq9bkKfnpMOAo+0bWJmlwKlqPQU
X-Google-Smtp-Source: AGHT+IFjqUyRiTKVWJF50KZXuILNEfC9bh/Fh8RLdQLup8g1ZfgW4ZYU2YulBex/PqxtrdUJC77Ijg==
X-Received: by 2002:a05:6a00:2295:b0:730:9502:d564 with SMTP id d2e1a72fcca58-739059a64c5mr17595506b3a.14.1742802593070;
        Mon, 24 Mar 2025 00:49:53 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611bd23sm7430118b3a.96.2025.03.24.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:49:51 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:19:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcie-xilinx: Support reset GPIO and wait for link-up
 status
Message-ID: <vazbdawfo4jnct4rdokknxwvknespcf33jzrmobsnecbxnrbjn@kbvxvhrow4fn>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c4ab15e9-561e-402d-bf39-9e852485e4fa@emailsignatures365.codetwo.com>
 <20250314145933.27902-1-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314145933.27902-1-mike.looijmans@topic.nl>

On Fri, Mar 14, 2025 at 03:59:02PM +0100, Mike Looijmans wrote:
> Support providing the PERST reset signal through a devicetree binding.

Where is the bindings change?

> Thus the system no longer relies on external components to perform the
> bus reset.
> 

There is a similar series for the CPM controller:
https://lore.kernel.org/linux-pci/20250318092648.2298280-1-sai.krishna.musham@amd.com/

Please take a look for reference.

> When the driver loads, the transceiver may still be in the state of
> setting up a link. Wait for that to complete before continuing. This
> fixes that the PCIe core does not work when loading the PL bitstream
> from userspace. There's only milliseconds between the FPGA boot and the
> core initializing in that case, and the link won't be up yet. The design
> works when the FPGA was programmed in the bootloader, as that will give
> the system hundreds of milliseconds to boot.
> 
> As the PCIe spec mentions about 120 ms time to establish a link, we'll
> allow up to 200ms before giving up.
> 

This should be a separate change/patch.

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
>  drivers/pci/controller/pcie-xilinx.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 0b534f73a942..cd09deba0ddc 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -15,8 +15,10 @@
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/iopoll.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_irq.h>
> @@ -126,6 +128,14 @@ static inline bool xilinx_pcie_link_up(struct xilinx_pcie *pcie)
>  		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
>  }
>  
> +static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
> +{
> +	u32 val;
> +
> +	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
> +			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2000, 200000);
> +}
> +
>  /**
>   * xilinx_pcie_clear_err_interrupts - Clear Error Interrupts
>   * @pcie: PCIe port information
> @@ -492,8 +502,21 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie *pcie)
>  static void xilinx_pcie_init_port(struct xilinx_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> +	struct gpio_desc *perst_gpio;
> +
> +	perst_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(perst_gpio)) {
> +		dev_err(dev, "gpio request failed: %d\n", PTR_ERR(perst_gpio));
> +		perst_gpio = NULL;

No. If the GPIO is defined in DT and there is a problem in acquiring it, you
should return the error.

> +	}
> +
> +	if (perst_gpio) {

This check is not needed as gpiod_set_value_cansleep() can accept NULL.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

