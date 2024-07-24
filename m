Return-Path: <linux-pci+bounces-10712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5D393AD08
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 09:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E771F2369F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F0261FCA;
	Wed, 24 Jul 2024 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymc+IyV4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DABD29E
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805151; cv=none; b=k/Zn50ehDHkqQxUsijmVDY2j6npCP/evFq6a3VWC44EtyNtm/7I3bzyw3SLgw2bzF/lw4FVRBbfgfD9S2hO4S7nsxhSDi2o8r0KcW9jttwOYjTfLurkwxQPengE1Apz75P/BbmDx/pItn0ycO9E1uwwRtbErQLGC+AVDRK/rRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805151; c=relaxed/simple;
	bh=2ET06663yJTfOvxOaRwLCX+2okuvYMcVwphYsNHgItQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeRrx4KABHlJv5luR2JzNP7KW/eOZIxcetdUd+JNWFIpGRAiqWknr8XG2zLuGFArv7up03a8kJFD2BHYEeuKFBmdIfcEfjHf0u4BqTnOWqfaxCP5VH4YbkYjQzRSdJCby3490+qjYNMK5r173T5rFpz2w/VmC2qu8EhwTkfRzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymc+IyV4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6518f8bc182so5099557b3.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721805149; x=1722409949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cLTAfdBRmXNzN4nm7AmqSiNth27gEuiMxE8KchKt8To=;
        b=ymc+IyV4wHdVYM4XEUydTVm7BSe0EqEqWDfsfGEANGPg9AUx5z+VoEmk3uNm1U2AxS
         OZ10WSO3bCOGIivwGM6tPbAvU6E2GLbgJJ3kqq4kiSsoUb9HTw9YG8a4h96mFrvTty57
         1iJmq0XY9xe5ERBGjEgMXW2b9fmJNv2GxMXXefQ0ZlPPnATgs/4JclB/pV7F8sPNCHuU
         7elbI3t/N5hchtJ40eZI4ZJ4bMkkoODRtHq4vNazuafOr2N8WejRe4rPHkU41n2uHJ4w
         Esm7aofYFP7240eYhNOJPjnPKojBiu3AJuI8b3rcXynkZG0E0sjcGvGuvHwfuyLjZWWD
         +ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721805149; x=1722409949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLTAfdBRmXNzN4nm7AmqSiNth27gEuiMxE8KchKt8To=;
        b=VUB1iRbWBKL1wzfKTJef94xDvXHdeQ4ny41DsduKV1P77M1QEf4fc3hFe3Ta52Z7mC
         Acu0SqJ+DDy92Hhx74ekErvQoNd3P8WxlRx+uT6mdtkiT8OKqOmvH5yBLBTFQkFTKLVK
         F69hn7vUGlGrONF5A/j5fRNh7DQTVx95nIVdRKJkhxgrvsvq/12vgKAmoq8biiUvqfxB
         XL07XiIrLZzlY/NTkN/BUGz/AMnX+DSNWOSNdK3mLCuQALrXBIHaO8c33V2kHkiZVGbi
         B9M+/1M5UOKBSKW50EjewyQ7/VK/Qpr8SxcHZUK6PUXszORZApsYpYjHPhmJAKCWSzCz
         S8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5vFEw6IISf3d02ArK7+WV3DOv4kk7BVli4hqM3WqEozl5m0tIawnmRdNIj8iWeOOx6g4hfPiYCPGczVAN1AmTsUpotrMgF5yT
X-Gm-Message-State: AOJu0YxUtJ5LequOy2KEsvTRVLHrFNekhDCZtHVXv3UOHzHAWedhSOyf
	5mzo5ee16R7WEMNDKdDi7H0IV19WG/YgSxPsxN89HNdzwoCccWbxK8JH4PaAKcRzuNLns70ACD9
	ye2zYYwfviYwBQWmTgcX3HX2EMOaBXMs05teMew==
