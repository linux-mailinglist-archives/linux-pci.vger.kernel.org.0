Return-Path: <linux-pci+bounces-40549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F38BCC3E466
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 03:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E42624E5968
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 02:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26482F12A3;
	Fri,  7 Nov 2025 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlHBFQLh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2320728D8F4
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483446; cv=none; b=Gfkn2LfZ5bqlC4SuB5u6WuKj+7hHSfF3n9apml/MYvEZNIHBstamHgNDvlODXZmIkBl3jIDc7sf5+/383tRiEvqN22abN38MOXIp55qEf0tkwAb88JD5SH6Ddt6w4gN6t84OTYlG1M1yS9M8pxRSG9nS08pv0e9iuaksUYglNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483446; c=relaxed/simple;
	bh=f0zO8wvgQhxW3NMqX1Rfvdtn5DxNIhGdOq4ogpGv4Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCxOsarNkyHsGpDUstHE3jZaF1vNT2b27xyeTWgfMQX6xBTH0hOmnLE4O+crC7FW51V3wJq1JcjfC1YGOXca9qF/71NbRPT99tpfTEY9bO0NjpiIMFk018eCZoGAnOPAByXCBMTjkTaYkZjTZnGm/2ocf6WoKeQVeDIvZzc5EX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlHBFQLh; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3d47192e99bso211477fac.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 18:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762483444; x=1763088244; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tQJFO3d01XRWHlItzAgkgKpAHFmrqaV2k8tk3VC7Qsk=;
        b=BlHBFQLh/UZuO1Vd7TyJbmQiWmsQH5fEz+JdpMIVwmNjuTfmB3USdPmo577ml5MDX9
         RNQC+4Q5khFuY7fzTzOwH5JYMlMUFoc7YQfO8Y2kYnvV1CrYlc7lSkSpKg+HSZqXarGf
         eFXLnmVP0zZ1FsTpG7OaknTglg5nDP2UbclVZ37b7DGOs6TKfhV3tpKAGsy4S4bhg1ua
         1Z9c7IV5hvMua0/rZqdBpdIZgmM8E7+n7WIUMd4KGshnXYduPSskKUMVQ9ZfE68pBP9i
         V+nxtdXpvJBrmGIIwZn2o8GfefHsHbbzj3F3dasldmLjH+KX1y587ZPd/mCXGlQv8SJk
         DXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762483444; x=1763088244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQJFO3d01XRWHlItzAgkgKpAHFmrqaV2k8tk3VC7Qsk=;
        b=uXrfa3krlRTTm8gkI3n0Ls0TMm7yFobkOC9ISOAc0c1XvH9IDVICqQPN4kg96mrnsQ
         yF5UA32P0bQZB6o0iINJMVjnsGb+6NRFrI2P6cmgoNLxs6k+VuuTRu0S0VzmT44z/yhw
         f1uH95whSo/QivfKd4vYlG0aiVyi/GncXzPU7+l86weDzfUtbQQi7eHHgv0PMJUFB7pr
         07udYdimM+1rBlbfG1N3bnUQEA6WlTl+yIEksvh3JAUXwqJG5fNXT3OxsraL83hm4+r/
         2vX4W1BA6092Al4sm/bR5fnNTa2+eFvJsJcXCxuTiW6oLTN+qw9ej2y7EPa7nQQP40TX
         E7hg==
X-Forwarded-Encrypted: i=1; AJvYcCUKj20OS4eLLmXjpGU2pekQ7BPPzpP5h9+Ti8XdYvNIOq2q8chfFZO4mD9P8o3nKzzxU3WkdSGgEuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV2ugslJxvyL7tdgemNIrt8jsokEcNSkq98nk6adp5QcNKQOaC
	DJU9aDASQJyPHXQRBKdO8JQ9YG+IGLvsSV7stlqXFLEk/y4ZjKtbJU1O
X-Gm-Gg: ASbGnctnYgxZ9i6t7awt5R2+eD6ITJ1On9MTRkk+fnHFnMXqENe2Tgk/zZKfTmjaDa5
	l52YVugZcVLmnmNJWucNzixHZMy+MFOmjPmsQeem+PvlpUyrqOg5GSjfc2eXpxEYg9sXhd479Ny
	/qgufzah66SpqFN2M/yBJsegAvSmXyIMS26Y4ACpCEaHK3ap6gDdPZb5rtKvMWSjfU9u3JG8Kf5
	obadtLTxco3noJkN52YTC1W+wwX4ih8ss+STI9zCkcWwgVHEdb30GYkC/kje1PR/meZWhmQaqxn
	aNn3wsRYtd4GXwJwHiGhUEn+ap8jWhXQc5c4Zw21/JL6WxKSpASH4QovpqphWMCfeHfXRl+fbo/
	1zBJmnNRhaxH1Y53BVgvhjNSPo4PtcPuMT+ke1KjHtkSSgtIwYDkaZYFVtColzg==
X-Google-Smtp-Source: AGHT+IFD2D//hG6hBMCeFSWKnWdmScBR8+/9DZwOHc0uXkeVWeA8HfOnZLz9J/lfwgpLyio/zbkAWg==
X-Received: by 2002:a05:6871:51e7:b0:3e0:aec2:8b50 with SMTP id 586e51a60fabf-3e42aba92a0mr60346fac.22.1762483444119;
        Thu, 06 Nov 2025 18:44:04 -0800 (PST)
Received: from geday ([2804:7f2:8082:6c9::1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41f1ec269sm760868fac.20.2025.11.06.18.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 18:44:03 -0800 (PST)
Date: Thu, 6 Nov 2025 23:43:57 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aQ1c7ZDycxiOIy8Y@geday>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>

On Wed, Nov 05, 2025 at 04:56:36PM +0800, Shawn Lin wrote:
> 在 2025/11/05 星期三 16:18, Geraldo Nascimento 写道:
> > Hi Shawn, glad to hear from you.
> > 
> > Perhaps the following change is better? It resolves the issue
> > without the added complication of open drain. After you questioned
> > if open drain is actually part of the spec, I remembered that
> > GPIO_OPEN_DRAIN is actually (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_DRAIN)
> > so I decided to test with just GPIO_SINGLE_ENDED and it works.

Shawn,

I quote from the PCIe Mini Card Electromechanical Specification Rev 1.2

"3.4.1. Logic Signal Requirements

The 3.3V card logic levels for single-ended digital signals (WAKE#,
CLKREQ#, PERST#, and W_DISABLE#) are given in Table 3-7. [...]"

So while you are correct that PERST# is most definitely not Open Drain,
there's evidence on the spec that defines this signal as Single-Ended.

Thanks,
Geraldo Nascimento

