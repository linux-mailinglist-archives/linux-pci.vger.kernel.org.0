Return-Path: <linux-pci+bounces-35663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE39B48D46
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 14:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA4B3B6ED2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 12:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCB322FE15;
	Mon,  8 Sep 2025 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjqlUQvu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AF221DB5;
	Mon,  8 Sep 2025 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334206; cv=none; b=lPtI2YAx0i3dBfdPaAdz9arGHTw/OcOyOkWygvDuxlF9wY6KTBJBFMOYQ690UevqlE3doAMfe5ibFJoUCiV/QgyfvlnfDFnLDZLHuwpJgrgGZmlA0GZPtZ96cFAftydGQPX4em4FF9G87LVZM0CNugk1S/tei+lHO7Fyb8/F404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334206; c=relaxed/simple;
	bh=D6cneQQmhd1FoJDTC/XACRkYANyh+3X4gy7qW3UFAos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KJMUD99ICYuHP5sRHgR3vLoj8OH8nPZ5eP9TjFAKrxHmkHrOYG2axg8SP91a0yAJ8ev6kX0+sYGR52yeQ9os3jXmCG4FKvxJGq0xZbEUme6tywgWPyDp7fOeOALIAvunDxZDlpFMZBn681cYMeQx9C5EnTt6f1NCzM5Bw+7/nNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjqlUQvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17027C4CEF1;
	Mon,  8 Sep 2025 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757334206;
	bh=D6cneQQmhd1FoJDTC/XACRkYANyh+3X4gy7qW3UFAos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hjqlUQvugGe99TOgR4h6szERkWrZoLhqLcNOL2cwplnO85sQCIL7+gkzaRfwiWlki
	 znXTi8CZIMYaAXqlqDpEH4BQa9yZJ5RVTgohMcvFedOVclposdrlC5O78FBNhHy6/5
	 SIviNze3FKbLtE2sitMdF7EjogdVAdynt7uQcf1cWw2lJ6Lmgd0UhHI/l1+TGuolks
	 aKsU1IFupqE7V3+tq3NiT0naS+YoQCRzfb7Mk3O4kP+1QT432XpD7BAqK3uWuyFEJR
	 a0qtK+bevHkpLv9xFgTzJ/Cic5/X81ZpdCbHsVp+96ScxC+e4SA+80np7vUjRyKPgS
	 4NmbxQ3U52xxA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, helgaas@kernel.org, kishon@kernel.org, vigneshr@ti.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20250908120828.1471776-1-s-vadapalli@ti.com>
References: <20250908120828.1471776-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v4] PCI: j721e: Fix programming sequence of "strap"
 settings
Message-Id: <175733420164.9759.8251040864412190074.b4-ty@kernel.org>
Date: Mon, 08 Sep 2025 17:53:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 08 Sep 2025 17:38:27 +0530, Siddharth Vadapalli wrote:
> The Cadence PCIe Controller integrated in the TI K3 SoCs supports both
> Root-Complex and Endpoint modes of operation. The Glue Layer allows
> "strapping" the Mode of operation of the Controller, the Link Speed
> and the Link Width. This is enabled by programming the "PCIEn_CTRL"
> register (n corresponds to the PCIe instance) within the CTRL_MMR
> memory-mapped register space. The "reset-values" of the registers are
> also different depending on the mode of operation.
> 
> [...]

Applied, thanks!

[1/1] PCI: j721e: Fix programming sequence of "strap" settings
      commit: f842d3313ba179d4005096357289c7ad09cec575

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