X-Google-Smtp-Source: AGHT+IEvAasOl0cQtJERYgVEQnAkSlrJQKqNpmGkUyf9LG97Q8RPaN3ZEWsL4P54X5/lsTvBXFGI8U7s16kMGD0DZqs=
X-Received: by 2002:a0d:c683:0:b0:651:ee07:76c with SMTP id
 00721157ae682-672c025ee17mr6101177b3.15.1721805149228; Wed, 24 Jul 2024
 00:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <rzf5jaxs2g4usnqzgvisiols2zlizcqr3pg4b63kxkoaekkjdf@rleudqbiur5m> <a87d4948-a9ce-473b-ae36-9f0c04c3041e@quicinc.com>
In-Reply-To: <a87d4948-a9ce-473b-ae36-9f0c04c3041e@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Jul 2024 10:12:17 +0300
Message-ID: <CAA8EJpq=rj-=JsYpPmwXiYkL=AALf-ZPQeq9drEoCkCAufLdig@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] Add power domain and MSI functionality with PCIe
 host generic ECAM driver
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: will@kernel.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org, 
	cassel@kernel.org, yoshihiro.shimoda.uh@renesas.com, s-vadapalli@ti.com, 
	u.kleine-koenig@pengutronix.de, dlemoal@kernel.org, amishin@t-argos.ru, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, Frank.Li@nxp.com, 
	ilpo.jarvinen@linux.intel.com, vidyas@nvidia.com, 
	marek.vasut+renesas@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, quic_ramkri@quicinc.com, quic_nkela@quicinc.com, 
	quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com, 
	quic_nitegupt@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 06:58, Mayank Rana <quic_mrana@quicinc.com> wrote:
>
>
>
> On 7/23/2024 7:13 PM, Dmitry Baryshkov wrote:
> > On Mon, Jul 15, 2024 at 11:13:28AM GMT, Mayank Rana wrote:
> >> Based on previously received feedback, this patch series adds functionalities
> >> with existing PCIe host generic ECAM driver (pci-host-generic.c) to get PCIe
> >> host root complex functionality on Qualcomm SA8775P auto platform.
> >>
> >> Previously sent RFC patchset to have separate Qualcomm PCIe ECAM platform driver:
> >> https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/
> >>
> >> 1. Interface to allow requesting firmware to manage system resources and performing
> >> PCIe Link up (devicetree binding in terms of power domain and runtime PM APIs is used in driver)
> >> 2. Performing D3 cold with system suspend and D0 with system resume (usage of GenPD
> >> framework based power domain controls these operations)
> >> 3. SA8775P is using Synopsys Designware PCIe controller which supports MSI controller.
> >> This MSI functionality is used with PCIe host generic driver after splitting existing MSI
> >> functionality from pcie-designware-host.c file into pcie-designware-msi.c file.
> >
> > Please excuse me my ignorance if this is described somewhere. Why are
> > you using DWC-specific MSI handling instead of using GIC ITS?
> Due to usage of GIC v3 on SA8775p with Gunyah hypervisor, we have
> limitation of not supporting GIC ITS
> functionality. We considered other approach as usage of free SPIs (not
> available, limitation in terms of mismatch between number of SPIs
> available with physical GIC vs hypervisor) and extended SPIs (not
> supported with GIC hardware). Hence we just left with DWC-specific MSI
> controller here for MSI functionality.

... or extend Gunyah to support GIC ITS. I'd say it is a significant
deficiency if one can not use GIC ITS on Gunyah platforms.

> >> Below architecture is used on Qualcomm SA8775P auto platform to get ECAM compliant PCIe
> >> controller based functionality. Here firmware VM based PCIe driver takes care of resource
> >> management and performing PCIe link related handling (D0 and D3cold). Linux VM based PCIe
> >> host generic driver uses power domain to request firmware VM to perform these operations
> >> using SCMI interface.
> >
> Regards,
> Mayank



-- 
With best wishes
Dmitry

