Return-Path: <linux-pci+bounces-19002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221199FBCCA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 11:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A710C162925
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 10:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C51B414D;
	Tue, 24 Dec 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHhQfxDj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB01B1D65
	for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037890; cv=none; b=Ky6qy7BuVh2bmJ7SFrKFuZ6cJtmTQnNBiWWgQjeunM9Os/ZPVnElMrj/4LB8Sn0F+hurN0sKEUId9uJGISBAyzRg8LaHmvyiLPGNnYTNg08a0/FNk7iYMHNPg8xt2mwoZ1DD2ph+yMge+W+Ys6epmE3mhBeYtPuG93zMTq2VauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037890; c=relaxed/simple;
	bh=67z40HlFoHPukuZpcvkJ103/YrG7E0JT9k6eds45gaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLgUsNOn6NWDzVr9BD3yaCSyA8apayeDDjk/yzH6xtiSkqj1f8SNnt4loO1tEU8NiwSOvW6UZ50rSK/FaX2Z1O+FK8Bh4kD9oePazImPcZISQI56rPHo42Xt4ZwRtuX0ByRx+ns+3YCrHjDevvznhnworF3Dyo3TBuOttRtGZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tHhQfxDj; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3984b1db09so4268948276.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 02:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735037888; x=1735642688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VpK2ftdkbt4R+pFm3fosJx4wuVtu20lzej0WhTZaeNI=;
        b=tHhQfxDjp+mG794ViZh34feCLLOvICabvw5hCf4laPtydBqmNWHp8SKSnNlvCPhZgC
         DPQFzVAmFG6RjEwU3iW6kSFN9kwGeaJw/0CRnmTOns3P0VzaXYYjEi86zGA5gidXnvJc
         oHeRYp5IA8VS4NpBWbwiU0yWXWfWfvbVKsrfPmdEMGkZu76MoEHPV66q+rr4td2u5QUc
         mfoeB61PVg/Bb1ExY4ZjYE9t9tshQLf52pFz8JqgsF+H1faXq9fvm59Z2zkIkEdPdomh
         eFavST45lIUS93hHwo+m8qZUDlVu8UUVUDvnTq+xmzT8zQfhycaSONZyoG5jPqk/ekpv
         2neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037888; x=1735642688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpK2ftdkbt4R+pFm3fosJx4wuVtu20lzej0WhTZaeNI=;
        b=ZLl/QqdVzjSOmBArLskpDSXY4IJtXImlW2d0E3iTQClEA3ndC8i7uBf6N26buxIgGx
         ioTPvkVrq4vYB9doQFgOiHyghGJdcAtTvZDoVsg+kQ6NPbrjpyHKE7oDSjOZ+ozGXvDQ
         O2VRcV5u319JeArbJJeofWnmmX9myehWnjR6KQHrIB8Is+6rKDk838O3S/3AjF6S0TPZ
         ErqW6ZMrw9tKvtrfjXbW/4Wb0cNIwlJcQ06POmk1+7CekdHD+lWTWvV8w17cCwMd/irH
         puB6iF1AeByMNg54ifT9jX2h/28MXiqqOfOBN+pKeRLvZ8MSCTXs8+c5LzNoe1SCRdB5
         mdmA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Dt79ZfFCfWK78T3o/hQH176XzMUbVme9eDOf+717c7iqn9x9T+G6OPchmXxZDEu0Z1TFok4dPyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+IqYa8kY3m1uv4+LhOEaJ15dMq5P0KUKu/xuH4/1BeuIb/6n
	RPdTtTmjGvT4fzCQQkAGPSmrV9+SchxDfzVfiw4MxWBFOUw/+Pbt3BAVTFf1G8ppLcr0RcnMEjw
	jL/H7Di0LADp2ta1YwrTL/yl/+euJ72xavo1rYQ==
X-Gm-Gg: ASbGncvI+Kwbnwzhg1tNtBqWtQgqc3t7ocp46POO0tK4DKZr8I/wNJnUBBEM80oSgWQ
	gehR1J98LA+P33tI4FqMfm7BL06U2qhq18rql6j8cv9DA1+MOUjhN
