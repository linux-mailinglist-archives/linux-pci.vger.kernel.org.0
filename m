Return-Path: <linux-pci+bounces-22850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B20BA4E271
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F06117C2CB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ADC27E1DA;
	Tue,  4 Mar 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azrrZJOX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19610277806
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100254; cv=none; b=iS7eGddUVh9g2YpgfWnmU/qUNLjPe1eIFlcjmiOXR5hCrNAcOQMpHNuTgnb8MJiCq8mQ7LORV4x4gagzwIa0BOzyj0UnvAuZsFtsh50k24cePvNL6SrGUFRv8d7djoHXcM9WKwPWbzbjXLw5KI1/B+0jf+6v28amOhLn5TAtmjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100254; c=relaxed/simple;
	bh=K8C3hmIFC9Q50r0TsdLo+cvtp2V7ltUvaziJRbo5Ll0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2YiP9Iq10Y26LGEr/6x4V8V6cxg5sXqtnQhci2BLFYaB1r1Feet9hMT8CRawmBeGKxASnpulYtokjJOWRWLVgWlfrdP+AHBoLFVU+jXp0Ey9Ix8BmH6bYw2wGU6LOC3ri3wGEAKlaYuCUveg24GLN4dT4RwDOKK5Y/EcwS/8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=azrrZJOX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2238e884f72so52027365ad.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 06:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741100252; x=1741705052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bB0FA1hVPZJ0S4Y1IaK4hi0Fvaas9G2N8erQYJkQNzE=;
        b=azrrZJOXrdoBbsbo2U26Giciaf6KTN0PABnbXlMjZPVAIY7PCjs2CKOcRgbC7443T2
         t73iOnR5TZaH2nYXipTkShu7149FP/WqSZrq24Ee5UUX4AYwQ2nsUeJlVuQ9PkcvauDv
         3YhEjjnzhgTDQGcSyCWcuR8g38gJShd2bKGMzCKObxZfaclKkOYgYZDC9xP1RJfb+6/c
         1kDtB1m0uU3qf5A6c/nITpwOUwbsytteQUIix5/hAgy5fn0STUUGJWz+A1AeO9AGiJN5
         FP6XiCwUz2T7vYZD0BCWrnPUHKQS1K+7nCEkjA/P4LMIgRtdLfz4XLXJCmczW3yIxu5A
         xuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100252; x=1741705052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bB0FA1hVPZJ0S4Y1IaK4hi0Fvaas9G2N8erQYJkQNzE=;
        b=Q7R2R2N1empqI7dbi0t5e4QWDVKr5Plh7u5o9m059BqsSu72/Fbuzd47NBkmU2NYoS
         yyYYrmaqjbjjDrAMXAKYSoHoow8FD+QnQzBeFyFZaWlmD496H4XfW/I+i8ibfOUkudjV
         CtwozJ9x1VSnBwmRJ1Ews6atad4BSbOdEO+AXmUMA+O3npO/mSN7cTghwIfdCKx5FMST
         LE/BO1emvhnvGQ3tIZ14Skjzmc6BgBgXT4ogU7qHKr4uEGrY1J3al5fNulEWhvGPgG2x
         +N+3qa/PqxFjVmO2epUCz6Sq8cJ1bNxqWgGTatMG+PX+pF56+3EFyJNxGTyMzLA1hJjr
         EAgw==
X-Gm-Message-State: AOJu0YyJjLJtZUK9tDRTEOYJ6It6XlMmaOYlWI53VwpiA+PctuiBFSvl
	bU1ZzZgD4ME1rDW1MASnWzvtDIUO32PpjYqnlAOrMXVEzYRqOu3WrrTa93lQQg==
X-Gm-Gg: ASbGncvLxC10xrWqEIpONWXeu7HZ2Qu266QE34p+w2mDDz/Yd2SoUZeKfTW4rKlcB1D
	C709eiyZ0993J5BD1sMF7vGPnuhhrdKyGDka3JgEfcuIOYuNl9MUNvpy8ARocPoe3QsotGpIRBk
	LKN8wvgpdIPZgeXBpIl81qnlC8jFvZci36oUe4k3nfgEHLDR1oVSxmSLyFD4IUR57FL2cS13Xj4
	Tc/SKo5nAO4dAufZw8JYJwtnEGTsYXPIcGpbArm1Eisb+W83inENUHiOx15RHHzrR5Hxaud2HEY
	3G0yMIuOxfk7bLJMc9SSdrtt7MuNU7o4n59Cfv3a2k+oABbEFWVjxhM=
X-Google-Smtp-Source: AGHT+IGo7wa+ol8U/rxNOCJnFdMfRJrO9oY2HvfjcAeePQLXu1JAeASpEDGGST/KBMpQr7w4rAQjHw==
X-Received: by 2002:a05:6a21:6f09:b0:1f3:46cd:d01f with SMTP id adf61e73a8af0-1f346cdd0f4mr1167212637.21.1741100252271;
        Tue, 04 Mar 2025 06:57:32 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73519c31931sm8622046b3a.20.2025.03.04.06.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:57:31 -0800 (PST)
Date: Tue, 4 Mar 2025 20:27:24 +0530
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
Subject: Re: [PATCH v2 3/8] PCI: brcmstb: Do not assume that reg field starts
 at LSB
Message-ID: <20250304145724.itrzj6wnflxxf3up@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-4-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214173944.47506-4-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:31PM -0500, Jim Quinlan wrote:
> When setting a register field it was assumed that the field started at the

s/a register field/LNKCAP and LNKCTL2 register fields,

> lsb of the register.  Although the masks do indeed start at the lsb, and
> this will probably not change, it is prudent to use a method that makes no
> assumption about the mask's placement in the register.
> 
> The uXXp_replace_bits() calls are used since they are already prevalent
> in this driver.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 98542e74aa16..e0b20f58c604 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -415,10 +415,10 @@ static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
>  	u16 lnkctl2 = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
>  	u32 lnkcap = readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>  
> -	lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
> +	u32p_replace_bits(&lnkcap, gen, PCI_EXP_LNKCAP_SLS);
>  	writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>  
> -	lnkctl2 = (lnkctl2 & ~0xf) | gen;
> +	u16p_replace_bits(&lnkctl2, gen, PCI_EXP_LNKCTL2_TLS);
>  	writew(lnkctl2, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
>  }
>  
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

