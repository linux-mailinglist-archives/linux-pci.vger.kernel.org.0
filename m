Return-Path: <linux-pci+bounces-37208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01755BA99C2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 16:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E47189F854
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614F30649C;
	Mon, 29 Sep 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ3zrcQL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B2F2FF677;
	Mon, 29 Sep 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156705; cv=none; b=gXYvzu/Oy41+A4wtL11FmEBMYscOBrw6pnQqUHkciV2t+LyUF4zQsxKm+V4P/UVoyU5yXbAQUT8Aopm1xMVnrWqygOR3DeB83vXLtn5g19XATMCltWuEGofwruAoRLukPedC2qvtijf13gucR3eM7HEpQE51kjQwnE8UJ7IEQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156705; c=relaxed/simple;
	bh=sLDFL9Wl+Iuq12IDgheionrwfrRHgVXtiDYtXHXsCrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vEWsjEZ0YowzSSymS14xF0biek1bji9G0kBMLfuxrqcjfr8Nx7anuIA2ja4heL/hU8qw/ObtrolqwnNVt8anPVz2Tg+FW6vOJycJldceWjOcR62K9aPqSlR90nsUaqdxoOHqTr5T0fxKhdEnujofMfQJ7wQ+vvMDMg+cE+Hs0Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ3zrcQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DD6C4CEF4;
	Mon, 29 Sep 2025 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759156704;
	bh=sLDFL9Wl+Iuq12IDgheionrwfrRHgVXtiDYtXHXsCrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YJ3zrcQLw5rDQWPYhH77bBI8hSRc5rpFYkP9UrVEJCDJhjwfRy/TNVb4CjibWExaX
	 YAcIwsq/RWB3pHd8Zr3yAwxFKU4dY+CCPhezjfxwJjYOK55JhYT7d3d86M0oGDkpO2
	 vfgB0ecsvfPzBlDJNNs8n/Zl3xE2koAiu1xRZ8w3bqrWdK2yyVyY+H82v9S5PeqjXh
	 tZLH1qdn0QFCxXZ+BlkDmokQX3Jht8zTLvGSvK+rSL81LHsmzSLRUAggA3vER/mplb
	 pI9dODQQEaAITpyeuQt/iOBib9HMLB+bK3QyDTJUBtUBmK1kc9JHxs2ICdDczDf+3j
	 7X5r12Veu556A==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, Christian Bruel <christian.bruel@foss.st.com>
Cc: linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250902122641.269725-1-christian.bruel@foss.st.com>
References: <20250902122641.269725-1-christian.bruel@foss.st.com>
Subject: Re: [PATCH] PCI: stm32: Remove link_status in PCIe EP.
Message-Id: <175915669921.12348.6942864048975237850.b4-ty@kernel.org>
Date: Mon, 29 Sep 2025 20:08:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 02 Sep 2025 14:26:41 +0200, Christian Bruel wrote:
> Guarding enable_irq/disable_irq against successive link start
> link does not seem necessary, since it is not possible to start
> the link twice. Similarly for stop.
> 
> 

Applied, thanks!

[1/1] PCI: stm32: Remove link_status in PCIe EP.
      commit: 7d1c807cd2ddf8ef771f214ae4dab9bebbc61522

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


