Return-Path: <linux-pci+bounces-25000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F311A76155
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 10:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD513A77D8
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BFF1D516A;
	Mon, 31 Mar 2025 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tktUFjVH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75214A01;
	Mon, 31 Mar 2025 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743409261; cv=none; b=kfN7/RjINQ2BnPAOXIfXQ1KVNmDPA6mDBeH4Gyft2TWCTx2tsJJrS0bGRNscp0IblvmsaHB3Tq5T7QaQKLojRjTmHCLTmcjCGRRPAtWoLpuyaBZAsvSCtALPgj3IuPiSsMv9UvFcnhQTD12aBHd0UgHDpVrCVcIJaVGrjDSwk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743409261; c=relaxed/simple;
	bh=h4jDZiKUQ6uMigFCCJI6gh8GJJR+wHZwPFP6HF66PY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqeH7srArtWqoHgX7WcBboPPCrKMuK1wa4D7zGeaV65mp746iTUaGOg10TQmROShRGTbuTqDsCLZK0IGAY6DuhdzubFjM7mYpcfuR030pTfYdJOfbHVSLEgcFFpAOoGEIlgkG3dzS5Dhx9qx+ItcYkb5wToAu8OGnJnJe/Cevys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tktUFjVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8CCC4CEE3;
	Mon, 31 Mar 2025 08:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743409260;
	bh=h4jDZiKUQ6uMigFCCJI6gh8GJJR+wHZwPFP6HF66PY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tktUFjVHZ1FEfiJoozniwdYr4yIJQGkvVmy758gtpmIiJtXkvNMV9KQBC0kUtdFky
	 +LQVx9OPYKjrhV8Yp7I+ciVp0bmHgRC7BFnUNB8LJBKye/Tza6+oM3RDmRnMFh7d28
	 ZeTyzIZNCx0pCh/O7cMzo4rCejkvv0mTo45kLxVvjcCPhBnPJJ23wpAoIhSUBIRRD8
	 DFhdKvchgA+x/LbtuvogWFkNn6xAMZa2kDfM4Gpf9BblfPQKBsk6mGBqfLHUXgDa12
	 UYX3zIYIubF9kiUmQVOmJKDCFT4S5k7sA5aeWUlrxLwvUFiHpXI/AVl4jTp7HUA6UP
	 KTJT9q+ugahnQ==
Date: Mon, 31 Mar 2025 10:20:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>, 
	Kever Yang <kever.yang@rock-chips.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: soc: renesas: Document Renesas R-Car
 V4H Sparrow Hawk board support
Message-ID: <20250331-visionary-precious-wildebeest-f3aefc@krzk-bin>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
 <20250330195715.332106-4-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250330195715.332106-4-marek.vasut+renesas@mailbox.org>

On Sun, Mar 30, 2025 at 09:56:11PM +0200, Marek Vasut wrote:
> Document Renesas R-Car V4H Sparrow Hawk board based on R-Car V4H ES3.0
> (R8A779G3) SoC. This is a single-board computer with single gigabit ethernet,
> DSI-to-eDP bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports,
> micro SD card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD,
> debug UART and JTAG.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


