Return-Path: <linux-pci+bounces-12699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0896A99D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC35E1C20AB3
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78CF1D7E46;
	Tue,  3 Sep 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnalmnS7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2F1D7E3B
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396637; cv=none; b=NF4L/bPCL+f03empjtnd5UDeN0wCiVC2FsQdf4ygwdxIZ00GvQbgW89Q2GLWHradQj5JQ43tjfQbeKwNWxvRjSAUISHfN98uYHja2uK4zCAR/9OnQcS+BTY72FxKnTuIC8GERH9H+zScVRDAQFEnkc7HpvbiK87u5uZsb0xXleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396637; c=relaxed/simple;
	bh=vHendUxrr7qm67eycysQPGu+1hyPjOQ+daW7oEALHRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eBALWiPNeaAJViSzxjTwfSlvoUiOVqHTQpac8g8pv7+/McxTWX2iKUi1KhxUxQGRCdEhdWMhibXe5xWpqu3tJeg/IYAXbPVnHviMRD4NE5mYEO6aFwCJ0CYlG9Q1t1Cg5yAUYQY72V0dEYiwMUxat4om6wg2ZG0hd93cwAf1fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnalmnS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0590C4CEC4;
	Tue,  3 Sep 2024 20:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396637;
	bh=vHendUxrr7qm67eycysQPGu+1hyPjOQ+daW7oEALHRU=;
	h=From:To:Cc:Subject:Date:From;
	b=BnalmnS7pae/kNkUsElnxMlUkN6Lls4sAkt+D/4lqStNHDK2tgKefbLam3UUHlml8
	 ZeoU1k2FYGaBQShJwsg878muiAb3bRMcK6ZWHsCQ+V2kocAREiWaZLlFlYwwCsxS3d
	 1yEatCIlRuNynKr/IiYj/fsddPidY0GBkfHtl7tHv+oUV7uo1nP+DNZrNKWkN5612b
	 fkGGHNmpRHF9/ZcZ8aNwdfTG3dqyeHRxTnpa6wVehfyf0j6b4cf45sihEMqIoL2Pwl
	 HemXeIIK9YncmvSg5UzNzA83eLq1Ea1oLidovYSJWEvtqx1obQFckXaPHW1GdtD3p1
	 bXEpM/Q/zElwg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: endpoint: Fix enum pci_epc_bar_type kerneldoc
Date: Tue,  3 Sep 2024 15:50:33 -0500
Message-Id: <20240903205033.277037-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

e01c9797c0eb ("PCI: endpoint: Clean up hardware description for BARs")
added enum pci_epc_bar_type with incomplete kerneldoc.  Add the missing
piece.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci-epc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 85bdf2adb760..697cc190747d 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -149,6 +149,7 @@ struct pci_epc {
 };
 
 /**
+ * enum pci_epc_bar_type - configurability of endpoint BAR
  * @BAR_PROGRAMMABLE: The BAR mask can be configured by the EPC.
  * @BAR_FIXED: The BAR mask is fixed by the hardware.
  * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
-- 
2.34.1


