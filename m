Return-Path: <linux-pci+bounces-7618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194368C85B0
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457F71C22EE2
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C593CF74;
	Fri, 17 May 2024 11:28:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A741A91;
	Fri, 17 May 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945322; cv=none; b=k25ce0UT2O3lx4GRkEnptGBTgx+mz3o+v4aPM9zHT/JrITyuW7GxWisgcEldSA6V++pxXJA1rh3oNGp1vRvC2XfD0LKR9t0/7rT6EUIaMjCsXCrQ25xaXBgkkacxvzU8GKCCOKmzlkqOOa/rXILpk6bp/V8/HGUlcI1Ln+KPUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945322; c=relaxed/simple;
	bh=MOlfvlG/28VbmFZOFyPcqXJdcaVWt1Be9k2UUTaYKmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCyDDQPEeAFfARAt6Lp4mxIap0RXpoquWL4QpeBeUBiDE8p3Z6Jg7n3dCyjcTtNhBfuKImPWXAoJ43Roih+jEhku82qBWYbp1j0aujKtKVx4YkveIL3uGN+OS1UANHyWSJFJlDlAFAdVQPoPluyrq38FIQI6L2N9SKM1V/DxhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso4513045ad.0;
        Fri, 17 May 2024 04:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715945320; x=1716550120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/VzM2K19gpP7DtzQSnUBbSooKbYSd9MHhWTzEldclY=;
        b=k1bhfhbKzKloevKFpYkwZ23cyMqkxqm/XgykM2WxzhNx9npNYrnT37wkH24jzLh4pf
         5OB8nYeQ4w+t2yEEaiNtfsz562Hy7iGvCyQBM2Aav93ToKLGy5f7yeThAUc+UG+ItYjc
         cWn2OhkZ0+dFADrS08aNp1T0fSCwtPlRBUooxCN7e4kUSqjLMQdL5dkB9lZrZwdeLSf2
         EPaFK56w2vdOcX10g1Sd/z/zZljtyTQiWV7Dd70Ay75+5oRCpNSqoj0a9O114xu86nhk
         C/+ieubF2TP4sw0h4gPiTZHRwKV8ioQW0WcxzXCPLkTVNE8/7oBn6KSIBC+8gE2PDB0D
         0SDA==
X-Forwarded-Encrypted: i=1; AJvYcCUO0PrSBLpM5GJXhdwVDhr0uScoqloBX3eUihppmU+RtnYUMrVQbfahcHSoHrc2NF61UB0RkYchLIlh4XvkSCAfdTojMtxzluKv35YsuaFTyHgbq8EfiO8QS8FbkzCWo66JFpGopy1H
X-Gm-Message-State: AOJu0YypBKGZtytZrcrWY75WZaxNSdSnisGR1BxP5EmWmZmhB6fMjyTJ
	MttBnvDgs8brIAfvrcdnWThejwW7bDuA66vVmSupAp96YHmccY6Q
X-Google-Smtp-Source: AGHT+IE/Un83bPzwhmNVQGr25Y+zvb+y67UV9IonvwRucjCGT6y2VPztfcQp+tR2GZDjFKnUMtWJsA==
X-Received: by 2002:a17:902:b607:b0:1e5:c06b:3330 with SMTP id d9443c01a7336-1ef43d29b42mr212337995ad.24.1715945320503;
        Fri, 17 May 2024 04:28:40 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d97e9sm155088595ad.17.2024.05.17.04.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:28:39 -0700 (PDT)
Date: Fri, 17 May 2024 20:28:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
	u.kleine-koenig@pengutronix.de, cassel@kernel.org,
	dlemoal@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v7 0/2] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <20240517112838.GY202520@rocinante>
References: <20240328085041.2916899-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328085041.2916899-1-s-vadapalli@ti.com>

> This series is based on linux-next tagged next-20240328.

Applied to controller/keystone, thank you!

[01/02] PCI: keystone: Relocate ks_pcie_set/clear_dbi_mode()
        https://git.kernel.org/pci/pci/c/390f4969f26f
[02/02] PCI: keystone: Fix pci_ops for AM654x SoC
        https://git.kernel.org/pci/pci/c/9e6ffee1f846

	Krzysztof

