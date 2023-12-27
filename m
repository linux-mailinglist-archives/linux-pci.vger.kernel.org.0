Return-Path: <linux-pci+bounces-1417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B7381EDDA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3755E283856
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C46288B6;
	Wed, 27 Dec 2023 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="SUuvw1G2";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="Zw5EYan4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00F1095A
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com AF1F4C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670363; bh=xUVa7prqwAVqNbBX5/MWuagYaqe7bVGwSoh/co5ZIog=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=SUuvw1G24IP9ZKBS9YpGbwTCmp/IV3SEru1T+ZrQeE0wt30kpXsQWiokN4T5OIF98
	 Lbqix4FjFyc6R/HSeTnJfm6938lCKftQH41CN47MF6iYpB0Hv+wUFmv29rxh1yxBZF
	 t6b64Kby6JcyofhOuY46DMiLAB+IhUce8ORAUaV4yhbune743pxsSWq7giAKOpmoi0
	 2VNVEqhfm3YyKYZFLt5Qbyxqy2d11vLkmxhZoIpJdSzerEZOblogssnl7JxqjTtpSG
	 Va3jANqxLU8n8d/fWFa3GiPwOPyYdOdxVJ0bKX3k2/U41friPVkXVthdA+ccc43Q0G
	 iIU+fxsXJIoKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670363; bh=xUVa7prqwAVqNbBX5/MWuagYaqe7bVGwSoh/co5ZIog=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Zw5EYan49WgzUgyjaD/055f9yEy29CQTNLz1nS10llBQvNh2oVWa31bpmonVekWdY
	 dfhNt/0BYiCM1l2UzQl1RXWZCZ5lJ+SW4A2BHqZ9G2VV2b9Wc8fHSVVVd1ylwQvB3/
	 mCT8YRNiW2OqY2jHCuS1LU2j0NNaV9DsCce4pIWh8G/EBaf0r6+VdaTPkKJ1whKFN6
	 ExYTgoTpblLxeg02vgK7N5Qz/CRB7+7krUi16KytiToyJa0XfQWeWMq4gJy7Jca1HV
	 HPuM7gWrHRT0ScWkoQ0VfbSLeKElYp+ViJN5+7whC0mZxDUarakId6WPPeTiSB4blb
	 2tHb9zPED3aXw==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 02/15] pciutils: Add constants for Lane Margining at the Receiver Extended Capability
Date: Wed, 27 Dec 2023 14:44:51 +0500
Message-ID: <20231227094504.32257-3-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227094504.32257-1-n.proshkin@yadro.com>
References: <20231227094504.32257-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lib/header.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/header.h b/lib/header.h
index 2bace93..2141013 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1414,6 +1414,13 @@
 #define  PCI_DOE_STS_ERROR		0x4	/* DOE Error */
 #define  PCI_DOE_STS_OBJECT_READY	0x80000000 /* Data Object Ready */
 
+/* Lane Margining at the Receiver Extended Capability */
+#define PCI_LMR_CAPS			0x4 /* Margining Port Capabilities Register */
+#define PCI_LMR_CAPS_DRVR		0x1 /* Margining uses Driver Software */
+#define PCI_LMR_PORT_STS		0x6 /* Margining Port Status Register */
+#define PCI_LMR_PORT_STS_READY		0x1 /* Margining Ready */
+#define PCI_LMR_PORT_STS_SOFT_READY	0x2 /* Margining Software Ready */
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
-- 
2.34.1


