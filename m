Return-Path: <linux-pci+bounces-42494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E07C9BE8E
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 16:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1823A66CA
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E33248896;
	Tue,  2 Dec 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KURMxBqP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED89245005
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688465; cv=none; b=WO6e7a9aO9XD1x+HXUebj2dywRBSVUpf2RBjQjoBLJfOq9R3DfccfF47KHkrulgfAafic3ACx0t9bVqixyJspm3fKeta7OXXTB7kcKwPn2z+EmIfXbbFR9CBRJI91qjyc44+Czoo6ej9OmQJYH2ndooc2pMnB46chRJ8GeumZm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688465; c=relaxed/simple;
	bh=s9PyBBA5M1k7BrImLk4d1aplAQOhaONghsfw4hkE2D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g48rr0nzEejDnX6yTJm2amuvgY3r1TR1hbp3BjVYBnraknGIg5RDPaPHaess8qc6xoz0qdbEcylwW+WR/VOprRMjQMAsp9Ni278RhsOY25/AXUIMKS6hJlnFOW2HAOAOewdID6JHjpqnJaCXg7zIiJHh72MS0PLeLDhE6gKPff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KURMxBqP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b73161849e1so1402010166b.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764688462; x=1765293262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81D1SIg5imer8Axj2ZpqiIl+5v9nMwH6BKsre069itI=;
        b=KURMxBqPqD/RpKqeJrA8o9TSeUAhlLF6qUxlFqZh5w8mYcZT0dVNqFWb/s5qZZ4hJX
         AoWnu+r0LaxpVbMpr32VU+TKs+pV5SJ9BK/tVwIn0g0BJkaMP0ZsXrzyoIc7HkWCWjpg
         7EE9PvK/ksTDXYyLHDKv8XAfyTq9MB+t2Ex3VqsNXx+4pjLhaoQUhSOUDJkSDukrca4V
         IuMgERWgpVL9Vqfipc/xK9CtMHSpSD3BLj/OitdZeCO6ill3+UHAaz0pn3HneW2n8dQS
         oM0ficOb52WyI72ZyS2Ze79kSmIv2wdxTxLifwAblDLwK82mHV4HQS82Z7Fb5nncN7kN
         ClkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764688462; x=1765293262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81D1SIg5imer8Axj2ZpqiIl+5v9nMwH6BKsre069itI=;
        b=klj2GY6rnv2gOu5g1VH8mFBr9otQZNmLc8aCuPBFraaJ0cH8Zu/tFDJQiO6TpAUDbC
         UlJM2sSVaATxGDUyv75zxo2Bk8H96gqL58fZ+q31mLPzSLiq9st+gecH5bbB5igSZtQx
         r4hbZN0+w//XznEisqtqZB8Ssuc2TYqs/dZ9m3HjHQ5bT/y7zwa5Wpt9ASv88PpeQYPh
         sUUVY9b9+v6AUkYzwrsGVwI7/nR6w85/xa0CRq26quk0S3fJ2I+0jyLHhyGlX8I8GOaP
         Lwu41g6t9HZlrR3WbZ1ixhf/KDdhOQd5X2bfHwsAjFgRDbhLvb6oTrIj8ATt3s/rXk31
         TElw==
X-Forwarded-Encrypted: i=1; AJvYcCWVimWjbQ0mn5lpJIjrh41nkz0X81v1V4RNJQ9c2ewujGSYAfDGmAjn6sknkQ1ean0SJzJKXPm/NdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYJSqI5YkM65riAcghh7hjCVBin4R6zEO1Db6/05lZVe020ai
	QpinVMHn92TOSHr7kuuwHyKFDzCqK7Mi56vFKKwi1RDvW2WciFbhR0TNUpGP4SWuQlk=
X-Gm-Gg: ASbGncvLN6DNLJziTY+ViDU7wq2dl4+8K1cGiyhEvWouT0n38xhUvpAU4WNv122btwK
	8sfDe8jCbwRqhNpm2D8VkBCsq8Do1MKsPb3a4KdJDSSf/o3n0T6NceBkrQCYkPadpc5itTTKfSm
	Ua2bht33O0D50FY5B8IPz/XbsC/mvEDXQC8CmVwl/3hVpYyicTU5U9r152T/odcofBmIt2Uijj8
	eFPjVk+Nr1q0KZj8YNHcdOc1WYP0J72MeQSPfFDz7MojMt9Keh8gR1blhOlUsPIjSge3A3zCtNX
	QH5L/ovxZ8Lf/by8C1HIZnABptW42GybH/l9+zi530K3niDY3NTbZDhU2rcsOC93Kr1OaW8JZsI
	ScMoa5/3HsQ4u17SUkYXW3+gM7LhBkOs/LJkMQVfEbiX0IYkjdGp4Sx9VyFC/Jq/xVMyTH7lAoq
	Sq9UHVUV0NJ7C2dyMt8IlIx2KDi7JhPVRZlCGQYt843XR5/PlIrzTDzlN47+A1mlIz0yqiIdKbK
	wg=
