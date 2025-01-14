Return-Path: <linux-pci+bounces-19705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6967A0FDBB
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 01:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECEB1888FC3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 00:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA935280;
	Tue, 14 Jan 2025 00:57:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0F22EE4;
	Tue, 14 Jan 2025 00:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736816262; cv=none; b=UaUmxb5Zd1XMcb/W+0hORxPurdcDr68dXzPzcHtkIOf+67SwZkgarLMVoV5Vqdb4fs1yEsxif4FlwQZp8EOc/EK7zuy2ahSvI3Y/zb8le5k2Ui53bYwDcE+Z200ol8CtpkSa6VFGe0/zbG/PcKEfBdqurgu6x8QwsEvnle7nSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736816262; c=relaxed/simple;
	bh=f1Seb25/f2pGhxtxOkobWtROy38R2mi/Oio4vFNa7mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugMo97UD1DLnRCaRBaSY3x00V+KqudFNSavN93xrd3XZtrLIJ7suUarXpBKRYQmVo+IQs2i9l9J/VsHkBsePCp3rhxhnzzZkos/8povdO2IxC/P+ZLdbL7HyKfRPyrvRZmtw08OEBDY1Dp6L+MXBlPAcNtXejBox7CSnJyAC6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163b0c09afso89699725ad.0;
        Mon, 13 Jan 2025 16:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736816260; x=1737421060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4sWIJUZXzedQw0C3f0Jzz0k+vKMVBflYPi7Bxanx6A=;
        b=l8oSiwJBAZvwhGI/gUiCkrQCcc7teKGhmyhPKf+CEOJEtkkMIs8BUBKQ3ArTYGtJX4
         9mPWBrAGFHuBLkuxNmmmpTVQRyB1qdCSZB8zJAZCZfWaomooMgdPEf9tafeZd5VATo3+
         wMNC+n3z0w0K0A3Faywaf4mPkokGs2CV/gRvfSmRvCCSLo/U2Xz6j0h0g5suFzfEYfR6
         HxZnEosmTsNBinSNTMVfYdMnvg6qmXRNumWIXuWcbgjtXfaodBWngP8sty2c3IgOiCH3
         xWYFBHGHGr2IYDNuPHByjfNVyaK7rySNRlaTyHTmZbk1PJApai55pD+ELKYzDAoXglb2
         4yiA==
X-Forwarded-Encrypted: i=1; AJvYcCVWl5nNUkpsna7tj8gXtA6AKaqxI27ud6rKMrr7UM+KUeImLF2MTvuYJMKTWy4hQO2YvMNlDfyg@vger.kernel.org, AJvYcCVte+MlFt1qfCWoVtd9s00BzKzjJazjGoRScgsyvV9bvb9LWuvrYtQ1BBppg9KOPVtcQBfyTGVP02ln3lc=@vger.kernel.org, AJvYcCW+duR2JbxbBkIs7CtDxixbQmyPLX3+FS0pF3aH+UFjAiPEGgtJgZG2Awpcmr5W/57WKw9LMsK1BU2P@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4a9lil4BTWNuw22GTr8c8MQKvisurbbN19wGcNQ9I03Rwyk5
	hEmL1Aw8mUdjSu9Ued2l3b/AXgxekzSX61PQWcMI1dBaR7hejNVi
X-Gm-Gg: ASbGncubuKG7PjtWcAhNa6wu1iNmAp/V20nkyXuuJZm+KInkjXJ2Q8L8ZO4Jsv8v0pP
	pnMdYVhjx2CQh3Udtc0Ts4OoBlwBKx/r3IDP+D0qg7yGtsHHRmd9HD7DtdQB2UnN2sCcm9TD0I+
	GjKvATpmxjtgpMgkQwNYFreb/AkWSpThKnYrZb5ZtMR7BMw0k7yc70NK3nEgCeQWtTLT3Muq+mH
	zFsSv4fzTUQdrgFKyMCYW8UiQ8//y19bUwsvBhqe+oHy2W3LU5LjyeMLLigRumsWN5vobSiMHe1
	GYIJYWhnEDaow88=
X-Google-Smtp-Source: AGHT+IFrCWbROxxZdCtV1Duds4GjExTHU0qQPYzNJ1/rf0saUHL5RugKwDmCGXLAmp8SJ2T6hzUvJw==
X-Received: by 2002:a17:903:244a:b0:211:fcad:d6ea with SMTP id d9443c01a7336-21a83fcf7a9mr350087285ad.45.1736816260402;
        Mon, 13 Jan 2025 16:57:40 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12f919sm59001105ad.69.2025.01.13.16.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:57:39 -0800 (PST)
Date: Tue, 14 Jan 2025 09:57:37 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: lpieralisi@kernel.org, mani@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jpinto@synopsys.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix a double free in __pci_epc_create()
Message-ID: <20250114005737.GA2004845@rocinante>
References: <20250107074601.789649-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107074601.789649-1-make24@iscas.ac.cn>

Hello,

> The put_device(&epc->dev) call will trigger pci_epc_release() which
> frees "epc" so the kfree(epc) on the next line is a double free.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Which kernel release did you review?  I don't see this kfree() when looking
at the current code base per:

  https://elixir.bootlin.com/linux/v6.13-rc1/source/drivers/pci/endpoint/pci-epc-core.c#L956-L1020

	Krzysztof

