Return-Path: <linux-pci+bounces-17551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314ED9E0B9F
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 20:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92E4280A20
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D821DE4CB;
	Mon,  2 Dec 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gAh+PeH8"
X-Original-To: linux-pci@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E21DE3C8;
	Mon,  2 Dec 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166181; cv=none; b=hSEV9IgOAmfHk1I3jDJejineZuHnfs4XfBFdWMtfnH1xNPV/n4Iotw669gz+GjKG4UDPYHGVxpgNwydmJqtmWRBEs/+euMHSS4p9u2IWmX/ZQIVH8W9i/wxAZtFhp23Ccq65IP9IxE1fqZlWnuFClaNfNyrNdaCjNjK0L0lKa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166181; c=relaxed/simple;
	bh=k1pJ4luVhcXBDfBpiVnJtsHgnGcvABs2ve248K8/HvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEgDfqGYf+gGZSz4mq3BfLFZukhK4z8APejR/qBwjeujv3ISydW5w6ZfDqjgObpYDehI0dJEGIoQ/9sk3swf1/y7IUJuO7DCGVzmLGTB5S89zL7ydjr69Lv/NjE+ANDXGQ2ZcTJvx8js+C2hckpa5mC7EGF0iwcr1lY/ZPUtB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gAh+PeH8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166178;
	bh=k1pJ4luVhcXBDfBpiVnJtsHgnGcvABs2ve248K8/HvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gAh+PeH88LU3FtARYAKE6c8qWzlOUHigfxx+55tmH+ae6fISLMw/G2hSf4khhZlAh
	 Qp7QaNxzVZuhCMXVmjmrBwVbBo/K3I5ujbYsnZQQ7Kk3pva6n5gITCTJ3K1k+fEuuO
	 kJq2d06iSApUrTw9h1e6phSVnKCCrYfpP2GwRKhg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:02:58 +0100
Subject: [PATCH 2/4] PCI/VPD: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-pci-v1-2-c32360f495a7@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166177; l=1980;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=k1pJ4luVhcXBDfBpiVnJtsHgnGcvABs2ve248K8/HvI=;
 b=bBXG8cMXvBqNSmdvQe+DxGUV01eaAAhlF0GD9rEicmlXAOoOEpI/oTJiYtAXal5U6RSdf+XDb
 v8xgnwHB9ePAaZ0zmS0AIvRD8ynG9zbrDl/208wQpvBnwgVqufnF3fA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/vpd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index a469bcbc0da7f7677485c7f999f8dfb58b8ae8a3..3d29b2602d0fb760b81c374036a506a4ddb4b281 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -271,8 +271,8 @@ void pci_vpd_init(struct pci_dev *dev)
 }
 
 static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *bin_attr, char *buf, loff_t off,
-			size_t count)
+			const struct bin_attribute *bin_attr, char *buf,
+			loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 	struct pci_dev *vpd_dev = dev;
@@ -295,8 +295,8 @@ static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
-			 struct bin_attribute *bin_attr, char *buf, loff_t off,
-			 size_t count)
+			 const struct bin_attribute *bin_attr, char *buf,
+			 loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
 	struct pci_dev *vpd_dev = dev;
@@ -317,9 +317,9 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
 
 	return ret;
 }
-static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
+static const BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
 
-static struct bin_attribute *vpd_attrs[] = {
+static const struct bin_attribute *const vpd_attrs[] = {
 	&bin_attr_vpd,
 	NULL,
 };
@@ -336,7 +336,7 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
 }
 
 const struct attribute_group pci_dev_vpd_attr_group = {
-	.bin_attrs = vpd_attrs,
+	.bin_attrs_new = vpd_attrs,
 	.is_bin_visible = vpd_attr_is_visible,
 };
 

-- 
2.47.1


