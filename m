Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ADF3AD3F1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 22:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhFRU5b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 16:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232648AbhFRU5b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 16:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624049720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0/V0dxodhfIUoDR1ubqGKXgNsVZumGtsantN7oCE3Jg=;
        b=NHWXxkNQpcLucMiXm5yZeuLESbHkWY1nJ/eYgnun4m8wy0Z03HPE/hSBJ7DMBNDL9Ccp6E
        OOiNxxw3M/02PwKbVotyoGRFvHwOgSmtoaVGc1jqtTS2oOlnt/+F83kwNi15gC6ptY4RPz
        Y9OJbQxTORxDXydXNTA4eY4v/vnZWdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-qXD2jhh_PRu6grZqGu4k0Q-1; Fri, 18 Jun 2021 16:55:19 -0400
X-MC-Unique: qXD2jhh_PRu6grZqGu4k0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 499BA100CEC2;
        Fri, 18 Jun 2021 20:55:18 +0000 (UTC)
Received: from [172.30.41.16] (ovpn-112-106.phx2.redhat.com [10.3.112.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC4023A47;
        Fri, 18 Jun 2021 20:55:14 +0000 (UTC)
Subject: [PATCH] PCI/ACS: Enforce pci=noats with Transaction Blocking
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     rajatja@google.com, linux-kernel@vger.kernel.org
Date:   Fri, 18 Jun 2021 14:55:14 -0600
Message-ID: <162404966325.2362347.12176138291577486015.stgit@omen>
User-Agent: StGit/1.0-8-g6af9-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe Address Translation Services (ATS) provides a mechanism for a
device to provide an on-device caching translation agent (device
iotlb).  We already have a means to disable support for this feature
via the pci=noats option.  For untrusted and externally facing
devices, we not only disable ATS support for the device, but we use
Access Control Services (ACS) Transaction Blocking to actively
prevent devices from sending TLPs with non-default AT field values.

Extend pci=noats to also make use of PCI_ACS_TB so that not only is
ATS disabled at the device, but blocked at the downstream ports.
This provides a means to further lock-down ATS for cases such as
device assignment, where it may not be the hardware configuration of
the device that makes it untrusted, but the driver running on the
device.

Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c    |    4 ++--
 drivers/pci/quirks.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 68f57d86b243..5aa1bb2ddd80 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -915,8 +915,8 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	/* Upstream Forwarding */
 	ctrl |= (cap & PCI_ACS_UF);
 
-	/* Enable Translation Blocking for external devices */
-	if (dev->external_facing || dev->untrusted)
+	/* Enable Translation Blocking for external devices and noats */
+	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6d74386eadc2..d541076c083a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5031,7 +5031,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);


