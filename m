Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990914614EC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 13:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241858AbhK2MZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 07:25:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244317AbhK2MXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 07:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638188392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L37pwsHQHKvZbfR1sKIBLcJDZnuF8PL4vls2mHdyB7A=;
        b=UdjXaAGfrR3mz4jD7yctoATfp/njWGguPxe2h9FXth+AU7wYwm06JGF7Qt3ujOO7kM+bTA
        EYpJAAKpt+IvqsgyGyNI4MAR6lqkEFndMrQ9QgUxtwvI5vLt29DO+9jjSl01RMf8bDzrDj
        dxoofaN87+PlxUpJvZ7Mv/Dg6ivzhdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-PTARWtVRMGSN20WV5g-45Q-1; Mon, 29 Nov 2021 07:19:40 -0500
X-MC-Unique: PTARWtVRMGSN20WV5g-45Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550461006AA0;
        Mon, 29 Nov 2021 12:19:38 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.194.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CECB1017CF5;
        Mon, 29 Nov 2021 12:19:35 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: Add a pci_dev_depth() helper function
Date:   Mon, 29 Nov 2021 13:19:33 +0100
Message-Id: <20211129121934.4963-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a pci_dev_depth() helper function, which returns the depth
of a device in the PCI hierarchy.

This is useful to have for lockdep annotations for dealing with
nested locked when traversing the hierarchy.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/linux/pci.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7d825637d7ca..6ad78cc67aa8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -691,6 +691,26 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
 		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
 }
 
+/**
+ * pci_dev_depth - Return the depth of a device in the PCI hierarchy
+ * @dev: PCI device
+ *
+ * Return the depth (number of parent busses above) the device in
+ * the PCI hierarchy.
+ */
+static inline int pci_dev_depth(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	int depth = 0;
+
+	while (bus->parent) {
+		depth++;
+		bus = bus->parent;
+	}
+
+	return depth;
+}
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
-- 
2.33.1

