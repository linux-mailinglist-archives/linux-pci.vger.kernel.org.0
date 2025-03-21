Return-Path: <linux-pci+bounces-24341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AACA6BB57
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5211780B0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FC1F2BB5;
	Fri, 21 Mar 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSHJTQm4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A838F80
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562017; cv=none; b=C6Db6SUVz8yuHwro9kbU89EBD+ZCTK7aTbf6GVI+08sAQK7F25RhC+hPaJ4lrlIR3jUtuj87gAHRUCkI5dKrduC688VeQKbk9uZZKNWLvqA/O1VE1uMP3seGDqReeq0rSz/An/TbrYlo+3MIB3atVKSJP9dGFkaw6cmXRpWp3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562017; c=relaxed/simple;
	bh=plwBUBWa9ym9Mh4TJJ3ICNDcswub88W+vU2KUtjaPjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVXOpSfUWkgMmDYJbylqmzgM/N54kmpt/V38zbUCwlVuXWBpaDkFkK6vnYMqlNN+YC+i/0a/akh4McIGNbGaRt2yCoVHHvgIcTFS4Z7ahUNZSgr7k/CWjas0h/25DblbuyXLGuzn2E4NKzmbt7yhNXJZA5iezx84BpPnSDHTiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HSHJTQm4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240b4de12bso2449505ad.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742562015; x=1743166815; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wLOWpBJ/84QqSStkKvu70G+ifFT/ePp0AEqvzzVNHGQ=;
        b=HSHJTQm4gzsOdAXxkfpUlnIASgwID2Qa/SB3VSa7FykybFmUFkH0AGKLkOIz/EAc9q
         ta7siQKSzDUJBEGz51J2LDuhnChHUqKfmBlDD/w5Kanc0tyMRTEaS7JqlKE0wc8F9obR
         bteVDlbqvqJGOsFXoJ9vuwqn40t9e3kcmbFRxL6PndlocfiiH4ufDiDlU3WwYTlco2mx
         f6KTfxhGXmC6MCknGSKN0mWsReQjqcqKvniDfHBj2fMGWii5yk2o3dgkzDfGYNHZ0VR1
         2ZCtqws6lfzCSxJLVLIqpExKbcyQZqAv/z4QZ5RHvu1jB0N/S5bpzierV0HuFMxKNPJo
         kNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562015; x=1743166815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLOWpBJ/84QqSStkKvu70G+ifFT/ePp0AEqvzzVNHGQ=;
        b=mcImSWS1vxjGhVA16FQ3dU4G2Sg9y5KFf0RiYljdlRbaBsU5t/rY8CCHaeS9pEvvEr
         pLdaRXQfiwNyW8Ha0RK5AySpEQMunxEFgZElD36zCM0XPczAlHnp+EymG2g1t777qWG7
         cWZRJK7fah24rhRlhAGOZR5PdIE3XzDlwh5QsZigbjqw34MOtrGkCLSN0xhFwIL81Jfl
         1P0j3t8i2mHgWwJs/cVhrmkHZ79BRvu1FvRmaK2xHgyecy9f1uHiO5FfBchY+7qLCHye
         XhaM3IqEzePJHLSbe7SHBrYSrIDrx8/xVOfVWL95qQV1nnPFj8D2IuNqWFegUfDcjEgX
         8Log==
X-Forwarded-Encrypted: i=1; AJvYcCUo/Hr4rVxw/AZbZF6LY5VSh/lmklX19FhgdADSFYAtityLl2fI+v6qCxvn1oLGojSEUtyVYn+/jnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnvgu57bDXaLDRUGAU1tjbGKYynqcLZyR4EAwmS2WDzvgn2jw
	r7wpsrANvSkeX5u49RA/NIf8oGRbxWG+Qmk1bHPLV/hCm6wErtM8a50dF12SFA==
X-Gm-Gg: ASbGnctOOvm4Gp31hOzJbSs8+WaAUuuz/6GOQi6ZdeLVAElmB2HfUOoc1+hQilFUD8Z
	vR5Vzl2k0u+Gfhd9kcupQc8P4ToOC8dDfTi/JDYrzafb0aUwVv0X/4g3KmWD9D9gzZH3bpfOBs9
	LsXW4MOfVdEggMr/YxjPOMCSMRPOhx2YUhq732D8a9sItq4saFPwtCEtjL2cMuaL7VToe6ivey8
	j3Zy+I2372RzwK16KdeB8Bnw/4v+APY6ab5IY70TIk17KST7Cp3eBL+EEZ4zZQp8sRhj582XIZB
	OitNUN7VzyCv8ReTajIlPYiZt7OnTsxVxjzt0e4rl2BfAvElV+rS3AsdYALSbmkq8Y6w
X-Google-Smtp-Source: AGHT+IFTfL0DLPrgepqPKLA9JqmhC76PAJXtBjhi2YTyYHpFIbG4X1nRwScZA52uGahHQ3nMbVLuZA==
X-Received: by 2002:a05:6a20:d497:b0:1f5:8678:183d with SMTP id adf61e73a8af0-1fe42f2c686mr5981977637.14.1742562015263;
        Fri, 21 Mar 2025 06:00:15 -0700 (PDT)
Received: from thinkpad ([2409:40f4:22:5799:90ea:bfc4:b1d2:dda2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4f585sm1602397a12.73.2025.03.21.06.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:00:14 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:30:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v4 1/4] PCI: Introduce generic capability search functions
Message-ID: <20250321130010.s6svrtqlpdkgxmir@thinkpad>
References: <20250321101710.371480-1-18255117159@163.com>
 <20250321101710.371480-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321101710.371480-2-18255117159@163.com>

On Fri, Mar 21, 2025 at 06:17:07PM +0800, Hans Zhang wrote:
> Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
> duplicate logic for scanning PCI capability lists. This creates
> maintenance burdens and risks inconsistencies.
> 
> To resolve this:
> 
> 1. Add pci_generic_find_capability() and pci_generic_find_ext_capability()
> in drivers/pci/pci.c, accepting controller-specific read functions
> and device data as parameters.
> 

I'd reword pci_generic* as pci_host_bridge* to reflect the fact that these APIs
are meant for host bridges.

> 2. Refactor dwc_pcie_find_capability() and similar functions to utilize
> these new generic interfaces.
> 

This is not part of this patch. So should be dropped.

> 3. Update out-of-tree drivers to leverage the common implementation,
> eliminating code duplication.
> 

This also.

> This approach:
> - Centralizes critical PCI capability scanning logic
> - Allows flexible adaptation to varied hardware access methods
> - Reduces future maintenance overhead
> - Aligns with kernel code reuse best practices
> 
> Tested with DWC PCIe controller and CDNS PCIe drivers.
> 

This tested info is also not required since the DWC and CDNS changes are not
part of this patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

