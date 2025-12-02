Return-Path: <linux-pci+bounces-42432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81626C9A028
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 05:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BB1E345451
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 04:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF44245019;
	Tue,  2 Dec 2025 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ks6Dc1l/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30D2F5461
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764649708; cv=none; b=rjFDvqAz5zmC8n/qfo6H+UpV55PDBOd76ZrBdnE+tsD1NC4E3gn7gK0OQ9dsjaYTlEQz7rpGNOLmkW2AZuw6CmosPdi0VZCbpvx07s1kAaGs3/NIeh+5eoMzuF7lNWu7yBblMF5rCxYyECeyxKKxVM+S4/IUMDqb1OH/DtJ/NeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764649708; c=relaxed/simple;
	bh=crsFLDgVaXi059lngL00+3IYJxJAGz/pJ25CeD6imWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPTPKo5+vgiDSKP3XXaK7ebzHihwvFioy83Qqfan4xS7J2Wh357x3OpOvoV23pHu/ULajVZ2rYfbVkJuq1+R6Ofhnt9qnsIp1McYumy2o2rNMsGhLItym2osruUPqxwh/dnvwv3SI/Y9+1sglBllIQffVeGxN3MFMBidvn/dNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ks6Dc1l/; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2a484a0b7cfso7049718eec.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Dec 2025 20:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1764649706; x=1765254506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uv873R59GF4pDUvydCooybALtCJ2h5ZZnBbEItimlbk=;
        b=Ks6Dc1l/9pzgaEt8/YGZoH5xozWj8NEUu2gnBoiCbz6GTWF+ijuoJkim4sIq6692xZ
         17+bPREtXTaqKScTikSa1fT8rNQGglF8rJk2u1kDtFfa9qLf2VRxANr/CcONLzO0Xo6T
         XwlKoguAeVyXzP3k4Ek9e6Y7z5x/rJeLYH1ZL8Pt6WvsaRgCSlIKdX8hb/XYHVD7x8Ff
         rlXGtTMAbQ5d6vmA/3OmRZiCKsydYFQOtfgt6MHMkXPDwflv6DST/Ta+0vjWH3kRWomO
         gRlWZXpSQovHu34hbalN5Gi7DOzUYca6yaAKvIGbDYzSjIq7eVFsji+BKtAKCC8qCVry
         LanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764649706; x=1765254506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv873R59GF4pDUvydCooybALtCJ2h5ZZnBbEItimlbk=;
        b=p6g4LXPQQnPT3cWBRQBtFEk6OYpbQHyH83RouGFEW5cgt4guROOh5n/XahBI9S4Ny9
         r3UuKBGSj+6uaBf3DUy8kkpYlVUShTHbYSFY9f1aCNjFL8XfbEwzXVtushaPRcTGOd7V
         AvCEGox6fEVoBiiX6EulqF/dXbHs5bC9ctudbJ+ETcFOxMYsahXiWFkjK0d4Bou239l3
         daf5EPfCR7YXrHl6G1nXvh91hGsqkiYWWfdOvpbWGYC4u6Y4AsoFrvfKScITX7O9LKB1
         NRqKr0Z3f6U+pJME98TlC9bpfTEXuTZL5Uepwgmq2WLEpYU3ttmwwU+cCpvuJy7Zdyjp
         vLhg==
X-Forwarded-Encrypted: i=1; AJvYcCVWt8Esdn6gSP47viJJHKpX+92dSrl2gDdoQ0n0cl+qypQBpeCHW7kadwXOutx7AfiEa5e8TavlnvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhqyDSynehVlf3uKqHg+VQCEDhFlMH0hcgnvGoMvh6dUN4KkB
	8WuwEq8E1XMuJ2EeWf/6KiYt4SwKAg1+djCent8m6thkBDoHHN94BLWRESbpw1neuHM=
