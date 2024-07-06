Return-Path: <linux-pci+bounces-9861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D90929020
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 05:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7CA1F21D7C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 03:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB005C8F6;
	Sat,  6 Jul 2024 03:07:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA40A95E;
	Sat,  6 Jul 2024 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235226; cv=none; b=X9uD9yskvU2dd0YYZTescWKjo25tW2DNzZsWL9LsFyk3zUC2nL8S3ZFisqMxRgXOsMAsjOhSvXDG4yVwP/RgzPJUKiyGAJWKCiv1W6lONaxTYyvD2cVDqoz+8IFs0euznoWiLD0G9++cpnFhCU5VbkDra8TBT3kn1S4MJKg2/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235226; c=relaxed/simple;
	bh=ngljVW3PZb17rkn34LUMdX1JI38Q0k/D5pbIVGM8tmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRnq1zlq0MWML5895OulwD6P9ymgvduY00VbACxl8T5YDn1+hwDtZnZHRK3YNeOee3tgfufehAC553NNvot9fNw+uBegLqfPQ3YWFzvWN1zWf5gOLGiU1xqxYcStKjcTbH5f7Hy+h2L+qnlNd8hm7JDc1RNgWovHSiohRtNgzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d853305abfso1284951b6e.2;
        Fri, 05 Jul 2024 20:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720235224; x=1720840024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPdvg1XTUtnEGz1joPO5mZy0DEvXNcNHwnijHftKF48=;
        b=occWwOKNWKFeniylO9KgQUM7suT7fMdg8wCpAnPqphFsUboN4uVA/UNLeiafomhIsW
         zu3twMSbvP31V1XSxiDmzsKXYNW1HH9xGYzEfwySJrRRfbn+O+Hc4CN2WZI/95oRMhv4
         r77azgYCeXujq55XEkDGZ/C4mzRDrC63TGEzl+jdLU2D6R9z5gMpNp21ZNqjv07IuVrQ
         TMuDQSz07E8Lhhy1DN0rEeRU3GNmm1W+QvT3TRhqH0P0Aw2ulCdG9wnvuWFdMiREE7RV
         MhEx7TVZcoHSuah8sDz30qloV4A/YbIUhsILM7SGUgVrsu7r6vjiPXsUKNi1y9NTDn60
         C19w==
X-Forwarded-Encrypted: i=1; AJvYcCVTUHJd6uBIf+uA2ZRgj7hVwLSgKbEYMfTJEUq9fJxs+W14i079YB1XED87ulueOaoDby98mwo8JU15uqEA7bHN/tvDtWJdCWbbZp/eNHzPoxpSMSIm1qrEe5Blw/ibwk0a
X-Gm-Message-State: AOJu0Yy+DEhCqj8yQWwGiIIjCsUOrcCQeBOcRHbTp0bS8SLWDNHGrkcK
	Gh3IgI5aIqBe3njPCGwiZorbrru7Cx/nX3woAVWVsnMRlczGPEb+
X-Google-Smtp-Source: AGHT+IEDHTTBvjqLHAnJK5kvDoslHvFnypo1j9DNPnLqdBleoHtHQ6L7gk1zAWVnVJXv7J6BQfgFwA==
X-Received: by 2002:a05:6808:2227:b0:3d9:20c3:cdab with SMTP id 5614622812f47-3d920c3d1b1mr2138629b6e.16.1720235224093;
        Fri, 05 Jul 2024 20:07:04 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256c9dcsm14715249b3a.74.2024.07.05.20.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:07:03 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:07:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, loongarch@lists.linux.dev,
	linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
	Sheng Wu <wusheng@loongson.cn>
Subject: Re: [PATCH] PCI: loongson: Add LS7A MSI enablement quirk
Message-ID: <20240706030701.GA1195499@rocinante>
References: <20240612065315.2048110-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612065315.2048110-1-chenhuacai@loongson.cn>

Hello,

> LS7A chipset can be used as a downstream bridge which connected to a
> high-level host bridge. In this case DEV_LS7A_PCIE_PORT5 is used as the
> upward port. We should always enable MSI caps of this port, otherwise
> downstream devices cannot use MSI.

Applied to controller/loongson, thank you!

[1/1] PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal
      https://git.kernel.org/pci/pci/c/b69d24a763b

	Krzysztof

