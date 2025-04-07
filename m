Return-Path: <linux-pci+bounces-25357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAF3A7D1F8
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 04:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26EED16DE0B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 02:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0502144D4;
	Mon,  7 Apr 2025 02:07:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE392213E70
	for <linux-pci@vger.kernel.org>; Mon,  7 Apr 2025 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991653; cv=none; b=SjX00KMrHngXKoVkp59erR661eOdlB2DSsyN9FSsx6X1H3xw4fvHUe/juN+5oed9jNW9CZkaTJ77+xYU8kh/hf9fonUKxgRBpx4ay0sZkInIoGRcNcwypHtzx6i/dG+5gxayfxOReD6bCCzuZzvZcZ++FP69X/OIR+V37mnJY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991653; c=relaxed/simple;
	bh=LI1xxYswTZGnREaBh49kFITjcqbPBpNgdy0MRsQJsEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAxZv7RBuxlKweGoSRYanVtvy69WrrTkYf1yWYn1x8PY3DfmyaxvZ/bkrzlDEd1rysftfYHVUxpeUUjddoKNSLPmaQTPORQkqWmwNdaBiO+C22pw69Cvnq7Vit3zk/p4q7o5D+eWlEPrssySa+douBKJij5QlBdVWU3/ChppuAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1743991639-086e2365b83ef00001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id pCU9HxyFP6hAAIVa (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 07 Apr 2025 10:07:19 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 7 Apr
 2025 10:07:19 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Mon, 7 Apr 2025 10:07:19 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 7 Apr
 2025 10:06:03 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<leoliu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v6 3/4] PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
Date: Mon, 7 Apr 2025 10:05:56 +0800
X-ASG-Orig-Subj: [PATCH v6 3/4] PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
Message-ID: <20250407020557.1225166-4-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407020557.1225166-1-LeoLiu-oc@zhaoxin.com>
References: <20250407020557.1225166-1-LeoLiu-oc@zhaoxin.com>
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
X-Moderation-Data: 4/7/2025 10:07:18 AM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1743991639
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1201
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139599
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
 include/uapi/linux/pci_regs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ba326710f9c8..96dc910dc0eb 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -814,6 +814,9 @@
 #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Mess=
age Number */
 #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
 #define PCI_ERR_PREFIX_LOG	0x38	/* TLP Prefix LOG Register (up to 16 bytes=
) */
+#define PCI_ERR_UNCOR_MASK2	0x30	/* PCIe to PCI/PCI-X Bridge */
+#define PCI_ERR_UNCOR_SEVER2	0x34	/* PCIe to PCI/PCI-X Bridge */
+#define PCI_ERR_CAP2		0x38	/* PCIe to PCI/PCI-X Bridge */
=20
 /* Virtual Channel */
 #define PCI_VC_PORT_CAP1	0x04
--=20
2.34.1


