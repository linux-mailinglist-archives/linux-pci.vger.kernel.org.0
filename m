Return-Path: <linux-pci+bounces-28006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9E2ABC593
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 19:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465833A8C33
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82343288518;
	Mon, 19 May 2025 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bESJvtNS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92728286417
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675612; cv=none; b=oC+R+RJseubNkjFUfJ2Ymn03k/rfkExgDAJ5JmMpf2MrMNRn5r29bo5EnfAUn9ADc4nEbG9kFhRTlf98Ov8SeSw/SI5NA+9st3Fhvx6lqhHY7FnB9tyxWy4m3v2AVy9krrkDtpHIeFYpz8URZoY4x0gYnKxGhoR5s2Hkq1bAuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675612; c=relaxed/simple;
	bh=5dm9GHYI0B+aUvQ1dcZSfxiizT2RAJzBr37B32OQ2To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGldah+6HHoItGyz7AMQ+XZSg/vypal5G976Ts3W4wO/uYID7D9jDE+nkAi0GP/yp3wH9d6iEodh3LhClnRe9ar5T0wNUT3U1JQmtdCywBBUwO5FDOh8hkB1teJcZulyPp/J2qpxr0E+ytk+3b0UBFQVA2Ywh7iZXTtd4Cltgy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bESJvtNS; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-601d66f8cafso2390086a12.3
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747675609; x=1748280409; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ab0m2oDjVG6/RnjE/ly9PDGKXz106oLRL51wYT7MeVs=;
        b=bESJvtNSAck26hKmJUJQAV537te1AmB790NRGqwtMmFt+OiDvo4CntPZaT0c16PYzE
         v1MnUaS1xbmAIRfdUOROnVTC4zlfhoijPFmsPp4D1r18FQjM9JHaQAFdrxx2xzFB/iCG
         58oNWRNzCgi5iIg5NPbIBr2UlFbgNfbanEA0GRT8E82iL72bjiMXHuUj2MnOOGlv5Ycu
         4Js8lFpePst/Dc/78e2oDtlMyvKxiPoQ2GqV84zpAC/yf2qHd/kaRpMk9nFHeuuKdWM/
         BxwjrWs3d3Ijn1J9NJ0AD+RgF4BCvwaG9HxM91MHglEg6XtN3+34hTcFWBK7Rd0lAR0w
         xwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747675609; x=1748280409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ab0m2oDjVG6/RnjE/ly9PDGKXz106oLRL51wYT7MeVs=;
        b=GsX0wQRsl24Ea7fDtmhU5l/XYnLPjYaowQp68cTVCx3lqOyOy8lq7wzcRj6GBGBRuJ
         KqE7YWK02jsIcM6dLnVb8jCD+uO5kQPCWojkzPlMkAVm4vYuU5jeT//XGODKF1F1Uu0T
         EIgdhx0KetKKI5PpKhJ6nUBSABFH0lIJkaLbahz70r8Ih6IRumWnhydeRP9KfP9E6fK4
         E7Pz6CQRce7leco9Cbvfx96KNh2asHB3TwYZeIDgV3Bi4yFZ5zKKBlpPALY3fnMTwzPB
         823nVHdACrjcXlks+18RzaK58uFhk50UBQfJkXKk6iHdLy1ytQb8QoWPL3DEUWisfH1M
         9uqA==
X-Forwarded-Encrypted: i=1; AJvYcCWocZoXa6O3I4QCsw4Vy8C8zqounpteBcGPLUu7O+pdINgnrKUHtiPABU145EEaUtTz5jN4wymjXS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOdmxM6VHYhsEWMPtMSVZcUdKrm1PKN0c/dzgCPpO8GnBkh4Qa
	7AQARN1zuJP3T4DCeqJTzSoop31UXHbSNgH0dbPe539FxuFIt8SnjN4jMYNLNVYq0w==
X-Gm-Gg: ASbGncvbSSAZ3zOumRMJdiGh5TlO2HLgdSI81FIaZA5UNHf6L82VGc9lsLBvja0A7Y4
	rJ6yw9TY4bBr/5ysLGLkLQY/GKuxL6I1g5fnHWzOwNvlWD6IVQn/cGjVB43tGnrkUN8LxjYsrWQ
	UuIZEpYmaoPD+ygZytemUtbSAJS94ufLbO24c5OOzQP/AZP+IrDybJx0tiEWmVBM7gYkGcwsxxL
	8/7U+3TlFbA7L5mfCYqcWn7Tln04WlGTu4xFGPWA0W4a7SLcQHYuqPh06/uWvprdbQHdjvb+Eoo
	FoT9CgwoY7Q557c40Na3AoDLnLMYFO1IA0eAadafmSP+WiQElJrKgKi57ybEZ8dKemHnYfWdkTa
	JW/XNxeSr7DqDIlQ396TUjKWGgFTO9uojpg==
X-Google-Smtp-Source: AGHT+IHIB7flNhn5eZh/Nw3e7z0P5LT0jtcJFGpy9akrYcoSMgQBV5GrU4JnhSvSNGAcIq/K7+7fvw==
X-Received: by 2002:a05:6402:274d:b0:5fb:87a2:5ef9 with SMTP id 4fb4d7f45d1cf-6011411d1e4mr10899333a12.23.1747675608812;
        Mon, 19 May 2025 10:26:48 -0700 (PDT)
Received: from thinkpad (host-87-20-215-169.retail.telecomitalia.it. [87.20.215.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae3953esm6058717a12.73.2025.05.19.10.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:26:48 -0700 (PDT)
Date: Mon, 19 May 2025 18:26:46 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 'Cyril Brulebois <kibi@debian.org>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, 'Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, bartosz.golaszewski@linaro.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: POSSIBLE REGRESSION: PCI/pwrctrl: Skip scanning for the device
 further if pwrctrl device is created
Message-ID: <qswaeguq35p47hmjesnmpvmpqw5nwx7f6ii5usnv3jwjegogh5@o7vfb4tltnpu>
References: <CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com>

On Mon, May 05, 2025 at 01:39:39PM -0400, Jim Quinlan wrote:
> Hello,
> 
> I recently rebased to the latest Linux master
> 
> ebd297a2affa Linus.Torvalds Merge tag 'net-6.15-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> 
> and noticed that PCI is broken for
> "drivers/pci/controller/pcie-brcmstb.c"  I've bisected this to the
> following commit
> 
> 2489eeb777af PCI/pwrctrl: Skip scanning for the device further if
> pwrctrl device is created
> 

Thanks a lot for the report and sorry for the delay in getting back.

> which is part of the series [1].  The driver in pcie-brcmstb.c is
> expecting the add_bus() method to be invoked twice per boot-up, but
> the second call does not happen.  Not only does this code in
> brcm_pcie_add_bus() turn on regulators, it also subsequently initiates
> PCIe linkup.
> 

May I know why add_bus() is invoked twice? The regulators are supposed to be
enabled only once. I should be missing something here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

