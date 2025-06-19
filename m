Return-Path: <linux-pci+bounces-30183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A6CAE0655
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 14:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8339018891F1
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2190C242927;
	Thu, 19 Jun 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3OMvFyJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE102417F2;
	Thu, 19 Jun 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337765; cv=none; b=FFpma8Kv/yyG3kj1VpCS/Z+oznuog1f3pC5wrNFo7oEi973R5ndURXdqInAdSmXU0xfEUjSwonQJY9ymgkg50NPhfUi54TXokThM4k+sL5rK+71XHRTmepIhKU69BJsH3l3ath7kCTEwcY+7e5tPGBrn/8l3YIabCbRsW8u/2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337765; c=relaxed/simple;
	bh=61z3Z9ZUMVuGadXMmxoys/sL/Hu56s62dGvdkITuqjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jQZtGSXKeFVVLd1AmJbBHOCcXQCH5uVAZXZcapKQvyNyGx87+yisTNwdLbUPSwxidB5zymZES8/3S6PIIC0qKVGnrMcO5LQ1zmiADQ5LfqwNIJhTt0RCjj37IKIEdgpNg7jXRhUbtHT02VIjZGwndMZMR3yqPtquJNxUfB6iER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3OMvFyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC06DC4CEEA;
	Thu, 19 Jun 2025 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750337764;
	bh=61z3Z9ZUMVuGadXMmxoys/sL/Hu56s62dGvdkITuqjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W3OMvFyJJlwm4NWv+4YydZ9uOtxHp04NLHXzOaghRPApC1xVT88UHNPr+Nw4Zv2tS
	 HXYoZns4xPKpwyaiVZfZIqh0KlCyxBvRUEFBgecPNPowT9v9g9baPxFbKFrCfe3BLR
	 MHWzNIE+JG7UeaQh7U92F6O/RcdqC5T6PM2QP0eMkSX2h/k1kIw2jHstyjAo2FBiLO
	 XArxqHEsabqTVdpJf/+TCjOa9ajuvlqiN1z7V6965tFRuDFKYwXWJEfhEnbLIHu52r
	 NhWZ1j+66E/2418KS6turkmp032w1yXfdzjTtD0bMny0Yv8F9fcgEvdqqqY4uwQJ5k
	 5Htx57H4CZl2Q==
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
Message-Id: <175033776037.16241.1043152602736525633.b4-ty@kernel.org>
Date: Thu, 19 Jun 2025 18:26:00 +0530
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

[2/2] PCI: rockchip: Remove redundant PCIe message routing definitions
      commit: 1a69c63fdf1c9095e132096081e27ac85a4d48a5

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


