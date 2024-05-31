Return-Path: <linux-pci+bounces-8114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E958D602C
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 13:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3321C21205
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAA9156863;
	Fri, 31 May 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lk+qwqSC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7ose9lI"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2F1386B4;
	Fri, 31 May 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153432; cv=none; b=MC6Wtv46XNrfDQemBPIvjHGA2nv3Hhl0Nzlu2nuBikjl6GMnNjoP4DVNvKwsxgmmAIAD5PcyYv8LF3ILn1F6CDKtjvExHNxhAbYW0LPkUaPdLv1+wVfkVCcESg9NWy2zlUkTEeKkl0fxkb3jUAV0i1H9ND60X8rdSui0JOOLY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153432; c=relaxed/simple;
	bh=u2XM75t4IvA2pCbU6k8ocA0j7B1oVUN41SVqxqtDTms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t0eoo65uvWtM38hz6itJNzoLhlYSBUcT59FX8N4UvkP5IQHoSqipi+kv9uPaXUd1RM+jrtv3fPy6B5wxp1SKl+k7g2riqLzjJS7ZT1Tp/ehxZIVZmQad8XUs9/DkKgooWrTStfakPal01ZL8vixo44JSuJfgmGJDZpfnLPQXuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lk+qwqSC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7ose9lI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717153429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ilNHlPRGRrx6lQXkZab5wH5B1TU8D7A+BitRKeb8hDc=;
	b=Lk+qwqSC/+aH3JkkLiIp1JziwqOO5ppnj0DxcbmOqyJsG+nzqL0OTlpayMNciHkhN65EtC
	Hqxd9JwBsYD1vkpYAAL9J+S+MkYcORO/VNSqpFVIEJq3wWpwLkkL4JkmAoe/QBe73E3ebm
	SQQ+9oy80rtaufmYcdhcvSu2XVEY9kTtiAMKYIjsfnTok8m+ODpmqTT2kaf+UrL4t391Kj
	I2Sn5PX2TAdGFNxH5DUdpTHrWHOZMyE59r9wQm1Hj0S1hteiV0C/eSLjQu7lQygNMhJwdc
	EBsJTsxhBFLZXLJULMbkLR6O9lCO7tvgaZcqhE6gcS8z3B2sF8azGOJNXoBB/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717153429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ilNHlPRGRrx6lQXkZab5wH5B1TU8D7A+BitRKeb8hDc=;
	b=z7ose9lIBs8WgZTceQpfqST8NihAeZLAQR/WoBT1syJwD0umZDss3o960jtYVHejWNIpyu
	TkFsJvMpaeAC0GBw==
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: Bail out if bus number overflows during scan
Date: Fri, 31 May 2024 13:03:43 +0200
Message-Id: <20240531110343.3800767-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function pci_scan_bridge_extend(), if the variable next_busnr gets to
256, "child = pci_find_bus()" will return bus 0 (root bus). Consequently,
we have a circular PCI topology. The scan will then go in circle until the
kernel crashes due to stack overflow.

This can be reproduced with:
    qemu-system-x86_64 -machine pc-q35-2.10 \
    -kernel bzImage \
    -m 2048 -smp 1 -enable-kvm \
    -append "console=ttyS0 root=/dev/sda debug" \
    -nographic \
    -device pcie-root-port,bus=pcie.0,slot=1,id=rp1,bus-reserve=253 \
    -device pcie-root-port,bus=pcie.0,slot=2,id=rp2,bus-reserve=0 \
    -device pcie-root-port,bus=pcie.0,slot=3,id=rp3,bus-reserve=0

Check if next_busnr "overflow" and bail out if this is the case.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org # all
---
This bug exists since the beginning of git history. So I didn't bother
tracing beyond git to see which patch introduced this.
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2f28..03caae76337c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1382,6 +1382,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		else
 			next_busnr = max + 1;
 
+		if (next_busnr == 256)
+			goto out;
+
 		/*
 		 * Prevent assigning a bus number that already exists.
 		 * This can happen when a bridge is hot-plugged, so in this
-- 
2.39.2


