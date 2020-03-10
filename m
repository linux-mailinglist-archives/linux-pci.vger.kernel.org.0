Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC241807E6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 20:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCJTXc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 15:23:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37494 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgCJTXb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2020 15:23:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id b3so14359771otp.4
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2020 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uquqTddGAw/7wibDE14A8tN0ggiXoy7cb5hU7AerrAY=;
        b=ZfKOS8G57catKleBS9YS4019d8HZE8cAofoDbaqio6e/G9bz/S3TziDipnWj6WLlcT
         CeWqPtZAqPcfGSKi824NmICdqLXvDE1UQLSKQRTn+VJ7MLoF25MJAOv0Jsmfew91RC25
         fqrLZbienuuQwj7N9BIqzfg/19xk1M3CdAD2xMD6qYIpLy9VncRVHgul1mR0f2rh/G2+
         9HqrnI+Aa5P85cSUesSCKwTNww/G5NJH3dNibc/RVfUNN/gCupFvyk9ZModzBjetKRZH
         aY19klHxyWtkebQbRBOCyAFrA0/oRjfHgU+NV+U/vB+DBwbVBN/Q7xWBebu7C428AExI
         FLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uquqTddGAw/7wibDE14A8tN0ggiXoy7cb5hU7AerrAY=;
        b=t2AdhnLBi1SHPwFT05f9wySpC1Cs28iSBerQ35hQGCHMqwHBF1F29Xcyu7MhMkCuT+
         QFe1RxGoVtYQ6UY0v6hevuG6rVJdWR/9H+yqHV+XlotqYIO0Y8xoaQcxVPrYsXduB8zE
         FnysBUsdk2hVuL+YnS/OJIKcf1Y3sc/i1OM5RDoX7Opj1Yw8G9X2YopivIRZnlAtiEjk
         RjMKcPwimkpVuu1HbEey1SWCzULalTCfef5TOQtp4+8/BC6j0/XNne41i/mzCkrxmUVl
         lwIYixLcIF1wn6rm9fk+gZ6cS7pvcqivqWWOhdjJCU2iVsUMvPRHcCqQ4z1MIZ7xFG7T
         hloQ==
X-Gm-Message-State: ANhLgQ3c9hE1rgn8iSJ3UUobGDZ5regi1KcY+tqbTglqWiDVfGBpN+K/
        K74U0GdiCkk3sKFwdfIXF7n3LjZ5WQ8=
X-Google-Smtp-Source: ADFU+vv8P8bXfx+uJ9tqBW7lsT4TP94Zr6Pf2U1XUL1P9Ekc/sW+/xuiL+YmpA+V4H3H4K+4QGGD+A==
X-Received: by 2002:a9d:7696:: with SMTP id j22mr18933720otl.188.1583868210708;
        Tue, 10 Mar 2020 12:23:30 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id k17sm4610381oic.45.2020.03.10.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:23:30 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] PCI: pciehp: Don't enable slot unless link or presence up
Date:   Tue, 10 Mar 2020 13:21:00 -0500
Message-Id: <20200310182100.102987-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a pciehp slot is powered down via /sys/bus/pci/slots/<slot>/power,
and then the card is physically removed, the kernel will sometimes try to
enable the slot as the card is removed, which results in an error in the
kernel log.

This can happen if the presence detect and link active bits don't go down
at the exact same time. When the card is disabled via /sys/.../power, the
card is placed in OFF_STATE, but the presence detect and link active bits
can still be up.  Then, when, say, presence detect goes down, an interrupt
reports that the presence detect has changed, and the code in
pciehp_handle_presence_or_link_change() will see that the link is up
(because it hasn't gone down yet), and it will try to enable the slot.

This patch modifies that code so it won't try to enable a slot in OFF_STATE
unless it sees the presence detect changed bit with presence detect active,
or the link status changed bit with an active link. This will prevent the
unwanted attempts to enable a card that's being removed, but will still
allow the slot to come up if the slot is re-enabled by writing to
/sys/.../power, or if a new card is added to the slot.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 6503d15effbb..f6cbf21711e0 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -267,16 +267,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		cancel_delayed_work(&ctrl->button_work);
 		/* fall through */
 	case OFF_STATE:
-		ctrl->state = POWERON_STATE;
-		mutex_unlock(&ctrl->state_lock);
-		if (present)
-			ctrl_info(ctrl, "Slot(%s): Card present\n",
-				  slot_name(ctrl));
-		if (link_active)
-			ctrl_info(ctrl, "Slot(%s): Link Up\n",
-				  slot_name(ctrl));
-		ctrl->request_result = pciehp_enable_slot(ctrl);
-		break;
+		if ((events & PCI_EXP_SLTSTA_PDC && present) ||
+		    (events & PCI_EXP_SLTSTA_DLLSC && link_active)) {
+			ctrl->state = POWERON_STATE;
+			mutex_unlock(&ctrl->state_lock);
+			if (present)
+				ctrl_info(ctrl, "Slot(%s): Card present\n",
+					  slot_name(ctrl));
+			if (link_active)
+				ctrl_info(ctrl, "Slot(%s): Link Up\n",
+					  slot_name(ctrl));
+			ctrl->request_result = pciehp_enable_slot(ctrl);
+			break;
+		}
+		/* fall through */
 	default:
 		mutex_unlock(&ctrl->state_lock);
 		break;
-- 
2.18.1

