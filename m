Return-Path: <linux-pci+bounces-12569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A989967995
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8081C2127F
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9BE185924;
	Sun,  1 Sep 2024 16:45:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6718132A;
	Sun,  1 Sep 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209122; cv=none; b=cWDyhUXVl05k6YdVvp8TpXUTc5gVrPmBfubGAfBqGYmsYPSIV1qLnZ0BLX9dOyYK7XbKN4qFDfSnzRJnDrf1rvWLL4+MR65j8KHzPmKKnFZvHWNGdXqM5DCF0exHxQM7fPJpH4uvE0Fvqoa7+Rr99LMPX2dPsulak/mGgilRh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209122; c=relaxed/simple;
	bh=yvKUgatiTc6SLyOoCWtZa8RwschLsW3BY6maidvt190=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uu3mVl+rav6cx3PgNNrAKuVXHqmM6X9caIAkex4E2pnwKi8QqQRz1SdAsQYE3bO/08W9OLwu/6gHhYK5WdMh2auL/bH1uGJSGUFRKTS43hHvh4u0W4iojXcu7MOVWoMG2vvYrkzM/dmLkvVCowDTWrl65oaOFPobuPfuyqgVxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so2753020b3a.3;
        Sun, 01 Sep 2024 09:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725209120; x=1725813920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UePvY76NdI3e5ne8Q0tkvG9Cg5FDn/IgzB7RkpQUkpE=;
        b=VdXNzKSjLrmCGd9WOmW+1poijdJVBTq5eXqVaZAmYER6a979rsNmh9Fkm0Jf6KhORb
         4EjNrPFIBeV+mCD9sZEHaVf4XyUJvbU4dy+AgvFm6dr+FpmiLuW25fR/LSC4FohIf6nY
         YbTXyPK2GDNwE0Eti8l+yTg0pgxDNz3tXTwbAf3YIIyjEtOT6fGFp6oH1dEL75ilHvwi
         TNrpwlcQI/sFOSy9BS5ttkCOlVTFiCHa1WKoNl5nbibPnKm5hhQVoWcBTJf2/8qwWRsn
         mejBl7GE8tKXF5QWCKcTDq21t4flTLZtmhiL6IA9kWNkd4n+ubJL2yQPagaHIWN9SOOT
         rV3w==
X-Forwarded-Encrypted: i=1; AJvYcCWFDr0CFZBnedt0JOXON2X97bFpL1oKBFkZlyis9D9ciEQFOERRHKJF05YhxqHkj+gO3OmOWCy9MHSZWA1l@vger.kernel.org, AJvYcCWR8SYdGtOUXy5x47G+V6k6MbLVEamHuXCaitEFMVOQKZ0g8hXStIM+IYnxNUjzJp5PQYdlPeugTOYv@vger.kernel.org, AJvYcCXn1+CDWMNBopOaSKp3dRMgJcqx/bshsPeA7z206pkUj8F5Ouq55RMdT9AhlxZJ+D+T0IznTwkx+DDg@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFANsZhLleTl2ezvd7PpCQfip2aj+j4GP94yuYMXRNhw+VCSL
	+VNVFyq7YDFgnAWV5IvNmIizBkuF1qVbXVwZedZSKeO4IRHYTLWp
X-Google-Smtp-Source: AGHT+IHxVXP/Iba+uMbQeOLL5SaK8/FdBVxPnxH1cCWA6X2wTO4x69gO/x6E7rzzUfOzJH7ctukffw==
X-Received: by 2002:a05:6a21:3189:b0:1c4:8876:299 with SMTP id adf61e73a8af0-1ced058a8b5mr4252353637.46.1725209119993;
        Sun, 01 Sep 2024 09:45:19 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b39ce64sm7303481a91.39.2024.09.01.09.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:45:19 -0700 (PDT)
Date: Mon, 2 Sep 2024 01:45:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/2] Add support for Xilinx XDMA Soft IP as Root Port
Message-ID: <20240901164517.GE235729@rocinante>
References: <20240811022345.1178203-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811022345.1178203-1-thippesw@amd.com>

Hello,

> This series of patch add support for Xilinx QDMA Soft IP as Root Port.
> 
> The Xilinx QDMA Soft IP support's 32 bit and 64bit BAR's.
> As Root Port it supports MSI and legacy interrupts.

Applied to controller/xilinx, thank you!

[01/02] dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root Port Bridge
        https://git.kernel.org/pci/pci/c/899d54826110

[02/02] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
        https://git.kernel.org/pci/pci/c/6ac721795d73

	Krzysztof

