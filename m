Return-Path: <linux-pci+bounces-7628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE17E8C8A87
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEBB1C222E1
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69AA13D8B3;
	Fri, 17 May 2024 17:06:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56313D8A8;
	Fri, 17 May 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965616; cv=none; b=OmWdJ6/f5vNsxzw/S4NrZVq/QP/LfLn69aWg6sSJ9aKLYSWuaRG8/hgHYyWmVNez2sp8BdMzs248QSyiXUZ4waGirmeuQq0Ftjn1JvOXJPlevZMvvG4pzdrnZMbi3ws3Rir52xajsEjXjI822/hua9DZQ4cH6SMja8AWzbV6na8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965616; c=relaxed/simple;
	bh=cmXJHYt0n27WurVX5CSCRo0/J6W6YEmPq397ULn1iWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0nwyQaJWckuXA1/CuZMIP7Y0FfAvFaxLjgqgbk/qQudC4+d/WeMjGkmRY/UoOaNLxv3n+QgLlIBi4lwtayefHPJqLAFrDkUc+xRtSvsyHPIG91ionibp2BGT8+DP5zJP6hv/kjUVeXUVCxQgqv45L2Hyo6InRZSANiwaNbCuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ed904c2280so13473135ad.2;
        Fri, 17 May 2024 10:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715965615; x=1716570415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tX2V3zugpj22RtcaxmCt5d+IZOg/f7yrPNcCBjnFxnU=;
        b=M3tgSX5FeNxu4oqoJ8ORQ739u+V27ZMqm0BvAsuiqZ7Nbd6AouEGLLIcAf1GjljoBD
         I/6gEbDDaAp/F3sJFxEwrXQ/cATn5Nk5mplGhzGGEvkYkNfzZk0kjvLRuYdInIP4EzxB
         hMjdxsfLCL8Yg2kKP3RWYCVHa/mD4Cty7Xe6zlVDaP8z4V5bQExyyc80rokAYMrLdkyy
         qMXWdwHpdmcPKXUiVjeDPr/ZQHQdN8ESbMN8+1YQfrsAmfMcyZJ7/RpyMPPmJbYDWQTt
         2xecLV+4pAiKyFXzqisPu6X3AnIJv5jPjvfQIW3WBejK3BwZt8yn2qTwCklcyLkVwxaK
         omQg==
X-Forwarded-Encrypted: i=1; AJvYcCUDMTn+bA9PO2HxtEXBLtQLCP6ZLZvaevJ2bfVrLBNWztBybNQQ5mAeCC7tS3CXIYXjqrJIJnjts0VMInvFoGByFfaz8mWpxPS7/FoEYG7Ts8BlFX0a0acso8BjvcbSzRSNWTawTuqE
X-Gm-Message-State: AOJu0YzmRNHuAsfoB+PzEDdQWeqh380tAL28PnLno6h3FPTHNrk9Yuo3
	PhaDkRmOilAQxHhAENo8Zktiob0tuOV3aRkRHm32SYcCsWrBicU2
X-Google-Smtp-Source: AGHT+IGcpPnQ6L8AUKPL7T4eaD+5vSlhDjJypWgo2jQ4+KxJfz3d5egB8JUeE4n7pXKePdQoJXgdpw==
X-Received: by 2002:a17:903:1210:b0:1f0:6f32:e13d with SMTP id d9443c01a7336-1f06f32e236mr164155385ad.21.1715965614547;
        Fri, 17 May 2024 10:06:54 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d3b0fsm159107075ad.22.2024.05.17.10.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:06:53 -0700 (PDT)
Date: Sat, 18 May 2024 02:06:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: cassel@kernel.org, bhelgaas@google.com, gustavo.pimentel@synopsys.com,
	helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
	jingoohan1@gmail.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v4 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <20240517170650.GC1947919@rocinante>
References: <20240412160841.925927-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412160841.925927-1-Frank.Li@nxp.com>

Hello,

> When PERST# assert and deassert happens on the PERST# supported platforms,
> the both iATU0 and iATU6 will map inbound window to BAR0. DMA will access
> to the area that was previously allocated (iATU0) for BAR0, instead of the
> new area (iATU6) for BAR0.
> 
> Right now, we dodge the bullet because both iATU0 and iATU6 should
> currently translate inbound accesses to BAR0 to the same allocated memory
> area. However, having two separate inbound mappings for the same BAR is a
> disaster waiting to happen.
> 
> The mapping between PCI BAR and iATU inbound window are maintained in the
> dw_pcie_ep::bar_to_atu[] array. While allocating a new inbound iATU map for
> a BAR, dw_pcie_ep_inbound_atu() API will first check for the availability
> of the existing mapping in the array and if it is not found (i.e., value in
> the array indexed by the BAR is found to be 0), then it will allocate a new
> map value using find_first_zero_bit().
> 
> The issue here is, the existing logic failed to consider the fact that the
> map value '0' is a valid value for BAR0. Because, find_first_zero_bit()
> will return '0' as the map value for BAR0 (note that it returns the first
> zero bit position).
> 
> Due to this, when PERST# assert + deassert happens on the PERST# supported
> platforms, the inbound window allocation restarts from BAR0 and the
> existing logic to find the BAR mapping will return '6' for BAR0 instead of
> '0' due to the fact that it considers '0' as an invalid map value.
> 
> So fix this issue by always incrementing the map value before assigning to
> bar_to_atu[] array and then decrementing it while fetching. This will make
> sure that the map value '0' always represents the invalid mapping."

Applied to controller/dwc, thank you!

[1/1] PCI: dwc: Fix index 0 incorrectly being interpreted as a free ATU slot
      https://git.kernel.org/pci/pci/c/cd3c2f0fff46

	Krzysztof

