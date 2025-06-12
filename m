Return-Path: <linux-pci+bounces-29552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E5DAD719A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCE816D871
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484EE25393B;
	Thu, 12 Jun 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/9gzw+S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98324502D;
	Thu, 12 Jun 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734301; cv=none; b=aeCI0RRBTZM2Rdx8xQk4opC9zsZ72vi+b3MGAuMg8EOp3K4fgk6dB1qgHMQP0slsJoDaqauEvFVCs4qPgzq8BIdofZ3fzEsxL3cmhAMMGqw7fh5XILDz2eJhdG3tTeEhjFwN2bSFf3l5HM5e89QnCDpmkmv04Wb61JopKxiAVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734301; c=relaxed/simple;
	bh=6SZIFnmbLf8JV1vJNHSiq1P6ecTniyk9z2YoaDHDHKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5jJCuHgbbr25MkmjDtcnIMpzYSHl2jiIppx2MoMbq/afndUx8GbBNzlTYQy9okNZwvcDXzYPMhwVZyn6zdl1N3XW4V+PdCtmiXVojRDggeNtJwCa29a43dOT9GhysT7d74SbBXyebvf7MzXWnHhreCo3CUldDMWAJ3+Sbw2lrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/9gzw+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64212C4CEEA;
	Thu, 12 Jun 2025 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734299;
	bh=6SZIFnmbLf8JV1vJNHSiq1P6ecTniyk9z2YoaDHDHKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/9gzw+Sj9bAnBOePZPc+6llemB2Ta47w3C5ZmsoFID2TgBIBwPUCtuC7idEfc3Hm
	 cUqipnOxEDiiIWQngNoN8vo3u0n0OUGO9yA5xGq05aVqU66njci5WVvU8XTyFaHBbK
	 Uw0EE1D+epC9vwieMVa+ezGM7ws02SrNieTt7eRfNStM2sB1tihQAyTjY5p2cDVTDc
	 9rYGohNGO1LKDlrcDqvQZ4oN3PNoqfnCv1WIM9DlrvW/9lLsKWOOA8KMIXFlLxVIsS
	 4AJF6sw8nfalyCk8nmYDE2O9AjtRaE0suu/cVTQjxXS/LIu2HgHsVYGRWorRcD/b/O
	 cpcuuOBf8lGPA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Fix interrupt log message
Date: Thu, 12 Jun 2025 18:48:09 +0530
Message-ID: <174973424623.20170.44933782990222558.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607160201.807043-1-18255117159@163.com>
References: <20250607160201.807043-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 08 Jun 2025 00:01:58 +0800, Hans Zhang wrote:
> Detailed descriptions of interrupts can be seen from RK3399 TRM doc.
> I found two errors and cleaned up the driver by the way.
> 
> This patch series improves the logging accuracy and code cleanliness of
> the Rockchip PCIe host controller driver:
> 
> Log Message Clarifications
> 
> [...]

Applied, thanks!

[1/3] PCI: rockchip-host: Fix "Unexpected Completion" log message
      commit: fcc5f586c4edbcc10de23fb9b8c0972a84e945cd
[2/3] PCI: rockchip-host: Correct non-fatal error log message
      commit: 917600e630218ce61aa0551079592cb541391668
[3/3] PCI: rockchip-host: Remove unused header includes
      commit: 1fdb13f92388dfc936624b0a0d6abae362b0ace3

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

