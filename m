Return-Path: <linux-pci+bounces-9389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA491B2DC
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 01:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5631F21AF5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE31A2C35;
	Thu, 27 Jun 2024 23:35:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E579199E93
	for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2024 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531356; cv=none; b=l/6cX8FLNGJAEz74XsUntYR/VFOka/b+rBSOkkeU2vYPvaCYp30TcuiHBasH6WSLSBySKi36zABhtPP7nJpHgkjJhr2jqCo7vRm8mlLOxnn1g83m/kMphDPFx/Mol50snHu5TSH7Y/bmwhtKLvBo3MvsFg8qpwUdGFEPGhhJX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531356; c=relaxed/simple;
	bh=TTfrkGhsHfdBbdcp/G+SzwCXu5yrYsLB7/kylQj08Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFJexsXqj4tMes4m6Ewx1U+xfh4vH1uH9m6E87Ut6ctKMbLaIpW5FBmqvpvktnBje1hMKckqH64zzGwYw4uxP7j5oqJwPHOrJcKuLACVt0ujySsXhG+PreT/S0/zNitl/mZCMuQnoSvG1xw3HMwBfUVbC3BDWoFRWDCRB63AO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7041053c0fdso34380b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2024 16:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719531354; x=1720136154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uAAi9hSjvhkj8Fz6cbOK9vsbAahVDyW2BIq3D7Szog=;
        b=fJU9W2z/i+I8FXU6psve6ra3r1KgtQzQNQ+/Sx2NvI0js+yJ21WrSC0JnK6oahIcun
         uoN1ZL1Xkspj0OIwBMdr/PJqgC6bRKLqsvlOo5p5cAMpLYZA7kRVybcq6IWchd9Lmt68
         mA8cGc8Zfebp+RB0aSML3VkdxrgAXXa01wtI30iTvx/MB3xYLTZJc+a26uk3uoLnkHbK
         UEJAZFTQ1m9SIDy0snyi1NzgMKxY1+EZNracjZYvtkSWHQadh8zN4jrxmhUmvcmLeRb3
         1EtnqJjYVHqXLjluhCTspKONuCxE/FwKJ0HWThoWNRyoYiSHkenqCcgA1vnUbyjM5ScG
         RVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRSo8SUKlJ40X0b2GtfnqAN2i8cnGnhMIIJUlkxcCixJfXMkU5Q16YiMrugELUdvbmboTcjJI2aVN9PZBO3beVw+9DxKAI7SPG
X-Gm-Message-State: AOJu0YwzLeovgKCbKAGEsKgx8cb+KfgAqnq2iWeD38s/wUkWTBMDkHRM
	MaSW+bqI+MraS5ZHHKYD3v2o/G/XsWbS7y7tUViBr6uZZ/5pPCSD
X-Google-Smtp-Source: AGHT+IGPlcAWf/xqjRnZ77afeo0B4/6Q6ymVktQiLanNG6hRIJMaXx6RX21txgUVpmSoxpxiFgQG5A==
X-Received: by 2002:a05:6a20:1590:b0:1be:e3d8:1a85 with SMTP id adf61e73a8af0-1bee3d81bbfmr243655637.36.1719531354527;
        Thu, 27 Jun 2024 16:35:54 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc5a1sm349417a91.36.2024.06.27.16.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 16:35:54 -0700 (PDT)
Date: Fri, 28 Jun 2024 08:35:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	kernel test robot <lkp@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Depend on PCI_ENDPOINT if building
 endpoint mode support
Message-ID: <20240627233552.GA2060184@rocinante>
References: <20240626191325.4074794-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626191325.4074794-2-cassel@kernel.org>

Hello,

> All DWC glue drivers that "select PCIE_DW_EP" also has a
> "depends on PCI_ENDPOINT", except PCIE_ROCKCHIP_DW_EP.
> 
> Fix PCIE_ROCKCHIP_DW_EP so that it depends on PCI_ENDPOINT.

Applied to controller/rockchip, thank you!

[1/1] PCI: dw-rockchip: Depend on PCI_ENDPOINT if building endpoint mode support
      https://git.kernel.org/pci/pci/c/d7a8b355112d

	Krzysztof

