Return-Path: <linux-pci+bounces-6159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D3D8A23CF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 04:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B691C21F2C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 02:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32624DDA1;
	Fri, 12 Apr 2024 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDMxaAe6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0DC322B
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889445; cv=none; b=QcUkzDA8dqQg0Dma6COQ023jIgHjFdNoTfNnXfR/mctjWBtPETXkAW3tkGukiA/2GGMPnM+NLjqEuRL0mKEsxZRSOAYUE2zZRAiasQDLTtk16jOxD+schCQ6Vv4zxSawfauKkeQ/NvEc387PHenaMQ3pR2k/eP8Yfds27ChLJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889445; c=relaxed/simple;
	bh=HiXGHLZIGVbP/4SWHBC2OKseJqgpskR3c6BxJ2UIzzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdbXAX3ENWigFClBZ7XTuCzG0mEcLkGxGBRirKVS4aAi0GCiW2IPx8YGilOxidVEuTUeguAhU+BMM19ROXZ0zFnXoBiNMO1crolnKIHT2NyZEgcHcfPSgxc/lo+CfHmUAV5Nj9lcdeAKgPdA3sIbD6Ve3Q4cISNDH4IzINVhlmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDMxaAe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9407CC072AA;
	Fri, 12 Apr 2024 02:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712889444;
	bh=HiXGHLZIGVbP/4SWHBC2OKseJqgpskR3c6BxJ2UIzzM=;
	h=From:To:Cc:Subject:Date:From;
	b=GDMxaAe6Mf//QR8tIlECQQBFVTLYE1sX6P9IANcSUCFSvMsY8WJ3owa0tAe26/VaH
	 IqLMZkWdw7XVwdQy137PlUw/issDLCcf4bemQZVFpRkV0TWmLzXfMSrSndf/h84XMt
	 6KUJUvd552PDXEA12xT7BLTMzSba+yP7BCqOoh1HDYczxYwwzafFEV+ELh/APSts1+
	 iWgiP39n9YkgWqKMtcqFnIEAPl8QJG2G0fC5risa7aDgktGeOsJatEE1QD0tWPTkdT
	 lWx8TBggwuV6OwWNMMj9ucJciVvKxxxjjbdcY2piHsW1Wh7xybhHFZDuy/kQWa5/tJ
	 6WjENOQzk+ePQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] rockchip rk3399 port initialization fixes
Date: Fri, 12 Apr 2024 11:37:19 +0900
Message-ID: <20240412023721.1049303-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of patches to have the rockchip rk3399 host controller port
initialization follow the PCI specifications around PERST# signal timing
handling.

Changes from v2:
 - Use PCIE_T_PVPERL_MS macro in patch 1 (and remove useless comments).
 - Split second msleep() addition into patch 2 as suggested by Bjorn.

Changes from v1:
 - Add more specification details to the commit message.
 - Add missing msleep(100) after PERST# is deasserted.

Damien Le Moal (2):
  PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling
  PCI: rockchip-host: Wait 100ms after reset before starting configuration

 drivers/pci/controller/pcie-rockchip-host.c | 3 +++
 drivers/pci/pci.h                           | 7 +++++++
 2 files changed, 10 insertions(+)

-- 
2.44.0


