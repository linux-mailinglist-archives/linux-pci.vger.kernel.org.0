Return-Path: <linux-pci+bounces-28259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFBCAC079B
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 10:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0965C3A4A12
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6CE23507D;
	Thu, 22 May 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chJHbW5G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8250022B8D5;
	Thu, 22 May 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903629; cv=none; b=R4XLIOkcZLXro+madAYiNAgU1uPxlyGVwMX0IbhdU/AwbhvnL5MQKb25k1r4Mon/chzAR6uitFB4VzAErV3r+b1SqsVuezl1kUF8R/CP115JSKpU3ybGibTgNMsjK/LTI+22qB1q5AAhJMQJBStYRfutUIHxY1MBViiQZ0IekaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903629; c=relaxed/simple;
	bh=n9oU++bT/mBRsRIODU3q1PGZ1c/AzZwDFQmGZztTr08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4I6uv9m4tAtbzgPIC6ujNq/hjCzbRBQZENyFbinGXgultQ+0y95bp/XbM0Gllb4eoFzclvNjdUfrmtyFwxekd9JeO260PaCb8dmm2xT23WT5YNgWzayZyFo5tMPzfXeF2IThrlTL0ORqfZY754IYinw/VZ0zgr2m67yeHrWb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chJHbW5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4589C4CEE4;
	Thu, 22 May 2025 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747903629;
	bh=n9oU++bT/mBRsRIODU3q1PGZ1c/AzZwDFQmGZztTr08=;
	h=From:To:Cc:Subject:Date:From;
	b=chJHbW5GnCOXfXcxbu/CZsQhXtw/EBkRFbcgLKhneRziSYDqto0ftdLzxEw3eQWDl
	 ncCYwaX8Y75sUDUXH0CiDi2UeovYCBSvhgkI/fdcepSrSSkUX6nTefMsL9mY5FL11I
	 LZ43Ut6QRuwtqJFg3ma4y7s7F4zWrDG4YpaptNEy8O/bZ6FPKgAEe5VREaXKR8zsp3
	 LpOtlWicdUiuVIJCBjmSgEy3cAkVtni29e6bjGvduHlEMtiB72Sf1h+ed492dNA7sG
	 XR1U/JEPN55bY3+4K58SkyAzMzLNpaCii/J9MH4R6HnuSGGrdCyfbqVbzGbeKb85u9
	 NzcZcTfOAhc6w==
From: Philipp Stanner <phasta@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] PCI: Remove forgotten function prototype
Date: Thu, 22 May 2025 10:46:27 +0200
Message-ID: <20250522084626.150148-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The subsystem-internal header pci.h still contains the function
prototype of pcim_intx(), which has since been made public in the global
header.

Remove the redundant function prototype.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/pci/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cfc9e71a4d84..2dd7fa93d95b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1059,8 +1059,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
-int pcim_intx(struct pci_dev *dev, int enable);
-
 /*
  * Config Address for PCI Configuration Mechanism #1
  *
-- 
2.49.0


