Return-Path: <linux-pci+bounces-19000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E4C9FBBDB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 11:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015621888048
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A211C07DD;
	Tue, 24 Dec 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTdKa2Ai"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7FF1BFE00
	for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735034147; cv=none; b=UqaL0yC+vpgfl6uW5dwsFjzALKPUkmTufUTqeS2CN2RrC8CPCkV31OgGKjsXuzP32G2ncUvvAu+6ZGI2Mi0bH6ZphyELpMF6y2LHZ6JFIMGNzdSBxyerAExfpaZc7yP1hnfgFukx1iSZYq85l/eTlS3O13s+MIBUsDk5DCtiwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735034147; c=relaxed/simple;
	bh=bwMj3dIXxWcBhD3qJheG3RjmuekW+RJmLhr46VIp9Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xdyw7Ip55AE/MG0hbNSilPBwnc3cAILDT5O5QaEjh4FSo8cLXwuBYR2DqHsCQSGh+UitieavmZ4Y+XDfvOm0SuSge3/TO2bIsgjdrQte7wrI+IA8ISgFxu0MMSwAOY2yLhjIKHCWE+lehW0SOLT1Uq+Titc2Cd8gO4+WIbjlOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DTdKa2Ai; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so57786111fa.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 01:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735034144; x=1735638944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnBKAxdpRN3dssFropmfnlEMg5npemHKPrvqxKvvfJU=;
        b=DTdKa2AikUNBItnO5olA0e1KWCzm7wGzCeAxYoShXpvNyKZVxXGIPkOEUvfLHfBH3y
         xCktJdru0ObeDdnv/cNNt+0YZMsk4ViJKZnpmfw60aPSVNZwvTRS7YzbBWT4xnVZ4Plw
         2v8ivjBFoL/U2xEQTiNc/2DLivfy2EPD+aqtI5Erh4yZn2r3QNH2pdoUalRbfRO1sv5p
         1I6eomJ5F2+OsWB45FBqST1UbljXkV5sauR+3znaWHwHe2j6SXfXxmLlJVew0W34Ssg3
         DEpt7EueGCQgHmTjahgsdHffrrIM6vLeETIdXfYkbYMm5+RS+9v+oB3U2YOwizxe+an6
         MFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735034144; x=1735638944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnBKAxdpRN3dssFropmfnlEMg5npemHKPrvqxKvvfJU=;
        b=PZ5RjqREblCBwn1hD/PZk27XCaDs8o3pspysbN5ofzDg5+NvFXS2NFHLCzPoHYohng
         9wTUJ1L2Fo04DZERUCdkOgw82FsDzFNSTPqrmlHtxg59D2/dklmCa67uARZl+R0jQya9
         aGO0yx5sFISzSBcJpyShE4gKHBWUyF0KKIaOXPFVFMldjdzcl5s26jMCWEHzYDGX4EZ1
         bt/f84vwj0bwrUeoI66jMr9mb3hESdn1jMSeuMK6TqBRibdGKqh+5M0GmB4M+cV/OGR0
         zuOiEpoChFIdG7bMUEhzTT+Y2R2WUlHb/ZoXEJqkcrYpvVClYoliY+uGGo7akqGfVfTt
         69AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcq+7d3qlzXnbLw4Q7sFw6WaqcfFxVgrJuliastXf9Hfo75Ognwl1bAiwgUaLCGQu434yfNYDZGK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwruGk7TNj/Iv6SdOsucP6FS2Q699XhZZAAVsI3LstUIlWdcMkc
	qHuXO+iwcJE9tmqH5l37uZP+WyoskV/C+MyZz81n333aj0+tX/s6TYpHI8Usbz4=
X-Gm-Gg: ASbGnctU9Jio7io3j2MKLhuf82y1sqakJuCqu7mmMcs4/SWFmQ0ALJ+wgD1+jKhf0tc
	pxGcWnjUJxjndUX/OF51LISNAwOFvS3ZUPNiVlN9xzCQN59B7iBY+VLOAcvreq46db1c5JbODCy
	2MYWpTmn+vQHh2q1mhOqg6LNZXzIdhKNB1AKwaLzHHFbsYmLItWHabfpWtamvD5ljS76+NhV2Lr
	FnT9iCWjEBhcWk3grswjUEKYz49x3MeXHaYx1puUx7GaBZPrr7E07JS94thXGpJnA5Rs7C20moa
	ZPWPOoFwJQXSJzVkvC8uNa8OyIMGpwsb+vZg
X-Google-Smtp-Source: AGHT+IGBFSOvglUEu54m2IxDVx8yI72wJ4wIV6JEsxpY9tduGQGGlaX6sWGVDk4eZSLocwklaqFttw==
X-Received: by 2002:a2e:a54a:0:b0:300:34b2:f8a3 with SMTP id 38308e7fff4ca-304685482c3mr54541451fa.13.1735034143672;
        Tue, 24 Dec 2024 01:55:43 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6cb69sm16480291fa.17.2024.12.24.01.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 01:55:42 -0800 (PST)
