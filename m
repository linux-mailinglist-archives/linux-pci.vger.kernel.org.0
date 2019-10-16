Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26495D9A62
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 21:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfJPToz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 15:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfJPToy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 15:44:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E780421835;
        Wed, 16 Oct 2019 19:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571255094;
        bh=a+eVuLrgzrO9drVaHfvt7ADhX2JYoreKzv/cchTKdcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=N7P7XmA4fIAb2RTDSN/3aFMogQqqQYvmq9gt37Rv/aOR0GWsQTKokBBvpo/sQQeD1
         OK/EANIGdGZswaeiowWddtw470RJdK4eCZvHVLb7V0ogRRv55L1XD+kfXGDKZ86bHi
         IsAZDhY6XXrvSAjz7KwohX/b5JXXggeJL1k6O9DI=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/PM: Note that PME can be generated from D0
Date:   Wed, 16 Oct 2019 14:44:50 -0500
Message-Id: <20191016194450.68959-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Per PCIe r5.0 sec 7.5.2.1, PME may be generated from D0, so update
Documentation/power/pci.rst to reflect that.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/power/pci.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index db41a770a2f5..a90e82c70a3b 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -130,8 +130,8 @@ a full power-on reset sequence and the power-on defaults are restored to the
 device by hardware just as at initial power up.
 
 PCI devices supporting the PCI PM Spec can be programmed to generate PMEs
-while in a low-power state (D1-D3), but they are not required to be capable
-of generating PMEs from all supported low-power states.  In particular, the
+while in any power state (D0-D3), but they are not required to be capable
+of generating PMEs from all supported power states.  In particular, the
 capability of generating PMEs from D3cold is optional and depends on the
 presence of additional voltage (3.3Vaux) allowing the device to remain
 sufficiently active to generate a wakeup signal.
-- 
2.23.0.700.g56cf767bdb-goog

