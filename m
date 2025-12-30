Return-Path: <linux-pci+bounces-43839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4828FCE980D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 12:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15936300E463
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 11:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D5B29ACC5;
	Tue, 30 Dec 2025 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gndf205i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45590224AF1
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767092895; cv=none; b=Funppj9WR3mQVXXWrisUH6hU84ZBzqsUN9EHsOLBInkMNvYBX0E7kaJWUL9A75wNt8v2P9CVsgiHqNchPPzWq9MZnhDR7TMR5kUzcIqj6hLDfq7tL6JxJXcpinVrvc65pCmEHeNLQPmn6dc+wPU4qJEi0X2gj3duD9ccBrpqf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767092895; c=relaxed/simple;
	bh=4D0fiHWhXDEW5Ytcxhqg+9wEzv3/DBgvxj/5BYRqJW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwhADWjdAU2YbwFmY/S8sbLYv7uJZoz2cBGUmYEojfEP8oJ/G/2l4v9Ema4Tf3tBDgXYVZuk/UI8cMlrSDy1suQXuKRNEhBRM1O+23tahPtMnmrnu8Hrb/LVUegQJ/G7+/h9B+07h8rK+RRkxVArRmN6H5wQgIbah+EXRklZbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gndf205i; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0833b5aeeso134656915ad.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 03:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767092893; x=1767697693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6T4TM4UyzYhmp2v2V8GRXesYGcD0Z4PxJ/JcroqgtI=;
        b=Gndf205iuN0DhK+1hdMhJAjoBigjehNqRKMKO0X4NmZECHnyYCc4GK4BgoGDvFBo2U
         iVUQiVFVmU2WUvoPYDvsTCsyfhqVHU5biu2irsADIszD9DUHN+bNDEGwOppr8lsFZ4gS
         8hzuqXtVLLTEqdOeNEFyJUjC6noHfSN8CAdYrlk+TBW4U5nPyWmaRCLnHGJQOE4aBPKE
         s5j/gIb+bUOO+0ImfJw3g1pi14ihpLpNDvc9SWSsFKTTZUu7hNsqo+p44QLqcXTL8+fj
         8pHkoc43kNkEH9ZVo9LJxlIAbxNmPkvvbodTlWZejZUzkEEmLFQfHaFITF3GEYQNIrhW
         lHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767092893; x=1767697693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6T4TM4UyzYhmp2v2V8GRXesYGcD0Z4PxJ/JcroqgtI=;
        b=Qo6lbDgf8ZjzPmWTcDFfHbBVwBMlEVq/39L8b7qkrv6jW5qYThY+JLn2tiAkLvCvHv
         +65uXeSkyDTJABqZY6TDpYqlGO9JnMDUL2Xow2hxe/FFkVBezQpRms8BoVN9vWEhBT03
         f0AhGvCkQPOjQsrjeDJ0KK4/r94LPLDnEHFTgq1IE6Q+voedqcoDlUm6NNaIl1sURcKf
         iCD0X875dacm+Ot7FD9Rr/MBbUzwM9AjpWjmU+XpOSJgNBiaq5pGf3XIviPK2WHTThZZ
         ECy8FZrW+X5I60bERgeyEChXdmwdSApxOLye2Mt9adEIfRQ6O0aAhtR3iwUoqmW3E+5X
         yfGg==
X-Forwarded-Encrypted: i=1; AJvYcCUVjCht+IP4uxZE4SaJ5rb7wZQvK9q4JngkkbW3vUxRpEpL0La5YcKK7M6pvVirAH9skBpg1Nnr9Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiOgvRSmUiAItjXEtOQ+yqMUEXQoWUsK/HB6O4dbw0Nqjbba+G
	0Ub099NQA4GcOfzUa5jbofFcLx1AqFm+9rcw4XVk8Kf6dD/g5HMv5fgL
