Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A222042F5EF
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbhJOOq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhJOOq0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:46:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8EC061570;
        Fri, 15 Oct 2021 07:44:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so7410207pjb.4;
        Fri, 15 Oct 2021 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldCoPF9oxZH7/MigxipjFPAj1P91oCyhQC/cTDGjKcc=;
        b=OouScJo8ja/pvkJtRdlEZQtihBai8aqlCVtV47g3ith2pLVFv5EggIkWjSQWXjBLiy
         bR69cFniJIc7JI+EN7zvxDMqjH/wbKmOYW1/ir5pvriC6V7njh5I9OPvIL5ioktJbzlH
         nzNOREwfyuzcCPSkEHB4vY+kVvH7aeG7MGiC2upZxQeYtJTrT8INkJbYhzm7x1JqU0AU
         +c9lMyAhN1HtAvEnyk0sKpqvlJ1PaVFxM+6hK6+INVKviS7s5nUuKJDLMOvqhDq0rM2x
         N9kHtFZgO1ChtjMAz4XLU1nM0VZHmvwZURWHw8W3/8YdPGAI8H2MOo69KwX0vCgytfH3
         G5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldCoPF9oxZH7/MigxipjFPAj1P91oCyhQC/cTDGjKcc=;
        b=zeAMN6Iz2DllqtHnWWRMB3hQK0hftYdY2nX/xyP8XNTSSeizmaYIQ8pwnr0Wa8RGvS
         vG2DzoVaqt9LHKMvxyfdNmywn7Q0Kzut7GSnRjDL0Kby8Qm0z6wr07i3gn7RjXd49Kzs
         q8zsEZH07913pGiXoIzXCIZ73gN5ID40QSAJSgqjzRSnJKPzbbdCTSNGXfEJH/LQB51v
         Aup2ueRSW4B4D9y8cutydXsTk2hJ2GLFYtuBlQHsXAJ+h4M1B1buxMst8IXbtX8UXf9R
         TfZtwxYvS5UPEiSnO+0hNaAcA+NyGAJJtxQdsuMaXAhmCHPAWaND5vgQbwRYrSJ4jxLH
         7mXw==
X-Gm-Message-State: AOAM532PtjGlAn4H/wLsskOIwWt+wyZrEXXK3yNbcAOSR9gFt8dg+W/T
        gAPykx+ggmtlCi19OlIbENA=
X-Google-Smtp-Source: ABdhPJylYSfUH39Cu58cA3v3pK4Gdo2oUhIIxs2gB4VD/e/TOz3AGlV3Zo1+dcCeHy8mhbkvVa2lDA==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr13809594pjb.95.1634309059387;
        Fri, 15 Oct 2021 07:44:19 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:44:19 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v2 10/24] PCI: kirin: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:51 +0530
Message-Id: <9ccf6dd66a61b3889eddb36b0713ad5d65bf4744.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
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
index 026fd1e42a55..56ccc5ceee50 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -330,10 +330,8 @@ static int kirin_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
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

