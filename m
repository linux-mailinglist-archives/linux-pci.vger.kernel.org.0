Return-Path: <linux-pci+bounces-24913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C309A74414
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 07:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209EC7A7C18
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 06:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD44211A01;
	Fri, 28 Mar 2025 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZnAacXG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D15211A02
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743144230; cv=none; b=kUnRBrhXDEiwvtSiadoeyW5ugmnhJ+La0mhk0qzfLuWgvWPsAG1v9Z7iTfUhGJUAdBNd+oTc6ZVu7hq2DI9Fzg45bjOAriBxo3PR4s04iR3S5Vw5uD7J+yt2G0b98HJ2Zg0Zk52FI6O7goYWOC4t8Si9k6a3HVik03Ar2yLMM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743144230; c=relaxed/simple;
	bh=9gHYkn22rLzWvMO0bj/sd6YJ6w0VDygYaZJoz/6Ho5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg2XP2QFH5xSsU6CUxX1etWWc4TaIn7lPu7HcSQS4i1UNYE9WhhtyggVnewjwBKC6610HksyjsrULHzW4sY7PzkoSxlDb5iZiup4yoxN0u352hZHQOZjfPkpzIBs8D23IquEqDWG/hKJeiB08T/5TSnQTYnzwN9bw8jCw3S+Sos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KZnAacXG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-303a66af07eso2522547a91.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 23:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743144227; x=1743749027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4pqG4hQwbhscVZFAP8F4bfxFu0QSUaEoh/MTDWwHPFU=;
        b=KZnAacXGEyReGD+v1vOo5nGzwXfShkeVgzEjOMTLsULk/Pt3qq+bIWIn3V4RqQ26gA
         Vl/bTthliqovqZpT/Fg0ZPSWpFj9haEAbMYSHcWRcGyVyWi0dybWuLU+kgcKa9w/wupy
         fYHUaxz+dBgSCtAIJKpbbKqGsUDWVn1C6Zn82E/eM9XXI/gxRcNFtK37Z+aaw8u5UJmX
         jg8Bo22onJ7zSz+azIKPrAbUDW3647dTgG7pg6PW4s6ewAguxuitpwqV+gEjaImE0D7v
         6Q46tJzPEZRsjSGobsg1jBZI7o18+n0wzP4Y7nch7OETPHtCkBRD/FyWGTMeQZDSw1GM
         oHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743144227; x=1743749027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pqG4hQwbhscVZFAP8F4bfxFu0QSUaEoh/MTDWwHPFU=;
        b=vXhRAZ+IQHDxU3aClbvR6s1Gw7hipRI4Rx0H5ymYH0uJoV1h34ohal84GWmVq59kqi
         MowpzqWDDkNfhtccnPfH7nahc/B7zyEGOVUWCTk/VKo9+dd++cogKh97dRhl5JzwFg9P
         uPWfPJKhs4QYE+D4qYmBXnR4v0NEY/Jh2xH48A1SEzKLu8GFFTo+1lOOLjE408kFO5UT
         FRjc8jbXGXzT4/cRGSccsMsOkvhYSvSOL0p78LsQbS0M1LsU3lP7SMyxPq3rZvXlID8P
         JzR5s3SVuxOtdD6C4o0n0rjTlpLNqeqHQvemxXoOGCls/5Ltc0/jVVoORrGttw7PsN/K
         bF6g==
X-Forwarded-Encrypted: i=1; AJvYcCWfN7u4khaaDYAhAIadcUbnbCw3OgaWNTzoNFQAhWSErEZfgSIgYsnCh2LgsXP2aRtL6sZLb4afAls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxppD/1a86CFyEHTyYUmvraNcNvuIo+gsT1rKQ1dLgVS+mw+CNq
	HSlFBOdHuLoaYS/ElvtN/U5vuzTYua8aCEhrdmWBkzNKa21O/aPsP8adE2E5Og==
X-Gm-Gg: ASbGncsPd4X4onj2Jgb19jkJ/QpUdL7IuPwWe25e2lnDPYxSsjseqoeb+C5UTTPPFa5
	uFuMTekWG/Dd1UsCx099bwK3iN8JG1Nz/drmUgRi4PHWKJWu7pOO/P6bRLnvs7QGUFnhG2IB/G0
	Hx3V40nwX0DOtpGYXEbyIlNMukbGm4LkZdBdIN/NuKqqr+aGtxS8OqC/9Tjr4wTD9tZHXQGAqiy
	4LVUDu/vzPFv+6ZTpVdIcWd0iGjtm46T4xNnuFJ7SPmKquPgaC7Fpk/y3alKc2TeC8WRlwDLrsK
	PydCom507cY4uCwA7yKgzYWsRhXf6Lvvokl1yjwJRAv6wDVeRQEKeMk=