X-Gm-Gg: ASbGncsNMAbcevJvMb/umVTCWY7xxZOeFi7awmV5mpiMR07Xb9AwGyEPr4V/sfNfhtX
	Es6dq5j5gS31AerwEAKUvQBLGbIvyJuJtbDMY/ap8aB3MrXi63xbcvd8MtJs+A+98YZbZWd4k3i
	tXtR8WpX/iS/TVsFvvrk5/k5xMfTHs3ZZ3Ba+Gl8k6y4zzG2IxYe3AA5BEnoVzXSQJoQy2Bp9Dr
	ydd1ya/n6bDmHSCzs3ZGDrZV09gpRjCoy69udmctaBmxfIjcLNjG/d7upDyKji++v4k2UkwYf2r
	o5pd5RWnGPjqncv6s8YMLcnWuUQW5Nv8QMQ55blrHjY83eF8kv45+mgyiCHJxU+pUZtKp9Z7OgO
	WQZNJ5bZO/MSJp6XY0AM7P5lylk4NnpRy8q9eB4fcrahclTT9QVDMHQEroKaIzt1PyR/PVTYU4u
	Xsmwl7wDF7M+RxcPjjzw==
X-Google-Smtp-Source: AGHT+IHz9/5MGJKnqrRQBBG71Tv8qvd7//uMmkLyg5Z6fy/L0/ZDmN2B0A/dYTxnaQjFO5ur+16uhA==
X-Received: by 2002:a05:7300:e10f:b0:2a4:3593:ccbb with SMTP id 5a478bee46e88-2ab7e661990mr930517eec.2.1764649705538;
        Mon, 01 Dec 2025 20:28:25 -0800 (PST)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a96560986csm77426225eec.2.2025.12.01.20.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 20:28:24 -0800 (PST)
Date: Tue, 2 Dec 2025 09:58:11 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: huyuye <huyuye812@163.com>
Cc: ajones@ventanamicro.com, anup@brainfault.org, aou@eecs.berkeley.edu,
	atishp@rivosinc.com, bhelgaas@google.com, catalin.marinas@arm.com,
	conor.dooley@microchip.com, dfustini@tenstorrent.com,
	haibo1.xu@intel.com, lenb@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, rafael@kernel.org, robert.moore@intel.com,
	samuel.holland@sifive.com, tglx@linutronix.de, will@kernel.org,
	dai.hualiang@zte.com.cn, deng.weixian@zte.com.cn,
	guo.chang2@zte.com.cn, liu.qingtao2@zte.com.cn,
	wu.jiabao@zte.com.cn, lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn
Subject: Re: [PATCH v7 08/17] ACPI: pci_link: Clear the dependencies after
 probe
Message-ID: <aS5q28HPYLzK6h8r@sunil-laptop>
References: <20240729142241.733357-9-sunilvl@ventanamicro.com>
 <20251201141230.12656-1-huyuye812@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251201141230.12656-1-huyuye812@163.com>

On Mon, Dec 01, 2025 at 10:12:29PM +0800, huyuye wrote:
> > Hi, sunilvl
> 
> > Based on the above patch, I understand that you previously >resolved dependencies between Link devices and PCI Host Bridges by >calling acpi_dev_clear_dependencies(device). I would like to ask: >on RISC‑V platforms, if we need to manage dependencies between >multiple PCI Host Bridges, could this be addressed by adding a >call to acpi_dev_clear_dependencies(device) at the end of the >acpi_pci_root_add enumeration function?
> 
> > Initialization order dependencies can be defined via the ACPI >_DEP method in the DSDT. For example, if host bridge B depends on >host bridge A, bridge B should not be enumerated until bridge A is >fully initialized.
> 
> > Yes, that should work.
> > Regards,
> > Sunil
> 
> Hi,Sunil
> 
> I'm truly honored by your affirmation of my answer.Do you think this solution has a chance of being accepted into the upstream kernel? Are there any unintended side effects we may have overlooked?
> 
Acceptance of this solution depends on the PCI/ACPI maintainers. To help
them evaluate it, you should clearly describe why your platform requires
this dependency in the patch.

Regards
Sunil

