Return-Path: <linux-pci+bounces-29313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1DFAD34A2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340AA3AB50B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A9F28DF3E;
	Tue, 10 Jun 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZf5KJZL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276928DF35
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553860; cv=none; b=LAVjr+OTWOscfhWKTVOVPORksPdlw/pwn/0fJ7FKDLOtgUxMQA6PeG4iSrXSl9swB8yEO0lrL6d/rRjHoh9H0yvM1FVG8OMmTbnXO0K8Pi90Jfx+5oVcYhiiRnD7txkXkjHYetDonDh2JYF/WfW+/N7vc+r3lnIzgN1LQcCUtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553860; c=relaxed/simple;
	bh=moz2wim/rfV0N0Eam+BybWtmQPf4KPqMQ/vPGwKbkWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBUBGS1F8zAJObAJ1Em78+zYnQs6sqjue2X5acsrjNShixlFm+iFRIoZuYuAj3hVdHT0/ODwl/Txv1JePoVZW04TLtD86eTntEwcu0rUFUmIxKPImSXZR0qJCcStOPazsjJ7whuMXK+DhUOueop9FiVY8MdgVTmZWMxMG+HEaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZf5KJZL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442ea341570so34677045e9.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749553857; x=1750158657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/q/ZgTSjkrs+z+mH2vucvlcudnmZL89/lUFX5jLOims=;
        b=bZf5KJZLAlvtQ6h3Hx+hicQ12578idIoM4pQTxaGuMofgNp+6qd4JgVgp1W41wVFnM
         gmC+yVoo/u+tlh0lWhPjfyu5YdzRcHG0ePQiCDZUeolMoUEMY1fC7C/HZ1PhvKoas+qI
         gC4CLreXQgGl7hn4jSHWBh25786usgQHdXq3ZlhXtL3DsTXDCtnkMav+xrB4DJ6erWP9
         m6bI4LZE8YOXKy8wkDDQk7IVSQgEIUwNWdjevSkkdEsJqj4xq/dh9x35LeE9P3haEyFQ
         D5Mm6rMkpcab0DURPUbFrkk5IxxqdTiROmcvqzm8j1LaZCbNgj07hQXBa2v42wRw3oYu
         K2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749553857; x=1750158657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/q/ZgTSjkrs+z+mH2vucvlcudnmZL89/lUFX5jLOims=;
        b=fhHanu60AqIV5z5p9moReOgMzQZqg0fN+6elXwgXOw8XF2qxtEYYv3YRCpvO0TmlCF
         xGYCP0kd7VCCGC3Xm7ZQzmsOl4kDyYhcjCYf11/fTpO4zyN8DMnm8+/Cq9sRR5h2B9tO
         aCRR/nVCAYlCNJ4JzGBZziPGCAheaXbaaS+jKIT+FS09omzn1VTTjXlL6FXm32DGnQwE
         D9U+FzzwsPFjZ7kmDm24MoJ2sMGUdfz3jSCobTSL++/MWdWWYnnmG436s9f9ATSaQsfc
         SGxQQINmYMATq6AfmmFYVOy5KmuGk2jb4cvEZZAbDnVMuGjVjoGlN64X6YhrEEtg32wv
         DwiA==
X-Forwarded-Encrypted: i=1; AJvYcCVKU488rbTbWxZmKVr3MjqtTpiNSchgj+9ur74x6CuQg4MFoe8+ihWh8CO77L1PWf1+Yl8R9Tg0O0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ReHhtS2pqo5pwJNz90oRZptFk1Vsw5/YeDUpqjD+YZrUgTay
	LJuMkTdQzvhmvwn64/wmdj/mxyikzRK7J3mpwroFNBPz3rr0Go38B18HX8mCUiDYxz4d/NJhdbh
	uvBmm
X-Gm-Gg: ASbGncvgMVXEvESW50yiZW+51Hiq1IMNII8US7dmLbjMTEP3fsXYuXRzJdd06td0zhx
	S8YXrY7w0FIqyyb2MFP/BbuDEVTw2FaldWzGskz+DY3cCTG6sueibq9++Dkwf4XcMrEZ5Fg/smS
	/NDaeaV+kCmgv7UJWueE3LSutXRUx5izhVGa8+1ScXGlPEi3Fkbmw9iEw9meHgHCbEdYNwqEfFA
	HzJwZwUC52+8VTRHlPJTE3ukOQlEERRlvyLCXzhOZ7gi0FsgonHrl0DzB2p6hLgmwUggkcZrfhA
	g0yCylb6gv5Cc+qt08YJVrCqsmF8z+Lec0p6U3CHLexJU95Qykrpwh/FX05d/A2X1PyqrVXD
X-Google-Smtp-Source: AGHT+IH5Y3x1Ki501vRLyJm67k0wpvTB1sBYw1TI/SnhFi6z5THD53vwm2fVgUQX/KBtW47aDeeIdQ==
X-Received: by 2002:a05:600c:5396:b0:441:b3eb:570a with SMTP id 5b1f17b1804b1-452013681efmr181694725e9.2.1749553856655;
        Tue, 10 Jun 2025 04:10:56 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452f8f011c8sm134431845e9.3.2025.06.10.04.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 04:10:56 -0700 (PDT)
Message-ID: <2a6336cc-b5cc-4f8f-94a5-d0872a3c95fd@linaro.org>
Date: Tue, 10 Jun 2025 12:10:54 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Fix pdev_resources_assignable() disparity
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Rio <rio@r26.me>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250610102101.6496-1-ilpo.jarvinen@linux.intel.com>
 <20250610102101.6496-3-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250610102101.6496-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/10/25 11:21 AM, Ilpo Järvinen wrote:
> The reporter was perhaps not happy 

No, no, very happy in fact. Thanks for all the help!
I figured out that I need to get familiar with the resource fitting and
assignment code, and PCI in general, before trying to fix the problem
with the downstream drivers. Which is something that I can't allocate
time for right now.

So even if I couldn't fix what's going on downstream, I'd like to thank
you for all the help and time!

Cheers,
ta

