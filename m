Return-Path: <linux-pci+bounces-14432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED5299C495
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E681F2128B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03EC1552EB;
	Mon, 14 Oct 2024 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LV+QAYY5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C985156C62
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896581; cv=none; b=A7nXw6nHwf9dIHtOd0wjx/9gE+gVPd9K3A00ofo5id69MYWlTo0ZykiuVe5SexPFWHtzikDlmEuRTv8iMY5f9QJTATtNfSpN2ZVTouLyEaVcik1LbGbAdmouSRF3HJiNDIPJhrM4wCi40CnkLDxhlyI+RoHRHuyJPBqOXuRKHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896581; c=relaxed/simple;
	bh=2GisIUBe0IEWy+Sau5w4ZmES8kY8GzDvVOOez+Hfq+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejtUQLNEUbX5srjl9eaQBNNmr7ihOw1woQsz0YencK25Ivi7LNG0nFhv+FZYAvVbWoWNLkQSy9zMl3c7dOtHxi2BNoCHjq4DKbWki4Ltf7NmTrdmQKpWE2RWs3K8PktD/Mpfz0k9boDrzx4D38+yeB3crQgi8/PAiEBwaBi3lDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LV+QAYY5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e453c7408so1546606b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728896579; x=1729501379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r6BlRxGFAWXdmmWyG/Jl2AYSWcJ7q9f3AYTt/GTL8Vs=;
        b=LV+QAYY56vzmsVZnIe/UZIbuDRBg4Taz6blK0MKyl4tQcumxn9sEHI4QjThzBFvh4d
         Pt0kzWhrzkBLP1LoVuj8DpxknUY8GPHUlWrWSeyIH0VRKK/YWSdJBRc/31nUhA1azdAd
         W/l9DUXMM8cC7ylPFtVy1DRjsFUo/Im6ZbDhT6FO90nPPo234BSa1k2x3ycJ+3wDOdK4
         QLVP3tXdGeUM5xFbYQ2jFIzTl6cS8bOQRF7Q04jBP1PhiBlj/+qYd1kZCSagJOdh+6k1
         WaJGspLM6DWbet8DwuAKsPfK2iU/ClakgHeIpyKr/S62fjvVrRwiBmVupx7/Kr6QNg29
         0G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896579; x=1729501379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6BlRxGFAWXdmmWyG/Jl2AYSWcJ7q9f3AYTt/GTL8Vs=;
        b=cyMbum58v53HsykrxdwMCbjoA2jdxu01NyjkyTbm1TeorU6lNYiyfiIDiZcKdoVEOU
         gcmGMhs3XfeHwC5b2iW4dQXoxpGhhraqN5rwKI8hizSkPX1oPYbAYRc1fh5HfNQcGhAc
         AeYxehQcVOUTtLZCdAAO7wioEjCqw6OkgYzbjCUgIlkCvE/vanvYxvetWUD5RvWn4Kuq
         xGCMo233Mpv8UAmjANpacSCfmrD918uC/+YNoJEBXdy1mqk/ElKXGj4xWGlDX2ONVGZy
         nSX+B4ieFOnlnB1Uukv2H6yWFOBSx29OPl6+oxnQEqOZvE3S4zMP9bs0C4++MeQYBQI3
         vclQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1BQqH0WBdQIj3qn+pETLyq5roXWZ0Z0jNq3lvbULL3fEeeIOhAE0M0K4REvDa6KGg3DCfx4z6yJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykQlo7VMu9/3QhYStvBhec11kxOHyDUbFKlMepZ2dtacN7FV9V
	Hpev5TscTjYZI/vJ0LJacvGZvBd19z2LOL/QaAEQgr5nmY+d1m4xZLoZIAI4nw==
X-Google-Smtp-Source: AGHT+IEd4NMKPXw0+kEcZfxjlbat70LgfJ4YvfVvn2VjB+W9S14ALVCgSnHKZNhydjKJLkZrc0GTQg==
X-Received: by 2002:a05:6a00:1391:b0:71e:ba5:820e with SMTP id d2e1a72fcca58-71e4c1dcd95mr11403576b3a.27.1728896579444;
        Mon, 14 Oct 2024 02:02:59 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e6283e9f4sm2013750b3a.187.2024.10.14.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 02:02:59 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:32:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 3/8] dt-bindings: PCI: qcom,pcie-x1e80100: Add
 'global' interrupt
Message-ID: <20241014090251.r4sfaaxtasokv4oi@thinkpad>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
 <20241011104142.1181773-4-quic_qianyu@quicinc.com>
 <eyxkgcmgv5mejjifzsevkzm2yqdknilizrvhwryd745pkfalgk@kau4lq4cd7g3>
 <4802B12B-BAC1-4E99-BDFE-A2340F4A8F24@linaro.org>
 <3d1d0822-da66-44c8-a328-69804210123c@kernel.org>
 <65B34B14-76C3-491D-8A58-6D0887889018@linaro.org>
 <df6379c6-662a-4b35-a919-13c695a869c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df6379c6-662a-4b35-a919-13c695a869c7@kernel.org>

On Fri, Oct 11, 2024 at 06:06:02PM +0200, Krzysztof Kozlowski wrote:
> On 11/10/2024 17:51, Manivannan Sadhasivam wrote:
> > 
> > 
> > On October 11, 2024 9:14:31 PM GMT+05:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On 11/10/2024 17:42, Manivannan Sadhasivam wrote:
> >>>
> >>>
> >>> On October 11, 2024 8:03:58 PM GMT+05:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>> On Fri, Oct 11, 2024 at 03:41:37AM -0700, Qiang Yu wrote:
> >>>>> Document 'global' SPI interrupt along with the existing MSI interrupts so
> >>>>> that QCOM PCIe RC driver can make use of it to get events such as PCIe
> >>>>> link specific events, safety events, etc.
> >>>>
> >>>> Describe the hardware, not what the driver will do.
> >>>>
> >>>>>
> >>>>> Though adding a new interrupt will break the ABI, it is required to
> >>>>> accurately describe the hardware.
> >>>>
> >>>> That's poor reason. Hardware was described and missing optional piece
> >>>> (because according to your description above everything was working
> >>>> fine) is not needed to break ABI.
> >>>>
> >>>
> >>> Hardware was described but not completely. 'global' IRQ let's the controller driver to handle PCIe link specific events like Link up, Link down etc... They improve user experience like the driver can use those interrupts to start bus enumeration on its own. So breaking the ABI for good in this case.
> >>>
> >>>> Sorry, if your driver changes the ABI for this poor reason.
> >>>>
> >>>
> >>> Is the above reasoning sufficient? 
> >>
> >> I tried to look for corresponding driver change, but could not, so maybe
> >> there is no ABI break in the first place.
> > 
> > Here it is:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4581403f67929d02c197cb187c4e1e811c9e762a
> > 
> >  Above explanation is good, but
> >> still feels like improvement and device could work without global clock.
> 
> So there is no ABI break in the first place... Commit is misleading.
> 

It increases the 'minItems' to 9 from 8, how come it is not an ABI break?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