X-Google-Smtp-Source: AGHT+IFw5PHAHxLQPdEdAM5oJosaFHvnpdQSLmKklEwgtf72uvVqfB8ct4UvPQby+bvXGVffjPEtkw==
X-Received: by 2002:a17:907:3e10:b0:b76:5143:edea with SMTP id a640c23a62f3a-b76716953e1mr4486578566b.30.1764688461485;
        Tue, 02 Dec 2025 07:14:21 -0800 (PST)
Received: from localhost (p200300f65f006608c90d1d7fe637464b.dip0.t-ipconnect.de. [2003:f6:5f00:6608:c90d:1d7f:e637:464b])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b76f519d828sm1532650666b.18.2025.12.02.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:14:21 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/6] PCI/portdrv: Move pcie_port_bus_type to pcie source file
Date: Tue,  2 Dec 2025 16:13:52 +0100
Message-ID:  <420d771f0091dea7cf18f445b94301576dcee4c8.1764688034.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=s9PyBBA5M1k7BrImLk4d1aplAQOhaONghsfw4hkE2D8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpLwI5aOb3G1fQaE1Wp9xOyK6vq5zJnnMqhHSBm 4a9/9PMC1yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaS8COQAKCRCPgPtYfRL+ TpfQCAC2GL4ieuUF4EZ3C6uY2lCBndV03W5JJF2/k1in0t/YGaaPJwNUo3gBwIBky9ZKLTecrBg 5Q5iPjoBhdAGidk4YLSyTGRggAOTFhMJx15GzvDcLbA4zF8T9Ei4tA3le3/agIpvblUn3lsOXsm GBcVLzE0jrJYhC74PQ6UIg5gJ2N+5JAY91asciWasIrWcr6tFWK+m0Wj2ssx7pYfwzFNNvvCKh5 A0RbZtUkOLM+lRWEDS2ni1xanqGPhKXvk+yFRQD3LCLmFkELsEYwYYVnAGnms6afFZ9QyaHOPMD NktQQ07o/7dgElURVdcamBJ+Gz1UmWODJgGpagpnbuOfnKoZ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Conceptually the pci_express bus doesn't belong in generic pci code.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pci/pci-driver.c   | 22 ----------------------
 drivers/pci/pcie/portdrv.c | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 2b6a628fc7d0..addb1d226a25 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1699,28 +1699,6 @@ const struct bus_type pci_bus_type = {
 };
 EXPORT_SYMBOL(pci_bus_type);
 
-#ifdef CONFIG_PCIEPORTBUS
-static int pcie_port_bus_match(struct device *dev, const struct device_driver *drv)
-{
-	struct pcie_device *pciedev = to_pcie_device(dev);
-	const struct pcie_port_service_driver *driver = to_service_driver(drv);
-
-	if (driver->service != pciedev->service)
-		return 0;
-
-	if (driver->port_type != PCIE_ANY_PORT &&
-	    driver->port_type != pci_pcie_type(pciedev->port))
-		return 0;
-
-	return 1;
-}
-
-const struct bus_type pcie_port_bus_type = {
-	.name		= "pci_express",
-	.match		= pcie_port_bus_match,
-};
-#endif
-
 static int __init pci_driver_init(void)
 {
 	int ret;
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 63492c3d3565..5cb0daf6781b 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -508,6 +508,21 @@ static void pcie_port_device_remove(struct pci_dev *dev)
 	pci_free_irq_vectors(dev);
 }
 
+static int pcie_port_bus_match(struct device *dev, const struct device_driver *drv)
+{
+	struct pcie_device *pciedev = to_pcie_device(dev);
+	const struct pcie_port_service_driver *driver = to_service_driver(drv);
+
+	if (driver->service != pciedev->service)
+		return 0;
+
+	if (driver->port_type != PCIE_ANY_PORT &&
+	    driver->port_type != pci_pcie_type(pciedev->port))
+		return 0;
+
+	return 1;
+}
+
 /**
  * pcie_port_probe_service - probe driver for given PCI Express port service
  * @dev: PCI Express port service device to probe against
@@ -564,6 +579,11 @@ static int pcie_port_remove_service(struct device *dev)
 	return 0;
 }
 
+const struct bus_type pcie_port_bus_type = {
+	.name = "pci_express",
+	.match = pcie_port_bus_match,
+};
+
 /**
  * pcie_port_service_register - register PCI Express port service driver
  * @new: PCI Express port service driver to register
-- 
2.47.3


