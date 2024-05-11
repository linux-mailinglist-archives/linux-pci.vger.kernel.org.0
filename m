Return-Path: <linux-pci+bounces-7387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEBB8C34C3
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2024 01:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BF91C20CCF
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469C3A1DD;
	Sat, 11 May 2024 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aLxPLrwV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Eph8/G8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8539225DD;
	Sat, 11 May 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715471746; cv=none; b=Bj7YdA3gjwi/NotSqo9iwKvGP3cCpcqp9BdPe+5LTZxxlCRjpahQvfZe5iDXTU95oyeGnvngxiakptG6aFJq0dHudwEkDYK5gYUy1Rna5hIcHazYRpE2o5kz8+u2y9r/IesNw9llX/ggaToOZvnhIaTB7d6OvXLPXhRelep7oHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715471746; c=relaxed/simple;
	bh=rVO5lZJEhHhvxcpoHjnXpZHEHvnrU5HiTLXlrFJGgWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PnyXWl+TZNvuFTHFCTQ/3xV3H6oDMJxbkFfMj/RxEOqA4bgXLVI47HML7brb7sCQenxVVXYrTKW/u1RUgX5IpwRBpo+CYuDM0d/lfhXyK/y7MwDu1E9inavkZkF3QKPZQ4Jvk9BwI+BOGO7BCsnDnk5i2Xm8Pmf5oKTerqkTQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aLxPLrwV; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Eph8/G8I; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VcN135T0Fz9skx;
	Sun, 12 May 2024 01:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1715471735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cXNaVFdnA5HjJO8L+nWGjE0a4+KNH79u4It+UoUubC0=;
	b=aLxPLrwVOz6aDQmqbBBvLrNkEbk73rf/9HhfaWtQpiiUs2K3AO+NpnKe+9soVxLfLGbCX5
	O69tvvvgPmE3ikdZo5cwSoSGMDnres+LUHzSt6OYUwDZi/N1NKw3uiFTdFJQXinDZQ3P6+
	B9EJIhMvp5f/hyLpI8/sQ2YPKCkm+MjdQGG/c9CTEFae79cmI1I4lekDM32hOmbMsqBBTn
	oha3iisOeBftDOtYU1Tfs5YOSMSvMWtEWHc9Yx89s+4eMnDBsBB+RBJNjwH+U4Qj0JsKvk
	cI2LvmN4N6ufjQQsz83ZQUanrzVOEH2uecKQXCpRKBwCA9XR5GGFVOX69GOvuQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1715471733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cXNaVFdnA5HjJO8L+nWGjE0a4+KNH79u4It+UoUubC0=;
	b=Eph8/G8ILNWfW9gAbEyAntnNplts8iFHPIj4zSEdVhPrQQUTiF+ZbcLF1q/WoGeN/OLWuh
	Th7TK3s2hKZZ6vK970c27PFRTyn68MseGuEyz0Y8J9MZgAgLTfx5aP8PnGrrQMFUan4x4n
	IR8Qf+o4vBaF7uuSMlwwWY7c3jQp1XM49wS9FY6J0DphiK0cFQ6flzSw+JBkXO755cWNtv
	W/bT7gUmPIVwjpKJbw8/4bfxbqyXnjDmTxX1eMiIK0CDjafsh8/qoPyllmqLb64eyPbKIZ
	4ZAPCJeXidEks2N/WFavzLST2iFWryBdajL0Cow6lDeVeG28WQ3HC/fDCUy7vA==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar: Demote WARN() to dev_warn_ratelimited() in rcar_pcie_wakeup()
Date: Sun, 12 May 2024 01:54:50 +0200
Message-ID: <20240511235513.77301-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: z1jyy4rkdkn68gw39fy76cs6sdywyxw6
X-MBO-RS-ID: 843f82a5d73b027546a
X-Rspamd-Queue-Id: 4VcN135T0Fz9skx

Avoid large backtrace, it is sufficient to warn the user that there has
been a link problem. Either the link has failed and the system is in need
of maintenance, or the link continues to work and user has been informed.
The message from the warning can be looked up in the sources.

This makes an actual link issue less verbose.

First of all, this controller has a limitation in that the controller
driver has to assist the hardware with transition to L1 link state by
writing L1IATN to PMCTRL register, the L1 and L0 link state switching
is not fully automatic on this controller.

In case of an ASMedia ASM1062 PCIe SATA controller which does not support
ASPM, on entry to suspend or during platform pm_test, the SATA controller
enters D3hot state and the link enters L1 state. If the SATA controller
wakes up before rcar_pcie_wakeup() was called and returns to D0, the link
returns to L0 before the controller driver even started its transition to
L1 link state. At this point, the SATA controller did send an PM_ENTER_L1
DLLP to the PCIe controller and the PCIe controller received it, and the
PCIe controller did set PMSR PMEL1RX bit.

Once rcar_pcie_wakeup() is called, if the link is already back in L0 state
and PMEL1RX bit is set, the controller driver has no way to determine if
it should perform the link transition to L1 state, or treat the link as if
it is in L0 state. Currently the driver attempts to perform the transition
to L1 link state unconditionally, which in this specific case fails with a
PMSR L1FAEG poll timeout, however the link still works as it is already
back in L0 state.

Reduce this warning verbosity. In case the link is really broken, the
rcar_pcie_config_access() would fail, otherwise it will succeed and any
system with this controller and ASM1062 can suspend without generating
a backtrace.

Fixes: 84b576146294 ("PCI: rcar: Finish transition to L1 state in rcar_pcie_config_access()")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/pcie-rcar-host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 996077ab7cfdb..c01efc6ea64f6 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -78,7 +78,11 @@ static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
 		writel(L1IATN, pcie_base + PMCTLR);
 		ret = readl_poll_timeout_atomic(pcie_base + PMSR, val,
 						val & L1FAEG, 10, 1000);
-		WARN(ret, "Timeout waiting for L1 link state, ret=%d\n", ret);
+		if (ret) {
+			dev_warn_ratelimited(pcie_dev,
+					     "Timeout waiting for L1 link state, ret=%d\n",
+					     ret);
+		}
 		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
 	}
 
-- 
2.43.0


