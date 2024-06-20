Return-Path: <linux-pci+bounces-9006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50D90FCAC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 08:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F77285FCC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 06:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14532B9B8;
	Thu, 20 Jun 2024 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GohHJSct"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C81CFA9
	for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718864949; cv=none; b=pWwlTebBl6hSSZYaJGCwm3wEOa39VoLhG0+DQgCBionbB2FB1Op2kOl6mIGaoB9d2rybz5PWGNDjdYibAtpzPqWHqB6pjsVxjqDiIVt0q1rQ6vZGE41ngwrBsEZhSP1G+qYiOAMbvk5byv30WmrjDqS5wjeBYLzgF0w75iSsAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718864949; c=relaxed/simple;
	bh=qSZ4TkMvLzHHdnQyRb7cUKqsQR3bINeDvTqHFWQKxRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlpcmZIY1rpuVOxznKMyxVj0nK/y5NwbZ88Ce8dseE1QgJViRuzqTe9S0uEQWis9YlG46BX3fIKA0VVD7FJ5JO5DTnl3QpVyxS8UDDqCHhsUjuSP1c6Dx0B+AKSA+9Q2tnA8i03iyd0HpR6u9BNMrrJQmOWQCkghMckIK4m1Jtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GohHJSct; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6e40d54e4a3so415182a12.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 23:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718864947; x=1719469747; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OrOguSW1xSBikrPxVle5u+auw5xGxdyhVPIRfQxuybU=;
        b=GohHJSct1Y2UIVJmT5O11duROIvLm6Ay4YSGCLJwkbMQQFqu4eWJLOi6C/Z41QKClo
         aIHhIhfUM3nKdjSIozPifac2FrFZzfmxvLXb61DSfOCXS4qKo4a9SD+HEy5Q4XRpkXSd
         o9B/jXRaBQwQfbIUTxajLXxlJntW0c7363GVmuvMEotHnooXEglsti0/Vhgwlu7Ln6nW
         GLIZRe5Sqr+osYky406fB14RfSsWjRQr49E8y0yvQF9UfTzxoHVEx0REK9ROqN492tw/
         5ipUQEP3/tmpGfB3BMQbYHtCJc2E0dEE7QKwDnBFyADpFvuKV5xpn/d41w4F7pCvJNOe
         zdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718864947; x=1719469747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrOguSW1xSBikrPxVle5u+auw5xGxdyhVPIRfQxuybU=;
        b=doAawelxSm18aKAUwjZ6GTkPJbJp/oo58FzJpR18sTr+8fQrEe87beKPYNRGyMIX8i
         Q6Ch/874aGsQ+Uygf35jFmtr+4UHhxod708CAmRpK89PdglKlCKJOxAX6uKovNRkoI+1
         hiUNvP4FJYi4t6f6nDezCvHYPltKmPmpGQjWtDj7nPhyDkTjdjvFdGXQdLzztPQt5bjZ
         9MzmtbGB97RFMaULxehKPV9FZGnpTDqp95vl/4LiNevSeAQAn0mflxUhhn8X30f8aRnk
         5alWlXUm2DbB71dL4bkACF8jF7D6b9nJMXTyPDZuGGEjx7ZOL/moS7EXcCQN0h51nWgg
         koag==
X-Forwarded-Encrypted: i=1; AJvYcCUwEThQIt1Mhb1RA2R+dsGSQdIn2Z1uXoUXyMcjCQ0lzMwIP/qGuPDaistlqziJEjra0i1wp8NxMN8dW37NfaIbrcgrQtoKAx9b
X-Gm-Message-State: AOJu0YwWXAPUou+UI2er/at0rxxlVlAla7HA5KM0XjP1iTqNipKPBY3n
	hAUKVlqvf0dr6ZxlB88LJI1Kq3Z+RUp7KthUYGtyIcg2/Ogsns7eLE/DqnKy8g==
X-Google-Smtp-Source: AGHT+IGhBLmT7J5yTVsjH+i1UCXjrqy1tsA6XXF04aIkSu369kHLPXXzz3maS23iBc759WeKfIKRQg==
X-Received: by 2002:a17:90a:2f43:b0:2c7:bade:25be with SMTP id 98e67ed59e1d1-2c7bade2676mr3877809a91.14.1718864947153;
        Wed, 19 Jun 2024 23:29:07 -0700 (PDT)
Received: from thinkpad ([120.60.54.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53ea57fsm837788a91.14.2024.06.19.23.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 23:29:06 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:58:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: mvebu: Dispose INTx irqs prior to removing INTx
 domain
Message-ID: <20240620062853.GA15813@thinkpad>
References: <20240619142829.2804-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619142829.2804-1-kabel@kernel.org>

+ Marc

On Wed, Jun 19, 2024 at 04:28:29PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Documentation for irq_domain_remove() says that all mapping within the
> domain must be disposed prior to domain remove.
> 
> Currently INTx irqs are not disposed in pci-mvebu.c device unbind callback
> which cause that kernel crashes after unloading driver and trying to read
> /sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.
> 

Thanks a lot for respinning this patch. It is indeed fixing a real problem since
this driver can be unloaded runtime.

It is always a debate on whether an irqchip controller should be allowed to be
removed runtime or not, but I hope Marc will provide some inputs here.

> Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx interrupts")
> Reported-by: Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> [ refactored a little ]
> Signed-off-by: Marek Behún <kabel@kernel.org>

But this patch looks good to me. I hope that we should be able to use this patch
as a precedent for other drivers as well.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> This was discussed back in 2022
>   https://lore.kernel.org/linux-arm-kernel/20220709161858.15031-1-pali@kernel.org/
> IMO Pali gave good arguments about why it should be applied, and Lorenzo
> agreed.
> 
> Can we get this applied?
> ---
>  drivers/pci/controller/pci-mvebu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 29fe09c99e7d..91a02b23aeb1 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1683,8 +1683,15 @@ static void mvebu_pcie_remove(struct platform_device *pdev)
>  			irq_set_chained_handler_and_data(irq, NULL, NULL);
>  
>  		/* Remove IRQ domains. */
> -		if (port->intx_irq_domain)
> +		if (port->intx_irq_domain) {
> +			for (int j = 0; j < PCI_NUM_INTX; j++) {
> +				int virq = irq_find_mapping(port->intx_irq_domain, j);
> +
> +				if (virq > 0)
> +					irq_dispose_mapping(virq);
> +			}
>  			irq_domain_remove(port->intx_irq_domain);
> +		}
>  
>  		/* Free config space for emulated root bridge. */
>  		pci_bridge_emul_cleanup(&port->bridge);
> -- 
> 2.44.2
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