X-Google-Smtp-Source: AGHT+IHRDHsx1k+Od69u4uBsB0C3Jh2W8Sh5sKAFibjZe96Qe/QtkETMHIOtOv/wvGXXoSbgAKHtaf75ZpGsRUgiJtU=
X-Received: by 2002:a05:690c:c92:b0:6f2:9533:8fba with SMTP id
 00721157ae682-6f3f80d6121mr123466747b3.1.1735037887716; Tue, 24 Dec 2024
 02:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
 <20241223-preset_v2-v3-2-a339f475caf5@oss.qualcomm.com> <piccoomv7rx4dvvfdoesmxbzrdqz4ld6ii6neudsdf4hjj2yzm@2bcuacwa4feb>
 <d317c51a-3913-6c49-f8db-e75589f9289a@quicinc.com> <wjk32haduzgiea676mamqdr6mhbmm3rrb6eyhzghqpczjuiazx@ipik3jhjzmhz>
 <7bc9f3f2-851c-3703-39b4-fea93d10bd7f@quicinc.com> <ntag3wc3yqax2afsbzesev32hpj3ssiknhjq6dtncuuj4ljrxh@23ed4qdwfrxi>
 <49ccd5f2-8524-eba4-25ef-4cdc39edc93b@quicinc.com> <7busek7zgost2s7mjklgvlccaef3lgz4k7btki72nkr5et7fdn@wkv2z6zbicdj>
 <fb17e142-e66f-85a7-353c-0e498892b884@quicinc.com>
In-Reply-To: <fb17e142-e66f-85a7-353c-0e498892b884@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 24 Dec 2024 12:57:56 +0200
Message-ID: <CAA8EJpr=ktQ4c2dGxnCQNF4rLOCuCLRr6OYT4yVkyOnk2nF+Og@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com, 
	quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Dec 2024 at 12:36, Krishna Chaitanya Chundru
