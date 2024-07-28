Return-Path: <linux-pci+bounces-10881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6093E355
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 03:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC451F21F72
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41B1AC45A;
	Sun, 28 Jul 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ3ZnU3V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC01AC42D;
	Sun, 28 Jul 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128201; cv=none; b=ORbzck4QBj/u7L0KszdmCbKUygHo5bqKlUn/sMVfWvZiRqT0uI0gsYLTAqyUqCpxiEOqPer0fCpPztaoust0yp41ySNPHYVeYegDt+NONjhnm4k5tYEW17ol7NqZoECvOVSdeSG1DHPY+VpjaOkVOYKPCX3mzh9HR7Wgdcn3uD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128201; c=relaxed/simple;
	bh=8A3LPGuXYv3E7eVwRDjfik1nvj+nHjlCDT27CJAQBHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eo5teQCW39ZrtPNnAwewyfx1CJWyfccZIMeAvJRD4UDjoyI7gKyAYpWzJEZCQIuUwV3FHvMgCWAcOZUIAh81eRSz7PrKYX1gjdZuhPK8gilGT0EbXnFc1idhk8fjHFlz2GkRj1nY4HEWapNWPVDJTLIz7XQzcs4k0Ci7zdoBeOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ3ZnU3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B193C32781;
	Sun, 28 Jul 2024 00:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128201;
	bh=8A3LPGuXYv3E7eVwRDjfik1nvj+nHjlCDT27CJAQBHc=;
	h=From:To:Cc:Subject:Date:From;
	b=aJ3ZnU3VkpPBqizYP19HPcFTmAfz46c1LNOsCmNzFz8HQj+xGm9cFyttv3y0D6z1k
	 lQqxq9SttSGe2Rc2czT5TNhfSWQwFsB9u66UxYo/EGjSLKabHdV1FTNjMmmNpMNMIe
	 nr81155SNsKyHanarOEkzVKWPE0XejRFdhke+Mka80WlwmkPGX2o8w0alCPPHoSdr6
	 CNSleyD8CYljeMn4ofbG/bQZDN4JQWTvvYFlLGFPxf66SyWC+oiOrCrn74eqnd7rL6
	 Yozm8rYJW0cjdoospkkjuHbSzR67yid9m13/blO3McCPb2ilzhQTclfjT/3e5iyem8
	 eG9JSaljQ0kBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/4] PCI: Add Edimax Vendor ID to pci_ids.h
Date: Sat, 27 Jul 2024 20:56:35 -0400
Message-ID: <20240728005638.1737527-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

[ Upstream commit eee5528890d54b22b46f833002355a5ee94c3bb4 ]

Add the Edimax Vendor ID (0x1432) for an ethernet driver for Tehuti
Networks TN40xx chips. This ID can be used for Realtek 8180 and Ralink
rt28xx wireless drivers.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20240623235507.108147-2-fujita.tomonori@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 3ac7b92b35b9d..91193284710f1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2136,6 +2136,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
-- 
2.43.0