X-Google-Smtp-Source: AGHT+IG/FVmwgfHC7BvrjYr6Thd5v8WbLAe0kILb9pAQWylgj/z/boQSWc3aPoouzs8lbrJVeb83NQ==
X-Received: by 2002:a17:90b:554f:b0:2fa:e9b:33b8 with SMTP id 98e67ed59e1d1-303a8064dcemr11430379a91.18.1743144227250;
        Thu, 27 Mar 2025 23:43:47 -0700 (PDT)
Received: from thinkpad ([120.60.68.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cdd52sm10401615ad.157.2025.03.27.23.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 23:43:46 -0700 (PDT)
Date: Fri, 28 Mar 2025 12:13:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v8 2/4] PCI: of: Add of_pci_get_equalization_presets() API
Message-ID: <epg6mtsnemzwnqvsze7zbkehovxvu6fpmw52kzfrjmjahadg66@k4gprl4zg5b3>
References: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
 <20250316-preset_v6-v8-2-0703a78cb355@oss.qualcomm.com>
 <gl2klkvpkb2vrxrzdqbqjomfis66tldy6witvbqdd2ig3st3rw@jstguoejcofa>
 <7a0724ad-89a5-0ccd-eba5-ca4871ce1cdd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a0724ad-89a5-0ccd-eba5-ca4871ce1cdd@oss.qualcomm.com>

On Fri, Mar 28, 2025 at 10:54:25AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 3/28/2025 10:09 AM, Manivannan Sadhasivam wrote:
> > On Sun, Mar 16, 2025 at 09:39:02AM +0530, Krishna Chaitanya Chundru wrote:
> > > PCIe equalization presets are predefined settings used to optimize
> > > signal integrity by compensating for signal loss and distortion in
> > > high-speed data transmission.
> > > 
> > > As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> > > of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> > > configure lane equalization presets for each lane to enhance the PCIe
> > > link reliability. Each preset value represents a different combination
> > > of pre-shoot and de-emphasis values. For each data rate, different
> > > registers are defined: for 8.0 GT/s, registers are defined in section
> > > 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> > > an extra receiver preset hint, requiring 16 bits per lane, while the
> > > remaining data rates use 8 bits per lane.
> > > 
> > > Based on the number of lanes and the supported data rate,
> > > of_pci_get_equalization_presets() reads the device tree property and
> > > stores in the presets structure.
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   drivers/pci/of.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
> > >   drivers/pci/pci.h | 32 +++++++++++++++++++++++++++++++-
> > >   2 files changed, 75 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > index 7a806f5c0d20..18691483e108 100644
> > > --- a/drivers/pci/of.c
> > > +++ b/drivers/pci/of.c
> > > @@ -851,3 +851,47 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
> > >   	return slot_power_limit_mw;
> > >   }
> > >   EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > > +
> > > +/**
> > > + * of_pci_get_equalization_presets - Parses the "eq-presets-Ngts" property.
> > > + *
> > > + * @dev: Device containing the properties.
> > > + * @presets: Pointer to store the parsed data.
> > > + * @num_lanes: Maximum number of lanes supported.
> > > + *
> > > + * If the property is present, read and store the data in the @presets structure.
> > > + * Else, assign a default value of PCI_EQ_RESV.
> > > + *
> > > + * Return: 0 if the property is not available or successfully parsed else
> > > + * errno otherwise.
> > > + */
> > > +int of_pci_get_equalization_presets(struct device *dev,
> > > +				    struct pci_eq_presets *presets,
> > > +				    int num_lanes)
> > > +{
> > > +	char name[20];
> > > +	int ret;
> > > +
> > > +	presets->eq_presets_8gts[0] = PCI_EQ_RESV;
> > > +	ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
> > > +					 presets->eq_presets_8gts, num_lanes);
> > > +	if (ret && ret != -EINVAL) {
> > > +		dev_err(dev, "Error reading eq-presets-8gts :%d\n", ret);
> > 
> > 'Error reading eq-presets-8gts: %d'
> > 
> > > +		return ret;
> > > +	}
> > > +
> > > +	for (int i = 0; i < EQ_PRESET_TYPE_MAX - 1; i++) {
> > > +		presets->eq_presets_Ngts[i][0] = PCI_EQ_RESV;
> > > +		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << (i + 1));
> > > +		ret = of_property_read_u8_array(dev->of_node, name,
> > > +						presets->eq_presets_Ngts[i],
> > > +						num_lanes);
> > > +		if (ret && ret != -EINVAL) {
> > > +			dev_err(dev, "Error reading %s :%d\n", name, ret);
> > 
> > 'Error reading %s: %d'
> > 
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 01e51db8d285..78c9cc0ad8fa 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -9,6 +9,8 @@ struct pcie_tlp_log;
> > >   /* Number of possible devfns: 0.0 to 1f.7 inclusive */
> > >   #define MAX_NR_DEVFNS 256
> > > +#define MAX_NR_LANES 16
> > 
> > Why did you limit to 16?
> > 
> As per PCIe spec we support maximum of 16 lanes only right
> 

No. PCIe spec defines Max Link Width up to 32 lanes. Though, we have only seen
16 lanes used widely. This field should correspond to 'Maximum Link Width' value
in the Link Capabilities Register.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

