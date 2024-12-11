Return-Path: <linux-pci+bounces-18093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DE9EC597
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94662852FB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF41D86FF;
	Wed, 11 Dec 2024 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ypco1HAR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC71C5F21
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902184; cv=none; b=PmPRgCzavdjjn9Ckx1oV9n0QlzAeAONilrqGDDkW4/Aw1pEHNSiOwBzM2bIagZ+yttAniqujbKPAWamEMY/iYkwtZJe5pMpRMpz6gJ5LMKu3wEtoZSDZJGrkB1/1MKeSFu/7YlCmIEAqVS32dDPJ69CHyYU41pApGRWK/vhOAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902184; c=relaxed/simple;
	bh=Ui2/Jdpz1fxUj57/NUfwZXPgzbfy6zMSI8MNHCZHnUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XHn1G2w5/6pv71fgnSfFzfspihZtkcfkl0KP9jCkz08WoSs7F0/s9AiOiMx2MjKZMdUP21ufEGWQRzMjzMKwLVaZSWBe8sFiA2osQReyCBnwPFbGsgMR/dB2R3zZIgkhaqS24b77soD51by/CsXcDeebuGyD8MlAXEle/RlvEhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ypco1HAR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725dc290c00so318562b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 23:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733902181; x=1734506981; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8/oq+gebTAnADYfYNzQqdkR7lTEj/+kWYp6cfNh4N6g=;
        b=Ypco1HARloPtoVKz8IsXikNcTOPmWrnM3hcDmFAOFxiyLXECllxHEE3qgHlTrpRD2m
         9+PH+cr9YeMhfs/uwo+KdJy6DWrr/q1Jl9BRNvUE/i4C7NckfbKY2W8Jj2Z1Pbl9s1oL
         7yb6dCGYX+RR0cozLbXqwqawIqrMi+hzYbTFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733902181; x=1734506981;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/oq+gebTAnADYfYNzQqdkR7lTEj/+kWYp6cfNh4N6g=;
        b=t8xWaarcC97gbqBKHrUlXURJ6aKff2eklD88dXKLIhs7czrUS8q3T7Pmkf8swkUlQB
         +U9sDjTNsO5ovUAPBX+1vquhlGVuLyzaRAOJb/TwVTzcoj2cdmAPFq8XxLbrI5v58fq0
         ukH0Iv51w9brkPDKdoiWwyJQVYfFBrHNFwucD+nYa/5wvBjhn26dR7gzpSoqhucrMLKZ
         lu0DVJLm8dEYoJbDU8mc+z/W6OahG3g5S2JloUIdFtq3JivpjA+vJgzn+iG63LgMyfpW
         XvYJhSyUxwJ1M7nEgJYQxJXoZtRtTgvEQ09QYYzSskkKbzowHPTB1rnOL4h1Z7mF21cX
         3hBw==
X-Gm-Message-State: AOJu0Yw5V06jNIK+9EtZL5Wd0rXy7NnlxJXiWTdFFuVDQB+WnVbWWD//
	uCaPFY2DRigHoOHUSAAK+SnvTFghBSD87/dK+igDkR987fai8J/lWEN11wGG7D98Svo48b0dkfR
	oi321bc/iZGEeruuwOEUmsn+I3Rzbad6GxU6bAoet/lWOdVay4Y7Kwzkfq6Cd2i4dMpYUdyxmNI
	O18iuniWi5ud/wDaR7wCGRnyiBAuej/zsMGNkCX1GzAh4Q82z2lEDSOrKJvZzM37UAdQ==
X-Gm-Gg: ASbGncuc4XKDI0lbNh/vEOxYJKMoLzQirxjEI4Y6TV2BOse5uF0/qNJ+iDNB6zXTXPW
	8L49wfRE6yE9usQl6OLhJwiqrzwRoTjeiwABNcnFwrjrOFZDZdMOR/Cfcj6+Shy2T7zoGnsRZ9d
	xQRLK38UXh9ZLOELEl9BpKmvQGDtoUiW7vIezC66h8T8QTt4O/Sbax3b2hjZXb3YsPFa5JXhnJW
	ihk61aKpQ4/LuYvb183d6MuE4mDlfJZBPZEXsSPAVquk9GlZDJu4VNLb3GHuheRIQhT/aKXuuvH
	BYGLo98hjPQXkw7JMVrbXzGuQ28u8TqZGCgYZTG5/IEE83g19NrN+klCJsKo+g==
