Return-Path: <linux-pci+bounces-18089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F339EC54D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CED328606D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 07:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F131C5F07;
	Wed, 11 Dec 2024 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kGEeXcZd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m127206.xmail.ntesmail.com (mail-m127206.xmail.ntesmail.com [115.236.127.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD711C5CD6
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900619; cv=none; b=M36Tt4IT0sL4z/Ilzq9t/R1PaoTa2iDjqx9s6WsMA9plcfvxy1H+NfxDY9M2YyjN1GpiMOWGJIzZpOlUUH9bCsIIS9Y/dWrAedy9N4PuUx6CGLKFT3qoW2WUvMGTs/Fm8WsiPiGxtRFUkUzmLdMGOJNFJ8U8ygy2HVaVdlOp6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900619; c=relaxed/simple;
	bh=O5M5KiUjZ0jzYUhcMLOTNmgn/QndIeaEpv2Nm0iOG8Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LJLgphYqAR+7tgp4q18fQndOEMc7/91N1M8EA7ZQjp6dfDlMBTLqcyRseJq9Y4HVY07y98GnXCSSIDF8WHjRYAsH2/0XU8yL2C86uaWpdO4YbV1C2jGQW4MXDdhTP0ZfSsR2VPY4GHk3YO6CNIu8y+R+ijjq2DQ7QycOXcNAvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kGEeXcZd; arc=none smtp.client-ip=115.236.127.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5634f3fb;
	Wed, 11 Dec 2024 14:58:24 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] PCI: Add Rockchip vendor ID
Date: Wed, 11 Dec 2024 14:58:12 +0800
Message-Id: <1733900293-169419-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9KH1YZThlIH09NSUJMSx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93b483004d09cckunm5634f3fb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6Iyo5UTIKKjIVGD8YOA88
	NToKFBdVSlVKTEhIQktLSEtOTkhIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU5KTzcG
DKIM-Signature:a=rsa-sha256;
	b=kGEeXcZdxvpEVwC5Fai+uK0g/EwQTEBHddmqRZwBfAbqSqyVtb0uSJb0SmIURyPvZMfUZGriFJMD1OjfsnwYfB7HHgo/iGOuDMbtmVuzXRtNVPxwgPt8Gi2lMF5uekM/7e9m/ZzBWHdj/Jdp27dUlZJ4mBDZma2/RYf3lYLGfaI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=NeSwLDckgABoXoOblNs/UFIvNqkHGEVF9lPKgickDh4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d2402bf..6f68267 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2604,6 +2604,8 @@
 
 #define PCI_VENDOR_ID_ZHAOXIN		0x1d17
 
+#define PCI_VENDOR_ID_ROCKCHIP		0x1d87
+
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
 #define PCI_VENDOR_ID_META		0x1d9b
-- 
2.7.4


