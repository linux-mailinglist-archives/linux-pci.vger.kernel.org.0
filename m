Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DFB436585
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhJUPPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhJUPPQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:15:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E182C0613B9;
        Thu, 21 Oct 2021 08:13:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso3365241pjm.4;
        Thu, 21 Oct 2021 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxis35XdZSIgJr6mklaAXMEQHUEVDMfz+GZuoz2m4I8=;
        b=Ta4YqYD2dK9OeXNp0Zf5sqRkd/eq5kKd9TKeSc7ykHYSyvg+AeeiCKrpVUASKxVcXO
         wuH+KY5fSV9Rhi36wDSxclOzZMA6090dku+9uOweOzeA4m39Dgz6EJUhy8n9yDMp+1KC
         SrTnIXPKdqLyR66BLKwc4N3B5KxF9II83/rFNd6rgtirT/4w7EXj9vsWCbX9F5wBW2ku
         /UQOume5egEv4+YxSu4FzEVM1Qxp45HdhQhDdjxsrqOHs1/RLA/XUbzt+JhP/CpVACS1
         UsFbILyL6AsKSmf9oIRbEfDOommGYts92I3339GreiSSCGk50bjRKc/mjm9qwN4MTtrH
         EHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxis35XdZSIgJr6mklaAXMEQHUEVDMfz+GZuoz2m4I8=;
        b=Oj/JInJCNeC4pAY4PE14P71xPE9QivjZLLN2mxJKnGyjc30fEsMv7lSXqr8r+8HuYA
         WM+UbtgZ6QZTpEDM7hCWIVS8rBLhFwEBtzN/yPBRF3AR2zJv8a+U3PTyjTr81sM3IE/+
         1jGPJ1fXocdi+/6CrYvohOrT7kjhDWlhImnrEM6aFqRnUXl4zk7v6EU5ql0GhuwbmnMe
         HTZeb5S7dI51dcL2I5/rK3mymK2gSZQZAIlU4TYEYKeXYAMERqx063bMZPmcrq+ai7RR
         rFz2xQtXeICmfPBBY3TBKFATx/Unvmif+S6BKj552MBQvi4HRi8BnzDPGRJdUv9M8Bco
         jUVw==
X-Gm-Message-State: AOAM532S4ruUQYXZ7uVUILVgqvCPyP5KX09k07+fwxFr/tJoqxOjOngF
        B/GJWYeMSOT+9M3iieD2JhU=
X-Google-Smtp-Source: ABdhPJzgNhh6rQx1sqeey1CJfymo8XrBMm/8GD27m8WuMW3TcimDLTespjy/AzEL2p0EjasNmaE0yw==
X-Received: by 2002:a17:90b:388c:: with SMTP id mu12mr7323134pjb.146.1634829179947;
        Thu, 21 Oct 2021 08:12:59 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:12:59 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Joyce Ooi <joyce.ooi@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v3 13/25] PCI: altera: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:38 +0530
Message-Id: <4a195807b993aa709d08e621c821fbf0c353f33a.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/pcie-altera.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 2513e9363236..a6bdf9aff833 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -510,10 +510,8 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn))) {
-		*value = 0xffffffff;
+	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	return _altera_pcie_cfg_read(pcie, bus->number, devfn, where, size,
 				     value);
-- 
2.25.1

