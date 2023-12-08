Return-Path: <linux-pci+bounces-655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD8809F3C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459CA1C20A54
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38917125AF;
	Fri,  8 Dec 2023 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="jP9WvKLE";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="DGsFG2pI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A7171F
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 875B6C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027143; bh=O/zlUo1HspP9LNqAMQfBFrDOh0YlNsMwwIWZTQJsg1A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jP9WvKLET60gi7uFApNZhB4PTxrKxepnNufOp5CFNds6AJOo2qOaTYXNF+5kLsRjt
	 Flg4wfM2SXizTdZous5W610ooZayA3dsaelZ+4Ks2PBv1gBXKxH8gttZBK+xKdKhJ5
	 AWyEg6bu+obCEvS1UsO2Fc3uj6X7+F17YtGXrswMZ497h/qEgI6LgfETlfQ5vnTV0I
	 FZ3MRoRryjAyzn5L60xA3xifJShbLOD53Mvq/sXrx4fqDCaCeh+awyM+zodtZjW6x/
	 8CpAxDeiX5HuLaTNPXY45kl3TrtGEBxccS/xCbUM7wQqf0wExDIDqN+NNBkXausgbq
	 Q0aiz6QIg6g4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027143; bh=O/zlUo1HspP9LNqAMQfBFrDOh0YlNsMwwIWZTQJsg1A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=DGsFG2pIDPTf/uk++QCCEAdGwEhXjrixU/qJskfrywe2BnqdCxFpAgsNFX38XFNuI
	 XY7EgZiOZg5whRK/eUA+mDgg1cBHxe0x4MQirkDe1NVMEP1kpY0nDsKtUw2Oh9Y4kr
	 8tu0r0ve8w4GC6xIWT46fxCXd5tl51H5o92Ycx9KYUIwmRmN2hY0LFn4436ngHDcdf
	 2EuSiZpG9xzgBmnCN36EYd4CJYYcoGdxiC2BVGMk3AGbGPKV1CijOYHer8zrXEg6SU
	 cgs0qtNlNtRwFb+33/OTedIL+BZp8Wq1zStEDErUSDAGqwHG/hMUHUlI0Dg4ifTyOr
	 w9THLgGlz+hgg==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 03/15] pciutils-lspci: Add Lane Margining support to the lspci
Date: Fri, 8 Dec 2023 12:17:22 +0300
Message-ID: <20231208091734.12225-4-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208091734.12225-1-n.proshkin@yadro.com>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Gather all the info available without writing to the config space.
Without any commands margining capability exposes only 3 status bits to
read through Margining Port Capabilities and Margining Port Status registers.
It makes sense to show them anyway. For example, Margining Ready bit
indicates whether the device is actually ready for the margining process.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 ls-ecaps.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/ls-ecaps.c b/ls-ecaps.c
index 267d98e..cd6f5d1 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -691,6 +691,26 @@ cap_rcec(struct device *d, int where)
     printf("\t\tAssociatedBusNumbers: %02x-%02x\n", nextbusn, lastbusn );
 }
 
+static void
+cap_lmr(struct device *d, int where)
+{
+  printf("Lane Margining at the Receiver\n");
+
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where, 8))
+    return;
+
+  u16 port_caps = get_conf_word(d, where + PCI_LMR_CAPS);
+  u16 port_status = get_conf_word(d, where + PCI_LMR_PORT_STS);
+
+  printf("\t\tPortCap: Uses Driver%c\n", FLAG(port_caps, PCI_LMR_CAPS_DRVR));
+  printf("\t\tPortSta: MargReady%c MargSoftReady%c\n",
+         FLAG(port_status, PCI_LMR_PORT_STS_READY),
+         FLAG(port_status, PCI_LMR_PORT_STS_SOFT_READY));
+}
+
 static void
 cxl_range(u64 base, u64 size, int n)
 {
@@ -1548,7 +1568,7 @@ show_ext_caps(struct device *d, int type)
 	    printf("Physical Layer 16.0 GT/s <?>\n");
 	    break;
 	  case PCI_EXT_CAP_ID_LMR:
-	    printf("Lane Margining at the Receiver <?>\n");
+            cap_lmr(d, where);
 	    break;
 	  case PCI_EXT_CAP_ID_HIER_ID:
 	    printf("Hierarchy ID <?>\n");
-- 
2.34.1


