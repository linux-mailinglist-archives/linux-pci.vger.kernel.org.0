Return-Path: <linux-pci+bounces-21100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B228AA2F5A2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8A31693DE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FBD257AE3;
	Mon, 10 Feb 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wu7zErk4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8FF2566CB
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209449; cv=none; b=VMiZxejejnE2BlpSGow5TAWEssrfRRFM5CxXwkEYtLYoRxYG3IzVIxHjxF4x9COtkhgRyj4fKWSqD0snieLNv9ebBG9k6YHtSU8/Kbd1av8a1j5mJxXarIWqxKFQjJITEwHCPZvxesm8cTcdjPwrQvLc/3rt+aYKMWO8uDRNBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209449; c=relaxed/simple;
	bh=MZEYtgbgkRzWrOBlQYfmPgTqpgt4KupY+Sbh2oWyooE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS4CwYWuIxxgtN8w3ZWDHYLFvnxUeyCwOvEU0kzO2i3evI8CqE5m4Xevwqkt/5AXuGit5Ozc3hdGhT1L7RldoqZnjV7Mj8JYATdCjP0l5ELcWwXkCmIK70v+G2QP3GYmXEuEfmtM5QzfuEscXuTDhrYQczX88egb2xTIKzXc+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wu7zErk4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f48ebaadfso76405065ad.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739209447; x=1739814247; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3p0Nb18WEpCUScW3nbIYjqeHasF4SbUZ7UgG+ZawxuE=;
        b=wu7zErk4JUr5rVYsbpkircTLico4+S1OZNO/FGSLAskDBSblHjc8t1DR7sYw7Bp2C2
         aXnZRr1GdVGI2wnqGzln/e7yTDjmYY2vtBUGG1K0D9qZPtauSYFrEWrt+A7ZU8PfPvBc
         I/rSVTKEMeihcHS7ZvU5WFOHX9DvyBv5/Voy5ukTM+rO3m13NyQXc0YF/c5VaszMnFKI
         dG0FjUALBTW3nvWi7kXPjv7EvgiL/FLBEnnqb9iTsL8sRaNuV8mVUqaOXAZ4F2VGs7Po
         J6J9RptfjO40kofMsdGn6jFWnUFG4gYrXz+MEu95OklsrKvPloq3nWblameBl8sc7wl8
         1ewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209447; x=1739814247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3p0Nb18WEpCUScW3nbIYjqeHasF4SbUZ7UgG+ZawxuE=;
        b=R8sDnLvN6rd1KaRoI6j0zs7kS4pjyfX5rrhQgj9vPg3WkzAfUPZk5Ug2JK7dW/cwQW
         UdwsNxDKgTQN24nx1Cg6IP5Lkd0zbNI2JBDSs9mQfCYZsSruo+QuMYKQX0qyG3EmVsRo
         4yutsfyXxErKh7W82YVW8MIGiBVAzGIMuq3wccsutgp97NP1AR/lQUFg9fC7NBXEcfY6
         HfT4j+pHme78aqdKMaSf+GTRSFegyV3P5Ac085mvDLPCqamiefyF8hZYOUdxRUtIbaoU
         MYgaxvt3GQ2WzNGv/bFifkrBdGWll2sF+6GB8B1WElALpAzh6TcHN2UE9l32yYJLM3Sn
         Ohbg==
X-Forwarded-Encrypted: i=1; AJvYcCWCOWYeVd4b/boR/c2zIApS1U3DDMhVcXp3bVe83npsbKJ2/msSqvV1j8qX0haJB43+h+Z+JzgGRQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4JQtRjvnkQdqoCuhv+hzf8oVoVDX9OuMRXvRpAWjSpptSBoY
	ydM8yZZTjNdLP+EGRPGmjXaguHp98vurbzclVLI/cbhMDm2JgKFFszuGhAK8Lw==
X-Gm-Gg: ASbGncsONobdYxqrEcbinQ4zp/QYEeLWWb4QGnmzyxbY8m9nnLccGCkgGrTl8l/+mQt
	ckYH6uZsXHhn2z3eXG5cgCG6l78sGUS2V4UJAtO1WKIYG5uHcbjTLZ3P5Su36Dp9Avm2U0RGIju
	gBgk2NTDA9rwxmzrAZ4AJcqJ4iw8blz4OSX2yDl4lkS1tlnmk0polg69vLJC/1XB2SgswBkKPRp
	hY00Wq/BJS9XqzOY1dOjM6gm3cwb1Miesjv7XBa5bQkaZ1Noi140k8zegzxDyfqGbcr9LnUoWOR
	Kveoz5hj61aacyN6QBhKQ+qc90U1
