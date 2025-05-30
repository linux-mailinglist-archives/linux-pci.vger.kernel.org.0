Return-Path: <linux-pci+bounces-28732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2B6AC962D
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 21:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A7C1BA1F8F
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08F27A446;
	Fri, 30 May 2025 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcB+90+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0626F461
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748634229; cv=none; b=sDFbUbq2CMiHERJgh7x0C0sfTJ4TtU7AZIqrszoRIXTwr2gRGjNO2w9MU6bcVXyFyzoaqXIzz1J6xEElUH8Ju0FcOmnNAvag7oZ3tge2F1ufgpViV8qacNNBhBpBu2Gdk3h6feTYRq4pD+KHp5e7VnlGV83IauDW7sTsdgsjedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748634229; c=relaxed/simple;
	bh=0vCexfz0/m7ZSD9o27mnf/i5aE11GNqR8VJ8Kkd2bi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tC1lFn4k6XPqJOklWCgIgChCZmjFPEpNMDMdeng0GU4WiZ0Uy198dY5G8aS2DjHdQjS8lRpfXG6zWXU8puwasEUdSmp1HwGaXdY5v8aWSe0oEm4RrIjP0Rs6znU8SD68LsSwkHooIf41L1B6JVvHx2G5Cl2mYY/IYgxbyUxFg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcB+90+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0552C4CEE9;
	Fri, 30 May 2025 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748634229;
	bh=0vCexfz0/m7ZSD9o27mnf/i5aE11GNqR8VJ8Kkd2bi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EcB+90+TQdOtwEYbs7sd/EeKSL6M6QyvefVoPK/JHZpMYN0ikHItMS+OWqCs5XbPO
	 gza2uSRSWP5zQmS7q5bdlQPx+ERA87keGhtm92VyjgJiKzGoQxbcgSMZqa49Dog996
	 UB573dqxmB/nMK6RiIRwP3N7RjfM0+WghCSGR2qTgF8RFTgeFIhztOEyb+8wAY4vak
	 3spFVglzPoM65fLLmuvFZ1cXtq3uDB5wSfpavP4YOO7pDB7KsxJcqXhDJij5Q6O+PN
	 pwHdPG1iL1OHqMBMFBQFwiQ0lmkbkA5KMeiePRbI/+OPb41FxT0G9J+6GhNAkLK+BA
	 0doHfzZaLM8dQ==
Date: Fri, 30 May 2025 14:43:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <20250530194347.GA217284@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76F22449-6A2D-4F64-BF23-DF733E6B9165@kernel.org>

On Fri, May 30, 2025 at 07:24:53PM +0200, Niklas Cassel wrote:
> On 30 May 2025 19:19:37 CEST, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >I think all drivers should wait PCIE_T_RRS_READY_MS (100ms) after exit
> >from Conventional Reset (if port only supports <= 5.0 GT/s) or after
> >link training completes (if port supports > 5.0 GT/s).
> >
> >> So I don't think this is a device specific issue but rather
> >> controller specific.  And this makes the Qcom patch that I dropped a
> >> valid one (ofc with change in description).
> >
> >URL?
> 
> PATCH 4/4 of this series.

If you mean
https://lore.kernel.org/r/20250506073934.433176-10-cassel@kernel.org,
that patch merely replaces "100" with PCIE_T_PVPERL_MS, which doesn't
fix anything and is valid regardless of this Plextor-related patch
("PCI: dw-rockchip: Do not enumerate bus before endpoint devices are
ready").

