Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE00521BF51
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 23:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgGJViN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 17:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgGJViM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 17:38:12 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3865920772;
        Fri, 10 Jul 2020 21:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594417092;
        bh=isY0pS9oGm7dGtxlL9m4aLsA5EJIEBlakrUHURN2ht0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzBtSTV5wS1vLwn1ewmhaZpMbH2Sj9LaladOMvk6RCzyJ48ljQ/ZeHxpW8BjuyNlX
         dkqx/FLR54+gqNiz6bKVN99d4X6OMYOGMSB2zJ0b/EVAueY7NAJVgHW8Z6DKNAkz95
         8JNtFVBZgrz0tz2F4jlNRcJczX0yTCJwt2/vovp8=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI/ACPI: Unexport acpi_pci_find_root()
Date:   Fri, 10 Jul 2020 16:37:53 -0500
Message-Id: <20200710213753.83420-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710213753.83420-1-helgaas@kernel.org>
References: <20200710213753.83420-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

acpi_pci_find_root() is called only from pci_root.c and
drivers/pci/hotplug/acpi_pcihp.c, neither of which can be modules.
Unexport it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index b6da9745efcd..933890f97720 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -246,7 +246,6 @@ struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
 
 	return root;
 }
-EXPORT_SYMBOL_GPL(acpi_pci_find_root);
 
 struct acpi_handle_node {
 	struct list_head node;
-- 
2.25.1

