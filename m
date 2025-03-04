Return-Path: <linux-pci+bounces-22845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620FAA4E218
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C1C19C1360
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516827D764;
	Tue,  4 Mar 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joUmfuVl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C627CCFB
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099892; cv=none; b=OqtFwUimGdhhtgq7aeQ2SPchHF2qFi3hA4ywb5GPVo/TsTFcIL7m9Hj2HF0kFUrFZroHmoQIoRn/G8y35Q4hbyxin5A2kwCj3rsS6A4K9QoU9aRLLCnBgRu9BGM0tdsuwTE3OZhF6Rkhq9oSYf3CJ5BarbGU90wo2axWCm0cS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099892; c=relaxed/simple;
	bh=Othvkt4z3OMuKADQKjYPkNUm0zui2FIoobFAyRI42mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6QoMeF2CxQcT1y8nvARmU2Ja6alKoz8V5BDMaGw3z5dAaDRwnUx2Wp/h56N3KvEmKHi7TXMqB9gh1d1umfEEOMnB6yLqxCVYyJ6qo5Xj5TAmvM+RXsKoSleboKTLVAt20Wyf+RBWAONHb2VKIRmhxhecHwLd28mWQsj5yY8rX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joUmfuVl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22328dca22fso86270065ad.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 06:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741099889; x=1741704689; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gznVwH+MYZINzbreoVjaIlyEQO9ArPaCcwj3cczf12Q=;
        b=joUmfuVlCTm+lEWSmqCHbY/hNYkLvBk0konQk2llGZemZbsYZDLrEqb9KAM1Mia1Lh
         JJ/iLEOhxefiLTcMZ1sFr2F4GmfZrMzFsFJn28lEI2flENULAL8pXeicaxR3/NCn5LZy
         gzR7SljHkthORV0MedWNJ4Sa+1HUS+6Je+HDBhrGSkJG4aobu4mmv4xS7jhyEMDI1TZZ
         ZUukduN508JI9cPUGMCyxyklvffnoKY3ZNlmuILQmRB9dJxyNDfCtHzjheWVgge/hsln
         /mfwb/WkPjP2EWtVf20hsIlMuP1icGNk1RlegUd7Q+xNRVbhqmU6qb/Ro7cY9bJ7w2lR
         lx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741099889; x=1741704689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gznVwH+MYZINzbreoVjaIlyEQO9ArPaCcwj3cczf12Q=;
        b=P6qHseTqBmbCt8xHQ5tbFAM23Wk4wjPG783N07jbUUHlWOCwcDvDC8Ou3LCtPcocX2
         gNZ5LuR780Zj7clIDOy7FK3YYaAaJaJlG+zoB1OS4tnP2zZ+BZ30eaW3/pTBKjcL7odL
         SRJcAHQYyswVJM0ZRA7E/FvaGkBy1pCaiPvDpMyAxDbXvJV6DmePhwoOKt9Ip7S2w7AZ
         vg7yUVLnrA5ECDp/sR3VIjsOyStHRjK1ssBrEdE+4w1EQbFQbRwDxQTcU+u659nVtzOE
         2zEwpSXUAlC0cLJmTbZlz3uTcwUoDMVKm5StiAoej+tASk7mvcvcHF9WTW0hiATtOKAH
         3oXw==
X-Gm-Message-State: AOJu0YzbpiOpNhIFV2gj+cvxMA12uC8DGOP9Hh9rrZn2MVjiQqLl/hml
	q48qS4qF9h+fMdzsQIgLIZG2Gfoy0xYDbNMZnl25gVSEag9uJqsiwu51El5UGA==
X-Gm-Gg: ASbGnct1KhomCqLkAq2SLWWNa2FIhmlKe+M5Sj1GIXSjE6c5Ip8n+vvVus4kwubtFvP
	WTp9cc8mz1Wo+zfZlkLau/BnCysEhYNmAXscPl/qnveayDsxbxkYevgLKWI2i5qqzlMW0q/KTjg
	YNz8WnQGhyBzkX7mdVfpvKFINAgw5P+ebn8aXA28B6U3peILvIFLwR82EIkCeQOCyyeszqTQ5FW
	89VZriIQN7unp6WZ4t2OxaDs/q37Dz+I4ZmmbF+RBgsqX12KS1/7OSdu5pbFonec14S4IxlS/F3
	++DsVnocjJe4ck1Qhd6QmnC7s7P1wZ8uZK7DrtJxkmyY03GTrcCiUX0=
X-Google-Smtp-Source: AGHT+IFgqXki/xp/pRgDQUN3wwkxjCspLF0YwdBipW/dxQdQmaDNd9QyTywhiG7k4tt1FdiccdjR1w==
X-Received: by 2002:a17:903:fa6:b0:223:37ec:63bf with SMTP id d9443c01a7336-22368fbc8f5mr247045075ad.25.1741099888925;
        Tue, 04 Mar 2025 06:51:28 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d326fsm96562045ad.10.2025.03.04.06.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:51:28 -0800 (PST)
Date: Tue, 4 Mar 2025 20:21:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jeremy Linton <jeremy.linton@arm.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] PCI: brcmstb: Set gen limitation before link, not
 after
Message-ID: <20250304145120.jrcxrvnuhj2cweyp@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-2-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214173944.47506-2-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:29PM -0500, Jim Quinlan wrote:
> When the user elects to limit the PCIe generation via the appropriate DT
> property, apply the settings before the PCIe link-up, not after.
> 
> Fixes: c0452137034bda8f686dd9a2e167949bfffd6776 ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
> 

Common practice is to use the 12 chars SHA for Fixes tag and not the entire 40
chars. Like,

Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")

And no need of extra newline here.

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 546056f7f0d3..64a7511e66a8 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1324,6 +1324,10 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  	bool ssc_good = false;
>  	int ret, i;
>  
> +	/* Limit the generation if specified */
> +	if (pcie->gen)
> +		brcm_pcie_set_gen(pcie, pcie->gen);
> +
>  	/* Unassert the fundamental reset */
>  	ret = pcie->cfg->perst_set(pcie, 0);
>  	if (ret)
> @@ -1350,9 +1354,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  
>  	brcm_config_clkreq(pcie);
>  
> -	if (pcie->gen)
> -		brcm_pcie_set_gen(pcie, pcie->gen);
> -
>  	if (pcie->ssc) {
>  		ret = brcm_pcie_set_ssc(pcie);
>  		if (ret == 0)
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

