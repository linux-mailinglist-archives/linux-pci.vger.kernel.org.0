Return-Path: <linux-pci+bounces-22405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E61A455FB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 07:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132BB7A1BD7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 06:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A88269889;
	Wed, 26 Feb 2025 06:48:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F120FA9C;
	Wed, 26 Feb 2025 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552534; cv=none; b=NLTZer4N/JI902lCjv6dkOKeX1BViGr6N2FLKwZ1yDmbhHPmXj0FMjie1gKIXAWJWukG6dJ/RwB6RfO9UKy1K74dvsfy2gQ9xnhwmgrE2L++V6WIlFC3Wu5vwIjeuNVb1/7mejU3P5GRPY68nNaFDLmxD+zE+QlD5vmUhq9lJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552534; c=relaxed/simple;
	bh=gC7PSBjyRUnVpAoH8oaR/sRgc92k/ei7rpPXG+RmbiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX4c3tBIA4af7v4q13VO0AH455FA/g2czjljzrHEYKnwILdTKUzCw2OYiLFxw7GLWeUEUtW8KwVpDriQAjSQoAP9x6XPXMzjfYcAkMWrluhWSo3VVSHITpNL3o9T2aKBIqYV5MPK4mb2ZyhmK//+MY8fFOQKdclfWdbrx/ktZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22334203781so1829215ad.0;
        Tue, 25 Feb 2025 22:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552532; x=1741157332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFPHzWF9dvrF9nnBiTWLXmH6iPscf0ArvWzi8p1a6zg=;
        b=aEw4C1Ig7pUPmccjvUWp3FfIggCwsguGDZ6uvZxGM3cAv+I+3AY5l1JzSiwXBCpgky
         HiHh94eayPrrUXD1KOjp4B+1MrWDesjqOeqZUmH20fRUAlWpVhjGowtPARQtWrxPtR+g
         iRPObpuG/0SQAVKeJZXGnOJzBdNNlzGK/gQHpl5XLyGvBNyxwbA+9ZMJHp0istwkNCjN
         RFLAcFS2xu1GjfGYLaznvFPhvdLqOhP4qhlorXWe8teqp9zqYsFDHUWmwxPw+jepMfdw
         HIXvk2QBgp1qPju2sMHKB50KPuYIeCmwX6FSxjhKKDpEslqKF1jdK30qqz/8qRtDHIUs
         FuEw==
X-Forwarded-Encrypted: i=1; AJvYcCUKUase9qpBbrqzpDwLuM/7EMkMAHxPh9c650CoJgWMqv7bVrwPkXxRoWM/aJlJGc9iQm6fGxOsQ6HlQbVIT4PJZA==@vger.kernel.org, AJvYcCUQt/7XoGIiExwje0OdFVtEPvRxeUtMh0LreFzdFDLiM05cQYjz1bD2ijDwL4QIokfSx9Ny/wSxmGn7@vger.kernel.org, AJvYcCWYYnZj/f/dPhRPzLL7ov51LF+s0H2ceF+OzyDMCNeiSMGsg32m+umVB+hl1MKoYQ/SaFaewDCPyRFbd1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOFy3Jt0DWxaca2xsxsAPdNmS2ZMIrEKYaM0YlGFyHZ//pKHj
	WeHEMLzkDYpI+vyhWl4WJMK3WG3UqRdaoTgNSkIaOEZwThB00jH+
X-Gm-Gg: ASbGncuv4lJrRGPLPNDXveu3pl3S5ysiZVAslLPq9xKvH4gbod2DZe7FAvmPhWnQJoF
	3mCC7RiZ2qySTWf4IrhfdAj5R84J2RV52zSmdtkyDGNUX8LdSO9hVM/IGyeuMmLakmqzlGmN0+V
	SIcMQy9F5At58xXy9hoOT0gsS4ID+/boxnwpvtnf9fppQztqz9PMosOH+3ohtYvoXhGs185Oca/
	5/dZuyO21toHc4wEw3xBuJF1k2pNjtpN1dHI2DpHSnUmekRZedl9IgPe07HY4v7FeY9F3e1NOb3
	82UHRJaY6K/81Y597JX9zQIbdDSRMLpnKFszE5gEusdnVH7VrDI+mCthGkHzKpNKJZOFGcFaza8
	fhg4=
X-Google-Smtp-Source: AGHT+IGcE5VWjeLtYFuzMnR4StCCXIyHnVIwT6r2xYT1E3w/+YsuMDqsIDN1v9y0CaB1GqFIti/+Mw==
X-Received: by 2002:a62:b419:0:b0:725:4a1b:38ec with SMTP id d2e1a72fcca58-7341406be25mr35814240b3a.3.1740552532025;
        Tue, 25 Feb 2025 22:48:52 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aedab119e3csm2394339a12.76.2025.02.25.22.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:48:51 -0800 (PST)
Date: Wed, 26 Feb 2025 15:48:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 1/5] perf/dwc_pcie: Move common DWC struct definitions
 to 'pcie-dwc.h'
Message-ID: <20250226064849.GA951736@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132024epcas5p13d6e617805e4ef0c081227b08119871b@epcas5p1.samsung.com>
 <20250221131548.59616-2-shradha.t@samsung.com>
 <855b4178-cbd5-4d95-a2eb-32c5ee0e5894@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855b4178-cbd5-4d95-a2eb-32c5ee0e5894@linux.alibaba.com>

Hello,

> > Since these are common to all Desginware PCIe IPs, move them to a new
> > header 'pcie-dwc.h', so that other drivers like debugfs, perf and sysfs
> > could make use of them.
[...]
> LGTM. Thanks.
> 
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thank you!

	Krzysztof