X-Google-Smtp-Source: AGHT+IGz+rRFm4sLRz/LKXusArAECr2Awzp9D7TnZpTJWT8jbA5xaFCqDdKdJ/LsYsSZJfGbkx2YGA==
X-Received: by 2002:a05:6a21:9996:b0:1e1:a693:d5fd with SMTP id adf61e73a8af0-1ee03a93b08mr28177074637.25.1739209447306;
        Mon, 10 Feb 2025 09:44:07 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad543ceacb9sm4274040a12.72.2025.02.10.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:44:06 -0800 (PST)
Date: Mon, 10 Feb 2025 23:14:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	"open list:PCIE DRIVER FOR STARFIVE JH71x0" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: starfive: Fix kmemleak in StarFive PCIe driver's
 IRQ handling
Message-ID: <20250210174400.b63bhmtkuqhktb57@thinkpad>
References: <20250208140110.2389-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250208140110.2389-1-linux.amoon@gmail.com>

On Sat, Feb 08, 2025 at 07:31:08PM +0530, Anand Moon wrote:
> kmemleak reported following debug log
> 
> $ sudo cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffffffd6c47c2600 (size 128):
>   comm "kworker/u16:2", pid 38, jiffies 4294942263
>   hex dump (first 32 bytes):
>     cc 7c 5a 8d ff ff ff ff 40 b0 47 c8 d6 ff ff ff  .|Z.....@.G.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 4f07ff07):
>     __create_object+0x2a/0xfc
>     kmemleak_alloc+0x38/0x98
>     __kmalloc_cache_noprof+0x296/0x444
>     request_threaded_irq+0x168/0x284
>     devm_request_threaded_irq+0xa8/0x13c
>     plda_init_interrupts+0x46e/0x858
>     plda_pcie_host_init+0x356/0x468
>     starfive_pcie_probe+0x2f6/0x398
>     platform_probe+0x106/0x150
>     really_probe+0x30e/0x746
>     __driver_probe_device+0x11c/0x2c2
>     driver_probe_device+0x5e/0x316
>     __device_attach_driver+0x296/0x3a4
>     bus_for_each_drv+0x1d0/0x260
>     __device_attach+0x1fa/0x2d6
>     device_initial_probe+0x14/0x28
> unreferenced object 0xffffffd6c47c2900 (size 128):
>   comm "kworker/u16:2", pid 38, jiffies 4294942281
> 
> This patch addresses a kmemleak reported during StarFive PCIe driver
> initialization. The leak was observed with kmemleak reporting
> unreferenced objects related to IRQ handling. The backtrace pointed
> to the `request_threaded_irq` and related functions within the
> `plda_init_interrupts` path, indicating that some allocated memory
> related to IRQs was not being properly freed.
> 
> The issue was that while the driver requested IRQs, it wasn't
> correctly handling the lifecycle of the associated resources.

What resources?

> This patch introduces an event IRQ handler and the necessary
> infrastructure to manage these IRQs, preventing the memory leak.
> 

These handles appear pointless to me. What purpose are they serving?

- Mani

> Fixes: 647690479660 ("PCI: microchip: Add request_event_irq() callback function")
> Cc: Minda Chen <minda.chen@starfivetech.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/plda/pcie-starfive.c | 39 +++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
> index e73c1b7bc8ef..a57177a8be8a 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -381,7 +381,46 @@ static const struct plda_pcie_host_ops sf_host_ops = {
>  	.host_deinit = starfive_pcie_host_deinit,
>  };
>  
> +/* IRQ handler for PCIe events */
> +static irqreturn_t starfive_event_handler(int irq, void *dev_id)
> +{
> +	struct plda_pcie_rp *port = dev_id;
> +	struct irq_data *data;
> +
> +	/* Retrieve IRQ data */
> +	data = irq_domain_get_irq_data(port->event_domain, irq);
> +
> +	if (data) {
> +		dev_err_ratelimited(port->dev, "Event IRQ %ld triggered\n",
> +				    data->hwirq);
> +	} else {
> +		dev_err_ratelimited(port->dev, "Invalid event IRQ %d\n", irq);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Request an IRQ for a specific event */
> +static int starfive_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
> +				      int event)
> +{
> +	int ret;
> +
> +	/* Request the IRQ and associate it with the handler */
> +	ret = devm_request_irq(plda->dev, event_irq, starfive_event_handler,
> +			       IRQF_SHARED, "starfivepcie", plda);
> +
> +	if (ret) {
> +		dev_err(plda->dev, "Failed to request IRQ %d: %d\n", event_irq,
> +			ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct plda_event stf_pcie_event = {
> +	.request_event_irq = starfive_request_event_irq,
>  	.intx_event = EVENT_PM_MSI_INT_INTX,
>  	.msi_event  = EVENT_PM_MSI_INT_MSI
>  };
> 
> base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

