Return-Path: <linux-pci+bounces-17554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB7E9E0BAE
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 20:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEBC1656ED
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC811DE89A;
	Mon,  2 Dec 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DgzcbOGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FABC1DE3CB;
	Mon,  2 Dec 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166182; cv=none; b=h0z+tSTOdzjPq5IPVsoETFhC6Th89ewnQVYpXNi1VdwsIa2anWnr5tq1IUCZ/w5ZeQeh/2zQUPA0O58ENp4oxNHhvAAJ5SJNE2dRTavOMJqbC1K4YN6Pfbe7ERJ9aKe3+cZwsyv+2BsFEyupV3wgQAQqy/HZ9cSY8hZue+QJEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166182; c=relaxed/simple;
	bh=/zUCCLJT+qzhWuG/S9fH2N3Yr9GcYUwQq30QxYs/QkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JuaNKai3I4dQt9YMeYa34sFJ6GWKphoNXnMiuqLyAkj3kOoZFAFXayyNcKmYihickkqGezdCJb52B9vcypHkywk+Emyt3xHrWVu6D0mp98THsSzNcvBdIofFbGIoYT1thHlricO5AHCKafZ+y5c7PCKb8Jb6pjQz1AA14BiMELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DgzcbOGY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166178;
	bh=/zUCCLJT+qzhWuG/S9fH2N3Yr9GcYUwQq30QxYs/QkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DgzcbOGYIYs48GGw3TeYqtrOgq9orNXQrKpwgZUpg4v+tEFsX2KVHmQY9RftQtHns
	 UuegqSLBCTbIdITlKdYDw4PPmoIkszogJvf59mpXzH8h9/sAaxFYBV7TdoHKE3vCZj
	 UjfmktUwULH0SmLUIUYx0BrrA6zFh7Uc3H2j/onE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:03:00 +0100
Subject: [PATCH 4/4] PCI/ACPI: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-pci-v1-4-c32360f495a7@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166177; l=1876;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/zUCCLJT+qzhWuG/S9fH2N3Yr9GcYUwQq30QxYs/QkA=;
 b=rvaOTiPyVFS3UuHHIwx589VnE0dkfpixf3lqZdJwjhdkx/MsuDm9Eg4IJLowts0oEic0As9sH
 KdbJ+4q2hM4BpAyuJLQbtgiTk89yswyTMEzxogIGtU0kQKu3pQzbbFw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/hotplug/acpiphp_ibm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 8f3a0a33f362bc60ba012419b865b8821c075531..b3aa34e3a4a29417bd694273779dc356be284f1d 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -84,7 +84,7 @@ static int ibm_get_attention_status(struct hotplug_slot *slot, u8 *status);
 static void ibm_handle_events(acpi_handle handle, u32 event, void *context);
 static int ibm_get_table_from_acpi(char **bufp);
 static ssize_t ibm_read_apci_table(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *bin_attr,
+				   const struct bin_attribute *bin_attr,
 				   char *buffer, loff_t pos, size_t size);
 static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
 		u32 lvl, void *context, void **rv);
@@ -98,7 +98,7 @@ static struct bin_attribute ibm_apci_table_attr __ro_after_init = {
 		    .name = "apci_table",
 		    .mode = S_IRUGO,
 	    },
-	    .read = ibm_read_apci_table,
+	    .read_new = ibm_read_apci_table,
 	    .write = NULL,
 };
 static struct acpiphp_attention_info ibm_attention_info =
@@ -353,7 +353,7 @@ static int ibm_get_table_from_acpi(char **bufp)
  * our solution is to only allow reading the table in all at once.
  */
 static ssize_t ibm_read_apci_table(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *bin_attr,
+				   const struct bin_attribute *bin_attr,
 				   char *buffer, loff_t pos, size_t size)
 {
 	int bytes_read = -EINVAL;

-- 
2.47.1


