Return-Path: <linux-pci+bounces-831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF188106AB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 01:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6489AB21070
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 00:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141210EA;
	Wed, 13 Dec 2023 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQHitFp8"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4AF92
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 16:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702427786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4J3yyMVT0Ck6UqVMMggnyCj20M3aIOGukmt1/w28WlA=;
	b=RQHitFp8fXhxUD5EP4EHvhV7gBSpQZ/SN/nJmxzB4ZpvfKBWIA2F2/c/NhrhtCHAG4GLY1
	fY3Hrz+XtTfBxwuezsT4LxEvWnlpgViJ++VBZbAeQGVyAROQvcIGa4ixo5a3ef8n8SMKy2
	NQF7nm2XeQOnAuuhTsdy5d1RjpEQSpA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-nIPG_mAZOtSj-ICft5S-pQ-1; Tue,
 12 Dec 2023 19:36:23 -0500
X-MC-Unique: nIPG_mAZOtSj-ICft5S-pQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3BE53833343;
	Wed, 13 Dec 2023 00:36:22 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D2C821121306;
	Wed, 13 Dec 2023 00:36:20 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	imammedo@redhat.com,
	mst@redhat.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	mika.westerberg@linux.intel.com,
	boris.ostrovsky@oracle.com,
	joe.jin@oracle.com,
	stable@vger.kernel.org,
	Fiona Ebner <f.ebner@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple devices at a time
Date: Wed, 13 Dec 2023 01:36:14 +0100
Message-Id: <20231213003614.1648343-3-imammedo@redhat.com>
In-Reply-To: <20231213003614.1648343-1-imammedo@redhat.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
bridge reconfiguration in case of single HBA hotplug.
However in virt environment it's possible to pause machine hotplug several
HBAs and let machine run. That can hit the same race when 2nd hotplugged
HBA will start re-configuring bridge.
Do the same thing as SHPC and throttle down hotplug of 2nd and up
devices within single hotplug event.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 6b11609927d6..30bca2086b24 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -37,6 +37,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/delay.h>
 
 #include "../pci.h"
 #include "acpiphp.h"
@@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
 static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 {
 	struct acpiphp_slot *slot;
+        int nr_hp_slots = 0;
 
 	/* Bail out if the bridge is going away. */
 	if (bridge->is_going_away)
@@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 
 			/* configure all functions */
 			if (slot->flags != SLOT_ENABLED) {
+				if (nr_hp_slots)
+					msleep(1000);
+
+                                ++nr_hp_slots;
 				enable_slot(slot, true);
 			}
 		} else {
-- 
2.39.3


