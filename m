Return-Path: <linux-pci+bounces-19117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10B9FEF14
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 12:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F069188317A
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAED2192590;
	Tue, 31 Dec 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oofNmexe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3618FDC8;
	Tue, 31 Dec 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735644408; cv=none; b=dG/GLrzBI23PkyKVZaiVpIPuxgvxCTTckM7IwVwsQfEplVAG7qIZkQl3ExcJpi3RydCG1U1PmAJvsMJ1TNh6N7lWqcJmyWeNbLZMZ/FVVcQ+DwfabASAcqFeyl9Pyw7Qi8ZVwH3T76Hm3FddXLcnd2J1W18TxSbogYGWTuzANDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735644408; c=relaxed/simple;
	bh=7I691cikO6+2ya29OQVC4BNPWfPNDEUQc7RUJdpNRnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzFA3nUKF4uRtrGPEvfJsfklYv00Wy6isZW2GUzUnvY1IT4oBGGVkLu9/8RmG2occEgntSvq+9MEe0LebUoLKe6L1VHj3Onnna+MQCzbPE8PcxQjSSJ1VphiHtYmOiHEpM7MfCraTXBF/kJBPBSyxaWMR6BitcQQRsk6/LEqHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oofNmexe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60D9C4CED2;
	Tue, 31 Dec 2024 11:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735644408;
	bh=7I691cikO6+2ya29OQVC4BNPWfPNDEUQc7RUJdpNRnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oofNmexejOf6DtzMHzSm5/hhVPLO7oTwCu/lgM+pv7g4ZVjowqJTNbsOrLTxkNIHK
	 yEDDjgEvZoTC0YIXCLRV8BdTK2NbXvES1qMZ8TBiP2LPYJYqBO2uJ89NTVFbzEl1uV
	 eYe8zvkNWHwKOTj+IVHu68YjVv18a6o1vduIRADkkgDL5bC1ez/hDfBMmDPu3ffpSn
	 UOW6/420rP7TrrAoS2QCx731qGe4ohJkn/uGfFH/UTt1UMoeFzeautXULGB0UneWWI
	 Z3XqzxY2a87O0mdC4bCEdAQczTdSQafRh4KLfmGB7XSt+7vMcK24BExheL4o1CabOg
	 g7nbKh8UChVnQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
Date: Tue, 31 Dec 2024 12:26:39 +0100
Message-ID: <173564436965.205920.13726972992693707050.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202151150.7393-2-linux.amoon@gmail.com>
References: <20241202151150.7393-1-linux.amoon@gmail.com> <20241202151150.7393-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 02 Dec 2024 20:41:42 +0530, Anand Moon wrote:
> Currently, the driver acquires clks and prepare enable/disable unprepare
> the clks individually thereby making the driver complex to read.
> But this can be simplified by using the clk_bulk*() APIs.
> Use devm_clk_bulk_get_all() API to acquire all the clks and use
> clk_bulk_prepare_enable() to prepare enable clks
> and clk_bulk_disable_unprepare() APIs disable unprepare them in bulk.
> 
> [...]

Applied to controller/rockchip, thanks!

[1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
      https://git.kernel.org/pci/pci/c/fa0ce454cd4e
[2/3] PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function
      https://git.kernel.org/pci/pci/c/853c711e2caf
[3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks() function signature
      https://git.kernel.org/pci/pci/c/8261bf695c47

Thanks,
Lorenzo

