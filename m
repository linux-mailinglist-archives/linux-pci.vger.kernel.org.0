Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A71F918D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgFOIcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 04:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgFOIcn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 04:32:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6324C061A0E;
        Mon, 15 Jun 2020 01:32:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so13725481wmj.0;
        Mon, 15 Jun 2020 01:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LITx0hRUIi2s0zyE1t9RreKX12TROzF0jbPsYEw7a6g=;
        b=LROVgM3UbJsunBVTDQc6YnuCBFFfAkZvrZXlxcwnUE8Y5GVCb7hTTl/WDNhOZy+6Xu
         EaGowoNKFFiyujkvYmfaAGxdQPKziOwvy+LQzF3eBQb9l96HzHbmpfaVgHHnPADSWE2H
         I6Cet/NvMy8f/JfrVkwqIR5JbuOgl4gJBb48gK/f/Tgn/4rImbWs36a2vJtRYiuQ5S4C
         hj9jr1We9pK/qchTQGJYh/Y7VJKlyohhmh3H1wobfz8Pa80zCSQppsxmZdoatZCQSPMX
         1HLURZqPWoo+gKsZ6+ptU30rJmOO6mBKLhB7E8fSt7K5HOMQ+cddKgmHu8dtWVYLduFz
         3x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LITx0hRUIi2s0zyE1t9RreKX12TROzF0jbPsYEw7a6g=;
        b=SCDnVygK4+H0ycjzcuEbQ+JUbUNsBi8PucWPYgYTbk1JBLqNTIXwB5/bR95FZLpvXA
         JDlOG2HFX1L1JODtdndnYI1+IgRVVH1gql645+NXUbuOWyWKhWwswr8sDH9UNORB5BYJ
         0oHlbATS2TwkETfyBTZmRN3lkg0SjtJPiak76r0Kmy3noMdoA7NyHYt8QVAjgWmw9dKK
         RsevCVyPfxVRLggmD+IEGbOn9AU7CP6l48M7WUH7EEZckpWdb5C43OG+KIRERlevOIb2
         4iPKQt/0GN3+aRT6K0nJp2RStzeL6GUXhSzvVX10wL/lnABLWLDmBIU680O9thaxp9ps
         SoDg==
X-Gm-Message-State: AOAM532mYYM3zQP/7J9koXZuH7Cu8odRPOOFJfciF3SHdl+SwZpwuty9
        UfESXpxgxPombrT0/h5xXlY=
X-Google-Smtp-Source: ABdhPJw04FZmglvBQAYa1v3ByqfYKXiOGDZXpDs1UTQSt8C8BmZt7jyni4XR4+j0NGd7DZy+4KCTMw==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr11656022wmc.122.1592209961579;
        Mon, 15 Jun 2020 01:32:41 -0700 (PDT)
Received: from net.saheed (54006BB0.dsl.pool.telekom.hu. [84.0.107.176])
        by smtp.gmail.com with ESMTPSA id z206sm21954745wmg.30.2020.06.15.01.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:32:41 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org, Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] PCI/AER: Convert PCIBIOS_* errors to generic -E* errors
Date:   Mon, 15 Jun 2020 09:32:23 +0200
Message-Id: <20200615073225.24061-7-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200615073225.24061-1-refactormyself@gmail.com>
References: <20200615073225.24061-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

pci_enable_pcie_error_reporting() return PCIBIOS_ error codes which were
passed on down the call heirarchy from PCIe capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on the return value of PCIe capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative generic error values.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f4274d301235..95d480a52078 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -349,13 +349,17 @@ bool aer_acpi_firmware_first(void)
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
+	int rc;
+
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
 	if (!dev->aer_cap)
 		return -EIO;
 
-	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
+	rc = pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
+
+	return pcibios_err_to_errno(rc);
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
-- 
2.18.2

