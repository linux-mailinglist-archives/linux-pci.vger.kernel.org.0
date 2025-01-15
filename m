Return-Path: <linux-pci+bounces-19892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9815DA12457
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 14:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073B67A0600
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3EC2459BD;
	Wed, 15 Jan 2025 13:04:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F802459B0;
	Wed, 15 Jan 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946251; cv=none; b=sXweyiKQ9NrgoeW3qHNP65lukjbakO6feiy3oVAQtzqmKioG65RSXJOyps9KRqrgGXVZ9aQxSpj20M+ESqfIhfETEQjMggEaAwj+aPWHROzaBcM47PAhuksRcracsdOEsEnGqb2dfH68Nb/3ayMoHibfHUfEYVgHddfEOzZuMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946251; c=relaxed/simple;
	bh=FbLUcEIiJh+jtgdTTb4glrRZOazsjj7x/E+5iF5lUbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXW7KTMcnZzTPu2kgVrqqQ7RYbM+o0i00IRJPFt1jMeetrJGSoSHv8iURW2U8pkiNV5x2EPrYGWt02dkva+QTY7G/QmywxgH5m+4kCBryZOdKLNC3MD+vKvMvmZBBZnHYzxgnpV0ZP3U8n1FenogqbB90xYLiHVr8St13vbL6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-219f8263ae0so110322035ad.0;
        Wed, 15 Jan 2025 05:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736946249; x=1737551049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU3e/n6KhYgwGmV111UKdccXNVZHL0iNnBKvqCJS5vk=;
        b=Fn68I4i9tpMUU65/X51XdFj7u1YJsOt5lcnJzXHWiHfoXgw18ZrjiKfJLyQknlTjYw
         nF0Q6E77EZl4bQzRMNBPuaNAWsoSax9guJ14UZyvq4Mu+uFQMY9SXlkKeKqI+YhcEtmw
         0v1orrafaUluazEgpHmeFEES8sbXfFnnR9cST0b42fWrf5lrBEQQASdWsFLz/RiUzy2f
         vIKuRy9Pd0R6z0+2XYtQJc+ParSyKO2KHuJWryZEb49osGm35RSBGTeUI8MeFqgR5sgo
         AybgET8FZMOCl6zhvne/x1Z/SCNjQkrF661Az9MqgjjXj9b5lJnX+EqYPYA1YtgvvP4b
         LG6A==
X-Forwarded-Encrypted: i=1; AJvYcCU/khHaybr66rW939u9n/8lyHxvrQFk4WHd8E29VBwC7WPYo+cXkn3QXz70x2HPi0AoTW8w/2qN7gVe@vger.kernel.org, AJvYcCUkEt0MESbFMf8WqY/Jt8EL11ADcy4yOE+ppTrfMMuQKcm5DI8WGn+e3uVeHzvvyRylweiQER4AROje@vger.kernel.org, AJvYcCVfT4hIBi+xT1NRSjCSm8ea9GTnGQ0ELkVMdluFmsAo4xeUDUuW/r13mJhmS9+WeEF8Et22Xo1y3iO98Ifp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6QzKxKjNdHUAHX5R5/EcoGESAqmFtUsv03O6BmK4DwT2uNZ1
	CscaKLBF+2YzB3LswjuX37wJyeigZ57dcPxOIUjDGXfDpcMZSu+B
X-Gm-Gg: ASbGncv3BmtoB+9KBCby5xgmKz7vKDQNTYQcoHASyvr1dyKFMVVEYLQNHoNG8vP+eFz
	nWWPm7bUyLG/m4lO3C8TouPXroT45KKoz6fe4JvZ6zQWDwjO+Uz7Fx1L9o/2RGYbns7RUvS0Egw
	fc0MOPn9G+qBrcKW9u6OzJ1zayyuzjjA8IdXHMrQwuiC49ATK/IG8vt6ooodXQrAE49cBIuDnSn
	PNvoZBkJ6ITsLsCqp+okmTYEGy0LnUzqO+68fPXZLTjauMsM1A3KT0Bz3uUEweqArTDxruknXVe
	BSlY/5i4ntrbrJw=
X-Google-Smtp-Source: AGHT+IGJ0xkBFQDRoR8kdZYAlnl/B+msy18AyfBuH1HwSbOm/KPPtntHdjqM9javko0XPog/mwl9og==
X-Received: by 2002:a17:902:da84:b0:216:501e:e314 with SMTP id d9443c01a7336-21a83f54b4bmr429475315ad.20.1736946249035;
        Wed, 15 Jan 2025 05:04:09 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219f0dsm81875515ad.139.2025.01.15.05.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:04:08 -0800 (PST)
Date: Wed, 15 Jan 2025 22:04:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	frank.li@nxp.com, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/10] A bunch of changes to refine i.MX PCIe driver
Message-ID: <20250115130406.GS4176564@rocinante>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126075702.4099164-1-hongxing.zhu@nxp.com>

Hello,

> A bunch of changes to refine i.MX PCIe driver.
> - Add ref clock gate for i.MX95 PCIe.
>   The changes of clock part are here [1], and had been applied by Abel.
>   [1] https://lkml.org/lkml/2024/10/15/390
> - Clean i.MX PCIe driver by removing useless codes.
>   Patch #3 depends on dts changes. And the dts changes had been applied
>   by Shawn, there is no dependecy now.
> - Make core reset and enable_ref_clk symmetric for i.MX PCIe driver.
> - Use dwc common suspend resume method, and enable i.MX8MQ, i.MX8Q and
>   i.MX95 PCIe PM supports.

Applied to controller/imx6 for v6.14, thank you!

	Krzysztof