X-Google-Smtp-Source: AGHT+IFOzanYKtnaLHjb7nE4GzsLl0AT8VJBXbmwVneBepN2mAgXSwZ2Jw0VJvwyFz/yHtFGHb4bvA==
X-Received: by 2002:a05:6a21:3396:b0:1e1:a789:1b4d with SMTP id adf61e73a8af0-1e1c2720ba0mr2236406637.15.1733902181215;
        Tue, 10 Dec 2024 23:29:41 -0800 (PST)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cc7fcfb2sm7540539b3a.141.2024.12.10.23.29.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:29:40 -0800 (PST)
From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	logang@deltatee.com,
	Jonathan.Cameron@huawei.com
Cc: linux-kernel@vger.kernel.org,
	sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com,
	sjeaugey@nvidia.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v3 2/2] PCI/P2PDMA: Modify p2p_dma_distance to detect P2P links
Date: Tue, 10 Dec 2024 23:17:48 -0800
Message-Id: <1733901468-14860-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1733901468-14860-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1733901468-14860-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Update the p2p_dma_distance() to determine inter-switch P2P links existing
between two switches and use this to calculate the DMA distance between
two devices. This requires enabling the PCIE_P2P_LINK config option in
the kernel.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
Changes in v3:
Fixed review comments from Jonathan

 drivers/pci/p2pdma.c        | 18 +++++++++++++++++-
 drivers/pci/pcie/p2p_link.c | 18 ++++++++++++++++++
 drivers/pci/pcie/p2p_link.h |  5 +++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7abd4f546d3c..9482bf0b1a02 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -20,6 +20,7 @@
 #include <linux/random.h>
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
+#include "pcie/p2p_link.h"
 
 struct pci_p2pdma {
 	struct gen_pool *pool;
@@ -576,7 +577,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool verbose)
 {
 	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
-	struct pci_dev *a = provider, *b = client, *bb;
+	struct pci_dev *a = provider, *b = client, *bb, *b_p2p_link = NULL;
 	bool acs_redirects = false;
 	struct pci_p2pdma *p2pdma;
 	struct seq_buf acs_list;
@@ -606,6 +607,18 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			if (a == bb)
 				goto check_b_path_acs;
 
+#ifdef CONFIG_PCIE_P2P_LINK
+			/*
+			 * If both upstream bridges have Inter switch P2P link
+			 * available, P2P DMA distance can account for optimized
+			 * path.
+			 */
+			if (pcie_port_is_p2p_link_available(a, bb)) {
+				b_p2p_link = bb;
+				goto check_b_path_acs;
+			}
+#endif
+
 			bb = pci_upstream_bridge(bb);
 			dist_b++;
 		}
@@ -629,6 +642,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			acs_cnt++;
 		}
 
+		if (bb == b_p2p_link)
+			break;
+
 		bb = pci_upstream_bridge(bb);
 	}
 
diff --git a/drivers/pci/pcie/p2p_link.c b/drivers/pci/pcie/p2p_link.c
index dec5c4cbcf13..87651dfa1981 100644
--- a/drivers/pci/pcie/p2p_link.c
+++ b/drivers/pci/pcie/p2p_link.c
@@ -141,3 +141,21 @@ void p2p_link_sysfs_update_group(struct pci_dev *pdev)
 
 	sysfs_update_group(&pdev->dev.kobj, &pcie_port_p2p_link_attr_group);
 }
+
+/*
+ * pcie_port_is_p2p_link_available: Determine if a P2P link is available
+ * between the two upstream bridges. The serial number of the two devices
+ * will be compared and if they are same then it is considered that the P2P
+ * link is available.
+ *
+ * Return value: true if inter switch P2P is available, return false otherwise.
+ */
+bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct pci_dev *b)
+{
+	if (!pcie_port_is_p2p_supported(a) || !pcie_port_is_p2p_supported(b))
+		return false;
+
+	/* the above check validates DSN is valid for both devices */
+	return pci_get_dsn(a) == pci_get_dsn(b);
+}
+EXPORT_SYMBOL_GPL(pcie_port_is_p2p_link_available);
diff --git a/drivers/pci/pcie/p2p_link.h b/drivers/pci/pcie/p2p_link.h
index 6c4f57841c79..6677ed66f397 100644
--- a/drivers/pci/pcie/p2p_link.h
+++ b/drivers/pci/pcie/p2p_link.h
@@ -21,7 +21,12 @@
 #ifdef CONFIG_PCIE_P2P_LINK
 void p2p_link_sysfs_update_group(struct pci_dev *pdev);
 
+bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct pci_dev *b);
 #else
 static inline void p2p_link_sysfs_update_group(struct pci_dev *pdev) { }
+static inline bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct pci_dev *b)
+{
+	return false;
+}
 #endif
 #endif /* _P2P_LINK_H_ */
-- 
2.43.0


