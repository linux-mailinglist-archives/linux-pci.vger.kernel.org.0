Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F4D2A81C2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgKEPCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 10:02:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730466AbgKEPCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 10:02:32 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51A8321D81;
        Thu,  5 Nov 2020 15:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604588551;
        bh=URj8NlXXCPLy7TXdBMc+cMKW0YKZFM4nnxFiFi+b9Ig=;
        h=From:To:Cc:Subject:Date:From;
        b=B3h0xM+UJTUVFYQm/aqKENTZYqRD7K9E21VDPVU7YOh1arRZOEdA6E2MOOj4k0bfZ
         6AmYiJx7O8uYeOHjM/rCD3f1S83bGD0Xy5BTGqe75l4tjeA4lwdFcW3XzSJy7FH8eG
         c3Daag7A96v09sEgcffLAHi54R970MjxbIygAJyA=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Tom Rix <trix@redhat.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] PCI: ibmphp: Remove unneeded break
Date:   Thu,  5 Nov 2020 09:02:22 -0600
Message-Id: <20201105150222.498674-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

A break is not needed if it is preceded by a return.

Based on Tom Rix's treewide patch; this instance extracted from Joe
Perches' list.

Link: https://lore.kernel.org/r/20201017160928.12698-1-trix@redhat.com
Link: https://lore.kernel.org/r/f530b7aeecbbf9654b4540cfa20023a4c2a11889.camel@perches
.com
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Joe Perches <joe@perches.com>
---
 drivers/pci/hotplug/ibmphp_pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
index e22d023f91d1..754c3f23282e 100644
--- a/drivers/pci/hotplug/ibmphp_pci.c
+++ b/drivers/pci/hotplug/ibmphp_pci.c
@@ -294,7 +294,6 @@ int ibmphp_configure_card(struct pci_func *func, u8 slotno)
 				default:
 					err("MAJOR PROBLEM!!!!, header type not supported? %x\n", hdr_type);
 					return -ENXIO;
-					break;
 			}	/* end of switch */
 		}	/* end of valid device */
 	}	/* end of for */
@@ -1509,7 +1508,6 @@ static int unconfigure_boot_card(struct slot *slot_cur)
 				default:
 					err("MAJOR PROBLEM!!!! Cannot read device's header\n");
 					return -1;
-					break;
 			}	/* end of switch */
 		}	/* end of valid device */
 	}	/* end of for */
-- 
2.25.1

