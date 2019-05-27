Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0975E2BC3F
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 00:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfE0Wza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 May 2019 18:55:30 -0400
Received: from alpha.anastas.io ([104.248.188.109]:38665 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfE0Wza (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2019 18:55:30 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id AF8CF7F8F7;
        Mon, 27 May 2019 17:55:28 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1558997729; bh=n/m3RzZx6edSehbm6HYEDIVIHMhjvUbaff76ByAx8Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h8PxsGte3Ax3bOzCUpo3miG+rEFcVJY6C6qrI9gbdp+EeCf3uvO6vf+rCjGk89UKp
         09Jbmhv+Qs6I3oJqhQzyl6HqMGhZZOOch6ErwXFehKlNbPlanS7KnPxvH7LgwOtTeh
         ZtGrMWbe2gY3MalzBUWDW8awynGhk5GM9hnrCOc7HnGIwZJUQpTfd+v3ZtLsFzt8l2
         Pc9eYsbUhqT2tGgzUvBxzbdQffyDXjmsn+HwXJ25tFzamPSZ9k45qfT+Ah5ZmFUr9M
         MNN/QjTcMzCq6q05zxX5mkEmGbtxaSnOyyOeilahKpLalN5fbGQkT3IWQMcEQB1d63
         E/6FMv3smWlqA==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, sbobroff@linux.ibm.com,
        xyjxie@linux.vnet.ibm.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/3] PCI: Introduce pcibios_ignore_alignment_request
Date:   Mon, 27 May 2019 17:55:19 -0500
Message-Id: <20190527225521.5884-2-shawn@anastas.io>
In-Reply-To: <20190527225521.5884-1-shawn@anastas.io>
References: <20190527225521.5884-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce a new pcibios function pcibios_ignore_alignment_request
which allows the PCI core to defer to platform-specific code to
determine whether or not to ignore alignment requests for PCI resources.

The existing behavior is to simply ignore alignment requests when
PCI_PROBE_ONLY is set. This is behavior is maintained by the
default implementation of pcibios_ignore_alignment_request.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 drivers/pci/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8abc843b1615..8207a09085d1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5882,6 +5882,11 @@ resource_size_t __weak pcibios_default_alignment(void)
 	return 0;
 }
 
+int __weak pcibios_ignore_alignment_request(void)
+{
+	return pci_has_flag(PCI_PROBE_ONLY);
+}
+
 #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
 static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
 static DEFINE_SPINLOCK(resource_alignment_lock);
@@ -5906,9 +5911,9 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	p = resource_alignment_param;
 	if (!*p && !align)
 		goto out;
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
+	if (pcibios_ignore_alignment_request()) {
 		align = 0;
-		pr_info_once("PCI: Ignoring requested alignments (PCI_PROBE_ONLY)\n");
+		pr_info_once("PCI: Ignoring requested alignments\n");
 		goto out;
 	}
 
-- 
2.20.1

