Return-Path: <linux-pci+bounces-9450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0B91CEE3
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 21:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1FF2824E7
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 19:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890780046;
	Sat, 29 Jun 2024 19:49:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400253C36;
	Sat, 29 Jun 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719690548; cv=none; b=ZaroJdGzydBOYAZOkL7h/+0gnPYGFeKwNSZDtlFoKeLXXFu26tFlLgSjj6CjEbpIPbSVjWDXIqei6A+1P7gLR4IVKO2/shRLfaP1DfETB2BaQA8XTUKDidYMWOSPpBucv9h+GRvNGGylJSAJg8PfjP34IlwJ9ePO+bCkeaiem5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719690548; c=relaxed/simple;
	bh=s0iFXmCuJ5OUQYhV0hinv2WKZyxMdoCEOoBzwlM0Gow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhlMf1u8gEXG3qFtvV8+2dmErrL22ALV+DVMjKzfffOi+SLD9oyz3ADgEdMYPmMf2iDf1k4Pznl+7XakvSFYJNdxJx4GrrJxm/411XlXfXnM+IO0DQx4Irx1zfyQ8IjeJFidU2ATyH41UDVbyF+lHqhds4YKP6tpAKsoNx4o/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9b523a15cso11330135ad.0;
        Sat, 29 Jun 2024 12:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719690546; x=1720295346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm8MJ6CkkuKy6+9wgIanxhphjAatz1s4taxVZaX9p5I=;
        b=W5JgfGweaRYdAJEr3XI+aViJzCyCEg7T5R1l8ESeZ2namC8Si0IPebARD2NEXjZnDo
         eTzoLrZ1/8arzFpklj6RsTWr5dGHqhpYSqtyFM3FnhVdqHHqccfFMoza6q6tZDGjLMHi
         IM49Ak0tBEnYt6+yC6CnRfxAd7fLR+V95jK3gtVT/2KnV7LIlbfMfj5EKpgqZyx/Lj8G
         /T+Cy5Elv3mLtfjH6uMXn6nzERg/1y7TN5Lc4HzgFikwrngBy/9mdnLBPn/+Ws2uP5R0
         bgEHPd4ivDg6Y26VDwO7d3AP0QnGWFAcaYc/AyZhlIw2kWJaN1dRbwgfslYv2Xtz8qJI
         Lhwg==
X-Forwarded-Encrypted: i=1; AJvYcCXgzZ1sy61Yka91a+7tQ/lXSMntD0tnyM8kKQ+v322/iDQR2K8foCQHfp55atuRh8/h+3o1+okm63tquQSOkzHDYZcT2zcmOMM303dkDCc9uluG9rfoOAzxpzmfuGRP4p6/V05XUC2FVjOWeZI=
X-Gm-Message-State: AOJu0YxU/12G5aRTAw+wCRsmD+421MfChjF2MXLB/XFtVO60y5kZEbvk
	PSPPkmfs+cWezCDqlIN61ItTXKDSrYQpd4bPM8OxAm7/SpZUg4HBkaa+qqfLX/0=
X-Google-Smtp-Source: AGHT+IEfn/yxe5V4anOCNHK0sPGfx5JLT5AP+j2eqTaebyRcpcMFznMQoDzy7EFD1J//fVkPrttRpQ==
X-Received: by 2002:a17:903:22c3:b0:1fa:df6:63a2 with SMTP id d9443c01a7336-1fac7eec962mr78022055ad.23.1719690546337;
        Sat, 29 Jun 2024 12:49:06 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8f5csm35795815ad.7.2024.06.29.12.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 12:49:05 -0700 (PDT)
Date: Sun, 30 Jun 2024 04:49:04 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 0/5] PCI: rcar-gen4: Add R-Car V4H support
Message-ID: <20240629194904.GB2249818@rocinante>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>

Hello,

> The pcie-rcar-gen4 driver can reuse other R-Car Gen4 support like
> r8a779g0 (R-Car V4H) and r8a779h0 (R-Car V4M). However, some
> initializing settings differ between R-Car S4-8 (r8a779f0) and
> others. The R-Car S4-8 will be minority about the setting way. So,
> R-Car V4H will be majority and this is generic initialization way
> as "renesas,rcar-gen4-pcie{-ep}" compatible.

Applied to controller/rcar-gen4, thank you!

[01/04] PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
        https://git.kernel.org/pci/pci/c/544a18c936f9

[02/04] PCI: rcar-gen4: Add struct rcar_gen4_pcie_drvdata
        https://git.kernel.org/pci/pci/c/ac1d89f8dcc3

[03/04] PCI: rcar-gen4: Add .ltssm_control() for other SoC support
        https://git.kernel.org/pci/pci/c/2c49151b3fff

[04/04] PCI: rcar-gen4: Add support for R-Car V4H
        https://git.kernel.org/pci/pci/c/60ad25bcac1d

	Krzysztof

