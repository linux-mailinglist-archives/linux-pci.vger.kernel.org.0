Return-Path: <linux-pci+bounces-4698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489ED877265
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 18:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21681F219B6
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D991F614;
	Sat,  9 Mar 2024 17:08:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4515BE
	for <linux-pci@vger.kernel.org>; Sat,  9 Mar 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710004116; cv=none; b=IXcyp3VNEJ11W59DzCXha6nmXQ8I7mvRWgaMLA+KqLBBy7UEnmx4z8w1C03LAv2r6L+WjqWiSmnA5HVk1KhC5SrVyGRdyxOGrGaMf1AA7j47EPbxHWJkOi5XaTV9sIijFV43Muuz/6/JUqkISqJZOGLCDH/C1GmIJO5TLtS2beg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710004116; c=relaxed/simple;
	bh=FOkFTVtL1iN9FDZN1jpcFUlwPSZa39N3l+rpDqYXLiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C57jHW0MvI+l7hF6v6Sml7buVfH4vB3BmLvn749O/kVejmytISJOL3oXB/Z2q1Pw3AfCMGT9yDkWRFQwtQaD+fj7sRrzeHcXkNHPsIOFKS7/DUgCuc8Y8WRQvxxMoxQ4stFFTJ+iqkwteWQ01bTjie4dRolo0A9u6lQVXaLwnYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4131b1f8c91so10676045e9.3
        for <linux-pci@vger.kernel.org>; Sat, 09 Mar 2024 09:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710004113; x=1710608913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s50rKyJ4o5gQNkVDulGntboGrSQ6onReqwS1lbCDDcM=;
        b=GSyZlkNWO3zwYEPNQlmxxVAgo7r6H6D0zNGdZX/dMAE4JP+bEyW/rot2HFcKnNuyCE
         oOi9jw5GqqeB//Ydtxp6b0FRyxIeDQ5SvZ89nE/S95qGgVROfW+/6rODmULU/y3K/z9B
         cReXDZXN04P+g4CqAc403c3XGxTGccxI/MEmMvnXTgfhxp9pvYcwbNhMxps4BgSgj54S
         RIlFJ96AH2xZyiRHYi7x3Y6ycmLq3JltRr2ILhzABnB+0XfFO8pzmDQs3rFyhNM0109o
         DipfmpFxm9WM9mgyLRTgbdrU1VmVXpZBHujlfmxZC4orO9QD3KtPkuximMEhxuYd2WHZ
         kFlg==
X-Forwarded-Encrypted: i=1; AJvYcCVElKmIJaRujYm9amPX5iaWjEQYuAyeECxya1/BxDJIPWCdwfjrgJmNNJl45Dg/f0HeM/4VowYmcc13T7igLt8DKss+LRzfouZK
X-Gm-Message-State: AOJu0YxmmPyKhLDRR2MGzGenzw1qElSEnFhNk7Q5MRgSAbmZEEJFkmfX
	ZGwo6x6JLb1MD/Vz1QQqS+9Vc5hHzEI3BM72qn0GaqVglDoaqn9s
X-Google-Smtp-Source: AGHT+IHSVHCbLq8V6uiZe3ZrnT6pkcm4nKluP6syAXCEmgav5cQ9yLKSyLrflt/n+0CGl8cH17a7QQ==
X-Received: by 2002:a05:600c:35d0:b0:412:ea4c:dc4b with SMTP id r16-20020a05600c35d000b00412ea4cdc4bmr1864624wmq.6.1710004112787;
        Sat, 09 Mar 2024 09:08:32 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b00412f02bff2csm9637905wmq.37.2024.03.09.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 09:08:32 -0800 (PST)
Date: Sun, 10 Mar 2024 02:08:29 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH] PCI: brcmstb: fix broken brcm_pcie_mdio_write() polling
Message-ID: <20240309170829.GD229940@rocinante>
References: <20240217133722.14391-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217133722.14391-1-wahrenst@gmx.net>

Hello,

> MDIO_WR_DONE() tests bit 31, which is always 0 (==done) as
> readw_poll_timeout_atomic does a 16-bit read. Replace with the readl
> variant.

Applied to controller/broadcom, thank you!

[1/1] PCI: brcmstb: Fix broken brcm_pcie_mdio_write() polling
      https://git.kernel.org/pci/pci/c/48389d984332

	Krzysztof

