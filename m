Return-Path: <linux-pci+bounces-7592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB9D8C848E
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97AC284587
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70932D044;
	Fri, 17 May 2024 10:09:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9332CCA0
	for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940573; cv=none; b=icVWLVtG99ZnqxwJWP23/D0gmnyWw5G0aXhoAMKPICSeJ5iEppVyBCJhnWPyCmC5UQ2kKXEruaTGD3SMwGYnBglHg+2MpT41sEprH0uVosRKFVrQAUNR2iLO3gGt/1uPEz/obPpGtW2A/+guPOQhcl8mytx4FyG6OInJr/0HMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940573; c=relaxed/simple;
	bh=soJgA1MDbpUupUh8ZaqPA75UxD4xvaG1iYUQK/A7H9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMjRlgxdZBanWksHxZczl3LRPEB96tvKnw6zJMx5Z7IdV145QqbvlzIxXUkUTo/pe3ndGlhsorkUkcFr/acUYj9Amo7rul6iejfzqterWAxnq9xB7BNUy3jD5Lb0VV/t3Rl05ievjGKBOLbmC04dcuT8oB18AhBdpNl8FCPkCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ecd3867556so4123305ad.0
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 03:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715940572; x=1716545372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOh9BJwyjcqvsPvV9EWnG2hxXtpF7Qd+qqUKu5/+wHs=;
        b=ByDG/1IbcI8TSR5/6MY7g3+le+sYI2znq7QCy6T3ZTtbHcVOJ2W2vzymdNrbu+E3kT
         QwqzJABRIi3864dkt2cURUCy0p6MlrMa+NSu0WK9wCbkVE0yqHx0WKyLSY1CNBLq2GXV
         +S/YgBKZGpQuI3CyQORboLWHvFtpGUwjVReDXkPMwyUlArtBGB4ooXeW06wCLLmLMhTd
         gV2M3LOCypZO7aSfbBMtDJnTbAq1LzWCfd3uRrZnq7L98UZmkr0vg35DwtACWsFmSp0/
         iE2/uoFD2CuSpTKWOudWD0Ap6jZ1Qed5h+4BeuZPuGSs0m29i6vTaIpz9tuyvCddJ/x0
         336w==
X-Forwarded-Encrypted: i=1; AJvYcCWBJQcLv18rEYDSUF/p96qRpIrOOkgr01O2nj60RVRTvN1BbTbHBjBaU0snsTFLSTSCIgDpc0KZpzsqzp0FoFNsuvlnMMA5zEGS
X-Gm-Message-State: AOJu0YxSiQkQqnZP000JPjGXbzdTxuYpz8d/V1mVu0zMvB3IRarF7WDn
	aPW3OIJkGcYWPT3Du2qcLeGVZ8vB6plrES5MsawzoOSzqyQm437L
X-Google-Smtp-Source: AGHT+IGgVCpmawCMyEVCMuhxDu9eXSqEekhFZ9I9z5FVk7/0Cel1tg2pisRYWTDu0sxLw59SShhvYQ==
X-Received: by 2002:a17:902:d48f:b0:1eb:5a92:cabf with SMTP id d9443c01a7336-1ef43e3484cmr273308795ad.41.1715940571595;
        Fri, 17 May 2024 03:09:31 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d3b67sm153600215ad.10.2024.05.17.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:09:31 -0700 (PDT)
Date: Fri, 17 May 2024 19:09:29 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <20240517100929.GB202520@rocinante>
References: <20240322164139.678228-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322164139.678228-1-cassel@kernel.org>

Hello,

> The current code uses writel()/readl(), which has an implicit memory
> barrier for every single readl()/writel().
> 
> Additionally, reading 4 bytes at a time over the PCI bus is not really
> optimal, considering that this code is running in an ioctl handler.
> 
> Use memcpy_toio()/memcpy_fromio() for BAR tests.
> 
> Before patch with a 4MB BAR:
> $ time /usr/bin/pcitest -b 1
> BAR1:           OKAY
> real    0m 1.56s
> 
> After patch with a 4MB BAR:
> $ time /usr/bin/pcitest -b 1
> BAR1:           OKAY
> real    0m 0.54s

Applied to misc, thank you!

[1/1] misc: pci_endpoint_test: Use memcpy_toio()/memcpy_fromio() for BAR tests
      https://git.kernel.org/pci/pci/c/9ff0a8cdf12e

	Krzysztof

