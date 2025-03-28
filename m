Return-Path: <linux-pci+bounces-24914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED457A7441A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 07:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC93D3BD239
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE690211469;
	Fri, 28 Mar 2025 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ryzwUU6h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7080BEC
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743144342; cv=none; b=V6YF5VmDRYnq1zjrdSfoIxmUNYDlNTkcps+ct349McSWDk6q4prGlNDtz2PHfc+YCbBxGqs972bXSsRUmc3qVBXxdnr1KAHhzAUGACBrZIyVWGqgjcDlbZQHQJ/SNyfPqNaitds2VDxIXX5YVtJr249KmE0YlM+NZ47TJr//0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743144342; c=relaxed/simple;
	bh=KEXuAvGR6b6lzqgZK23RTCDLLbmKotBYs3tIqP6xaZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4/Wcut18NWqxvnToArC+xU5XOKjndfA1P5AFwi9pxA7jhtUc4jyCzn/T0+DEQg9b5CzIz26GRm2TFH40V+Fyb/qmoARX+n1VmEjYNnUJS7aZMcJD+0f4iq5xr3uat0thFbiYZYOmwe57PQiK1kr7fd6/Jps3GaTll7hwTYr6H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ryzwUU6h; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so5856690a91.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 23:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743144340; x=1743749140; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=54fd9XomxozUMYP9lqWRd9DunYOsr0ScKSvXhsi/qYU=;
        b=ryzwUU6h6kixfEUwjDJOJQZPOL94arjfic9Y1ylhawdfxv3Z3uhm6Gxr9jmPSNQRWa
         xxqsaoNA/9Ys2TWPnj50mbrCmFxBiIGZKg3UkUZNJFL6/+aayQja7cOyqjRdwlOYidP+
         LIT6pMtKAaL9bCmuVQLkrcNZVaMmnO06AALBJMGJ2LDtxCTWRA87JstIljFDz53Lrr9n
         e3E7ADTLJWti9SG2ZWCxCk/lBtt4N++96bTH9Jwlnpdm8EVHWe3wAMByCNR6yqmgvVlT
         7BCf+ESpzUTziyC5oFnwQErRxWyD+HxLC72I79n3bDZDuLJcdGB3SOKJWw1wLY/j2mk9
         GXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743144340; x=1743749140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54fd9XomxozUMYP9lqWRd9DunYOsr0ScKSvXhsi/qYU=;
        b=jarg84Octx5mpVtyk/fOp7sWZcKZGZNyVm0Jih4TizT4BI7FvMeuTDLdgSu3aqyMRH
         Su/obJxJrYGUffBPBfycTpNiONTyAZrXaPOIhkVtqUj7vKqm7armnu8Q00v1A1+FEMQZ
         gtUzJnqt9mNa8DAkL5NGLH6AR9OgzcczGBI3oT8L006vBuqFplThClHlaJRrpQbGXNe+
         tfkGbGNm0a2nPU+o8owyuQP4B4ObN1ROsaJHjKFLrhl3uGQNBz2t7POg5gqA6gwCaRxW
         eCJJYlD3bBuwsz4GTP7YYoEkIEiuXN+oRC/XAqY/ThiyfEMYc3A8Xc7mHEzRQpfrEjNI
         qGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaoXYDtoSzV83uxOUYiwZ/tLpgoFsjP0sOOvOSmlhXrQxYA4349eiMI+FK901Cwh0QQ9eeiAxhZ7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrzMjmEJadZIbDj8skGELB6gtgjc/PLmDNBY9yatNjHQ7tlGio
	V2GyU1UyROaiHQc4IZj0wlVmxz2RvhOWYjp1GqOZLXSH1ZLfjv8ndrbbIjgLWw==
X-Gm-Gg: ASbGncumry67pAGBSEqYMva9GOvcjxmPBqDGsfWb7oCD/DTm0pujW79EtcJ04v1DQ0l
	61xZN8Fwx8nU9WXfv+PmMj9i7dqknI+wm0mAE2eeI0U0moRhoJZr9s8s1NWQTJBYjTLiVwh2oeL
	r9w+majezbHg/2lWxeNcni+4SAd7AZxq2H+f+Uqlv8cUGiqRlQFF5tuWRsia3I3PWcyHTAaeRdX
	WqS5hJha64BVuhoD58nsLJEU1SdDIajPiK1ADZ5VBYxmOKi6Fda8Q9TzHJx9rpWn8okCp+hO4xU
	ig3tNVV97faKnGo6fH/Y8FNR3FqfCqnwkBFJ8Ohy76KdIphDQzSW+rA=
