Return-Path: <linux-pci+bounces-13291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA497C5C4
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C0A1C22B73
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04A31991C1;
	Thu, 19 Sep 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CmHtYYP6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D1198A30
	for <linux-pci@vger.kernel.org>; Thu, 19 Sep 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734343; cv=none; b=OZbQJCUpO1kzuXeiLGrulWrcHO023NChsFxRmL+8ZV5vLM9faqySr7FyMadTYGv0ZnQ1qKMHShjNH9YXAXL/NjYJS/a5iEw6jFk8QsQf/t9Kth7mzCdsae1tOalb0r+wsAqapvR567tkFcI8EnwNgX8oVgfkhBk40y+kdKj9PFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734343; c=relaxed/simple;
	bh=8NqLkMy3Zx6bnWeNPtd3QcNpt2w1EU41lxesU7fl/oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BtHUtKjODqS395tLa7A7dDVpUYpTDgGEAWWck6WMj67F8HZztDG7q2Ql6yTZI1g+qcU+jv7Oqpla1xhF7z1jJprCAw2F7EESx1zRwfmj53Ev+4p5Ug4PrCGMuPV2O6kFQftW61PZFBROum/ZID26XI5Zj8BdBvKigYc4BCFJPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CmHtYYP6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20573eb852aso11427955ad.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Sep 2024 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726734341; x=1727339141; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HmqZt8e3zro76L+L3lI/fpw4YEZYvty94868lL6i/x0=;
        b=CmHtYYP6D1Pc0srB4ZVKie96F6yiKRnAOdibKwZAZFSt3v+AiW4EbuVH3UpfO40xyc
         jE7fqiXfRwp4RUEYNXDIQ5dh26d80e4zKf5p2j+Hj/udHtrA6zglre+0l0L0B6vLw6fb
         ozjhngH1773zjME1YyuX/NVOa+4aXkQVvtuGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734341; x=1727339141;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmqZt8e3zro76L+L3lI/fpw4YEZYvty94868lL6i/x0=;
        b=f8GymW6mf35v2Izr18LUVxYdRjKgnb40t/nrFI6pwTF3elhCXfCpoM4vPUhC+cRyuS
         yTw7Ii3dkFQkwV9uUTUl3pJ7DM4WQSfX+t7WgaVi9kiGLoycLoQ/JYm/8H4+MgElsEAG
         BqyyJXd1lMvFZprMSzQxDhHOB3qX5eJkFyR96zs1iPbn6wug9n6RBiJkSIfYexZjBmvN
         y3YpvsCzifUYlfdlVLsl60sWKRcTIIz4CplC/h3oLVM+Hg3W7T8m30//BC+2i2CkAxw9
         umLvdR01Uy088XHmeck8uztwen5UTQUm60PtwBKP5TIAinuFCVWSjxRKmDQk5y3rEXW/
         ExYg==
X-Gm-Message-State: AOJu0Yw/78+n9oLHXUAYyVsjpnz7zfeLYavdsJVZ5JMJX3DwbaIE4K8F
	Bsf50/2tmY9zFuSLEqq0tkSsBV9XdNn1vA1c8+zGuetN5TWnRtKr5KR/UP8LKUlHgIT2KFSNnnb
	tdBJ8ghC7trV5f+Rvbk2pFDMy2s24bpBiEztvxiBwoENQKCQY1BkCfTf0cyrJ6tlDsmVj3MVUQ4
	6UZyuh22labbgt1IRGa8hOCb4AkOWuOUg7ylO1gAPh1jR48Vq8046q4Gh3vbthi3I=
X-Google-Smtp-Source: AGHT+IGIoR7DQTByHj/l4Zf/Tfkw0Ev3y9F9w0HlqKuds5yDKg55HUfdksZ5EucrAa8WOWGaXEVCsw==
X-Received: by 2002:a17:902:f706:b0:205:8763:6c2d with SMTP id d9443c01a7336-208cb8b392emr43227385ad.9.1726734341144;
        Thu, 19 Sep 2024 01:25:41 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794735810sm75228425ad.278.2024.09.19.01.25.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:25:40 -0700 (PDT)
From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	logang@deltatee.com
Cc: linux-kernel@vger.kernel.org,
	sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com,
	sjeaugey@nvidia.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 2/2 v2] PCI/P2PDMA: Modify p2p_dma_distance to detect P2P links
Date: Thu, 19 Sep 2024 01:13:44 -0700
Message-Id: <1726733624-2142-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Update the p2p_dma_distance() to determine inter-switch P2P links existing
between two switches and use this to calculate the DMA distance between
two devices.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/pci/p2pdma.c       | 17 ++++++++++++++++-
 drivers/pci/pcie/portdrv.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h |  2 ++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13cb500..eed3b69e7293 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,8 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+extern bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct pci_dev *b);
+
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -576,7 +578,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool verbose)
 {
 	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
-	struct pci_dev *a = provider, *b = client, *bb;
+	struct pci_dev *a = provider, *b = client, *bb, *b_p2p_link = NULL;
 	bool acs_redirects = false;
 	struct pci_p2pdma *p2pdma;
 	struct seq_buf acs_list;
@@ -606,6 +608,16 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			if (a == bb)
 				goto check_b_path_acs;
 
+			/*
+			 * If both upstream bridges have Inter switch P2P link
+			 * available, P2P DMA distance can account for optimized
+			 * path.
+			 */
+			if (pcie_port_is_p2p_link_available(a, bb)) {
+				b_p2p_link = bb;
+				goto check_b_path_acs;
+			}
+
 			bb = pci_upstream_bridge(bb);
 			dist_b++;
 		}
@@ -629,6 +641,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			acs_cnt++;
 		}
 
+		if (bb == b_p2p_link)
+			break;
+
 		bb = pci_upstream_bridge(bb);
 	}
 
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index c940b4b242fd..2fe1598fc684 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -104,6 +104,40 @@ static bool pcie_port_is_p2p_supported(struct pci_dev *dev)
 	return false;
 }
 
+/**
+ * pcie_port_is_p2p_link_available: Determine if a P2P link is available
+ * between the two upstream bridges. The serial number of the two devices
+ * will be compared and if they are same then it is considered that the P2P
+ * link is available.
+ *
+ * Return value: true if inter switch P2P is available, return false otherwise.
+ */
+bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct pci_dev *b)
+{
+	u64 dsn_a, dsn_b;
+
+	/*
+	 * Check if the devices support Inter switch P2P.
+	 */
+	if (!pcie_port_is_p2p_supported(a) ||
+	    !pcie_port_is_p2p_supported(b))
+		return false;
+
+	dsn_a = pci_get_dsn(a);
+	if (!dsn_a)
+		return false;
+
+	dsn_b = pci_get_dsn(b);
+	if (!dsn_b)
+		return false;
+
+	if (dsn_a == dsn_b)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pcie_port_is_p2p_link_available);
+
 /*
  * Traverse list of all PCI bridges and find devices that support Inter switch P2P
  * and have the same serial number to create report the BDF over sysfs.
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 1be06cb45665..b341aad6eb49 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -130,5 +130,7 @@ static inline bool pcie_pme_no_msi(void) { return false; }
 static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
+bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct pci_dev *b);
+
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
 #endif /* _PORTDRV_H_ */
-- 
2.43.0


