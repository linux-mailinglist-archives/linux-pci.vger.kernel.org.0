Return-Path: <linux-pci+bounces-22857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A40A4E2FE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48B6420BD5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC9524C066;
	Tue,  4 Mar 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eITQcMky"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1324C062
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101051; cv=none; b=Yjm9YgKfCCuo5GSPNu2uCA2odQx2MIb4Kxe1zWYNuGLw/UD4aptvvI8EPntT4DRYkZDtqPxn9gjygCU+IVUeyRZWPaQgUYbUQrW13PSeWRp6vhwR5FVjGbgovZzr1uTo7NdndT6yh0SCgc9AAlqw80llyn4gmPHBvKHJvmSWsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101051; c=relaxed/simple;
	bh=43kkvm0fDoGaY3CU2LfS1Vs/lca8x1zkYXTvuUBDxGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMA853adhZxGV5LB8EDwKYMx7EdvtTL+J242yxxH8fpvs7U53VN3/9VDYjUWQaLLF/EZH8PnmLm+62g0F8BkCyWwShxGZwuJ+vU3fq2rci/xkEHA8XXaNlnQJiV/+yV62NIil8gbyRq30VTBrZV1qrrBX7NvFhNUQHSGz7RjWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eITQcMky; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2feb9076a1cso9517839a91.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 07:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741101049; x=1741705849; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vdhvna9uxBeu4mYpj5OPBxZhuzN87zcLw+LVQRQ7m7s=;
        b=eITQcMkytMhZaS2gd3R9YaW6ig419DuIwvf85dd23hCf0S+5c7oqCFRXj+uFUHQ/IV
         q7bETRmmzce7WYAxwnQBY/CADwA/7UWuOFxCYZFb/4UXQe213U3gUIqWahJB6P8hxAkJ
         G3/WVRR2jpojmpoPcCYkZ7pMbQ5LvUAw7lsPQQKT099BprX4J2gd0NCeCpG3gA/02W+N
         WAe2sKT1TKkcRFSwvS8/DlMWAInVA2b9eyLYhSVFbYnOw0ffhXhNMSJ7V7MO6hdBQ5P/
         DQ12WGxSizi/Coc6YXvFmTwVhzH4xpGz/ozg/lB8f24QIRaldCNyCNWsXeyBjygyA6r/
         SnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101049; x=1741705849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdhvna9uxBeu4mYpj5OPBxZhuzN87zcLw+LVQRQ7m7s=;
        b=JgFKmS0ysyE1zocPtDOKrhl5UP3HFZZCvuH32OTXWCnQAFykEbBgCqZykPIVA0Tjoc
         Fn7lOyLre40xMa/ZnLE4DR/szUH5nz3Nud35cLSsKOS6KrBJCZOq/zqduU9qZCmDWWWY
         c2bXDCP5L10R3hqwlOaJ3sNQLMLGXXFiUVPULKQ3fz3MbDcmFXV+LTPIbkqEO6O4FGpA
         0qbzzYt+zTS89CEKCnsy6XjMzDQuv+jg7Refko0xtOgyRKuTPErlOzfYadykNpX6c64i
         GlgHSSXpIkuP2maZPcqPVBsgFWgwted9pFLaD03YAW8iQxeWXgx6/qKA8vfinZNyEDRk
         c2Sg==
X-Gm-Message-State: AOJu0YyI5CIl5PlcNzzvxqNuIN2fpCDVnb+YewET/6ki3AZUl6YEY8B0
	YPRQ576SBXT9AXrXdSyHuaxHXD0dGEIhqBWQj4e0BPwPuwNpl4nULq6FPYK6BQ==
X-Gm-Gg: ASbGnctKVFDKry37gMLkvIzMtUfIH3Dk45f8jqQsgcAS9SnVvkEMj5FmpXE87CMHrxz
	ReBl2ArdQUPUNI1b9tfjRl94sbNcG3oMytPfWTv1CS0a74ype32eZhnX/luVoTZ3l2DGQzri+87
	kiEcGikXxRu+veHiq9WUsEEThau5SzqdFOAKEjNeSVFDDekHTD+SCnlY+gJrewWOWjpW4zob/fb
	HJmGdp4A6PH14amVygtRfSA/ra+g6toFtgoEeYqfsy/Dm/jKFMBPl6Ahihcqxl20LK8TxSLqVcw
	8bNWT8bB0HG8cJkCfv9s1urNjS1DN6NBnQOzXsUg+k+GJUSoon1d2j8=
X-Google-Smtp-Source: AGHT+IGfTEua5Nua/thzn0LAom+PoolH5xRKN+uIh0BTTsH6+TMAMWAEwJ3FTRgLK3drwMf2I3fVUQ==
X-Received: by 2002:a17:90b:4ac6:b0:2fe:b8ba:62de with SMTP id 98e67ed59e1d1-2febabd9d13mr26339791a91.25.1741101049205;
        Tue, 04 Mar 2025 07:10:49 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223852162bcsm59170965ad.8.2025.03.04.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:10:48 -0800 (PST)
Date: Tue, 4 Mar 2025 20:40:40 +0530
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
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] PCI: brcmstb: Clarify conversion of
 irq_domain_set_info() param
Message-ID: <20250304151022.qgp253hv5sxvxzdc@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-9-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214173944.47506-9-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:36PM -0500, Jim Quinlan wrote:
> Just make it clear to the reader that there is a conversion happening, in
> this case from an int type to an irq_hw_number_t, an unsigned long int.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index cb897d4b2579..f790d5252e9f 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -559,7 +559,7 @@ static int brcm_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  		return hwirq;
>  
>  	for (i = 0; i < nr_irqs; i++)
> -		irq_domain_set_info(domain, virq + i, hwirq + i,
> +		irq_domain_set_info(domain, virq + i, (irq_hw_number_t)hwirq + i,
>  				    &brcm_msi_bottom_irq_chip, domain->host_data,
>  				    handle_edge_irq, NULL, NULL);
>  	return 0;
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

