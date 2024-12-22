Return-Path: <linux-pci+bounces-18943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7542C9FA842
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 22:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EAE165918
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9612F26;
	Sun, 22 Dec 2024 21:12:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EF2259489
	for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734901975; cv=none; b=pZOVoUFw/bTb6SlwCvf+uYPFjt9TcuWQzUz3eMyfYGSYbPV/6UN5wrAwC/dUUjvAmeepFfjbcuq4uGNus7HunmmRn0tU7U4xCGPN04b5L93jEM8MJGciXm8cbGNmL3lFKvMzN2fFs1YUEz0vxYgjAA9xYjYPPjr8QH4wu2k/4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734901975; c=relaxed/simple;
	bh=euXoceb4gwHRBuG7lkmHV/Nx9Gj0PEUCwS7T/WoZH3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEMtl6AqGhDbLk5W9G+bDW07InPU1nHei0CdZ8Ib+55nYVnfUf1z+k44ktHJXjxwg+rEIQprSivF8FN6HMrWfe1xwI2uyiWgWT60x81WXU2jikVrKpTmm7g4jz/Rvh0OTf1fy0TUtU33HnpKj86jVnu7hUpYhOoJhkehSV2wRNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728e3826211so2776430b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 13:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734901973; x=1735506773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nzvl62NemkCu+bJQO3dI4ZT3Tjpx9yRwIHAXjwaQB0=;
        b=t3pYYhma0Gjf34SA9GSYqm057hdWl0s2sj7Y1zGverSwEMTF5KCABu6Q08ZVIMFr3n
         w/7IHdDuFwSZuGc2WMdPrlBRdCdLEoXomn3jegUSRqdLRjo/6z8bkW9sq/sy/4QQ3HW1
         ExMuZmomr3TXKlGG2go+AavipPkfcCrnnPvVhOggoIlrK3/RiJGEbrr+3nNIsUn+LvQk
         Ak9IETSdENqahAW5lgei5/eL3eAreU0syKVGiljgTVrQP8t/Zny2Jz5X+kmmogWxNQzv
         AuZ55prx5Ss3nAeIpdcQ8v1AFjbsL5HYzmMACtbw2qvJzKanD6bqiEctSqsyJvC5/wdK
         o8Yg==
X-Gm-Message-State: AOJu0YzQYA8u5bxIn3138BQEEJfSTpAsiDNzvCu155/I24JUTdtJ9dTF
	ctG4A/TScGtknCkLqZYjfQ13dQEGoEyu27oTnZiWdxaeXQtFHIC3
X-Gm-Gg: ASbGncsJ/aDzH50K7lSuY3mXex/TjyJ4wStqTUV21gEOZiERTQwqlvTD1GWHuFBxkjG
	KFo673sqLQy9n78JqM2kbLCk0XWxPwNHB3WYuNxshYL6+fqm9x+BGtqlrj7SYjqooMLysIDXEAS
	YW6Xq5l/eMLOQfUSo9M0wHnJ17tEY2i9lQWQ7s+Hb7TGjZ09hcqoJopsSUPcL3rptusi0+0334k
	VCQaMhCncDVz88U/IDMoSgS+MdPowgR2zg+uVL4AUML5d1vEJ3ghd0Q7erO95d5ZMWNY1R0fsQA
	iZb7EsaXCcREtGo=
X-Google-Smtp-Source: AGHT+IErdLVbT91Y8xdodtzbGYp47xdM6dfjrmekMVbOB+gxJ3TjSD7pL0kX7djpwKnV3LgclN8Q1g==
X-Received: by 2002:a05:6a20:c88e:b0:1e1:b12e:edb8 with SMTP id adf61e73a8af0-1e5e0803e53mr18165975637.30.1734901973006;
        Sun, 22 Dec 2024 13:12:53 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842dc604e58sm6056406a12.60.2024.12.22.13.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 13:12:52 -0800 (PST)
Date: Mon, 23 Dec 2024 06:12:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2] PCI: rockchip: Add missing fields descriptions for
 struct rockchip_pcie_ep
Message-ID: <20241222211250.GD3111282@rocinante>
References: <20241216133404.540736-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216133404.540736-1-dlemoal@kernel.org>

Hello,

> When compiling the rockchip endpoint driver with -W=1, gcc output the
> following warnings:
> 
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_irq' not described in 'rockchip_pcie_ep'
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_asserted' not described in 'rockchip_pcie_ep'
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_up' not described in 'rockchip_pcie_ep'
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_training' not described in 'rockchip_pcie_ep'
> 
> Avoid these warnings by adding the missing field descriptions in
> struct rockchip_pcie_ep kdoc comment.

Applied to controller/rockchip, thank you!

[01/01] PCI: rockchip: Add missing fields descriptions for struct rockchip_pcie_ep
        https://git.kernel.org/pci/pci/c/220bd83f9da1

	Krzysztof