Date: Tue, 24 Dec 2024 11:55:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, konrad.dybcio@oss.qualcomm.com, 
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com, 
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
Message-ID: <7busek7zgost2s7mjklgvlccaef3lgz4k7btki72nkr5et7fdn@wkv2z6zbicdj>
References: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
 <20241223-preset_v2-v3-2-a339f475caf5@oss.qualcomm.com>
 <piccoomv7rx4dvvfdoesmxbzrdqz4ld6ii6neudsdf4hjj2yzm@2bcuacwa4feb>
 <d317c51a-3913-6c49-f8db-e75589f9289a@quicinc.com>
 <wjk32haduzgiea676mamqdr6mhbmm3rrb6eyhzghqpczjuiazx@ipik3jhjzmhz>
 <7bc9f3f2-851c-3703-39b4-fea93d10bd7f@quicinc.com>
 <ntag3wc3yqax2afsbzesev32hpj3ssiknhjq6dtncuuj4ljrxh@23ed4qdwfrxi>
 <49ccd5f2-8524-eba4-25ef-4cdc39edc93b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49ccd5f2-8524-eba4-25ef-4cdc39edc93b@quicinc.com>

On Tue, Dec 24, 2024 at 02:47:00PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 12/24/2024 12:00 AM, Dmitry Baryshkov wrote:
> > On Mon, Dec 23, 2024 at 10:13:29PM +0530, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 12/23/2024 8:56 PM, Dmitry Baryshkov wrote:
> > > > On Mon, Dec 23, 2024 at 08:02:23PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > 
> > > > > 
> > > > > On 12/23/2024 5:17 PM, Dmitry Baryshkov wrote:
> > > > > > On Mon, Dec 23, 2024 at 12:21:15PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > > PCIe equalization presets are predefined settings used to optimize
> > > > > > > signal integrity by compensating for signal loss and distortion in
> > > > > > > high-speed data transmission.
> > > > > > > 
> > > > > > > As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> > > > > > > of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> > > > > > > configure lane equalization presets for each lane to enhance the PCIe
> > > > > > > link reliability. Each preset value represents a different combination
> > > > > > > of pre-shoot and de-emphasis values. For each data rate, different
> > > > > > > registers are defined: for 8.0 GT/s, registers are defined in section
> > > > > > > 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> > > > > > > an extra receiver preset hint, requiring 16 bits per lane, while the
> > > > > > > remaining data rates use 8 bits per lane.
> > > > > > > 
> > > > > > > Based on the number of lanes and the supported data rate, this function
> > > > > > > reads the device tree property and stores in the presets structure.
> > > > > > > 
> > > > > > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >     drivers/pci/of.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
> > > > > > >     drivers/pci/pci.h | 17 +++++++++++++++--
> > > > > > >     2 files changed, 60 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > > > > index dacea3fc5128..99e0e7ae12e9 100644
> > > > > > > --- a/drivers/pci/of.c
> > > > > > > +++ b/drivers/pci/of.c
> > > > > > > @@ -826,3 +826,48 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
> > > > > > >     	return slot_power_limit_mw;
> > > > > > >     }
> > > > > > >     EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> > > > > > > +
> > > > > > 
> > > > > > kerneldoc? Define who should free the memory and how.
> > > > > > 
> > > > > I will update this in next series.
> > > > > as we are allocating using devm_kzalloc it should be freed on driver
> > > > > detach, as no special freeing is required.
> > > > > > > +int of_pci_get_equalization_presets(struct device *dev,
> > > > > > > +				    struct pci_eq_presets *presets,
> > > > > > > +				    int num_lanes)
> > > > > > > +{
> > > > > > > +	char name[20];
> > > > > > > +	void **preset;
> > > > > > > +	void *temp;
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	if (of_property_present(dev->of_node, "eq-presets-8gts")) {
> > > > > > > +		presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) * num_lanes, GFP_KERNEL);
> > > > > > > +		if (!presets->eq_presets_8gts)
> > > > > > > +			return -ENOMEM;
> > > > > > > +
> > > > > > > +		ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
> > > > > > > +						 presets->eq_presets_8gts, num_lanes);
> > > > > > > +		if (ret) {
> > > > > > > +			dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);
> > > > > > > +			return ret;
> > > > > > > +		}
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	for (int i = 1; i < sizeof(struct pci_eq_presets) / sizeof(void *); i++) {
> > > > > > > +		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
> > > > > > > +		if (of_property_present(dev->of_node, name)) {
> > > > > > > +			temp = devm_kzalloc(dev, sizeof(u8) * num_lanes, GFP_KERNEL);
> > > > > > > +			if (!temp)
> > > > > > > +				return -ENOMEM;
> > > > > > > +
> > > > > > > +			ret = of_property_read_u8_array(dev->of_node, name,
> > > > > > > +							temp, num_lanes);
> > > > > > > +			if (ret) {
> > > > > > > +				dev_err(dev, "Error %s %d\n", name, ret);
> > > > > > > +				return ret;
> > > > > > > +			}
> > > > > > > +
> > > > > > > +			preset = (void **)((u8 *)presets + i * sizeof(void *));
> > > > > > 
> > > > > > Ugh.
> > > > > > 
> > > > > I was trying iterate over each element on the structure as presets holds the
> > > > > starting address of the structure and to that we are adding size of the void
> > > > > * point to go to each element. I did this way to reduce the
> > > > > redundant code to read all the gts which has same way of storing the data
> > > > > from the device tree. I will add comments here in the next series.
> > > > 
> > > > Please rewrite this in a cleaner way. The code shouldn't raise
> > > > questions.
> > > > 
> > > > > > > +			*preset = temp;
> > > > > > > +		}
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> > > > > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > > > > index 14d00ce45bfa..82362d58bedc 100644
> > > > > > > --- a/drivers/pci/pci.h
> > > > > > > +++ b/drivers/pci/pci.h
> > > > > > > @@ -731,7 +731,12 @@ static inline u64 pci_rebar_size_to_bytes(int size)
> > > > > > >     }
> > > > > > >     struct device_node;
> > > > > > > -
> > > > > > > +struct pci_eq_presets {
> > > > > > > +	void *eq_presets_8gts;
> > > > > > > +	void *eq_presets_16gts;
> > > > > > > +	void *eq_presets_32gts;
> > > > > > > +	void *eq_presets_64gts;
> > > > > > 
> > > > > > Why are all of those void*? 8gts is u16*, all other are u8*.
> > > > > > 
> > > > > To have common parsing logic I moved them to void*, as these are pointers
> > > > > actual memory is allocated by of_pci_get_equalization_presets()
> > > > > based upon the gts these should not give any issues.
> > > > 
> > > > Please, don't. They have types. void pointers are for the opaque data.
> > > > 
> > > ok.
> > > 
> > > I think then better to use v1 patch
> > > https://lore.kernel.org/all/20241116-presets-v1-2-878a837a4fee@quicinc.com/
> > > 
> > > konrad, any objection on using v1 as that will be cleaner way even if we
> > > have some repetitive code.
> > 
> > Konrad had a nice suggestion about using the array of values. Please use
> > such an array for 16gts and above. This removes most of repetitive code.
> > 
> I don't feel having array in the preset structure looks good, I have
> come up with this logic if you feel it is not so good I will go to the
> suggested way by having array for 16gts and above.
> 
>        if (of_property_present(dev->of_node, "eq-presets-8gts")) {
>                 presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) *
> num_lanes, GFP_KERNEL);
>                 if (!presets->eq_presets_8gts)
>                         return -ENOMEM;
> 
>                 ret = of_property_read_u16_array(dev->of_node,
> "eq-presets-8gts",
> 
> presets->eq_presets_8gts, num_lanes);
>                 if (ret) {
>                         dev_err(dev, "Error reading eq-presets-8gts %d\n",
> ret);
>                         return ret;
>                 }
>         }
> 
>         for (int i = EQ_PRESET_TYPE_16GTS; i < EQ_PRESET_TYPE_64GTS; i++) {
>                 snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
>                 if (of_property_present(dev->of_node, name)) {
>                         temp = devm_kzalloc(dev, sizeof(u8) * num_lanes,
> GFP_KERNEL);
>                         if (!temp)
>                                 return -ENOMEM;
> 
>                         ret = of_property_read_u8_array(dev->of_node, name,
>                                                         temp, num_lanes);
>                         if (ret) {
>                                 dev_err(dev, "Error %s %d\n", name, ret);
>                                 return ret;
>                         }
> 
>                         switch (i) {
>                                 case EQ_PRESET_TYPE_16GTS:
>                                         presets->eq_presets_16gts = temp;
>                                         break;
>                                 case EQ_PRESET_TYPE_32GTS:
>                                         presets->eq_presets_32gts = temp;
>                                         break;
>                                 case EQ_PRESET_TYPE_64GTS:
>                                         presets->eq_presets_64gts = temp;
>                                         break;
>                         }

This looks like 'presets->eq_presets[i] = temp;', but I won't insist on
that.

Also, a strange thought came to my mind: we know that there won't be
more than 16 lanes. Can we have the following structure instead:

#define MAX_LANES 16
enum pcie_gts {
	PCIE_GTS_16GTS,
	PCIE_GTS_32GTS,
	PCIE_GTS_64GTS,
	PCIE_GTS_MAX,
};
struct pci_eq_presets {
	u16 eq_presets_8gts[MAX_LANES];
	u8 eq_presets_Ngts[PCIE_GTS_MAX][MAX_LANES];
};

This should allow you to drop the of_property_present() and
devm_kzalloc(). Just read DT data into a corresponding array.

>                 }
>         }
> - Krishna Chaitanya.
> 
> > 

-- 
With best wishes
Dmitry

