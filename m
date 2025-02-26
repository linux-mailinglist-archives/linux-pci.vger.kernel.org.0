Return-Path: <linux-pci+bounces-22479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A349A4705E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 01:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C12716EBFE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 00:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B81BC2A;
	Thu, 27 Feb 2025 00:37:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8427005B
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616676; cv=none; b=oh7no9mhAcIW5IIcPcJzYf8pFY7p7fINs9Pviu8OcLwPExE5ijXgDyl5g1LW8p3edbveTKG4WiJiPZ74FCJYV4r4MCCmu54KNz9CXSPnTYyzljSbDA8IwwtuGtwwbTBRo6LH5ecY20le9dyBJ2iJLxUJAOeHAYQhjGamJGD/ZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616676; c=relaxed/simple;
	bh=VNYGYJK2seFGVd1KiZeuCd8DMJxYxkvPtam/PB9klKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imq/CeakGVP3ulKMv7SEjQk6n8Juxh8zXfRAvlIv6LjiFjaK9tSZrJDLoJ/Uvnva5j8CHCne30/qxMNsl+8r4gseVafxEGwxFNiNuudJ+7Dx/Yq0gqfSa+u3VHVgk35+wYKWU9M8I5NUiYteOc2ZSIms9ngNEiq41NZHt2Lqnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1740616659-086e23601815e2e0002-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id IjfANJBAOSPLeToM (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 27 Feb 2025 08:37:40 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 27 Feb
 2025 08:37:40 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298]) by
 ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298%4]) with mapi id
 15.01.2507.044; Thu, 27 Feb 2025 08:37:40 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Feb
 2025 20:19:02 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<leoliu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v5 3/4] PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
Date: Wed, 26 Feb 2025 20:18:37 +0800
X-ASG-Orig-Subj: [PATCH v5 3/4] PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
Message-ID: <20250226121838.364533-4-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226121838.364533-1-LeoLiu-oc@zhaoxin.com>
References: <20250226121838.364533-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 2/27/2025 8:37:38 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1740616660
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1179
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.137757
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

Define secondary uncorrectable error mask register, secondary
uncorrectable error severity register and secondary error capabilities and
control register bits in AER capability for PCIe to PCI/PCI-X Bridge.
Please refer to PCIe to PCI/PCI-X Bridge Specification r1.0, sec 5.2.3.2,
5.2.3.3 and 5.2.3.4.

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 include/uapi/linux/pci_regs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..0566c663beb7 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -812,6 +812,10 @@
 #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
 #define PCI_ERR_PREFIX_LOG	0x38	/* TLP Prefix LOG Register (up to 16 bytes=
) */
=20
+#define PCI_ERR_UNCOR_MASK2	0x30	/* PCIe to PCI/PCI-X Bridge */
+#define PCI_ERR_UNCOR_SEVER2	0x34	/* PCIe to PCI/PCI-X Bridge */
+#define PCI_ERR_CAP2		0x38	/* PCIe to PCI/PCI-X Bridge */
+
 /* Virtual Channel */
 #define PCI_VC_PORT_CAP1	0x04
 #define  PCI_VC_CAP1_EVCC	0x00000007	/* extended VC count */
--=20
2.34.1


