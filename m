Return-Path: <linux-pci+bounces-12120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4094595D121
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 17:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD5FB2D79D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA1189533;
	Fri, 23 Aug 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0zHCJVa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22A188A09
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425906; cv=none; b=qsWWZfPhuStdhaUGrqdAzvc+Q8pJb4kKty82EPRvl5+2QyZMc6VybqbFCrAmFXl8+oFdoMJKTkuaOh5HbF9Rb7bdPUwaPAy+B9SHml2LXM8vIkRXzQ5IwwlVnu7BIyllQY5MfPnkQRk0ZsQm58bKEYgkrm4iBnP+RteuTHoKdEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425906; c=relaxed/simple;
	bh=J2m/8kM3Eksumot+0e5Qr4kZ77hFkIhw/oyWA6o/sAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgNdb5H5HCX0lqx30Fi9T/QguJ7dZiVGbeTHt/oyD2ZOw0yBU0gAqkuzXQh2amoGEqoNk/5MegP6sW6Sqh8IulaEQQ5O54v3gEkoBaMDo+hCcfRGKh0Atbd/NeUJFgCHL2ZZGcuBYiuikf9cEKqe4P8UrKvT5Rt8T9+nO03vg18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w0zHCJVa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201d5af11a4so18578775ad.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724425904; x=1725030704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sIYcAgm41yET+3iAzpj+piLKV5uf4+0K2w+mHEHP/7A=;
        b=w0zHCJVaFrBSstn8gmnHiCSunKDpLH9QCNSsW2LhJkVyL+bQor1j1xHVIAvR5C5bnL
         lEzQlmWe8fUsU/jFgzE8Gc6x0Td0hEI2bOJ9grwFRGPln5O1NHLvsehyMEtG6hXTYJsP
         QNgzsUxhrgwmGBcF1L3hCx7X6kRdqmP7U45f7oGHg252pyCTYdJ4b05BGHkLneI78YOO
         oabUe9N7QIEP+kmcSPgenjSwW9nPAOH2t7kpViJOZGV5Eq4f5LD4gh7QHDHQeUEn8wPd
         te5kHreUnLyPaSj8c3JKA3H/tpOaPaPZfKu2yHr+FZxXCVGKAAZGknsIg99fytuM4lh6
         s/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724425904; x=1725030704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIYcAgm41yET+3iAzpj+piLKV5uf4+0K2w+mHEHP/7A=;
        b=cpUXuYTwsr8MzDABsMrd8hsOPS0dDELRt93hGdqGo+SIgkvlb1Kj8qyjm8EdPmfhjQ
         FHmbJ5ZbiA/i9F0Bveq9zKYS7NWQmc2aifn1ONPnNi2gAwFhLiwYoq8u6d2lUb4lanGg
         UuHhouIC4fMG2b8Hzt9MSmdOlDbQTPffd+oVl0LyBSYACfoJIj83Z7zyGlTkjN+cSF+Z
         mdBazcPaJArdEkNuGBky6qqbttYytZC83aZlZu+PpO5HmmqqGNZCjOgn7GlGkBXlYtLe
         gI1JBjsaS7dfTUlGRzu+s6PjdoI4FQx5J+B5pM11GySPgT4PZrofrK4fu8KeW4g71vy9
         7ppw==
X-Forwarded-Encrypted: i=1; AJvYcCVMW1mQDVFRPKO8oiYFHVdRUWd49tGmipW3MEgfnNCbeGJvejqvGkKjvP4UZGJRhVJi3PIJRXvb62k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zsWK+mF+PwFh1EJdsYnv5xg7m5Cm2L1qdVfkHP5xuH1elRfl
	VquilZAlCO2SqwZ7i8Yf4LW5QqC/8L86sRtRN6TeNM8fsqBZAyYq/pucQaaa+Q==
X-Google-Smtp-Source: AGHT+IG2k5GBFXoUK9l7h4yhbfmeQq5niMC3flczZuEr6fujoA/Vb88l72kyi2UM/C9ceKBX3J/7Ug==
X-Received: by 2002:a17:902:d487:b0:203:a150:e5f5 with SMTP id d9443c01a7336-203a150e627mr25037255ad.0.1724425904010;
        Fri, 23 Aug 2024 08:11:44 -0700 (PDT)