X-Google-Smtp-Source: AGHT+IGZKZtzFxis5h3cdv3dYAB2lOQJgZwWnL8kh3A0nuBZD/Tk7Y3yM9h5+Q1a4MPXEp6ddYwgKw==
X-Received: by 2002:a05:6a21:3294:b0:1f3:34a4:bf01 with SMTP id adf61e73a8af0-1feb5d04fa0mr2201903637.17.1743144340440;
        Thu, 27 Mar 2025 23:45:40 -0700 (PDT)
Received: from thinkpad ([120.60.68.219])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b69f577sm931818a12.19.2025.03.27.23.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 23:45:40 -0700 (PDT)
Date: Fri, 28 Mar 2025 12:15:34 +0530
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
Message-ID: <mslh75np4tytzzk3dvwj5a3ulqmwn73zkj5cq4qmld5adkkldj@ad3bt3drffbn>
References: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
 <20250316-preset_v6-v8-4-0703a78cb355@oss.qualcomm.com>
 <3sbflmznjfqpcja52v6bso74vhouv7ncuikrba5zlb74tqqb5u@ovndmib3kgqf>
 <92c4854d-033e-c7b5-ca92-cf44a1a8c0cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92c4854d-033e-c7b5-ca92-cf44a1a8c0cc@oss.qualcomm.com>

On Fri, Mar 28, 2025 at 11:04:11AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/28/2025 10:23 AM, Manivannan Sadhasivam wrote:
> > On Sun, Mar 16, 2025 at 09:39:04AM +0530, Krishna Chaitanya Chundru wrote:
> > > PCIe equalization presets are predefined settings used to optimize
> > > signal integrity by compensating for signal loss and distortion in
> > > high-speed data transmission.
> > > 
> > > Based upon the number of lanes and the data rate supported, write
> > > the preset data read from the device tree in to the lane equalization
> > > control registers.
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-designware-host.c | 60 +++++++++++++++++++++++
> > >   drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
> > >   include/uapi/linux/pci_regs.h                     |  3 ++
> > >   3 files changed, 66 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index dd56cc02f4ef..7c6e6a74383b 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -507,6 +507,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >   	if (pci->num_lanes < 1)
> > >   		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
> > > +	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
> > > +	if (ret)
> > > +		goto err_free_msi;
> > > +
> > >   	/*
> > >   	 * Allocate the resource for MSG TLP before programming the iATU
> > >   	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> > > @@ -808,6 +812,61 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >   	return 0;
> > >   }
> > > +static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	u8 lane_eq_offset, lane_reg_size, cap_id;
> > > +	u8 *presets;
> > > +	u32 cap;
> > > +	int i;
> > > +
> > > +	if (speed == PCIE_SPEED_8_0GT) {
> > > +		presets = (u8 *)pp->presets.eq_presets_8gts;
> > > +		lane_eq_offset =  PCI_SECPCI_LE_CTRL;
> > > +		cap_id = PCI_EXT_CAP_ID_SECPCI;
> > > +		/* For data rate of 8 GT/S each lane equalization control is 16bits wide*/
> > > +		lane_reg_size = 0x2;
> > > +	} else if (speed == PCIE_SPEED_16_0GT) {
> > > +		presets = pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS - 1];
> > > +		lane_eq_offset = PCI_PL_16GT_LE_CTRL;
> > > +		cap_id = PCI_EXT_CAP_ID_PL_16GT;
> > > +		lane_reg_size = 0x1;
> > > +	} else {
> > 
> > Can you add conditions for other data rates also? Like 32, 64 GT/s. If
> > controller supports them and if the presets property is defined in DT, then you
> > should apply the preset values.
> > 
> > If the presets property is not present in DT, then below 'PCI_EQ_RESV' will
> > safely return.
> > 
> I am fine to add it, but there is no GEN5 or GEN6 controller support
> added in dwc, isn't it best to add when that support is added and
> tested.
> 

What is the guarantee that this part of the code will be updated once the
capable controllers start showing up? I don't think there will be any issue in
writing to these registers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

