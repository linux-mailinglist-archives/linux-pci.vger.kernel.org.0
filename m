Return-Path: <linux-pci+bounces-21439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F56A35A71
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95ADA3A4A25
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD29D23F40D;
	Fri, 14 Feb 2025 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6I0aDEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51C2253E8
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525663; cv=none; b=Bk5XbGpKNGw9Ff50MYYYzQ+K7IEy51ukorD92l1V8RCSzCdOnbI180ivyyZdtmYu9th3nmlb+DUwqTx1/82KHDItrYZdthgLKmBI0UfvW16abKRjkOS8E4vyT2WyPh0+ZV9Td4MvI4esH/+dnNsH2PdWnn85xHv3VmJIfmS6lQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525663; c=relaxed/simple;
	bh=2tRaXOF0v8LaZTAj5JP6mDSWvTyNjRID6Lm1XvMJFxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+zUIuin/Wgy7iB6BCJ2huaSFIovW1oW7j2J3/ZCRhHTnheCjwEsrL7HdzsAzD2hhDXwX+GxvJCDrRrVYA8GZS1b2uflFnKSMgsqWt2Go2V/Q4wx5sn8TVqmhzaO67tKDF+35HCR8Zkb1rLEuLxkQU7RpzY7MjwBMI82Dl+uGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P6I0aDEA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e989edb6so21259345ad.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 01:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739525661; x=1740130461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u26Rj75SNGL2cIMYIyNITm7VqBxru2ajzzSchaDjSJ4=;
        b=P6I0aDEAAo2m2Wtx5cFN/bvOWlrTwAAiFb8NFixm46nkSSECiLwNwq2NTKd4QeX8Gh
         wLtvo2AjyHwyts9y4uLTZxFORupb5QR3/wYXHKWOP4+T8ytrQw6slqDA35yMlmWUBMBn
         bs8fSUIGNuwsmZeYQb1wVstSG626Bl8K0I2H5af4/5/6bsyubuqGyxfOlzt1tPuTpD+D
         eXo9QgsmYxQixYXkQ2yCUoxRxMjSeEVAETsRIpPBFGKV/a8yKBkPAaSTCwP7mhwSiJsb
         upVEluZ6L1FaC5WAWtBb7Crw1KTMfkAGGuqyOCLYBdVJ5DFl2ks1p+wNr56JP82wP4vp
         Zr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739525661; x=1740130461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u26Rj75SNGL2cIMYIyNITm7VqBxru2ajzzSchaDjSJ4=;
        b=v9Y9nlJ5zbHi7+w5+f3dw+2balewSD7iFdws1QfQbhg34UVNQdMeMOKBl5bBLlRbTc
         5ZR6AckbgN8QOOhSugXdRooAd+6TPdOZIzE9E7PW1U+rq7dwwFO01KbFU58xkjiiwywH
         Pb8KXTwYqRmCh7X7kzRgPCLiZBPLw9ul4qqDms6v52DYoLWHAk3FRyC+kta5fiMPFj2e
         RMFeFMoKnkPMCH/ucRczgw0PCuTarzd+Jf1dRdV2YBURkewLJ4Zh1kmNfhJrkCirgxUw
         BOd8nxbY+bvSV0hZx3hgCa9tlHrbnhapTeSK+I/hKo2ok/skA7tS1aNEmXFFIsQLqPP3
         gKLg==
X-Forwarded-Encrypted: i=1; AJvYcCUCGTRoLlqRKjquKTbw+e5WY+T45j0/i46ohDo+hBOc/UPAjocJuiVyEfdyyfBpV4cacm31y6g0XFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Shtl87DPj8rvrikAjlXq1GylHajHtP80L48G9BTxqWIeEhTq
	EdkuzLwDF/DzRKoU6Zo2bK1qDcbxru4zqdoSRqcnILotovk580j/T9H5PFQW/Q==
X-Gm-Gg: ASbGnctxjz2poSdwO9b2jYIAPYXBWUeiEfvu/qkOMRJdulyn2TiEBcDRsLzdZSwTTrX
	SjNzp8MjoCl9iyBKcPp1eFT+VK2aarDDnPafIoyxTDAI4X7DKYoGdqyKAt6+Fqo5AdmOZZmR4hz
	dAQ1A0dxr+HDzqQZDa6g17n3hV6a5DB8jKXX32PoqKpsaVJpZvIjlaIZUoXEVrG2iiG0jfR0KI5
	GF34LvEqdiWnIWhpffbuV1Mldm9OARU3dr67uOWTmqhUiKLRNUQsO8JIdSkEM2+rIVBs+8FoNCE
	DjwBnuvJYNEdM/8AgyCgbtXhg7hYsww=
X-Google-Smtp-Source: AGHT+IFZVE4yp9yE89oIpu/FQ04E4OEh1OdT4RRLsnSnVNmqpa4GLTJHeV+HTwobROJu0Q6OkCB1tg==
X-Received: by 2002:a05:6a20:728c:b0:1ee:67a2:f67d with SMTP id adf61e73a8af0-1ee6b36026cmr13591167637.22.1739525661324;
        Fri, 14 Feb 2025 01:34:21 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:a164:8397:3a17:bb49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb586186c9sm2480167a12.35.2025.02.14.01.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 01:34:20 -0800 (PST)
Date: Fri, 14 Feb 2025 15:04:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v6 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
Message-ID: <20250214093414.pvx6nab7ewy4nvzb@thinkpad>
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
 <20250210-preset_v6-v6-4-cbd837d0028d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210-preset_v6-v6-4-cbd837d0028d@oss.qualcomm.com>

On Mon, Feb 10, 2025 at 01:00:03PM +0530, Krishna Chaitanya Chundru wrote:
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
>  drivers/pci/controller/dwc/pcie-designware-host.c | 53 +++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
>  include/uapi/linux/pci_regs.h                     |  3 ++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index dd56cc02f4ef..7d5f16f77e2f 100644
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
> @@ -808,6 +812,54 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
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
> +		presets = pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS];
> +		lane_eq_offset = PCI_PL_16GT_LE_CTRL;
> +		cap_id = PCI_EXT_CAP_ID_PL_16GT;
> +		lane_reg_size = 0x1;
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

Please add a comment stating that the equalization needs to be performed at all
lower data rates for each lane.

> +	if (speed >= PCIE_SPEED_8_0GT)
> +		dw_pcie_program_presets(pp, PCIE_SPEED_8_0GT);
> +
> +	if (speed >= PCIE_SPEED_16_0GT)
> +		dw_pcie_program_presets(pp, PCIE_SPEED_16_0GT);

I think we need to check 'Link Equalization Request' before performing
equalization? This will also help us to warn users if they didn't specify the
property in DT if hardware expects equalization.

Currently, even if DT specifies equalization presets for 32GT/s, driver is not
making use of them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

