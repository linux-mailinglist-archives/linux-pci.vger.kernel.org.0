Return-Path: <linux-pci+bounces-11852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFBB957EAC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 08:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1449B1F24E1C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 06:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC71A29A;
	Tue, 20 Aug 2024 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa+TIK05"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF9218E36D;
	Tue, 20 Aug 2024 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136768; cv=none; b=aPCKZdWtaaC0ZGxHYFpc15XNXJYPlh0PS6xhyse64gQUe2l4vkF0GEWDqniaN8fMt4MWsJOLAdPTyxEdPaH1ykeHKcnxAiWNq4OC9X+IMPaUnxofKrCHeklBvXcJN+9jBLcjm8P+S2Qyln/FNthzhlmN4aIYta9qUxoFmj6pWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136768; c=relaxed/simple;
	bh=kWsd6UbBrZMTLutzNp0qbaqrK9LVosbs/UMeb/ewGpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK3dtsLO5rYZtpJlsLgtqNHP+fe+lMQ/kNYfjznBsJwo0vOvik0KINUt93hXWDtTVBiCmc1wJDs/iBxjk0dd98XceRWs5J+RF1SZtRH8nr2NwBNfbYICCAWqe7Z344eZ9u6tpLKfvvvsInUVFgXdI2g6tc91kpahC7i6XfmCjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa+TIK05; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53310b07267so6791741e87.3;
        Mon, 19 Aug 2024 23:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724136765; x=1724741565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0fnzpeczoVILcPKkO8zLBXL0D6BHapuvSYzKwE9Niw=;
        b=Sa+TIK05uMAJjp19pOShP1R4m+OROacmxyfs7yANjXv/fg2QiARMUougfNtpBuH80L
         n6oDzOz88S6pWvzM8Et4HNcPve5m/ODMdotUHauZik4FGNt4wnjMPFVE+alEMSyqmKpy
         Mk2AUfBfPwKHOE25AkOM1pBxY8zRO64qNkjCCt4Kvj61pLy3O6YvQ7xt24vx2tYxzcrP
         F2HYui4SIn45jNwMeo/KUyvTmmFc7oKUSlSuLfRjE2jEVGEwbSdPjdQMi16gWdoNHy9w
         qq2hoezAsbhZWQXn+56HXhzUzJuCm/iOy+akn8xKd86SGfWIXBdiOaREmj7f2aMhB64I
         vGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724136765; x=1724741565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0fnzpeczoVILcPKkO8zLBXL0D6BHapuvSYzKwE9Niw=;
        b=b+lG472WEgYTc0uXUWniAmS2LWFtp8Oq6n0OF/CsE0QgfVmXUJi2hc2tPV7llY4sIf
         eXJs2YV08NYeUNaqnLT2C6YzFPmnrrJaftZT6+ZnT2nNejmcQ2ufu4ITN0Y3b6e0mq+H
         cVleec5fnISnpZS24U9qbcW9apO+J/LqfWgcAJHmIs00e2Meqif4+g3xiWw7KVV12NEg
         AGizgbGFUuya0ss1O8hhkHlZE1fMmbo67Wj9uCL+7GIUWPe36DHTnKcR/BYH7MO6xmFW
         nEP7OnGdoGA7Fust+NhQXSEXpNWc8ivwS8VNkPnL9DZhNQCk1+di2WxBA0tAHl1EgbGu
         fYeA==
X-Forwarded-Encrypted: i=1; AJvYcCXb34MRCv0Z2Ra0dH+Udaxq544wgGIWDD6pEwxtQ4zeFqxmy/h78Sq4WigKU6puj6+B5aeZi9MP4i3k@vger.kernel.org, AJvYcCXin5jl0lVc7xjJuwAjEpBlTDjMd5B09vUvTs3FEDMYtErXhi6fb7+pwUMB53gip1LQnz2xmQFMqo2W9F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJi4RJxHbyfjtbBMM9KqUAx3tsnio4n70Hy4P+hOjpbQSpPLpe
	/9+h5rIKmc7oUGuWXCjPA93O5M76TQoSEodCLADid9wF8SPKs3OP
X-Google-Smtp-Source: AGHT+IFovNs2nwZnc1lJwCKr78P7Vc8jgqy02le1EmeWWeioP/zLobADP3e48VyNL9RyjxcDN+vlHg==
X-Received: by 2002:a05:6512:3da6:b0:52c:e119:7f1 with SMTP id 2adb3069b0e04-5331c6e3b3fmr10786119e87.51.1724136764869;
        Mon, 19 Aug 2024 23:52:44 -0700 (PDT)
Received: from eichest-laptop ([77.109.188.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394645dsm728973666b.144.2024.08.19.23.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 23:52:43 -0700 (PDT)
Date: Tue, 20 Aug 2024 08:52:41 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] PCI: imx6: reset link after suspend/resume
Message-ID: <ZsQ9OWdCS5o96VN2@eichest-laptop>
References: <20240819090428.17349-1-eichest@gmail.com>
 <ZsNXDq/kidZdyhvD@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsNXDq/kidZdyhvD@lizhi-Precision-Tower-5810>

On Mon, Aug 19, 2024 at 10:30:38AM -0400, Frank Li wrote:
> On Mon, Aug 19, 2024 at 11:03:16AM +0200, Stefan Eichenberger wrote:
> > On the i.MX6Quad (not QuadPlus), the PCIe link does not work after a
> > suspend/resume cycle. Worse, the PCIe memory mapped I/O isn't accessible
> > at all, so the system freezes when a PCIe driver tries to access its I/O
> > space. The only way to get resume working again is to reset the PCIe
> > link, similar to what is done on devices that support suspend/resume.
> > Through trial and error, we found that something about the PCIe
> > reference clock does not work as expected after a resume. We could not
> > figure out if it is disabled (even though the registers still say it is
> > enabled), or if it is somehow unstable or has some hiccups. With the
> > workaround introduced in this patch series, we were able to fully resume
> > a Compex WLE900VX (ath10k) miniPCIe Wifi module and an Intel AX200 M.2
> > Wifi module. If there is a better way or other ideas on how to fix this
> > problem, please let us know. We are aware that resetting the link should
> > not be necessary, but we could not find a better solution. More
> > interestingly, even the SoCs that support suspend/resume according to
> > the i.MX erratas seem to reset the link on resume in
> > imx6_pcie_host_init, so we hope this might be a valid workaround.
> >
> > Stefan Eichenberger (3):
> >   PCI: imx6: Add a function to deassert the reset gpio
> >   PCI: imx6: move the wait for clock stabilization to enable ref clk
> >   PCI: imx6: reset link on resume
> 
> Thanks you for your patch, but it may have conflict with
> https://lore.kernel.org/linux-pci/Zr4XG6r+HnbIlu8S@lizhi-Precision-Tower-5810/T/#t
> 

Thanks a lot for the hint. I will have a look at the series and see if I
can adapt my changes including your suggestions.

Regards,
Stefan

