Return-Path: <linux-pci+bounces-7619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1708C85B2
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1C81C22EDD
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512DD3CF74;
	Fri, 17 May 2024 11:29:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108DC3D541;
	Fri, 17 May 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945375; cv=none; b=BAkMZfv+f+3QabJkb1GtUPgZIvKqtWnE3BYnrseHCQPgQiexJnMEbqCMx0Dupu1HHmoceau1MlKpmD1QcnIF9lpAdvh0bqgpMKrzQeT/lfI4yN7na+j0K0BMf45HGv6NN1xGotgU3t09I7i5QFW/ajODMk4cY/zE8YUM7UAs8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945375; c=relaxed/simple;
	bh=ZRMJmTKPyB0t+OKgNt95jIX6buVPYN8uYg3tIxBCx+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM0z6HHvi53fzlKIFLFvfq4D1kzudkQpw2yyLdiHMEWwi7r+AYQE2IiOEBIL3j5+BlNtxAKXnkxFCXr9NIb6i/v+xGqnGY4OLZgE5q4Hpw4jFzQwf+DIDuA14Jcm+QLatgK0wzVMohKS5LbsC27C94DyEtffWWYZHhgr53rg2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee38966529so3528215ad.1;
        Fri, 17 May 2024 04:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715945373; x=1716550173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlO9hOsvvWncarTJ6TVIoeOrJIY+No0MzifzoPhfPog=;
        b=hReZxf9kzSt9bOqWAr+KSAVF/MQ01MGzB2L8sWmryZMvnKSO75Ajl1vunQ2938K01k
         89zWRi01W/JpdKn/ojgqYUP2K1O51h5tZwWbKfWUR1BJP2IohxOUTAa24xBbsUGcf7Dy
         mXr0eXGF7oA9RCb46ymbeLhWCWm4hJjFxrEGiT6B7hzeACxqY8FMlEKA3934/AtunQcj
         2mrw7Lm/HGAExdPxV+im90gDJ0m6LQ/EVMhfquJhmTt3IhoreykSrTjWlDeRY3VAqTIx
         kH7IgcG7wmDNYOR5jMHGEcwiW6NH91ZTYYIxwQ4nvXX9uloph9y1QF0lVZ388MLUUnCl
         mVqA==
X-Forwarded-Encrypted: i=1; AJvYcCUxH4h3T2u9fo8/DcG3SfbBt1R5Uekz4nVkg19aStDFf1F+qmd7sZOo4ivaxTSBfYep+58HZ7RenDR+77Jy2L36iBDU9NQPHh8S5cU/
X-Gm-Message-State: AOJu0YzjKxLsAgZOCbH6DERvv46VWrLNtjMK7ZGtYh7jelOqWazGq6Kw
	eUHYbGEkStNfrNuolXbn6Cdi+94FRrfw8M4ik8/QyhVP8sptQdO2
X-Google-Smtp-Source: AGHT+IFXEv9ghbQqSRx2esLmvtTnthat8U/buSvB+ab+E7flOcpeqYIcoK+QbYJeauvapLTXM3Ua+w==
X-Received: by 2002:a17:903:22ce:b0:1eb:904:dfd7 with SMTP id d9443c01a7336-1eef9f34562mr409147175ad.2.1715945373309;
        Fri, 17 May 2024 04:29:33 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c03b2afsm155146735ad.230.2024.05.17.04.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:29:31 -0700 (PDT)
Date: Fri, 17 May 2024 20:29:29 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
	robh@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: mt7621: Fix possible string truncation in snprintf
Message-ID: <20240517112929.GZ202520@rocinante>
References: <20240111082704.2259450-1-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111082704.2259450-1-sergio.paracuellos@gmail.com>

Hello,

> The following warning appears when driver is compiled with W=1.
> 
> CC      drivers/pci/controller/pcie-mt7621.o
> drivers/pci/controller/pcie-mt7621.c: In function ‘mt7621_pcie_probe’:
> drivers/pci/controller/pcie-mt7621.c:228:49: error: ‘snprintf’ output may
> be truncated before the last format character [-Werror=format-truncation=]
> 228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
>     |                                                 ^
> drivers/pci/controller/pcie-mt7621.c:228:9: note: ‘snprintf’ output between
> 10 and 11 bytes into a destination of size 10
> 228 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
>     |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Clean this up increasing destination buffer one byte.

Applied to controller/mt7621, thank you!

[1/1] PCI: mt7621: Fix string truncation in mt7621_pcie_parse_port()
      https://git.kernel.org/pci/pci/c/fd6eb49a84a8

	Krzysztof

