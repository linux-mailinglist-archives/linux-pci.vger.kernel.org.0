Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA8C455D69
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 15:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhKROJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbhKROJf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 09:09:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA94C061570;
        Thu, 18 Nov 2021 06:06:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so8281070pju.3;
        Thu, 18 Nov 2021 06:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8lsW4hpjhviqEYY030z6kfRyw6NTRFOimRsTY0Dd4qI=;
        b=R/sJSkzEx601ikKdcFXXcXBLPdX8M36alq3M409uEktIk9JmQzDH/88j+OTcY6m972
         oOCg2sOWlarizgYgRP/kZETioJd/V8hfz34YvW1/jTu9SjD29YddWg+Rjijc9dU5aJeT
         nIoQQcA4D7r5NWm345J0f5UH6Ha/yIQUXAQcraPv45NX8kDOzcgrTAv4+8ZfX73OnvXt
         yhCSzkxyY9V2Pjt6Ndq+hqexPvSdtjWCw4iUQHopkkxDTwEm4Akcg5zKeDASUu7HJyOj
         HoeWg7ASFeSEcY7OWnZCR5zkbtVroKZ8WpbFKbY6ppTefVKFBsHeF6wjUS4oLW/Oy5lU
         b/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8lsW4hpjhviqEYY030z6kfRyw6NTRFOimRsTY0Dd4qI=;
        b=Nb7sMzMD7SH/ousLdAQuV3QW9RWy3ZonXk8lv6pTXaDN92jqLrc7s+Te70mWEZDmEG
         1uENVpgOA6ZLQXG8eENoQQnR4rU7m1ezyV3qjknI0oNGmHs9PnbdLtyry+Y0V6jpapMY
         aBUjtR5ob8W9NdhjpMB7i676kHm02ZHhj/yvYf8x8Z91L/qqm9GDpHGsQRUe+yz8KdMD
         Ij4IXHMt7eoaJ2K1lxkxeZ5mUjs4imDvjJGQboVBvJhBOHMCd/Nvxu0P+vrk9QqzNMJW
         z8CjVOEDxAycFaxl51Klf63IVKHrMJyO9aBtVRcRgspEw0mwI89V6ao/QIcpSepZnrFl
         CcwA==
X-Gm-Message-State: AOAM53098WQS0wIl5fGo+8ANbWahy1q/kJRFkt4qctUFcgy2yOjIBdr5
        Zx9x3s/tnWMLi7hhqbGG8L4=
X-Google-Smtp-Source: ABdhPJzwsIz1FjnbkpaH+NZP6qwJ7t3ZNQ3Pl2HaHBCCx4yHGcbyTsopAFtMN1jFwxxEYO/VtU+oWQ==
X-Received: by 2002:a17:90b:33d0:: with SMTP id lk16mr10713763pjb.66.1637244395195;
        Thu, 18 Nov 2021 06:06:35 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id x14sm2822878pjl.27.2021.11.18.06.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:06:34 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v4 10/25] PCI: kirin: Remove redundant error fabrication when device read fails
Date:   Thu, 18 Nov 2021 19:33:20 +0530
Message-Id: <f87e22bc09a471d2cf15ad05dfd6432f57739aed.1637243717.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
References: <cover.1637243717.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 095afbccf9c1..e6dcac79c02a 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -530,10 +530,8 @@ static int kirin_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	if (PCI_SLOT(devfn)) {
-		*val = ~0;
+	if (PCI_SLOT(devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	*val = dw_pcie_read_dbi(pci, where, size);
 	return PCIBIOS_SUCCESSFUL;
-- 
2.25.1