Received: from thinkpad ([120.60.50.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566490sm29534265ad.38.2024.08.23.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:11:43 -0700 (PDT)
Date: Fri, 23 Aug 2024 20:41:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jingoo Han <jingoohan1@gmail.com>, andersson@kernel.org,
	quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: PCI: Add binding for qps615
Message-ID: <20240823151127.upu2sbqff3vt7p3r@thinkpad>
References: <f8985c98-82a5-08c3-7095-c864516b66b9@quicinc.com>
 <58317fe2-fbea-400e-bd1d-8e64d1311010@kernel.org>
 <100e27d7-2714-89ca-4a98-fccaa5b07be3@quicinc.com>
 <c80ae784-c1f3-4046-9d86-d7e57bd93669@kernel.org>
 <7f48f71c-7f57-492c-47df-6aac1d3b794b@quicinc.com>
 <aa311052-deba-4d13-9ede-1d863a4f362e@kernel.org>
 <20240822141622.tw7vcoc4ciwbydsw@thinkpad>
 <9cff09b0-d039-4e65-b6dc-57adaf94c12e@kernel.org>
 <20240823094419.7l2kvly4mnajrm4z@thinkpad>
 <ececab1a-b4c7-49ac-8a76-038d672a0dd4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ececab1a-b4c7-49ac-8a76-038d672a0dd4@kernel.org>

On Fri, Aug 23, 2024 at 03:51:25PM +0200, Krzysztof Kozlowski wrote:
> On 23/08/2024 11:44, Manivannan Sadhasivam wrote:
> > On Fri, Aug 23, 2024 at 11:01:37AM +0200, Krzysztof Kozlowski wrote:
> >> On 22/08/2024 16:16, Manivannan Sadhasivam wrote:
> >>> On Mon, Aug 05, 2024 at 04:43:47PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 05/08/2024 07:57, Krishna Chaitanya Chundru wrote:
> >>>>>>
> >>>>> Hi Krzysztof,
> >>>>>
> >>>>> QPS615 has a 3 downstream ports and 1 upstream port as described below
> >>>>> diagram.
> >>>>> For this entire switch there are some supplies which we described in the
> >>>>> dt-binding (vdd18-supply, vdd09-supply etc) and one GPIO which controls
> >>>>> reset of the switch (reset-gpio). The switch hardware can configure the
> >>>>> individual ports DSP0, DSP1, DSP2, upstream port and also one integrated
> >>>>> ethernet endpoint which is connected to DSP2(I didn't mentioned in the
> >>>>> diagram) through I2C.
> >>>>>
> >>>>> The properties other than supplies,i2c client, reset gpio which
> >>>>> are added will be applicable for all the ports.
> >>>>> _______________________________________________________________
> >>>>> |   |i2c|                   QPS615       |Supplies||Resx gpio |
> >>>>> |   |___|              _________________ |________||__________|
> >>>>> |      ________________| Upstream port |_____________         |
> >>>>> |      |               |_______________|            |         |
> >>>>> |      |                       |                    |         |
> >>>>> |      |                       |                    |         |
> >>>>> |  ____|_____              ____|_____            ___|____     |
> >>>>> |  |DSP 0   |              | DSP 1  |            | DSP 2|     |
> >>>>> |  |________|              |________|            |______|     |
> >>>>> |_____________________________________________________________|
> >>>>>
> >>>>
> >>>> I don't get why then properties should apply to main device node.
> >>>>
> >>>
> >>> The problem here is, we cannot differentiate between main device node and the
> >>> upstream node. Typically the differentiation is not needed because no one cared
> >>> about configuring the upstream port. But this PCIe switch is special (as like
> >>> most of the Qcom peripherals).
> >>>
> >>> I agree that if we don't differentiate then it also implies that all main node
> >>> properties are applicable to upstream port and vice versa. But AFAIK, upstream
> >>> port is often considered as the _device_ itself as it shares the same bus
> >>> number.
> >>
> >> Well, above diagram shows supplies being part of the entire device, not
> >> each port. That's confusing. Based on diagram, downstream ports do not
> >> have any supplies... and what exactly do they supply? Let's look at
> >> vdd18 and vdd09 which sound main supplies of the entire device. In
> >> context of port: what exactly do they power? Which part of the port?
> >>
> > 
> > The supplies for the downstream ports are derived from the switch power supply
> > only. There is no way we can describe them as the port suppliers are internal to
> > the device.
> 
> IIUC, this means supplies are not valid for downstream ports, so it is a
> proof that binding is not correct. I don't get why we keep poking this
> and get to the same conclusions I had 3 weeks ago.
> 
> Basically the binding is saying that downstream ports are identical to
> the device. Including the aspect of having more downstream ports (so
> device -> downstream ports -> downstream ports -> downstream ports ...
> infinite). To remind that was my conclusion:
> 
> "Downstream port is not the same as device. Why downstream port has the
> same supplies? To which pins are they connected?"
> 

Ok. I seem to have missed your above comment and you are right. I was just
clarifying the upstream port discussion as we cannot differentiate between
upstream port and main device node.

For downstream port, I hope Krishna will fix the binding.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

