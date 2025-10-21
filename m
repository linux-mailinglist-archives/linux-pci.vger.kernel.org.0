Return-Path: <linux-pci+bounces-38861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 449B1BF51E8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 09:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14CDE4FF7F2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C624A27FD68;
	Tue, 21 Oct 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Vq3LJ7/U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49237.qiye.163.com (mail-m49237.qiye.163.com [45.254.49.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807F27CCE0
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033258; cv=none; b=bjr427bUUphZFNDZ5UfjiIlwmIOJd8XCflmLVzzbeGYgU2XVap4+wa5v+yEmz6Tk+Nb7dWb6dlcYgQDrsEALtpYLoABHBnmHtOkiezqY+3VBKEayp6kwABTmHwUEtvL8jj/KtQ82b8VZys5AUj9bzpyEgrjW6PacvmAbtI2wdsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033258; c=relaxed/simple;
	bh=fo8/mrojmt6vNGKkiyUd2Ip7JLOqYwBtLut+V+A+ZAA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MZZ1QcLi69MxMMwJXKdVfvvtsxhg8IBHpu+Z4z6ujSfxuqR5eE77/pa8aBIBH9WbrbZZErx4bnnNpIySuaENO9Q6esAfxdMVJ5ELsI05oesMEPzjcodWsXJfaJ3qFEIOAupyJxsx+Jn2f8ez33Oafa4/x7fN++gc4ZduQmnT380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Vq3LJ7/U; arc=none smtp.client-ip=45.254.49.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26a1f526e;
	Tue, 21 Oct 2025 15:48:57 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/4] Add L1 substates support for Rockchip platforms
Date: Tue, 21 Oct 2025 15:48:23 +0800
Message-Id: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9a05be1e2309cckunm38953c58648025
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhOQ1ZCQk9JHUsdGE1JSU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Vq3LJ7/UGNDBdYOue34NgFlI1e8t5JJOYSzVN2d/DJK02q0KePB/H/l9zU+hf3ODFCXdQUTtXVCt8myp95loi/M0w7MSvD5VM3TxZtfC2xi+f7I3M3KQDQyJHRmmgn5iqLch2+L8eGdKBu+eLReQvJSJ3lMza2RGGWSfDCCFqeI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=VCQl/FqWE9J7fIKvF5/urqWiEUcYew2okAi1/XK5yYQ=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>


This patch-set adds ASPM L1 substates support for Rockchip platform.
As supports-clkreq is used by some more host drivers, patch 1 creates
of_pci_clkreq_present() and patch 2 reuse it. Patch 3 enables or disables
L1 substates on Rockchip driver by checking if clkreq# is ready. Patch 4
enable L1 substates on RK3588-EVB1.

This series of patches is tested on RK3588-EVB1 with a NVMe connected
to the pcie3x4 slot(actually I tested several NVMes), A RTL8111 NIC card
connected pcie2x1l1 and a broadcom Wi-Fi connected to pcie2x1l0. All works
fine under L1 substates by checking the LTSSM.



Shawn Lin (1):
  arm64: dts: rockchip: Add PCIe clkreq stuff for RK3588 EVB1
  PCI: dw-rockchip: Add L1sub support
  PCI: tegra194: Use of_pci_clkreq_present() instead
  PCI: of: Add of_pci_clkreq_present()


 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.7.4


