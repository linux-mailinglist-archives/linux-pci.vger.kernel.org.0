Return-Path: <linux-pci+bounces-6180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B5B8A2B96
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 11:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB38B21F9F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C6951C54;
	Fri, 12 Apr 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="iwRtVJQh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eLJcdaXt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF45102F;
	Fri, 12 Apr 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915456; cv=none; b=IL7N6AN268o/FwZffB3Jv+D7EPKvTPg4iP7h4GxrGh/8uj2CKMui+Ace9uAXJOhvBKiUvu/aTWLjl1sTCSAl/pHvCY7QH+u4rMeAdik+g5z4pvgvkmnsUPBUQaGfqmMCUGyZnZILLPvL/JfSiXjJ3g4Ns6L4a4VsPwn+YgROLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915456; c=relaxed/simple;
	bh=1IgzUj1eTO/PMSNfq6ZmN/QoFcyQyezZTR1aBc3v9QI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OU10xsCfz7o8JNOMIhfbdoMDsKEP2q2fXHM4hHZEy4KlWzhs0X6PcEp7vKL/oMlrPc8bjelTtIm+KHGKQ9t9ZEH6PQEypBuwkgac7Pz+Yx9140v9pdRBtsF/+xnhFSmnfwebCTupZr2ZqQkUUmP5DkS5i0NeE65Tzfa9rD4MuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=iwRtVJQh; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=eLJcdaXt reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1712915452; x=1744451452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QgmGdOEg7DQ1tbApfsUFEBLKwsTG/q51J960XOq9RNs=;
  b=iwRtVJQhcCSjgOFKCaIKKXQwhAZGjglnNnytQyCCJyl5m/H2guHT0xSH
   HBC4QdhhakSourEZaNKxDry8aNMmG7sA6jz0Sw8lWztHXJRp+MF0zX7lf
   KGlmHrTD5cErln5KBH3jGss8H6Ailpao4fHM6t6HKp94EIu27fg6MeW9A
   Qd8v7IWWyrlz+2d18CD06Z9tuBWwLo3o6Et1+Hqhs0yA7ePU8Muh9iMdt
   udmrquofLK543ui9WLehQFY63as95/5tA+IyfHszzDNfsaxrvM5ipgoAZ
   KEpajY2hJyPgGg9ZJs3KJRk6bHcT+1Uls4ItgNDzdKC/RNNuViH7cPsQ3
   g==;
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="scan'208";a="36387222"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Apr 2024 11:50:43 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51F3416F476;
	Fri, 12 Apr 2024 11:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1712915439; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=QgmGdOEg7DQ1tbApfsUFEBLKwsTG/q51J960XOq9RNs=;
	b=eLJcdaXtCcPDUsh17wT3L4DWPuDzstek0kkdq7E5sWLD6P4yD0hbvexOeCkhqKsFnWXTtz
	mID5ZL1IO42zIhi4YWfIDeZ4zVlT40FCENCWnrr6i2L5t0mQcVjnnyyTHDIx984ef5isKU
	JyoXnBh3vGJMiMNV7GPsH/oZcNMFbpv0S2ClUUnIov9nGRauiJzb5Wbn0gUmBJnK3b/+N4
	3at3Lhb9HKEq9Q4UVCZ16vlBR5bplj5nMNqBkZh8biiGgzFrqcEhvGX2UuhxQdxAeVqzsC
	gZD9XFXaYk7BcyUfWdcdG8i7PQ9zZhR3lSmMbPODXKS77/sR7lVyfpwoePPGsQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] Documentation: PCI: pci-endpoint: Fix EPF ops list
Date: Fri, 12 Apr 2024 11:50:31 +0200
Message-Id: <20240412095031.256163-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

With commit 5779dd0a7dbd7 ("PCI: endpoint: Use notification chain
mechanism to notify EPC events to EPF") the linkup callback has been
removed and replaced by EPC event notifications.

With commit 256ae475201b1 ("PCI: endpoint: Add pci_epf_ops to expose
function-specific attrs") a new (optional) add_cfs callback was added.
Update documentation accordingly.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Separated paragraphs by blank line

 Documentation/PCI/endpoint/pci-endpoint.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 4f5622a65555..3961ff4e5beb 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -172,8 +172,7 @@ by the PCI endpoint function driver.
 	 * bind: ops to perform when a EPC device has been bound to EPF device
 	 * unbind: ops to perform when a binding has been lost between a EPC
 	   device and EPF device
-	 * linkup: ops to perform when the EPC device has established a
-	   connection with a host system
+	 * add_cfs: optional ops to create function specific config attributes
 
   The PCI Function driver can then register the PCI EPF driver by using
   pci_epf_register_driver().
-- 
2.34.1