<quic_krichai@quicinc.com> wrote:
>
>
>
> On 12/24/2024 3:25 PM, Dmitry Baryshkov wrote:
> > On Tue, Dec 24, 2024 at 02:47:00PM +0530, Krishna Chaitanya Chundru wrote:
> >>
> >>
> >> On 12/24/2024 12:00 AM, Dmitry Baryshkov wrote:
> >>> On Mon, Dec 23, 2024 at 10:13:29PM +0530, Krishna Chaitanya Chundru wrote:
> >>>>
> >>>>
> >>>> On 12/23/2024 8:56 PM, Dmitry Baryshkov wrote:
> >>>>> On Mon, Dec 23, 2024 at 08:02:23PM +0530, Krishna Chaitanya Chundru wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 12/23/2024 5:17 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Mon, Dec 23, 2024 at 12:21:15PM +0530, Krishna Chaitanya Chundru wrote:
> >>>>>>>> PCIe equalization presets are predefined settings used to optimize
> >>>>>>>> signal integrity by compensating for signal loss and distortion in
> >>>>>>>> high-speed data transmission.
> >>>>>>>>
> >>>>>>>> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> >>>>>>>> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> >>>>>>>> configure lane equalization presets for each lane to enhance the PCIe
> >>>>>>>> link reliability. Each preset value represents a different combination
> >>>>>>>> of pre-shoot and de-emphasis values. For each data rate, different
> >>>>>>>> registers are defined: for 8.0 GT/s, registers are defined in section
> >>>>>>>> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> >>>>>>>> an extra receiver preset hint, requiring 16 bits per lane, while the
> >>>>>>>> remaining data rates use 8 bits per lane.
> >>>>>>>>
> >>>>>>>> Based on the number of lanes and the supported data rate, this function
> >>>>>>>> reads the device tree property and stores in the presets structure.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >>>>>>>> ---
> >>>>>>>>      drivers/pci/of.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >>>>>>>>      drivers/pci/pci.h | 17 +++++++++++++++--
> >>>>>>>>      2 files changed, 60 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> >>>>>>>> index dacea3fc5128..99e0e7ae12e9 100644
> >>>>>>>> --- a/drivers/pci/of.c
> >>>>>>>> +++ b/drivers/pci/of.c
> >>>>>>>> @@ -826,3 +826,48 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
> >>>>>>>>        return slot_power_limit_mw;
> >>>>>>>>      }
> >>>>>>>>      EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> >>>>>>>> +
> >>>>>>>
> >>>>>>> kerneldoc? Define who should free the memory and how.
> >>>>>>>
> >>>>>> I will update this in next series.
> >>>>>> as we are allocating using devm_kzalloc it should be freed on driver
> >>>>>> detach, as no special freeing is required.
> >>>>>>>> +int of_pci_get_equalization_presets(struct device *dev,
> >>>>>>>> +                                  struct pci_eq_presets *presets,
> >>>>>>>> +                                  int num_lanes)
> >>>>>>>> +{
> >>>>>>>> +      char name[20];
> >>>>>>>> +      void **preset;
> >>>>>>>> +      void *temp;
> >>>>>>>> +      int ret;
> >>>>>>>> +
> >>>>>>>> +      if (of_property_present(dev->of_node, "eq-presets-8gts")) {
> >>>>>>>> +              presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) * num_lanes, GFP_KERNEL);
> >>>>>>>> +              if (!presets->eq_presets_8gts)
> >>>>>>>> +                      return -ENOMEM;
> >>>>>>>> +
> >>>>>>>> +              ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
> >>>>>>>> +                                               presets->eq_presets_8gts, num_lanes);
> >>>>>>>> +              if (ret) {
> >>>>>>>> +                      dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);
> >>>>>>>> +                      return ret;
> >>>>>>>> +              }
> >>>>>>>> +      }
> >>>>>>>> +
> >>>>>>>> +      for (int i = 1; i < sizeof(struct pci_eq_presets) / sizeof(void *); i++) {
> >>>>>>>> +              snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
> >>>>>>>> +              if (of_property_present(dev->of_node, name)) {
> >>>>>>>> +                      temp = devm_kzalloc(dev, sizeof(u8) * num_lanes, GFP_KERNEL);
> >>>>>>>> +                      if (!temp)
> >>>>>>>> +                              return -ENOMEM;
> >>>>>>>> +
> >>>>>>>> +                      ret = of_property_read_u8_array(dev->of_node, name,
> >>>>>>>> +                                                      temp, num_lanes);
> >>>>>>>> +                      if (ret) {
> >>>>>>>> +                              dev_err(dev, "Error %s %d\n", name, ret);
> >>>>>>>> +                              return ret;
> >>>>>>>> +                      }
> >>>>>>>> +
> >>>>>>>> +                      preset = (void **)((u8 *)presets + i * sizeof(void *));
> >>>>>>>
> >>>>>>> Ugh.
> >>>>>>>
> >>>>>> I was trying iterate over each element on the structure as presets holds the
> >>>>>> starting address of the structure and to that we are adding size of the void
> >>>>>> * point to go to each element. I did this way to reduce the
> >>>>>> redundant code to read all the gts which has same way of storing the data
> >>>>>> from the device tree. I will add comments here in the next series.
> >>>>>
> >>>>> Please rewrite this in a cleaner way. The code shouldn't raise
> >>>>> questions.
> >>>>>
> >>>>>>>> +                      *preset = temp;
> >>>>>>>> +              }
> >>>>>>>> +      }
> >>>>>>>> +
> >>>>>>>> +      return 0;
> >>>>>>>> +}
> >>>>>>>> +EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> >>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> >>>>>>>> index 14d00ce45bfa..82362d58bedc 100644
> >>>>>>>> --- a/drivers/pci/pci.h
> >>>>>>>> +++ b/drivers/pci/pci.h
> >>>>>>>> @@ -731,7 +731,12 @@ static inline u64 pci_rebar_size_to_bytes(int size)
> >>>>>>>>      }
> >>>>>>>>      struct device_node;
> >>>>>>>> -
> >>>>>>>> +struct pci_eq_presets {
> >>>>>>>> +      void *eq_presets_8gts;
> >>>>>>>> +      void *eq_presets_16gts;
> >>>>>>>> +      void *eq_presets_32gts;
> >>>>>>>> +      void *eq_presets_64gts;
> >>>>>>>
> >>>>>>> Why are all of those void*? 8gts is u16*, all other are u8*.
> >>>>>>>
> >>>>>> To have common parsing logic I moved them to void*, as these are pointers
> >>>>>> actual memory is allocated by of_pci_get_equalization_presets()
> >>>>>> based upon the gts these should not give any issues.
> >>>>>
> >>>>> Please, don't. They have types. void pointers are for the opaque data.
> >>>>>
> >>>> ok.
> >>>>
> >>>> I think then better to use v1 patch
> >>>> https://lore.kernel.org/all/20241116-presets-v1-2-878a837a4fee@quicinc.com/
> >>>>
> >>>> konrad, any objection on using v1 as that will be cleaner way even if we
> >>>> have some repetitive code.
> >>>
> >>> Konrad had a nice suggestion about using the array of values. Please use
> >>> such an array for 16gts and above. This removes most of repetitive code.
> >>>
> >> I don't feel having array in the preset structure looks good, I have
> >> come up with this logic if you feel it is not so good I will go to the
> >> suggested way by having array for 16gts and above.
> >>
> >>         if (of_property_present(dev->of_node, "eq-presets-8gts")) {
> >>                  presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) *
> >> num_lanes, GFP_KERNEL);
> >>                  if (!presets->eq_presets_8gts)
> >>                          return -ENOMEM;
> >>
> >>                  ret = of_property_read_u16_array(dev->of_node,
> >> "eq-presets-8gts",
> >>
> >> presets->eq_presets_8gts, num_lanes);
> >>                  if (ret) {
> >>                          dev_err(dev, "Error reading eq-presets-8gts %d\n",
> >> ret);
> >>                          return ret;
> >>                  }
> >>          }
> >>
> >>          for (int i = EQ_PRESET_TYPE_16GTS; i < EQ_PRESET_TYPE_64GTS; i++) {
> >>                  snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
> >>                  if (of_property_present(dev->of_node, name)) {
> >>                          temp = devm_kzalloc(dev, sizeof(u8) * num_lanes,
> >> GFP_KERNEL);
> >>                          if (!temp)
> >>                                  return -ENOMEM;
> >>
> >>                          ret = of_property_read_u8_array(dev->of_node, name,
> >>                                                          temp, num_lanes);
> >>                          if (ret) {
> >>                                  dev_err(dev, "Error %s %d\n", name, ret);
> >>                                  return ret;
> >>                          }
> >>
> >>                          switch (i) {
> >>                                  case EQ_PRESET_TYPE_16GTS:
> >>                                          presets->eq_presets_16gts = temp;
> >>                                          break;
> >>                                  case EQ_PRESET_TYPE_32GTS:
> >>                                          presets->eq_presets_32gts = temp;
> >>                                          break;
> >>                                  case EQ_PRESET_TYPE_64GTS:
> >>                                          presets->eq_presets_64gts = temp;
> >>                                          break;
> >>                          }
> >
> > This looks like 'presets->eq_presets[i] = temp;', but I won't insist on
> > that.
> >
> > Also, a strange thought came to my mind: we know that there won't be
> > more than 16 lanes. Can we have the following structure instead:
> >
> > #define MAX_LANES 16
> > enum pcie_gts {
> >       PCIE_GTS_16GTS,
> >       PCIE_GTS_32GTS,
> >       PCIE_GTS_64GTS,
> >       PCIE_GTS_MAX,
> > };
> > struct pci_eq_presets {
> >       u16 eq_presets_8gts[MAX_LANES];
> >       u8 eq_presets_Ngts[PCIE_GTS_MAX][MAX_LANES];
> > };
> >
> > This should allow you to drop the of_property_present() and
> > devm_kzalloc(). Just read DT data into a corresponding array.
> >
> in the dwc driver patch I was using pointers and memory allocation
> to known if the property is present or not. If I use this way I might
> end up reading dt property again.

Add foo_valid flags to the struct.

>  I think better to switch to have a
> array for above 16gts.

Whichever way works for you.

>
> - Krishna Chaitanya.
> >>                  }
> >>          }
> >> - Krishna Chaitanya.
> >>
> >>>
> >



-- 
With best wishes
Dmitry

