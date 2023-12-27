Return-Path: <linux-pci+bounces-1418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A536881EDDB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BFB1F21682
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BFB28E34;
	Wed, 27 Dec 2023 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="IT9v5NBB";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="JcwKLlh3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBC286B5
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com CF1A1C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670365; bh=T7/F0FWKC0Ow4uaEbZVvDFdSptX9rapt1qbYdNZ95tg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=IT9v5NBBcpQupkG58WQRm2EVoSl5TKp9wRya8cJnbb21hEcmy7zxwqvOlUhxfrMyV
	 VhE+jD/DZJkYIgbApNprwZZn5L4kcwhXG8TjYzInx3ehwyOWYKCPSXxn7K4UFDalPj
	 GBIA+eIB0cG6az7gfWnV/kdV8AM8/rAvS8phI1YnbuMf58jSpAd9H9NT1+CGcEapUr
	 b0Wr34HRpyQ4K0QpgcW9KTFVeAfiBeSZoK1GQzdg+bESc1PC2dadLFFkh4PISKjOsb
	 SucGa5EFD41+9mSWGx3Q1YiyFFhltH5JJzp6g2hbkrKNqaKjz/7wZKc9dOv4l1Khwd
	 DHvhwDeg/rX4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670365; bh=T7/F0FWKC0Ow4uaEbZVvDFdSptX9rapt1qbYdNZ95tg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=JcwKLlh3YoMDztxRqK4lI2pN0A4S4VLfV2QK0ZAA3dxFTVPf04PajHfneoYIXxbUm
	 kftR1fMduaqsfRjnEfQdscCMOlUyvVfLmGHD3pRtTSwfOPGBH5XCPB9/VMDQk54jwc
	 feUgDCs9jpxqb1FmodfPgWEnJMyAYRh9lYg5XsatdFRw/E7AfVN4/I3nhvzsDGMxuP
	 5RD7EkdFjgX8fPpFhnyC5ffjwaxqEJi1S2VTKAXCBo776KBoPN4NIIEhvhXoA/w6K0
	 prAi37h3hjsrCwdTuikUpAvx+qNrYwRtdnX1ZxVRpSFbFBGMHPdz2h4gQrlSAnwmBp
	 7i4z1U55VIp7w==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 03/15] pciutils-lspci: Add Lane Margining support to the lspci
Date: Wed, 27 Dec 2023 14:44:52 +0500
Message-ID: <20231227094504.32257-4-n.proshkin@yadro.com>
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
index 6d2e7b0..9810044 100644
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
@@ -1610,7 +1630,7 @@ show_ext_caps(struct device *d, int type)
 	    printf("Physical Layer 16.0 GT/s <?>\n");
 	    break;
 	  case PCI_EXT_CAP_ID_LMR:
-	    printf("Lane Margining at the Receiver <?>\n");
+	    cap_lmr(d, where);
 	    break;
 	  case PCI_EXT_CAP_ID_HIER_ID:
 	    printf("Hierarchy ID <?>\n");
-- 
2.34.1


