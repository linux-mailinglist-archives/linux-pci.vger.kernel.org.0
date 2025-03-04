Return-Path: <linux-pci+bounces-22851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DB3A4E29A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E170619C430E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9E225DD08;
	Tue,  4 Mar 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yro1/law"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD172066DA
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100602; cv=none; b=QCafcGr3Iu5OQkxflld+Ucs/7Gs45upQ4+CeE6RIY2MdYrHwP7xq8UomnoqmeDYyf2ycLR/GidaUkNhEsW2qVvmoBsqK1hcvvVtAFUCEGuVncOEtU/CCBc11Eo52E8B6NupAOP/cuNsEPm0udTZVWO50XHE3Vrhdh7SSlmsq/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100602; c=relaxed/simple;
	bh=DMOSoahjsAmBQ1EiqWmZk689I5s/gEYGitICOTngPpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM0/NxRn0yL7m2HVcLgK0WiIwJ3UZ7Tr/lqLgsUXQeo26HSV2MhTV6jKG1ry12Dp7c7o6qtLDinC5FYcDCyqNwOx6EdL3F1EPxSMEE4WAV/pq3AQ1yv+g0xEUWfxnu/QLyddOq+4Rvl4idoVepOSD/OLFLNLM08EcgNRSTiKcS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yro1/law; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22339936bbfso85268175ad.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 07:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741100601; x=1741705401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sgp92zvnQjpgyBEdGrnvBKK/NiUrLp23oGoJzduBB2s=;
        b=yro1/lawCFsW9u2I30LjL5MTOsjrGLjVXpL1ZbwQybN1Bw2Ctft2Npl5sOzOQbspQ1
         qQxtJtcarvWSt7eF0k6GYpClR1DR9FY8sHJdFpNdDcD/gTOPj4IltlMMxBiYpXQrckHh
         iSPpNNr9XzcIrFlOBQUnhPCJZ0bKL6zxbmRBoF9J7olmfCqHKfcmZSHxKZmil6e4oBcj
         C5IlyBlzsN7+wuP9W14X67j1TEZrQn4AmgTp/tnUG+VF0whTQ3AbJxhyu/JvH0Io0guD
         kz22c08vKVxvQLC3UdfDt0teGPRzzJpRTllW0lO2EjjmoCLiw5F7fZZgBXVq6GKYcwvE
         JKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100601; x=1741705401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sgp92zvnQjpgyBEdGrnvBKK/NiUrLp23oGoJzduBB2s=;
        b=uLr9Pd29Mf+SbiNusTzpRf4o5tb3xOSdkURNs6KhUYniI+tRH8Xj7pAmV3+MtH2VzL
         pp7q5iczB5yYj9lOYWeN1S24X0NBgbsbZxpco5JiW2ov8W+Q5G0OmpBymE51vc/jPdbr
         9OZM4Ucu6AgaB0ARTIgj69wn1erI6ryXsx59/DYD7crKld16+gQXlyuS6FeFWIlTmYPJ
         3GYEb6kcoRMHqVPDdmyI1Zdg2jojiEK4lZi3rfOhDF5/dZRTMtXHBmkyUKB+9Zs4+JAp
         sYNwzyFxT10BZulYv/CQvOIXRggjDNSqTRuAHk1Iy6z1njxXbRvv9+h3AzjjtPBXRX7N
         IZBA==
X-Gm-Message-State: AOJu0YwuB8XK7vH/OL70/PwpB/dneo3MRNDoC2Q0JbK9epOqNTZdSCbq
	vGnT8PPY4i/BDuFrEaJd5rJ5gG365IRE8+SxD9beSDO/ZvNeXULAibdfob8EQg==
X-Gm-Gg: ASbGnctbvecT2beYTBWTu9gt5DNQ2wy53pFgOha6zXedzPKQJaet9+SqPblyrXtxLR/
	uERwN6/QsXoZ2qFvGE/LdEMtkt/FssT2XDSv28YLzPpPNsbTVf3ZxAJz5n1nGU4piM7MvVDDdwf
	VcpJsN9GkPq2u0cmo5+jgnuLIrvf2oY8ZTeDDDffzlh5Lb7/eZ9ox7GB/OqGcTe90LkCckLSJu4
	cG+9C2mkeUfcf8w6q6X0HjktUSGLDjDBysAu9j9u5eUpZmErUpsX5NtY47J2/k5v0XtKBDXRHVm
	T1Gbpv8JWmVPGQMuz/hfGD4JFoPA50oyqe6ErFDpIPI7AmF7N8Xo3eA=
X-Google-Smtp-Source: AGHT+IE8Rj7wGhoLcKkJr7aGFix0dNkKxSLf/uewEpInYpKi/5JDsy8IrIQcKfWAb0vRV66bAYwhQQ==
X-Received: by 2002:a05:6a21:483:b0:1f3:4427:74ae with SMTP id adf61e73a8af0-1f34427778emr2142169637.25.1741100600658;
        Tue, 04 Mar 2025 07:03:20 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de1f52fsm10116872a12.32.2025.03.04.07.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:03:20 -0800 (PST)
Date: Tue, 4 Mar 2025 20:33:13 +0530
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
Subject: Re: [PATCH v2 4/8] PCI: brcmstb: Fix error path upon call of
 regulator_bulk_get()
Message-ID: <20250304150313.ey4fky35bu6dbtxd@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-5-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214173944.47506-5-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:32PM -0500, Jim Quinlan wrote:
> If regulator_bulk_get() returns an error, no regulators are created and we
> need to set their number to zero.  If we do not do this and the PCIe
> link-up fails, regulator_bulk_free() will be invoked and effect a panic.
> 
> Also print out the error value, as we cannot return an error upwards as
> Linux will WARN on an error from add_bus().
> 
> Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e0b20f58c604..56b49d3cae19 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1416,7 +1416,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
>  
>  		ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
>  		if (ret) {
> -			dev_info(dev, "No regulators for downstream device\n");
> +			dev_info(dev, "Did not get regulators; err=%d\n", ret);

Why is this dev_info() instead of dev_err()?

> +			pcie->sr = NULL;

Why can't you set 'pcie->sr' after successfull regulator_bulk_get()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

