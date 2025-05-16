Return-Path: <linux-pci+bounces-27892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7952BABA2B7
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 20:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2D03ACE53
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B927AC33;
	Fri, 16 May 2025 18:26:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B0219938D;
	Fri, 16 May 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419960; cv=none; b=eSL+XRZuu4hwO+I7s4QmtPa5KhEmtADC8EmDMSTPyM0DaCdOEjaNRxu0hGNBXkd8mc/7Di3zkvy54qCRSoXzAbklW2Nj+r5f48hizXr+mCNCGasToJv9s9FdAnoVtPVNyE0qyczGikHGAb0/9WKDSyotq0W47C5WMT9Xamm3DLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419960; c=relaxed/simple;
	bh=W+hVoDrt69rQBrw2sQEug8sq4k8PP8rdFY5sfoogBO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPGoSE98Q/ifZiPkfoHicYRer6PP6dSkA/vQCPiRDwfAAnkRc4HKF2zPRU8CX9n9AVRP1/oF4rAhvTfM8/QeYRcewHsc6ZHTHZ2K1xsUiL598tNQn4wBaKLigxvGF4iBiQhqurAOhZUlqsZ7mKQrclr/IxWnXTvLpPKxIHczFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22fa48f7cb2so25697115ad.1;
        Fri, 16 May 2025 11:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419958; x=1748024758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvPrUCtff2XjbpPn1OxgQEe8xhgRwloghWbPZ3FwMXc=;
        b=svpXa0o0NFmSFEY1sbystuq5WZGbBHwZtHn3Pq6sDn1aL26k8MwTYL7FReabwHbt5B
         x5L3t538oz8evnu1MCoNb1LhRDtwgW5SJAlHlEeBgDitsM8OLiEnmzWbu4F2v7stf4/1
         rfO/Sdl6u+fKPVk0obdtPtC33Ju2ojpSDJvlbJm4vvKyxte93+xuAWEIN4LIDa1jFfrD
         ievGleECmkMl2JzxrE8fw7JHf9VxfvDrbwyDoywUT5Jbbd8zolDqLz6gfcUKDNX6wmDM
         i79dUeLcwJ3qdBgHUKBmDEWdyKQ8OA0+S0HXhCuu+lSXTtc5x95IAmVK40aXvgfu4aSk
         ffew==
X-Forwarded-Encrypted: i=1; AJvYcCUJKQdDMUt9QJKMkKajjeWflJUOaFA2zCEqi/wmgVMOFkNVVTI7RSZJ5SPeWnpScX9F28MoTu/mL+8=@vger.kernel.org, AJvYcCXK3ym58wQ58sgtjOeM1ed10MW8ZnR8KcH27qJlLaN5s3ElZDb65uUGoBL7Se+JCQjn14C4M6rrblbD@vger.kernel.org, AJvYcCXVbALIJjQXB1ZOGLXSFm94DA0AEokTxAO9R63HqvX+tM8zu6KCqWIhJtpHaxNyLUnA79VnzGclri7MaySn@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHgq9jzvVsyM3+I3zvU55PGeb2JjL3FfVrGKIxJAnhfuYq+d7
	aSvcIdeEPd0X+J2iY1CYzIP2ssp1DBb1uor9KGqyF4gB2BAxafJ/pxa6BDMLaGOyO/Ewxg==
X-Gm-Gg: ASbGncv/SUjl2L3MT5dITd6DjIwlxzghA8M66K0qV5Ar+AUXkgyOpVaI05h2s1QNiEz
	RSn3/d4bgmiIfiQm1omA2Jr2ME0DEtdu/5vUIAGeRIYQupxjWz9L2PI+Azjr+RwHDK0hjJYTIse
	1YgF0kjLgirKDwp72yG10Ol2hO2/hMuYWow6b9mKOv6ovXnvdFdznIppWrbAs1wbaiD50xb7DL+
	w2XS1E88vKXqbhybFzDj1fygY5eJ0LKYJU4IPTMH+yMKO7OkK802ugBslNxZDs0GFXSqBm8Vfy7
	Yw1lyRhSN+qd+52w7ONDuyyrHfN1OfWiQ/hdZiff9UDtuT6zWWwwvqnMZZcWvh8UhKfO6LpRt0n
	AbQue8d7Hag==
X-Google-Smtp-Source: AGHT+IHSB+sRs2Fbmf8vPDydgr9nhkv6k2jwT5M7BAgUxV7ABrcwM3ogVAPs1NwcZngJ06LFoaL/Aw==
X-Received: by 2002:a17:903:1b6d:b0:21f:136a:a374 with SMTP id d9443c01a7336-231d454e068mr60992805ad.43.1747419958457;
        Fri, 16 May 2025 11:25:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ebcd45sm17308925ad.210.2025.05.16.11.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:25:57 -0700 (PDT)
Date: Sat, 17 May 2025 03:25:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: Remove hybrid-devres region requests
Message-ID: <20250516182555.GA2914997@rocinante>
References: <20250516174141.42527-1-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516174141.42527-1-phasta@kernel.org>

Hello,

[...]
> the great day has finally arrived, I managed to get rid of one of the
> big three remaining problems in the PCI devres API (the other two being
> MSI having hybrid-devres, too, and the good old pcim_iomap_tablle)!
> 
> It turned out that there aren't even that many users of the hybrid API,
> where pcim_enable_device() switches certain functions in pci.c into
> managed devres mode, which we want to remove.
> 
> The affected drivers can be found with:
> 
> grep -rlZ "pcim_enable_device" | xargs -0 grep -l "pci_request"
> 
> These were:
> 
> 	ASoC [1]
> 	alsa [2] 
> 	cardreader [3]
> 	cirrus [4]
> 	i2c [5]
> 	mmc [6]
> 	mtd [7]
> 	mxser [8]
> 	net [9]
> 	spi [10]
> 	vdpa [11]
> 	vmwgfx [12]
> 
> All of those have been merged and are queued up for the merge window.
> The only possible exception is vdpa, but it seems to be ramped up right
> now; vdpa, however, doesn't even use the hybrid behavior, so that patch
> is just for generic cleanup anyways.
> 
> With the users of the hybrid feature gone, the feature itself can
> finally be burned.
> 
> So I'm sending out this series now to probe whether it's judged to be
> good enough for the upcoming merge window. If we could take it, we would
> make it impossible that anyone adds new users of the hybrid thing.
> 
> If it's too late for the merge window, then that's what it is, of
> course.
> 
> In any case I'm glad we can get rid of most of that legacy stuff now.

Thank you for sending a v2!  Much appreciated.

I pulled tentatively to the for-ci/devres branch, to get some soak time
with 0-day bot and KernelCI, while we wait for reviews and such.

Thank you!

	Krzysztof

