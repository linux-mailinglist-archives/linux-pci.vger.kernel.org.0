Return-Path: <linux-pci+bounces-25818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC3A87E6E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 13:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C51765BD
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA60283688;
	Mon, 14 Apr 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DunaRyoB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD082853EF
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628855; cv=none; b=JyPIACfLkka2aY+2DSHhh4y7psAJLQ1u9kLXCMGnBVCyeRo0KdU64Go1pziZKPOzfYWWhfNYKj8NOFiFJmJ5SHGWFH9XO96GBRUC/0mObP7znV5VpttMYLfEkstCHPeCm5gKiPprv4kJoDmdhzptlbG0vNJKJumwijsvsD0/CBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628855; c=relaxed/simple;
	bh=8V4ceruG5PBgZuLKk3o6878Go2CYJK67IJGXeFBYrDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4eWaaMzj4YOOGxAZ2HUXCCZRVsLe0tTzsUsij+DzhKgI2x13dUA3kLNUrjW2vCMq+as1IB3xb/qMPwyAEGNQ8juVwnm9YbEl/y7AQihwcfmzHveb2QiW1hqkQ1yrW55tb+NVlKe+NqSO9Hzzcp+pRW0UvyUPtBx75XCDcfbIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DunaRyoB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227a8cdd241so49057355ad.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 04:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744628853; x=1745233653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zFEHcpXAxg/GC10Ly7Ug5qKPKL7Q2jtqdYskUyHbzxU=;
        b=DunaRyoBd3M/pwedP13T+U0hsvSp+qVKtSN9Z18TfFY2g5HlivOl1SMCzfa/y2f8q3
         9sm4qhncPvMMiWbuektaUNIGGzJAqQeMIRFd4CMbN3nntyx1TPdrQAutBoZBfFedpntl
         27CaQ/o1kGIFHDtJ3ApoAbxcclHUzgjO+VOonsJi3oX6+zlmERzY7puyY9kq232WiW+Y
         qjdsmmjNEQRrAE30LW8Q3kni5B7fZzKo3mjyDFFss09cduE5/IGwo2eY6+Miogcrkfuw
         +WUXafnT7YELn6Z5C+TfuGPNijjadhzpFEvuGETNBAU8DiMqYv351qDtUaP5DDZl4beT
         uVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628853; x=1745233653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFEHcpXAxg/GC10Ly7Ug5qKPKL7Q2jtqdYskUyHbzxU=;
        b=dEWzyWG5oUU6NW5+7tNLO/X22hMQv6U2dF2INECN2fc2DMGFVQyc2iPdnnQ2zSph35
         OAq5Y9y5s9CajuW8o2M1SeW9WI/bWNdoJkzpSEZk0oSDB64uNSs7ToYBF3l/gtyeUruM
         wv/jsmlVJjI6rWjOH9p9IOfpArPp486RFqA5CdH4ctC7W5FEERHohVLADEnRLc9QJDDc
         itcOZw5OnnE9YbeqfJic40SGbfq3Ql9KS+ks//P8JpQviywqTtQjxwgDNsBpuSMgzVdJ
         mAwSX1LMZNGLfuIbveJZx3FHGWHF+3FyV4GiTLaOh7a5om47VSjnpFCUNKHmMA17Shn2
         m4+w==
X-Forwarded-Encrypted: i=1; AJvYcCV9YwIeM+DPGHZuLWigwoqqjkRmLg6uFwst3HBEXlwmWT5uZvJe77jZUFpI4xktYjnrseHmFud4+5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/l3NRBKXwC7ZHuWdve7A+Z/O0sH5QP9+cC5v3rnXcOWZeZnH
	NCdTEC77BaxSNDWtCmMixXzOPYJ5XLyz7K+Uf1uoyXUkYxgmRi79IcnxAfCAGA==
X-Gm-Gg: ASbGncuxt6hmCdAZatvgqOkU0SDQ7aqZG3HAiTyCHQV8Y8PyrO+jeu65KswKmGA60oz
	HDXfMWRwOqp7wwsLn09BmzJDcFOqwiWtNydWtrIABX0KyL6WE3Mk0Pe0zETZRSfO24ktBGEbf8m
	q2HzKS6b1fdLbspwsp9jcdFy2A/zkWXBb+h4Ng8egXR9X4S9XXPkbInaaZie9lTmtcmq0jrC9JB
	UEuKi6j04Vw4oirpz6qCPPnBw36yAeC8heO9gpw/7qiiYembdkw4Iaa/Qo0Db2JA61a57Jgt8RT
	eE/UPJ2hnhXGx6ZDf5Lx6n4+GKq31Wynmpr6O5q2JOIaUT15s1I0
X-Google-Smtp-Source: AGHT+IEG8eqgQ0Y8mpznX22CMbhITM96DhKYisQrcLo2Fr6NqPnURcoiXx+TnDQ54ctIZmZC2+bn2Q==
X-Received: by 2002:a17:90a:e7d2:b0:2fe:a79e:f56f with SMTP id 98e67ed59e1d1-308236344famr15907930a91.13.1744628853242;
        Mon, 14 Apr 2025 04:07:33 -0700 (PDT)
Received: from thinkpad ([120.56.202.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd12b62dsm12164634a91.26.2025.04.14.04.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 04:07:32 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:37:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org, 
	Tsai Sung-Fu <danielsftsai@google.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [RFC] PCI: pwrctrl and link-up dependencies
Message-ID: <uivlbxghkynwpmzenyr2b3xk4uxeuqf6dow6ao4mptcnzygrw7@ylfqavr3ry44>
References: <Z_WAKDjIeOjlghVs@google.com>
 <Z_WUgPMNzFAftLeE@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_WUgPMNzFAftLeE@google.com>

On Tue, Apr 08, 2025 at 02:26:24PM -0700, Brian Norris wrote:
> + adding pcie-brcmstb.c folks
> 
> On Tue, Apr 08, 2025 at 12:59:39PM -0700, Brian Norris wrote:
> > TL;DR: PCIe link-up may depend on pwrctrl; however, link-startup is
> > often run before pwrctrl gets involved. I'm exploring options to resolve
> > this.
> 
> Apologies if a quick self-reply is considered nosiy or rude, but I
> nearly forgot that I previously was looking at "pwrctrl"-like
> functionality and noticed that drivers/pci/controller/pcie-brcmstb.c has
> had a portion of the same "pwrctrl" functionality for some time (commit
> 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage
> regulators")).
> 

Yes, the goal of the pwrctrl driver is to get rid of this clutter from the
controller drivers.

> Notably, it performs its power sequencing before starting its link, for
> (I believe) exactly the same reasons as I mention below. While I'm sure
> it could theoretically be nice for them to be able to use
> drivers/pci/pwrctrl/, I expect they cannot today, for the same reasons.
> 

If you look into brcm_pcie_add_bus(), they are ignoring the return value of
brcm_pcie_start_link() precisely for the reason I explained in the previous
thread. However, they do check for it in brcm_pcie_resume_noirq() which looks
like a bug as the controller will fail to resume from system suspend if no
devices are connected.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

