Return-Path: <linux-pci+bounces-36479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A62EB89DB1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64DC3A2D1C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EAA313E3A;
	Fri, 19 Sep 2025 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUnhCcBg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A94313E2E;
	Fri, 19 Sep 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291223; cv=none; b=tfcGIKo2YxO2dV1WURO6iyevSAOgUE3NZbCDUn0QX6JrO9euSmq+Fvaa8HN20kdqtb+GYV7OepWU7Fo9iDZ88c8PMWqnDpSGpBpw7s4JicMVQhbvpIgsfE/vcc14LIb2O+Z/2qH5qQIXgG06EVHZlhHacxds08YguYdhknuUG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291223; c=relaxed/simple;
	bh=zsmMfy13t92PuvhDDdd5MeIl42HPR1hIGKVw0wAu95o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4zN42GSvARPNiojmx08t8FI4VgcvjF2wbE9YRK8UMCdgknYNC1CAnpWzjSoM2rWkMExDkiwVlR+zDdu9Irm4t17Bf8KTOC1VeVtetRG0AuoH+OulvuhCFCwILYusbR4PXvPMvIpEwBL9ymLbSqWpSO35D2NaILWIPuv+uJcLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUnhCcBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F81BC4CEF0;
	Fri, 19 Sep 2025 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758291222;
	bh=zsmMfy13t92PuvhDDdd5MeIl42HPR1hIGKVw0wAu95o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUnhCcBggT4OKOd9QktuA+CEF9Rhkea8L11xJ5mUwncSvY7NjfC7zGLDTG7+w8T3k
	 75iwaUN0Grxmo74cC5Vh66eQK01Psfj2mypiC5s8tn+ijas3EYdbqzwVdtHnsgsf9D
	 XEFsJgxrzVnN4jaOo5Taco0PLPNljQhhRrd+W43qz/LxAl3+pHZZJ4GvNQx5+yqqOf
	 R7IAr2sdjpv0npn1AI+j/Hznpotk1uUxova31F/5v0rztCr0InajxchiQdzv6voj5a
	 kUiSMQqHQPRVmuZ4lAS/xkh0gJ5L2QT1waEw7T07oyQvRuvD3eFm5fqsJD5hufVhMT
	 k2HIq5SxuRdGg==
Date: Fri, 19 Sep 2025 23:13:40 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing 1ms delay after PWR reset
 assertion
Message-ID: <20250919141340.GA709855@rocinante>
References: <20250919134644.208098-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919134644.208098-1-marek.vasut+renesas@mailbox.org>

Hello,

[...]
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Missed a tag from me. :)  But we can add it when applying, no worries.

> -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
> +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
>  		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> +		/*
> +		 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
> +		 * Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
> +		 * domain, after reset has been asserted by writing a matching reset bit into
> +		 * register SRCR, it is mandatory to wait 1ms.
> +		 */
> +		fsleep(1000);

Thank you!

	Krzysztof

