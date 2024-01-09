Return-Path: <linux-pci+bounces-1862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9FF827D6D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 04:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893F6284C52
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 03:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E599D3FFF;
	Tue,  9 Jan 2024 03:42:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650479C4;
	Tue,  9 Jan 2024 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6dac8955af0so1076512b3a.0;
        Mon, 08 Jan 2024 19:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704771722; x=1705376522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRtasBW72KfoDwZ/WxCb0AK88cwbM9CGvhgyqKmj2qs=;
        b=oBJAecOx7AA74JCFSt03I2pARts5YSFqLgkYpYI3rauTHW5qM4zqRbFkqcRLNJCpqY
         ImYIFnWlPL9iV5DUrViCVui1quqC3bYY3PPMrSTOZxbxg/cNvYb99QMU6TTCno9ovlNa
         hsAy60H2zBhsaOtMetEDc8uTaiSnCiDPpXjx25AsfT3eRKAWyEV/NcnG/yj4hNnuPCL4
         C/cKo+1wyKVqJGuitWBujN22qoUF3IQLMJhjkIqmWibMSBi7b8XWenQdzknNpkNv2pwT
         i+cP7u0UEKszKvhPhEvAHiTqtCM3XrlRfOR6OCcD/dPcLT4UiHKVGABW479brZkUM9hO
         vHhQ==
X-Gm-Message-State: AOJu0Yx7zcMdbOdmHIrVjqKDFG3X6Mz/l9cts/8dfOk+Ozl15Sx4M859
	d6DZtZevG1wnNkknRSwDbA0=
X-Google-Smtp-Source: AGHT+IHchAv9sUUY0pJ4PrEniWjBi8YeT0i2qc5gw9KP4S2TS/MsQ6NTHv9pqKerKBoV9HB7dpFcKw==
X-Received: by 2002:a05:6a00:3a25:b0:6d9:bf50:1c94 with SMTP id fj37-20020a056a003a2500b006d9bf501c94mr2546935pfb.9.1704771721845;
        Mon, 08 Jan 2024 19:42:01 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id kt3-20020a056a004ba300b006d9aa04574csm603224pfb.52.2024.01.08.19.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 19:42:01 -0800 (PST)
Date: Tue, 9 Jan 2024 12:41:59 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ilpo.jarvinen@linux.intel.com,
	vigneshr@ti.com, r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH v3] PCI: keystone: Fix race condition when initializing
 PHYs
Message-ID: <20240109034159.GA3301517@rocinante>
References: <20230927041845.1222080-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927041845.1222080-1-s-vadapalli@ti.com>

Hello,

> The PCI driver invokes the PHY APIs using the ks_pcie_enable_phy()
> function. The PHY in this case is the Serdes. It is possible that the
> PCI instance is configured for 2 lane operation across two different
> Serdes instances, using 1 lane of each Serdes. In such a configuration,
> if the reference clock for one Serdes is provided by the other Serdes,
> it results in a race condition. After the Serdes providing the reference
> clock is initialized by the PCI driver by invoking its PHY APIs, it is
> not guaranteed that this Serdes remains powered on long enough for the
> PHY APIs based initialization of the dependent Serdes. In such cases,
> the PLL of the dependent Serdes fails to lock due to the absence of the
> reference clock from the former Serdes which has been powered off by the
> PM Core.
> 
> Fix this by obtaining reference to the PHYs before invoking the PHY
> initialization APIs and releasing reference after the initialization is
> complete.

Applied to controller/keystone, thank you!

[1/1] PCI: keystone: Fix race condition when initializing PHYs
      https://git.kernel.org/pci/pci/c/c12ca110c613

	Krzysztof

