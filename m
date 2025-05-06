Return-Path: <linux-pci+bounces-27265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A6AABC32
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 09:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433EC5056B5
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9074A1EDA23;
	Tue,  6 May 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WR8OVbB9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="unk+dOg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC61FCCF8;
	Tue,  6 May 2025 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517355; cv=none; b=UQAgWuo4F+ocC0DPen67AX62Sd6srqfo8tqrZDrZa1W7EYDPCv7gQzFsMz2cgNmW8ZOxgUITniX/FVGo754hLigd3rTrnChtqzPN90g9UEQPJOQbuFMSQIH69vuSSRXsSBzeUY74Ri/WX29THssbxYE4gfCGWN/aPwfGUm7FZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517355; c=relaxed/simple;
	bh=mO+m+JaxLYq+BevXI0NK5P8AwDclsuWZdZ7YIumHxgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=logtTikKZZv8ilEZOCygYuzVE7UB1w4GJNOzFLPWhYMwJqzAQBSp8va1PnF+Nj3ccreR1/UFfxAi3DyPjBJI0PVKETCUd9BVRauEZIabPM7lGMwlKOYdUU4/spyTSDzVpt/P+AB1UA1C1w4Aak7YMNBbTjDUhlBDf1tpcIxfT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WR8OVbB9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=unk+dOg+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746517352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mO+m+JaxLYq+BevXI0NK5P8AwDclsuWZdZ7YIumHxgU=;
	b=WR8OVbB98rI62CJm0F0v0JgI2akbIkGT2OsobsosytZFD3JYGrWAL1v554FJkEAq7n+kSu
	3tyMaHgcVBgQzzoHiHMaEI/DBmoXo8hulJavFf/XuDFVa/lsHVbdFyprVFa6d8NOCyBAyr
	whlLIMrHobOJTJMHQYei0bjI3ATdosFgCFey4FlRLTm6xkGHFi5ahlkB9OK8Nz1qc3Icwd
	b12mrbiB1NC80481lq5IxCqEUrU34cneTKG9iUJlqLhjGfhEWWToAf9f2BXKrSATa7pbF+
	/lOQRvzVou/GAcx5mGGEcaMLbBbq9YWrfbPE3Bn1dqhdFXpYdVoxMcu8pfsAwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746517352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mO+m+JaxLYq+BevXI0NK5P8AwDclsuWZdZ7YIumHxgU=;
	b=unk+dOg+tXXJAMCzqGPhFJ3n4qZK94I3OgBtOvSILG+8LyTBnlfv1XldvMUpEb/ePs4PLM
	B3TukPbHTzBzbsAw==
To: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy?=
 =?utf-8?Q?=C5=84ski?=
 <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Kling
 <webgeek1234@gmail.com>
Subject: Re: [PATCH v5 0/3] PCI: tegra: Allow building as a module
In-Reply-To: <20250505-pci-tegra-module-v5-0-827aaac998ba@gmail.com>
References: <20250505-pci-tegra-module-v5-0-827aaac998ba@gmail.com>
Date: Tue, 06 May 2025 09:42:31 +0200
Message-ID: <87ikmenq1k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 05 2025 at 18:17, Aaron Kling via wrote:
> - Copy commit message exactly word for word on patch 1, as required by reviewer

That's not what I asked for at all. I asked you to read _ALL_ feedback I
gave you. I give up now.

