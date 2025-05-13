Return-Path: <linux-pci+bounces-27632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7E2AB5315
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 12:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96DC1882A4F
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33D6250BF6;
	Tue, 13 May 2025 10:40:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633F2472BA;
	Tue, 13 May 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132825; cv=none; b=kbLwVsYg0w4qOEnsTSNedeQGqPw/itf4jIZPRVDAHlkcS/I9o8eAvgYrn2Wh5yjRadr1tB1NZU4LjpocaTZrp3YjbxwTneQVBelQhmAY0enkOt/hW6f4k6RE7OpJ6R4mOkREA0zQIXfY/CQxYmMMoqQ2jVbFV0ooxJTaEHwihHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132825; c=relaxed/simple;
	bh=l/y3qcuOXIexffIqzdAAfKb5JPptC0q2mioWGR4lZ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+m5gvisMWDl+4S1RSSE9oGinxgfkLxZ1lM6j3blTFI2Vt3TgdyavlfjXRlvSOtUZhEarpYPWHuzlB3TE6Xi/+Hc+Y3BgdL6bCaS+d3rF9V2yXzK3OoMW5vMN+5/4jDMtTDdZNYpm3qHMlq9vuMmlQqHFcnPnjhN0HHiPdeG2Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7423fadbe77so3870039b3a.3;
        Tue, 13 May 2025 03:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747132823; x=1747737623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v0V/+AF4oDvIYG7l9ZAc1X2CkAPTP0CArzdqpDOm00=;
        b=SOE6v+JN+FmDfM8iv3EciL73Iu4033Z+0Db5vA9IUwXSY14basV0UxO2Fe/Dn6MSLX
         RGrpk1UV+5S5u+Kh3Fau7x3Yfrfu5BWVMc+K7dbcNtsrqTpJ0u4wb3Xbyt1DZNiYBNKy
         cnknnp7xT0DtVU2Iauo0j33w5iesnjhxGxKyjCjzipWsqk3djNVKMFtT8HDKtEUb4Do2
         QIWkj/PqwfxHWlnA9pmCDvyE4B3eJQd4MngBRqSLU//Ptv6RTvKlwCCAKJiu+PalQxDJ
         BinVqc5bbjSXON9oJBLcBtgv1B3g9Ah90fKkwPk5MBge6nciICmpqHG2GOyBn/nL9U6n
         XdGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZrMPtqbsKZ0ox+0cBD+Islcvcu58pUy45cphjUn9bhj8oB9HcbvLNVXUY0lG+cfqCoXpog3LAtbE6t9Q=@vger.kernel.org, AJvYcCXkxpGM6uO6saEHuMblRZ/DpJ6PV68qtoakEzAkXpmtlBruKaXNrKmX04M5LUHi/jxKQ1fE9tEgSJa5@vger.kernel.org
X-Gm-Message-State: AOJu0YwOydGwoRYsJ/2Oi+ikBEMwKlqHGjvw2xKlXmhyR3XHhYyW2L9w
	V1C7PSWs1jDxAEomXDUXhiQ4sZRprvZImjJue+FTvbJFGMlyHZwd
X-Gm-Gg: ASbGnct6pHAnuf/oFt9ZIRXuuduv6J9UkFuG3QTDgM4vM+TyFG1FT+T0FZpLAxfiNiO
	RYo6P5N9u95czFWFS8WgN1q4M3EdeUivUmjAocYmsx8S1OXEvvyqAvLPjBewsN18DJJkc08mqtM
	OBlbxDeyFFH6nsrtjvhw3GH8CQG4ciGXONJN3ptBDnZm4XwYZ/S6zFpDuooaSUxmlcFb44O37sI
	FG3DiR8nN41viecFsi7IllSsw8DxIkMq39z9m2PqJsRFblYSdQO8ayO0/5Ky+DDt/OzoESTCWl+
	kjKDLSaT/sNCSJ61cYiHpb0AdmBn0BenIzzjpGMtwVrS0+bwvu68dX8N1O/XhGXPhhRSDfycGEa
	1WzlRADr1JQ==
X-Google-Smtp-Source: AGHT+IGr2aW/45b/yavzWHBWkTHeJduuKUqU4UjeaD90HPWZf++irPva4RTyoiN9IoRRzK60hGo4XQ==
X-Received: by 2002:a05:6a00:480a:b0:742:4545:2d2b with SMTP id d2e1a72fcca58-74245452f5bmr13884832b3a.3.1747132823070;
        Tue, 13 May 2025 03:40:23 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237704713sm7594134b3a.2.2025.05.13.03.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 03:40:22 -0700 (PDT)
Date: Tue, 13 May 2025 19:40:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/4] PCI: rockchip-host: Refactor IRQ handling with info
 arrays
Message-ID: <20250513104020.GC2003346@rocinante>
References: <20250509155402.377923-1-18255117159@163.com>
 <20250509155402.377923-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509155402.377923-4-18255117159@163.com>

Hello,

Thank you for the patch and the proposed changes.

