Return-Path: <linux-pci+bounces-35625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3BB482BC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 05:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3CA7AB922
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 02:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8A71FDA92;
	Mon,  8 Sep 2025 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="iZqaXPw1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1800.securemx.jp [210.130.202.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19061157487;
	Mon,  8 Sep 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757300474; cv=none; b=SBs1OqHROI0PRaYnTxCKLYb/mchBgxgvBm9F7ZaPT1En5j/QTa6isfwfwINE8z0LNSxkSEVmVfQSetNd2iYXU8l5Vc1E6p80lHLt6MQsefyAB+ZHCmKLLf1xRw3ODZalnvH2+7y3Y4kC4M6hVgIZAwkjn4jqzf4kLYZEK0twKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757300474; c=relaxed/simple;
	bh=UOuCgsVOzcqGcD4bSe0mq3TlNWvnSHg5Np/d7vt13PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lZpaE3ZzzqAfk7oNnt5Cp4asISLC4yAZr78RAVverzRsKcSgHjSpSFxaAAvY2hPs73dQ7sFmZONaxIRSSe6xuGgkLDNztp9tqAEcZwemUEEPEpXXcgfwagWK6xF3qIuwtii5/KnH0ZiD6zv/fRkk1k3YudAnEs9mtQnqXADMeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=iZqaXPw1; arc=none smtp.client-ip=210.130.202.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1800) id 5882Yh4m3366788; Mon, 8 Sep 2025 11:34:44 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1757298853;x=1758508453;bh=
	UOuCgsVOzcqGcD4bSe0mq3TlNWvnSHg5Np/d7vt13PQ=;b=iZqaXPw160+CiPIhBtqrrViDlIvKS0
	viOmkwJGATdJ5endyJu1uTm4IjotbWxp2NDtKwCFELaiCNQpiWj7vHRQJCOe3XIIUJBwnifwqgZ5P
	H97STPBCs/DoX4o4Bbn7PMPSQq1DdNDNMeRAboKt6K8KW6VWoAUSv8TNybBlXZWug9dadq9HYcNyI
	uK7pkclc/vY4xuCPDMRqFLtFpNblLTGGYxEwwUdgZknZkXTSVp0rzl6mqNOe2Kax3oHUESvVDFIsm
	UDgKLrl4C/XQVjIMd7LPW0xwEU2hbxOXSbpyKsG+MJkoTYbRtocP6u0YsuBCClL1VVHAVHoyRtN4A
	WtDw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 5882YCH13421718; Mon, 8 Sep 2025 11:34:12 +0900
X-Iguazu-Qid: 2yAb1IXdsJfj9oAHkf
X-Iguazu-QSIG: v=2; s=0; t=1757298852; q=2yAb1IXdsJfj9oAHkf; m=Xw1EX/ZpLeBsPwnXn8A6IDPXLhm7k9BLgm4lJvZHWz8=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cKrch02TCz1xnZ; Mon,  8 Sep 2025 11:34:11 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH v3 0/2] pci: clean up cpu_addr_fixup() for visconti
Date: Mon,  8 Sep 2025 11:34:06 +0900
X-TSB-HOP2: ON
Message-Id: <1757298848-15154-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since 7db02f725df44 PCI: dwc: Use devicetree 'reg[config]' to derive CPU -> ATU addr offset

dwc common code have handled address translate by bus fabric.

1. Correct dts
2. remove cpu_addr_fixup()

dts change need be merge firstly.

Changes from v2:
  Move update in drivers/pci/controller/dwc/pcie-visconti.c to patch 2.
  Update Signed-off-by address, because my company email address has changed. 

Changes from v1:
  Update commit message.
  Fix range.
  Set true to use_parent_dt_ranges.
  move pcie under the dedicated sub-bus.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Frank Li (2):
  arm64: dts: toshiba: Update SoC and PCIe ranges to reflect hardware behavior
  PCI: dwc: visconti: Remove cpu_addr_fix() after DTS fix ranges

 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi  | 75 +++++++++++++---------
 drivers/pci/controller/dwc/pcie-visconti.c | 15 +----
 2 files changed, 47 insertions(+), 43 deletions(-)

-- 
2.51.0



