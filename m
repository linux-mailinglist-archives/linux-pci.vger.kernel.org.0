Return-Path: <linux-pci+bounces-24907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A4A74314
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 05:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEDB3AFF11
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 04:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A1192B89;
	Fri, 28 Mar 2025 04:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vV870gnk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908DE18DB2F
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743137643; cv=none; b=iM8ClTh98iQEpma5oVxvq4xP2BLcB4mmEUTLV1oF6G1G45kjuvQ3DADwQ8lHM24jx/WTk3WHyqVOAjPT4gU+kgfFW2aR8uaxynRpHV6vrfaUBygZe13yingNKh4RRJueoUEqOA8xqeZ9Raz5wMBBtvd7Oji+wfEbjWSD0vHVtwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743137643; c=relaxed/simple;
	bh=wlCOnsjiZBmy8hxKdTaPTWNa+BTqbyKajifqCGeReuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmkG1DHn7POPC9AVRZJFqQ/D/6WilIC55SZIxx3hA9AXQKYaVjcdc4/T/SHdNOHiz82jnOuDlTUZcoNPtyVziChP9N8LLJjBZtgkrzpYowNDb19/xHapg0v2pbR9jJit3zFn9cOS9SNedCTswcQJkamCZgCxcRgeuTOhdvuJvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vV870gnk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224019ad9edso47278775ad.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 21:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743137640; x=1743742440; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kuwg9J1mLwXX4otg3M7+S40hVbpDz6/sZtDcqTbG7BE=;
        b=vV870gnkADRUfCpvB4aWllfaAZECNzvfKpqLU59u6qGKH/WLLDrZRJSYErg36zyzQG
         fnb2WeNKxws5uVFoT10M8dcDAIGqn32g7hvAEZuHOqJqIDOWzGvAqJPv3yiCXrQTRQgx
         HtZg3gdt59cb00FtoWuzMUcKJ6d2Rp6QLspLiY0pl2wi1Y64bXqhExFBLV8UyiXb/5Fe
         aIif8ZGKiYotlDxo3ubm1f9CjFls9H1w+4kLr+RYvCdBgUl78e3aPqyCFNP7C75Di7sj
         lflmVFURG9cGBFXBH41FN1hRfB+y3owy6uJb6LWi3uJ4TxxHSyhBW0B00ly/J8qx2l55
         yccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743137640; x=1743742440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuwg9J1mLwXX4otg3M7+S40hVbpDz6/sZtDcqTbG7BE=;
        b=jjWjrVI9MtXCLmWUwepMXDU82Gd/Hg1Gg7R9mCyYQn+Mhwrw1TPLrVLMQUUhRDzOsG
         ksc1NOmgYzQaG41qHpYMb0U8UECXNf4/OX4X8ljBuW7cinKQQG+DzSVG2YFBWNwBEmFz
         TNyNECy85iZeQ+9Q8dIKOpfSI8BGJNimxQbzJFWFaZFhcn5VDw37wM2n4gmyVZtdbBGQ
         3VjXLlu4CCfbmGGs3H8oqCq3SFQt+ZdZXQ9ZRcruhAf1r6/UzUBgmflvG0eDlmSPgCgK
         q1s1YSTK41UH4va9DaAR8XqCjP+JHtdTmI7ULF2F4+1xG2ps1MSdgyMRSoXBFHzzsJ10
         gugQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMZXi6skh9bCo35UjqeIV2NNZ+94jF7wp3NzgdVZRL/c9BS5VtY2xo5qDkwlSx8JUdMIOuQ/OoQH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXpM5iWcRX5IDXKss1RVCv4ch/2IXgTjg9ie8RobgDpqoAcaeN
	VOJGnpYI0FuBjZFD64nHBXKHubX2MDitONakY9CDYZdJ9E3pErRKDCgKE1V0aQ==
X-Gm-Gg: ASbGncs/qh+i07eDIGRWOvBDrnyyL9qN/sShKxZ2ulyzG3Y6u0+7uXQDquzuvDi7BGW
	zr71RdQBg3/N8DQjrBwZWYZHGf7I1FzT2HTJH0g3NQ0IJpI1u9g4FZ5dTgwWo8OKKL8AnCi2kTH
	l1WzKwHk7IHbvvTGrFo0ORVEebsNZRPN99czwqOCy1aJkABGdDL5ji44Hj/a3oEuxFVcXvD6YNP
	tgOWA3WxFT5uQGs1AFTeIWlDnOYkVtZekRetVX0GWe5K5AHVwHJSLBa1Uhsfml8RV78oznRRvs3
	UCZbbDU0rmqsP8z1orNgaUlK9fmNb9Ry7LP5oTwtRF8L4IO9OzTHrsbyOPCFS26jmw==
