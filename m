Return-Path: <linux-pci+bounces-38070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49411BDAB34
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 18:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA1B3BBC6C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02904302CC7;
	Tue, 14 Oct 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DOnAas6y"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F3226863;
	Tue, 14 Oct 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460579; cv=none; b=M1gmALBres4OUAZjEyVMEtzVrCKfYOEBbYICUr6JB8GTXlLSt8k6Ec35SECPRaM4/s99N7mb15r/ibSBnz/oNM+dDJyVPaXPKcAbaBC4tf5TG5KtMljwgsuDfgSNWeGB7c5YQOWq2+7FOU91NOQ/7qQANlZ5mr4TBsldXO5Ci7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460579; c=relaxed/simple;
	bh=UwiIrfJPj3Rb3j2yAixN5rPXlyBm6a+1sySZeNJSpyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyNwgXBf7ptw8tJ9Q2IqmnWV4PohSHAm995h/YiIEOZvIn/3IZDttaZabKXDe7sozLSUQGSiMKx+dBMsRoilBn1PuxE2vChnSHP7X53faEbZeCWLJ2Ie9pf9ubsCy3cNdNP88xacdk5QJUz7djdCOYPx2OYA6UiBteSbwCFdIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DOnAas6y; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A5273261CB;
	Tue, 14 Oct 2025 18:49:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u7Wsu7gm3wgG; Tue, 14 Oct 2025 18:49:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760460575; bh=UwiIrfJPj3Rb3j2yAixN5rPXlyBm6a+1sySZeNJSpyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DOnAas6yGpiTHuYmDZJFI/GixzwMtZD5mwZnPmEXkt8xZlt+efBKT3c0acFniyvla
	 C+mmYx8fQueso16ehoimi2Ookmra+bFRXunwhSvIVk8KgU8pzFDPpva7DqDzJu4fhr
	 ZY1v2xzGSYelIjerHKFA8g6GINbSOutj3TkU7r4D6czJIR8WuWreobIoY5ka8ZBPfe
	 lGnqy+gFNzfietvVPJVNNbWMFQu40rBppu3LPULUZ/HdFLmIpfeJheqzyHW+FJ3Bur
	 isRvcI1SPKErl8Z8WJnlgs99sgN6ajczucu3UPCO9fH5dBdLcjgzycL/d6jmlz/M9T
	 hUhg44tqBiLEw==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 1/4] PCI: Add vendor ID for Motorcomm Electronic Technology
Date: Tue, 14 Oct 2025 16:47:44 +0000
Message-ID: <20251014164746.50696-3-ziyao@disroot.org>
In-Reply-To: <20251014164746.50696-2-ziyao@disroot.org>
References: <20251014164746.50696-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This company produces Ethernet controllers and PHYs. Add their vendor
ID, 0x1f0a[1], which is recorded by PCI-SIG and has been seen on their
PCI Ethernet cards.

Link: https://pcisig.com/membership/member-companies?combine=1f0a # [1]
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..0824a1a7663d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2631,6 +2631,8 @@
 
 #define PCI_VENDOR_ID_CXL		0x1e98
 
+#define PCI_VENDOR_ID_MOTORCOMM		0x1f0a
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.50.1


