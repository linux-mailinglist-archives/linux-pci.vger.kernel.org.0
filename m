Return-Path: <linux-pci+bounces-10752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C6993BBC8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3935B2355D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2C518633;
	Thu, 25 Jul 2024 04:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUxOa+HB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563718046
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721882249; cv=none; b=LYu3xdarHky6zu1ZBudRY2KW3PMf9OrnF8iq7LukYPjcT44D2AxB9tOLPQbhyIYEtYRsqx8wu3aY2JTg8wXbkk6KpLtpOzq1LpVC2aGi9Yixc4on9e4xJCOTP+LGMcRh7ojVCvPnJIVG/ytcee/CKf1dbBTKcWpO9lOK0t3PfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721882249; c=relaxed/simple;
	bh=nQ+RJQHyfq63tZOKYOqsxP8VydZPSKB+6877TeGYgio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChW45ox5JI6BfXRPbD8Ge4Dte+bAfuGk7OdjZjXIk5Pa+EccIqj7Jr9i0mH/kKMoKkMHO93J4uLPWQUcAg02qltmXRiZaK0zwHiqEX4N1kGCf88U+pz1NwpFQsm7DaSZMFMGVv50+ojuV1TQqceC+n6f0pVrqGPWH8jjMDyfVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUxOa+HB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70ea93aa9bdso452617b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721882247; x=1722487047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1JZC88oKp8I89s655kcwpoA6y+G6A3ga7BdD3U4lzs=;
        b=NUxOa+HBG00K471GvLFQE6JMIxdeTHYD8pYpZe+5w8N6yux4Nvawu2MyRCDiVxuI37
         Q/IKMSrZ1g+LyvxfspAb/6JhCiRAWXL4ZM34iGfukmer/0xm8rTxDl2njcXraKCQvJhX
         C0mAJGfaH0FXjeFQUSrlJWa9FFEeqgUHuOy3vX+XA9Cg8dgFAsqkVnQQYnwEFxTDFf7E
         UUSHP/2E0uRGrR5B54QP+yhunPAKJZ39w5rsX9Yw8iERpKnIzMrXETFmFHCHCHOPIv9U
         Lhc+h9TKEREqU3HcUmpw1pKN7yHeZKPiqlslVZpZ/NwWWH4NhSwoQx2XkpaOlega9iRv
         uA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721882247; x=1722487047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1JZC88oKp8I89s655kcwpoA6y+G6A3ga7BdD3U4lzs=;
        b=iLDaNN7bE/BffK/aq6kogHux6nwMszjiqKx2Wc9ATPREbFZ/Umi80eniQKi/ZaeDoW
         in0ByBovMNDwL62qiqtfWd3ptzyrlDfmkPbS8+CPtmkvMArzS7cDXSw3UoF33C3BxeE4
         dwXQ40OdOyNFFwNEsBOWr+rbvvlGHpL3lbMg2zaMSUaCkNKB8bMhwp+++ybk8OY1ipdt
         MnrusU7JS0UJCppRhTtVgvfPy5UicTpByPI3ZufpxU4uuwLHY5siloKN/uU2jgTUJKlL
         CNIfW7Yhvmu3Lpg4pOBhEZtPku9ME6lE7ue10tSNs3sf/HpnMIUxZA6bRGgCdbKLOyEf
         YZ9w==
X-Gm-Message-State: AOJu0Yy3TU+2VPuGYlBulR4hx8BrvNCwal0/iHC1QB2AbIiEVE/q52KE
	1+RfUMy2EmFkHAF9EGhZtJQ1JeK2NgBKdco5aiE3xUbAYk9rNpri1c/5hroJ4hQpQHAXL+anRZM
	=
X-Google-Smtp-Source: AGHT+IHb2jiz9X2SslE25mDu/kpZvHi3w6d2thIeHc9lJAHRInMESIHfvCFleCXeNij5wye9qnJ6mg==
X-Received: by 2002:a05:6a21:328e:b0:1c3:b1e3:eb42 with SMTP id adf61e73a8af0-1c4727fb229mr2515129637.15.1721882246765;
        Wed, 24 Jul 2024 21:37:26 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ccd5adsm4291585ad.74.2024.07.24.21.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:37:26 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:07:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/12] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240725043720.GE2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-5-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-5-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:19PM -0400, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> If it is present, use it. Otherwise, continue to use the legacy method to
> reset the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c257434edc08..92816d8d215a 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -265,6 +265,7 @@ struct brcm_pcie {
>  	enum pcie_type		type;
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
> +	struct reset_control	*bridge;

'bridge' is an opaque name. Use something like 'bridge_reset'.

>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>  
>  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
> -	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> -	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +	if (pcie->bridge) {
> +		if (val)
> +			reset_control_assert(pcie->bridge);
> +		else
> +			reset_control_deassert(pcie->bridge);

Well, these APIs will bail out if the reset_control pointer is NULL. So you can
just call them directly instead of if..else condition.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