X-Gm-Gg: AY/fxX6CA2HodlGAI2mwpH7BID+30AGwoKtgKszXm5NV3ymQ8icX9JAotN7n8oTOLrV
	SI8CilH1DxfzCoXfFBru1nSOz0cd2uBVLEKWbgSsIi0o/AU57uLO6VXjEVqiBTrVLZTZuM+PSwY
	3S9xlVF47UPjGROFemuo6wr3zCifAMvLojxnb31ZCibDFUJhsKt7inoGymdjQCIUYtHKpP/A0Ku
	4mbDXxoXxF79n4kEEv7ZH/Oqm/qPB3c2J5KBuJmtRY50lTaeVgGz49n1ayXdZPhRO0ILoVLuOyF
	u5G+lQb11RQXvVsR3xVeTXoedbJO+vt2JUoOOieMBPSMjDFfDhueS0W36c1AW/C37KIP6klicYA
	A5c1N+gsc5c7dujOL6XEyofLIrW/dJsQhMs9Z5tBY4xdMj7HZIwUVgzyT4xAVhXO6EDWFretwgR
	0deHbB2+AZiw==
X-Google-Smtp-Source: AGHT+IFdoXT1kgIAaEAH0f/HKYeNyf//JmLjWqqguUf/fnFyPcQf8JSxquZN9Ic4u5zIlQU2VDZMEA==
X-Received: by 2002:a05:7022:689:b0:119:e569:f620 with SMTP id a92af1059eb24-121722e13ddmr42552599c88.25.1767092893296;
        Tue, 30 Dec 2025 03:08:13 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724dd7f5sm126440428c88.5.2025.12.30.03.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 03:08:12 -0800 (PST)
Date: Tue, 30 Dec 2025 19:08:06 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Han Gao <rabenda.cn@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 0/2] PCI/ASPM: Avoid L0s and L1 on Sophgo 2042/2044 PCIe
 Root Ports
Message-ID: <aVOygptfKzyKsZf2@inochi.infowork>
References: <20251225100530.1301625-1-inochiama@gmail.com>
 <20251226163031.GA4128882@bhelgaas>
 <aVOfBNP3vy4Q52bZ@inochi.infowork>
 <yko2amyugikkuo2fa4plmkghx3ygxlzjw5nmerw4jl5ah6jyi5@qos2t2y356ot>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yko2amyugikkuo2fa4plmkghx3ygxlzjw5nmerw4jl5ah6jyi5@qos2t2y356ot>

On Tue, Dec 30, 2025 at 03:38:11PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 30, 2025 at 05:45:39PM +0800, Inochi Amaoto wrote:
> > On Fri, Dec 26, 2025 at 10:30:31AM -0600, Bjorn Helgaas wrote:
> > > On Thu, Dec 25, 2025 at 06:05:27PM +0800, Inochi Amaoto wrote:
> > > > Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> > > > states for devicetree platforms") force enable ASPM on all device tree
> > > > platform, the SG2042/SG2044 PCIe Root Ports breaks as it advertises L0s
> > > > and L1 capabilities without supporting it.
> > > > 
> > > > Override the L0s and L1 Support advertised in Link Capabilities by the
> > > > SG2042/SG2044 Root Ports so we don't try to enable those states.
> > > > 
> > > > Inochi Amaoto (2):
> > > >   PCI/ASPM: Avoid L0s and L1 on Sophgo 2042 PCIe [1f1c:2042] Root Ports
> > > >   PCI/ASPM: Avoid L0s and L1 on Sophgo 2044 PCIe [1f1c:2044] Root Ports
> > > > 
> > > >  drivers/pci/quirks.c    | 2 ++
> > > >  include/linux/pci_ids.h | 2 ++
> > > >  2 files changed, 4 insertions(+)
> > > 
> > > 1) Can somebody at Sophgo confirm that this is a hardware erratum?  I
> > > just want to make rule out some kind of OS bug in configuring L0s/L1.
> > > 
> > 
> > Hi Bjorn,
> > 
> > I have asked for the Sophgo staff, and they already confirmed this 
> > hardware errata.
> > 
> 
> Okay. If the hardware (Root Port) doesn't support L0s and L1, you should disable
> the capability in the sophgo controller driver instead. You can use this as a
> reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom.c#n331
> 
> Quirks is mostly meant for PCI endpoint devices (sometimes Root Ports also if
> there is no host controller driver).
> 
> - Mani
> 

Good to know, I will switch to quirks, thanks.

Regards,
Inochi

