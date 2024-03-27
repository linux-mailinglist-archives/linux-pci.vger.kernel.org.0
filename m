Return-Path: <linux-pci+bounces-5275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0486288ED8E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360C61C32600
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274F314EC49;
	Wed, 27 Mar 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYavmSnH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153614D281;
	Wed, 27 Mar 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562558; cv=none; b=D1MwXjENv3EADZaWpRZ/G+PY61S1pHY0IDHxsjS2UkWVsulGvHo0oH1rz14J//Yhd6lR0odi2w+jKjeu4bFNQoqz41fQhQ+sH//GvwrtWJ2v0epaBoqPoV+mKcI3eSE5da58fJ6mjMGDT8cuwi1h7B3+MvKYPAGeViwHcGAjnLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562558; c=relaxed/simple;
	bh=d1k8X7xmdafZmpo6x3G2deIJKdowcAVRxMW8wfsWQnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P3ZmGXONMRTwOU4PpkaCIrSMHCCzzcAu+NamwKDCB6kpgYrb9r+fqVmoglMnSa2sSnQaDRjbYzSDKlWwj/5gIjorysQh+ENgQfE0eKJOvX0wEq2ecOMV3Cg+JCBdOTzh/rfv05rMDoVoEqfh5Dpoyd9WMG/S/e5msy6Zo5JK9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYavmSnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0BAC433C7;
	Wed, 27 Mar 2024 18:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562557;
	bh=d1k8X7xmdafZmpo6x3G2deIJKdowcAVRxMW8wfsWQnI=;
	h=From:To:Cc:Subject:Date:From;
	b=SYavmSnHUIH0OwVJCJI/Y4OTjUSQH7jh/vhvxTUDOrJgmlYMMVTU+F4IEduby77nS
	 9jdmo1nqUsTuSY+gnsTjIEr8tMLn3XhWNHzFPuCzw6uoErZ4KjJVEdfqPLwqCoB+2H
	 qj1FrUFqzV3glFC+WoCc89KSFLCt7opffozX835yc771pkEcEfMr8oOq6OU3MmAEx6
	 HUjcPaVGslkNY4wJ8Sc1O7naSrrYkadjIXpV0XXCSgkMEGAU/K1aP5Vv9xoM6kvaJB
	 qWnfFGoS97Rpzleef/cvmNjRGDtrXh+iEkU3sijsVGrjeSJ3k63lm5MfNBtwSXql1v
	 Ab5pa4KOyAlCA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Update pci_find_capability() stub return values
Date: Wed, 27 Mar 2024 13:02:34 -0500
Message-Id: <20240327180234.1529164-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

f646c2a0a668 ("PCI: Return u8 from pci_find_capability() and similar") and
ee8b1c478a9f ("PCI: Return u16 from pci_find_ext_capability() and similar")
updated the return type of the extern declarations, but neglected to update
the type of the stubs used CONFIG_PCI is not enabled.

Update them to match the extern declarations.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index b19992a5dfaf..6a09bd9636d5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2011,10 +2011,9 @@ static inline int pci_register_driver(struct pci_driver *drv)
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline u8 pci_find_capability(struct pci_dev *dev, int cap)
 { return 0; }
-static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
-					   int cap)
+static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post, int cap)
 { return 0; }
-static inline int pci_find_ext_capability(struct pci_dev *dev, int cap)
+static inline u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
 { return 0; }
 
 static inline u64 pci_get_dsn(struct pci_dev *dev)
-- 
2.34.1


