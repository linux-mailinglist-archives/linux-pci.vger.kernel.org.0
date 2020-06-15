Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6661F9186
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 10:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgFOIcd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 04:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgFOIcc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 04:32:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36A1C061A0E;
        Mon, 15 Jun 2020 01:32:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so16134917wrv.4;
        Mon, 15 Jun 2020 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/dNY835TBbenopXfANftVUfONbLdxGaDwu4O0ya0Io=;
        b=mZllkfQGCwng8pRlqCnDf1668UeZ3bMTYHMKIP1Ey/wcpSqEZsDsvc7IQuOWTiZx7F
         6AEeHI7shVdh/ZBeG6h76mJYyVZ7gQofX0LMdP/CHdTAYElLgnEZIzWPXqn6HpvsiHep
         yKHDK91VHXk/xk0deKCtGYxo1eB+z5rnWqAswblhV6RXclciYmvA7gmjvL+IBaNdWKJD
         0UyCoDhbM29Vz3Rnu0G4+KppoCb63hhPn4SJe2yTCG7cvX5AMHEJNXZUu8L2LZIdsuK0
         srsTKxYCBTms6qEOeWBK7ogXPJPekbNkgs+YGmZYJOHYo8daqDqHq1VodYYjvgWmDIeD
         QpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M/dNY835TBbenopXfANftVUfONbLdxGaDwu4O0ya0Io=;
        b=DJl+2BuPqgsOXoPP8XxFPqcOw1voXKP4Uh8FwFojeNZMBCovdjaVgGjupMUDgI0Ei1
         TLHYpuck7wpWMeGTshyuyeppP1NbkaOOBTPC4ufX26OJpGLsMgBoNVYJPEcNpG5LjnYC
         XqRW0vpepAbrAaTa1gvrzG0EytE/ci5T84eFmObgcRH+M5sre8v92AeyEJkgY5frElyO
         Ce6KZ1Cluq9sr/yPzi65tCeGapfqmpDogiV+zhrLHgn5SMrifueCD4O5CDEPNb0Gpgym
         bi8GsMKgm0/29CDqfzeGFFlUcNAu1lTbJPhHnAQo/qlGrMWGI/OExLoJaVTTm5Y1Alxk
         FsUQ==
X-Gm-Message-State: AOAM53122FJ1BK9Brq+hN/6LAk86x9F9xsXPu8RXf7NSKb25twNHtqCZ
        vgie9mwfj675ILHF2v/9bcA=
X-Google-Smtp-Source: ABdhPJz4V9C1ENgGVqIPkvgCoJkdJ+A5hU166ZOZGB29u4rYCMNZZqZpD7b2MruwA13RR6eraLoO8Q==
X-Received: by 2002:a05:6000:90:: with SMTP id m16mr28561490wrx.191.1592209950561;
        Mon, 15 Jun 2020 01:32:30 -0700 (PDT)
Received: from net.saheed (54006BB0.dsl.pool.telekom.hu. [84.0.107.176])
        by smtp.gmail.com with ESMTPSA id z206sm21954745wmg.30.2020.06.15.01.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:32:29 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] PCI: Convert PCIBIOS_* errors to generic -E* errors
Date:   Mon, 15 Jun 2020 09:32:21 +0200
Message-Id: <20200615073225.24061-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200615073225.24061-1-refactormyself@gmail.com>
References: <20200615073225.24061-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

Both pcie_set_readrq() and pcie_set_readrq() return PCIBIOS_ error codes
which were passed down the call heirarchy from PCIe capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on the return value of PCIe capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative generic error values.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..fa49e5f9e4d1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5698,6 +5698,7 @@ EXPORT_SYMBOL(pcie_get_readrq);
 int pcie_set_readrq(struct pci_dev *dev, int rq)
 {
 	u16 v;
+	int ret;
 
 	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
 		return -EINVAL;
@@ -5716,8 +5717,10 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 
 	v = (ffs(rq) - 8) << 12;
 
-	return pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
+	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_READRQ, v);
+
+	return pcibios_err_to_errno(ret);
 }
 EXPORT_SYMBOL(pcie_set_readrq);
 
@@ -5748,6 +5751,7 @@ EXPORT_SYMBOL(pcie_get_mps);
 int pcie_set_mps(struct pci_dev *dev, int mps)
 {
 	u16 v;
+	int ret;
 
 	if (mps < 128 || mps > 4096 || !is_power_of_2(mps))
 		return -EINVAL;
@@ -5757,8 +5761,10 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 		return -EINVAL;
 	v <<= 5;
 
-	return pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
+	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_PAYLOAD, v);
+
+	return pcibios_err_to_errno(ret);
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
-- 
2.18.2