> Replace repetitive if-conditions for IRQ status checks with structured
> arrays (`pcie_subsys_irq_info` and `pcie_client_irq_info`) and loop-based
> logging. This simplifies maintenance and reduces code duplication.
[...]
> +static const struct rockchip_irq_info pcie_subsys_irq_info[] = {
> +	{ PCIE_CORE_INT_PRFPE,
> +	  "parity error detected while reading from the PNP receive FIFO RAM" },
> +	{ PCIE_CORE_INT_CRFPE,
> +	  "parity error detected while reading from the Completion Receive FIFO RAM" },
> +	{ PCIE_CORE_INT_RRPE,
> +	  "parity error detected while reading from replay buffer RAM" },
> +	{ PCIE_CORE_INT_PRFO, "overflow occurred in the PNP receive FIFO" },
> +	{ PCIE_CORE_INT_CRFO,
> +	  "overflow occurred in the completion receive FIFO" },
> +	{ PCIE_CORE_INT_RT, "replay timer timed out" },
> +	{ PCIE_CORE_INT_RTR,
> +	  "replay timer rolled over after 4 transmissions of the same TLP" },
> +	{ PCIE_CORE_INT_PE, "phy error detected on receive side" },
> +	{ PCIE_CORE_INT_MTR, "malformed TLP received from the link" },
> +	{ PCIE_CORE_INT_UCR, "Unexpected Completion received from the link" },
> +	{ PCIE_CORE_INT_FCE,
> +	  "an error was observed in the flow control advertisements from the other side" },
> +	{ PCIE_CORE_INT_CT, "a request timed out waiting for completion" },
> +	{ PCIE_CORE_INT_UTC, "unmapped TC error" },
> +	{ PCIE_CORE_INT_MMVC, "MSI mask register changes" },
> +};
> +
> +static const struct rockchip_irq_info pcie_client_irq_info[] = {
> +	{ PCIE_CLIENT_INT_LEGACY_DONE, "legacy done" },
> +	{ PCIE_CLIENT_INT_MSG, "message done" },
> +	{ PCIE_CLIENT_INT_HOT_RST, "hot reset" },
> +	{ PCIE_CLIENT_INT_DPA, "dpa" },
> +	{ PCIE_CLIENT_INT_FATAL_ERR, "fatal error" },
> +	{ PCIE_CLIENT_INT_NFATAL_ERR, "Non fatal error" },
> +	{ PCIE_CLIENT_INT_CORR_ERR, "correctable error" },
> +	{ PCIE_CLIENT_INT_PHY, "phy" },
> +};
> +
>  static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
>  {
>  	u32 status;
> @@ -411,47 +450,11 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
>  	if (reg & PCIE_CLIENT_INT_LOCAL) {
>  		dev_dbg(dev, "local interrupt received\n");
>  		sub_reg = rockchip_pcie_read(rockchip, PCIE_CORE_INT_STATUS);
> -		if (sub_reg & PCIE_CORE_INT_PRFPE)
> -			dev_dbg(dev, "parity error detected while reading from the PNP receive FIFO RAM\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_CRFPE)
> -			dev_dbg(dev, "parity error detected while reading from the Completion Receive FIFO RAM\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_RRPE)
> -			dev_dbg(dev, "parity error detected while reading from replay buffer RAM\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_PRFO)
> -			dev_dbg(dev, "overflow occurred in the PNP receive FIFO\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_CRFO)
> -			dev_dbg(dev, "overflow occurred in the completion receive FIFO\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_RT)
> -			dev_dbg(dev, "replay timer timed out\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_RTR)
> -			dev_dbg(dev, "replay timer rolled over after 4 transmissions of the same TLP\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_PE)
> -			dev_dbg(dev, "phy error detected on receive side\n");
>  
> -		if (sub_reg & PCIE_CORE_INT_MTR)
> -			dev_dbg(dev, "malformed TLP received from the link\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_UCR)
> -			dev_dbg(dev, "Unexpected Completion received from the link\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_FCE)
> -			dev_dbg(dev, "an error was observed in the flow control advertisements from the other side\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_CT)
> -			dev_dbg(dev, "a request timed out waiting for completion\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_UTC)
> -			dev_dbg(dev, "unmapped TC error\n");
> -
> -		if (sub_reg & PCIE_CORE_INT_MMVC)
> -			dev_dbg(dev, "MSI mask register changes\n");
> +		for (int i = 0; i < ARRAY_SIZE(pcie_subsys_irq_info); i++) {
> +			if (sub_reg & pcie_subsys_irq_info[i].bit)
> +				dev_dbg(dev, "%s\n", pcie_subsys_irq_info[i].msg);
> +		}
>  
>  		rockchip_pcie_write(rockchip, sub_reg, PCIE_CORE_INT_STATUS);
>  	} else if (reg & PCIE_CLIENT_INT_PHY) {
> @@ -473,29 +476,12 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
>  	u32 reg;
>  
>  	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
> -	if (reg & PCIE_CLIENT_INT_LEGACY_DONE)
> -		dev_dbg(dev, "legacy done interrupt received\n");
> -
> -	if (reg & PCIE_CLIENT_INT_MSG)
> -		dev_dbg(dev, "message done interrupt received\n");
>  
> -	if (reg & PCIE_CLIENT_INT_HOT_RST)
> -		dev_dbg(dev, "hot reset interrupt received\n");
> -
> -	if (reg & PCIE_CLIENT_INT_DPA)
> -		dev_dbg(dev, "dpa interrupt received\n");
> -
> -	if (reg & PCIE_CLIENT_INT_FATAL_ERR)
> -		dev_dbg(dev, "fatal error interrupt received\n");
> -
> -	if (reg & PCIE_CLIENT_INT_NFATAL_ERR)
> -		dev_dbg(dev, "non fatal error interrupt received\n");
> -
> -	if (reg & PCIE_CLIENT_INT_CORR_ERR)
> -		dev_dbg(dev, "correctable error interrupt received\n");
> -
> -	if (reg & PCIE_CLIENT_INT_PHY)
> -		dev_dbg(dev, "phy interrupt received\n");
> +	for (int i = 0; i < ARRAY_SIZE(pcie_client_irq_info); i++) {
> +		if (reg & pcie_client_irq_info[i].bit)
> +			dev_dbg(dev, "%s interrupt received\n",
> +				pcie_client_irq_info[i].msg);

Why do you think that this is better?

Other patches in this series seem sensible, but this one does not stands
out as something that needs to be changed.

Thank you!

	Krzysztof

