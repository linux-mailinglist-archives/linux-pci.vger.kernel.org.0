Return-Path: <linux-pci+bounces-13559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438989873F6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 14:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36F41F22AB1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9645D1B813;
	Thu, 26 Sep 2024 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSSiPCgS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705A46B8;
	Thu, 26 Sep 2024 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355555; cv=none; b=sKfrXXJB01Nti2K/QslRammrJzGw+ASeveNcj1lN1PJxLy8Yi6Ni2sbWvX3l3Q91gNVvheezmQtPQCs60Ca9OTjBFdpfqURIFrB+D5uAt6mmUMK4THjSKE7Y+yLNdN948B+6ZQUABgxCvvX3OQ8qUMpYabhj+wLjO90/5sQgUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355555; c=relaxed/simple;
	bh=ZdAhJ21QIG7zDxsr1ekfjLiEacNTsOqySk9F470vs8o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=enQK2NGvw/S0bXsrkEAWPFhovpOH3BZbC0j2Avcd/GIi9wZDJWziw++BbMZ9vrr5kxxHhH8nlKdgFjzAJFnfzeNB76WD11sK59ERzBPM0TuPw7PpRRi2y3MHEVem9Xe2hd/y3J2D0CTCUPWoFDpT2mMGppHylDyQbZNV6KP8Viw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSSiPCgS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e09fe0a878so374120a91.1;
        Thu, 26 Sep 2024 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727355553; x=1727960353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BF/l0giiWeqh3E8td9Oj70/mWfqZQ+JFj8iInRlZrCs=;
        b=nSSiPCgSF4MsuiajiTGjwAWfeBuR9G4zRSbeeW0LZsQBUG2anpWP48sA3A7DXPPc1V
         mbTIFx6BfRkTglpSSQWwTEkp8ZVvfPe3Pw25f5V8SnOSlk+Oa2UG2kOg9ct2IWPXir40
         kX0CaqsVfWiLofKC4P79YHN+0OnFEhcEPOaVsqqg3saBDe0Sk6e5QyMQAlaantMeDodu
         Ge4191QyS5V17gmB4wJ1sHzPWZNmLo+Z4b+OGeMKEEvk6YqtAKarUMrojR0lO+Z1KAO2
         pRRF0r37SchVzZ4Hrrzco46JR9TetHEpTVmFI8x3hxk8Bu0PwQaylTFHbDma8xWun0Om
         Zuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727355553; x=1727960353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BF/l0giiWeqh3E8td9Oj70/mWfqZQ+JFj8iInRlZrCs=;
        b=YHqx8/FBZHPiTuBq/j0NfshWAmxgskXM9mYTXW+L89Yzc49Nqgsmuk9r8bfBvw/1ZQ
         cylpQv1sIPJpQjoaIKvTXYv05eLZTVMfmidA1/BpsOpUksCSgDU0Rfz9s0IgYO9n0AfQ
         1qjztxpJSNaR8l6UGxy4pcRv9ZxAbjGWhoZ9bQIFkn90i7bZ7LlitYcG2SoMiC8uEc+N
         /HV9RBI+07SM2Q/Tjcg0x3w9ScAWKURKDH3dstPGDiSIIirBxyMYlLRVXpDJS47EQs1Q
         lJ9LufTX43P4wYZfcp3e45nj4WJnvLB6K8IHPxbjS79PZjVn8j0zYtHbR9lC/SBneH3G
         JK0w==
X-Forwarded-Encrypted: i=1; AJvYcCUSaNYX4zATroqH7Lg0t4Z57gApfL/C1Q0723Wdu4ouNMYMb+oWd+vUNFjVk4mttsDD8oZFvxCtUmo4XOQ=@vger.kernel.org, AJvYcCW9HEnaOnYo5LUxrQI2GknksJ7omNgIRFMExAFATjZXdwiAfAoGOuIRATNsjIwgReBEsmYDbYRji7fd@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUNzDngNWGH0wXxTh2AtKVlop8lfEeAeNNbtd6BYxlY9Ls24v
	AkqTjYQAj3+f+/nuMmD1Gheg3oUJ2brNc2EBX4cxgTlUmDkDvXUg
X-Google-Smtp-Source: AGHT+IGCEmdD/303ltSrV1xAx1icEtx6TH4RwTjDUqd/D4uDqZkClrgU5DgSVOGX6N9Nryl5ewehtg==
X-Received: by 2002:a17:90a:a789:b0:2dd:4f6b:6394 with SMTP id 98e67ed59e1d1-2e06ae73c2dmr7266993a91.19.1727355552646;
        Thu, 26 Sep 2024 05:59:12 -0700 (PDT)
Received: from localhost (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e05b57dff9sm2393314a91.1.2024.09.26.05.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:59:11 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug during suspend
Date: Thu, 26 Sep 2024 20:59:09 +0800
Message-ID: <20240926125909.2362244-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary pci_walk_bus() call in pciehp_resume_noirq(). This
fixes a system hang that occurs when resuming after a Thunderbolt dock
with attached thunderbolt storage is unplugged during system suspend.

The PCI core already handles setting the disconnected state for devices
under a port during suspend/resume. The redundant bus walk was
interfering with proper hardware state detection during resume, causing
a system hang when hot-unplugging daisy-chained Thunderbolt devices.

Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/pci/hotplug/pciehp_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e692fed..c1c3f7e2bc43 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -330,8 +330,6 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
 		 */
 		if (pciehp_device_replaced(ctrl)) {
 			ctrl_dbg(ctrl, "device replaced during system sleep\n");
-			pci_walk_bus(ctrl->pcie->port->subordinate,
-				     pci_dev_set_disconnected, NULL);
 			pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
 		}
 	}
-- 
2.43.0


