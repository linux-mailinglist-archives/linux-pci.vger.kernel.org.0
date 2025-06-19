Return-Path: <linux-pci+bounces-30182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D4AE0643
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 14:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A1D188CD8D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3622B598;
	Thu, 19 Jun 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiOvT/D5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8255229B29;
	Thu, 19 Jun 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337544; cv=none; b=adQk+j8Ju1GZfPU4VuknKpju5LUH3OCW91Wmmgoua7+GkN3SKhqlqy/25YlptB0ADrYJg1gW9vzH3sZEFyfOTy2QRF8tPLE3IenZamLyF0HUPHeFvPzJBZcwhcWqQHCsEJCaOHjAZ0UxLYxiQmIcfSzUe63mLQHOuRmwE4r+NKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337544; c=relaxed/simple;
	bh=p9Kau10uglpH75TFRcHGcWbbB8CHO/pVjhJTQAlCcVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ONbnSBR7zJxFIMk6xkumQB91GTpUpIEUvnxbCPOhPwW24sQKf7x+zRRD37rlZMGA2uA11JNslmid96wnw86stFNlZaSWK/d0uHKnjMhaKPFCnBVvV6FpaWK3NSL8TEaTmZbffvDYzIhiDmcVthJPXBbdHNHL9hygOL4uKVPsytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiOvT/D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7DAC4CEEA;
	Thu, 19 Jun 2025 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750337544;
	bh=p9Kau10uglpH75TFRcHGcWbbB8CHO/pVjhJTQAlCcVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WiOvT/D5zxTuexZvAyuVgsA0F+9yZIE6u3Zgr6ALQOfrvBis0ZINnwvApXTdKxGYW
	 fZKk6eOiHg1g5eXjM2was9KnhC7QWn/uWu7W4B/iCBQiVnr4DQZOLs1hDynZjQD6TM
	 CAE1nSXC4JXZd6ib2Z9TgDbh0sNIgzCEkeHwKy057ffn4QHb//5hyRPQ5tD3WPWtUj
	 P9qQt6MHNnUfO2Fpe7dtRrfVwdGSu9Dx9YBPpgKz40yxJam5kT+gKbYcuWY6px1sCN
	 7FOYfCx0/UhmZ1SO5ekxBLrVkedIho7AZxPMM/AMTMGantP1JoRnYICkQhxPqBhhxR
	 41NflEXNBbfTg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
 shawn.lin@rock-chips.com, heiko@sntech.de, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250607154913.805027-1-18255117159@163.com>
References: <20250607154913.805027-1-18255117159@163.com>
Subject: Re: (subset) [PATCH 0/2] PCI: Consolidate PCIe message routing
 definitions and remove driver-specific duplicates
Message-Id: <175033754020.15449.12159303573503323127.b4-ty@kernel.org>
Date: Thu, 19 Jun 2025 18:22:20 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 07 Jun 2025 23:49:11 +0800, Hans Zhang wrote:
> This series consolidates PCIe message routing definitions into the common
> PCI core header, eliminating redundant enums in the Cadence and Rockchip
> drivers. By using standardized macros (PCIE_MSG_TYPE_R_* and
> PCIE_MSG_CODE_*) from drivers/pci/pci.h, we ensure alignment with the PCIe
> r6.0 specification, reduce code duplication, and improve maintainability
> across the PCI subsystem.
> 
> [...]

Applied, thanks!

[1/2] PCI: cadence: Replace private message routing enums with PCI core definitions
      commit: f28413fe0899591492d8ca3cdf5fd35558d9c05d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


