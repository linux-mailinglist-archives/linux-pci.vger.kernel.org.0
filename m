Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9003F42A5B8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhJLNej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 09:34:39 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:33924
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236655AbhJLNej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 09:34:39 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5DB313FFE2;
        Tue, 12 Oct 2021 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634045556;
        bh=dKXMSStMoPxCZm0p9/uoqNBAaXNVf2iSmUkWehBtigY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=QIjK1rg/hK1MvI48l18670bu0Ps4BFgRAkdAP2oTPfC/vS6XsYo1VRgNvWos6zAhk
         luCBLGbFIDOX9+y2jZU+ycqVywMhrvfaOCRw/ZWjtVxqJOQMX824A0j0koPAnagAWZ
         OC/uoDfRYTrWZCBmeGJNoLCqpWpEsj9xy0UUrFUKkgD7Ca3bDZAjbFhpTeiL0w8Z8M
         wUMXDmAWgXw4HpUpKt9jBtXo/0jmu58NW7Cz5urUwrJap/ZgWF3EtIMlHQHaky9EYm
         /JB3vLoDfZjcZ4Bp6NDEYUys7kmrPVD7YiV4MrvNv+3EcTULr8m+I3MS52h3HhF1ys
         362t2VO1inoUg==
From:   Colin King <colin.king@canonical.com>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI: apple: Remove redundant initialization of pointer port_pdev
Date:   Tue, 12 Oct 2021 14:32:35 +0100
Message-Id: <20211012133235.260534-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer port_pdev is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/controller/pcie-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index b4db7a065553..19fd2d38aaab 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -634,7 +634,7 @@ static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
 {
 	struct pci_config_window *cfg = pdev->sysdata;
 	struct apple_pcie *pcie = cfg->priv;
-	struct pci_dev *port_pdev = pdev;
+	struct pci_dev *port_pdev;
 	struct apple_pcie_port *port;
 
 	/* Find the root port this device is on */
-- 
2.32.0

