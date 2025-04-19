Return-Path: <linux-pci+bounces-26278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264EA942D7
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 12:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA133BA71A
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D38F17CA1D;
	Sat, 19 Apr 2025 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqaxrAi0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A41632DF
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745058730; cv=none; b=MUB1SgwXOeQWZn3bMzJ9NNzWRgY9t1UvHhxYKGEijQ35QYw1K+lDLXXzmZByikZJzRULQ+5bfCHgep91m81/z9UL5m8mPajtsfdzGToNPcVAlrr+/JOCv2HCpklsRJ50E+FUMv9kDPgrDP6Wcz5urgBbV3e8SqzOfI/qCSiyF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745058730; c=relaxed/simple;
	bh=swRKLfJWKD2mlW0keXQmekByo0tOmThkSgTyIeveh58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnqo37WyLxPxGeusejALJOeQPc6QGBzshPMtNPjyft4ICHrgYfIP7Wh0a54IvNxySVJ26H/UJmEDx/RKTLu3V3UKL1NUuNtEe8tsIpm1WKsmRX05o91avYXaCB2CnQLnDbnonTn38wMltCWOjyWq4WZuOuAClvqaj5jfqV4eXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jqaxrAi0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224100e9a5cso30912305ad.2
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 03:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745058728; x=1745663528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Il2rU8Ei7/bRHYklnBb9fRrbnoPixb2FIIvOyMizU8=;
        b=jqaxrAi0voXqiOjYRZYcvWRQAAU4BEPuR1F+h4PA5cFc4+oh+L95zLUzkLu6WvJuID
         hXleUD8Lu7VuaKCB9FFw3GRk0EfC8mv0q1tGZsUGgZesiR3pCG+t4Rttr3PaRMRatZur
         NVegfF9NH6vZsBK4sURioUUIIy6we0nNVrlKJNrGm0pd8F7UP63MpM9o3OjYnd1QPqaS
         vpmWShnkHK9C+n+3Y9zSrApuIHzTJq6ZXDMPBBuiWgJb2pFSGe33nqphfsXc/K1M6syF
         GvY4U5EHo4twtWxAb/zsVaoAQVAsjWu4D8mvZANfPKy6wFIlLjaqntEHAn0rWJfYiwQG
         JjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745058728; x=1745663528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Il2rU8Ei7/bRHYklnBb9fRrbnoPixb2FIIvOyMizU8=;
        b=NvSzlkdMeFzJUaLK51WJFdI3cw3ckVJm+EUKcxcpEPJYe7EKb+u/YwRDC9THJCDEJU
         HvbAWa5hL0cGq/FQwMIn4c+YZ1NlA1dwsQuO3CnlWlmg9LyQcg8yK2T88SWgRdIaJcO7
         EhcKWRYBT+cGMcPprzXUhsmqu5lkLPGDlakFcfj8CFmoDN74Jc8unDFOyrpzb66GMOcf
         hpJNODwJORNAYTMaEnf2E0+juKaHaAH20Mwbsn6x3lAeP22zGjyBHNNBAt/l+8POVBtQ
         DbCouPoB/EfN38VebPXFC7vhmnYh4YwnMX1xQPv9Chb94hiJHgJh0kxuYBU54RAVRPou
         2m2A==
X-Forwarded-Encrypted: i=1; AJvYcCUe9f1a49sHOIPO3Cy9PUA2vt9fcb7G814d2HDFfaWlQFHx2cT0YbdelUWHN4TqLLwCrPc/CkXZdnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aK1QvyAxhShvP37rb6HhwxAkgUgyPR7ecTi/L5YFvA1Eg6B7
	VnCKShpL6jzuoRmdPDb70u0T00czeBjh5NUbFX8a/OuEw6sRvrHp8P5KlrgMfA==
X-Gm-Gg: ASbGncvDSbE+JOV2083Q1YNV4tI+vuO1G0BI/pJirOf3AkFro3pWYh/9trg8d/QklOg
	tfEMCqAAASGG6Pum6WGE3tfxCJ3HhnrkyujT8d4QYwC2y4Q4R8wtcMrc48iUbN8QgDYM5I5RF8i
	CDxZAiMOzMJGwcQfGsxRCKQcsW2t+rDkzHp//+S3RleJ6kQdERbLLouABBN64w7xhLArkaE0EmD
	5uo5Mv2/CWvrA45Qb3DoXs0lEeKikUdTqsKFLSYjwAhL49mdwNyfMp6f6rSC5FUxb6p4nENVqbO
	s0NcaeOXsdIXpVDpqdCtyGxDeI83XmcNDmXvB+VcsJ0U+ssSzIw=
X-Google-Smtp-Source: AGHT+IFIs3URHzShG2kPpjK29B1REbfnUIRhTOlT5ei3CMFMXuj72gvndCjXDA59PyRefPuYycxkCg==
X-Received: by 2002:a17:903:244a:b0:21f:988d:5758 with SMTP id d9443c01a7336-22c536011bemr96555915ad.35.1745058728233;
        Sat, 19 Apr 2025 03:32:08 -0700 (PDT)
Received: from thinkpad ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb6807sm30636225ad.112.2025.04.19.03.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 03:32:07 -0700 (PDT)
Date: Sat, 19 Apr 2025 16:02:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Minda Chen <minda.chen@starfivetech.com>, Mason Huo <mason.huo@starfivetech.com>, 
	"open list:PCI DRIVER FOR PLDA PCIE IP" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: starfive: Simplify event doorbell bitmap
 initialization in pcie-starfive
Message-ID: <ck6a66u3cn4uzwnz7z3xjoz5rorli7eww4lfzbjxmntbpbnzgt@dg2sfkhw4x4z>
References: <20250316171250.5901-1-linux.amoon@gmail.com>
 <20250316171250.5901-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250316171250.5901-2-linux.amoon@gmail.com>

On Sun, Mar 16, 2025 at 10:42:46PM +0530, Anand Moon wrote:
> The events_bitmap initialization in starfive_pcie_probe() previously
> masked out the PLDA_AXI_DOORBELL and PLDA_PCIE_DOORBELL events.
> 
> These masking has been removed, allowing these events to be included
> in the bitmap. With this change ensures that all interrupt events are
> properly accounted for and may be necessary for handling doorbell
> events in certain use cases.
> 
> PCIe Doorbell Events: These are typically used to notify a device about
> an event or to trigger an action. For example, a host system can write
> to a doorbell register on a PCIe device to signal that new data is
> available or that an operation should start12.
> 
> AXI-PCIe Bridge: This bridge acts as a protocol converter between AXI
> (Advanced eXtensible Interface) and PCIe (Peripheral Component Interconnect
> Express) domains. It allows transactions to be converted and communicated
> between these two different protocols3.
> 

Are these events used in the driver for any purpose? Others have mentioned a
potential irq storm issue with these interrupts also. So unless you want to
enable these events for a specific purpose/usecase, it is better to keep them
masked out.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