X-Google-Smtp-Source: AGHT+IEPFx2YvGLJ7FKIh8Gd3Y8GYR7AmiZtAy2aMPBo7YLDtuaEAWd1L+B7N/DCUhXjq3JhGPD8XA==
X-Received: by 2002:a05:6a00:1793:b0:736:6202:3530 with SMTP id d2e1a72fcca58-739610cb699mr6602382b3a.22.1743137640377;
        Thu, 27 Mar 2025 21:54:00 -0700 (PDT)
Received: from thinkpad ([120.60.68.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970def203sm778261b3a.6.2025.03.27.21.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 21:54:00 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:23:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v8 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
Message-ID: <3sbflmznjfqpcja52v6bso74vhouv7ncuikrba5zlb74tqqb5u@ovndmib3kgqf>
References: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
 <20250316-preset_v6-v8-4-0703a78cb355@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250316-preset_v6-v8-4-0703a78cb355@oss.qualcomm.com>

On Sun, Mar 16, 2025 at 09:39:04AM +0530, Krishna Chaitanya Chundru wrote:
> PCIe equalization presets are predefined settings used to optimize
> signal integrity by compensating for signal loss and distortion in
> high-speed data transmission.
> 
> Based upon the number of lanes and the data rate supported, write
> the preset data read from the device tree in to the lane equalization
> control registers.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 60 +++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
>  include/uapi/linux/pci_regs.h                     |  3 ++
>  3 files changed, 66 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index dd56cc02f4ef..7c6e6a74383b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -507,6 +507,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (pci->num_lanes < 1)
>  		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
>  
> +	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
> +	if (ret)
> +		goto err_free_msi;
> +
>  	/*
>  	 * Allocate the resource for MSG TLP before programming the iATU
>  	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> @@ -808,6 +812,61 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	u8 lane_eq_offset, lane_reg_size, cap_id;
> +	u8 *presets;
> +	u32 cap;
> +	int i;
> +
> +	if (speed == PCIE_SPEED_8_0GT) {
> +		presets = (u8 *)pp->presets.eq_presets_8gts;
> +		lane_eq_offset =  PCI_SECPCI_LE_CTRL;
> +		cap_id = PCI_EXT_CAP_ID_SECPCI;
> +		/* For data rate of 8 GT/S each lane equalization control is 16bits wide*/
> +		lane_reg_size = 0x2;
> +	} else if (speed == PCIE_SPEED_16_0GT) {
> +		presets = pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS - 1];
> +		lane_eq_offset = PCI_PL_16GT_LE_CTRL;
> +		cap_id = PCI_EXT_CAP_ID_PL_16GT;
> +		lane_reg_size = 0x1;
> +	} else {

Can you add conditions for other data rates also? Like 32, 64 GT/s. If
controller supports them and if the presets property is defined in DT, then you
should apply the preset values.

If the presets property is not present in DT, then below 'PCI_EQ_RESV' will
safely return.

> +		return;
> +	}
> +
> +	if (presets[0] == PCI_EQ_RESV)
> +		return;
> +
> +	cap = dw_pcie_find_ext_capability(pci, cap_id);
> +	if (!cap)
> +		return;
> +
> +	/*
> +	 * Write preset values to the registers byte-by-byte for the given
> +	 * number of lanes and register size.
> +	 */
> +	for (i = 0; i < pci->num_lanes * lane_reg_size; i++)
> +		dw_pcie_writeb_dbi(pci, cap + lane_eq_offset + i, presets[i]);
> +}
> +
> +static void dw_pcie_config_presets(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	enum pci_bus_speed speed = pcie_link_speed[pci->max_link_speed];
> +
> +	/*
> +	 * Lane equalization needs to be perfomed for all data rates
> +	 * the controller supports and for all supported lanes.
> +	 */
> +
> +	if (speed >= PCIE_SPEED_8_0GT)
> +		dw_pcie_program_presets(pp, PCIE_SPEED_8_0GT);
> +
> +	if (speed >= PCIE_SPEED_16_0GT)
> +		dw_pcie_program_presets(pp, PCIE_SPEED_16_0GT);

Add other data rates also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

