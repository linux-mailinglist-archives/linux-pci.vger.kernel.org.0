Return-Path: <linux-pci+bounces-34312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC9B2C824
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 17:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC36516C0EC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7FC281376;
	Tue, 19 Aug 2025 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE+N92nb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE05280309;
	Tue, 19 Aug 2025 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616049; cv=none; b=PljLhOENxXGLqwBfe8tD5UD2t8fEnxGoRufW0x4nrFfinxvsaWBUGsNz0l7ZHMbS1oDqeKEz39aIluhtsOvJhLW1Cqs4OnKR7eUk9PWvPcU4EnoRxCMtrp0gyvTQjoizQFdvwPghMBqJcoThNcVJwMqMGY7bQCwMeZLWjiLG0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616049; c=relaxed/simple;
	bh=FWERPV2b/K8+f34kGRRaIibkqQthKRkjtRIcOO9bI5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UattT2Yvamf+ZEbWziwuRw2N5EOBLLCdWIEY0rVPO914BRrkV+d8PANbeRTYj4mNQi/fv9LGr6rO1tjgOKGS7Is0Y/R1J/q4R6CxXODGfNVMcNExoxX89lZ5TyvG3bMMfzEIegM/Zjj7/VfJBRgqs33kmmAeBTK7RwuMggzVWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE+N92nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08798C2BC86;
	Tue, 19 Aug 2025 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755616049;
	bh=FWERPV2b/K8+f34kGRRaIibkqQthKRkjtRIcOO9bI5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mE+N92nbp+0JXiAfwUIvsTH3cdqCCtHHsNuHILfE2mK2nj9Hu6eIbPQAYGqMadNYQ
	 lE+BY04Cx6za6/mrYs/m3pr7JWmln6sXgeXvUZi9UP4Wj0RHKSxYZuMQKRWXb0RUTe
	 TQmGYIyAGtIBlvq1EfONtAE15fNiJ+sSdAy+dimAV901J6WuE592aAiuzvEeimJeLr
	 kZSiT12cx0D0uYSsObJj160WPnjKuyxpEKA57YcYffTu3t3VT7TxZ0ggDE6qFA8PuJ
	 4EXUpJ00lgf0jG+1Jkvz9DD70nYzymAm09Ch9bl5Cu15uowQic72B51sLb+htyhYz8
	 NAHjFR3vapv4g==
Date: Tue, 19 Aug 2025 10:07:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: 'Krzysztof Kozlowski' <krzysztof.kozlowski@linaro.org>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org,
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com,
	jh80.chung@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 11/12] PCI: exynos: Add support for Tesla FSD SoC
Message-ID: <20250819150727.GA586493@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b501dc10fd$f1fecc10$d5fc6430$@samsung.com>

On Tue, Aug 19, 2025 at 05:09:34PM +0530, Shradha Todi wrote:
> ...

> > Another question about the test:
> > 
> >   if ((val & FSD_IRQ_MSI_ENABLE) == FSD_IRQ_MSI_ENABLE) {
> > 
> > This assumes there are no other bits in FSD_IRQ2_STS that could be
> > set.  I would have expected a test like this:
> > 
> >   if (val & FSD_IRQ_MSI_ENABLE) {
> 
> Thanks for pointing this out. FSD_IRQ_MSI_ENABLE is a single-bit, so there
> is no functional difference in the two statements. I didn't have a specific
> reason for using "== FSD_IRQ_MSI_ENABLE".
> But I see that "val & FSD_IRQ_MSI_ENABLE" would have been the more
> standard way to write this. I will update this for clarity.

Oof, sorry, I don't know what I was thinking.  You're right, it's OK
as is.  But "val & FSD_IRQ_MSI_ENABLE" *is* shorter and more
idiomatic, so I think preferable anyway.

Bjorn

