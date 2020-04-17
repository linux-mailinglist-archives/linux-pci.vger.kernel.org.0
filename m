Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBD81AE515
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 20:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgDQSst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727890AbgDQSss (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 14:48:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39A2C061A0F
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2020 11:48:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so1534559pgg.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2020 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/m8uFUPGMTXPG6uE9UPBDXEGsmlpHvFfRMPeQIRglr0=;
        b=m55vm8qpsWewOdjKtNV9pAA/o9+H6/LdDotUxWcE6LTAdjTMH4J3LNhBIZ6wWCKmNo
         99GRImy6d5PLzuLZIH/aZlDXNr4DtUD48apChLpnvfxnpETe7l3oPQ/WtRQkVvRbdfSu
         skGOb/Tf+DAYWM4gntE5s80z0Yp0jHTWnqeG1ydjvMReWaJpGPGN3j/d1iPXF1Hn5uan
         M2t5AhwXcWJNEYNQJATDZ8rLCSC+jlt2B2QpqBzhNwiOer5QagoHIXeHh6Argt7eoU4j
         kU5xp6C9bqgXqa0hoED9I6CRFHE+bbrN49TWBqh14XXShfG5joisVXURuPXDedM/kDU7
         Npqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/m8uFUPGMTXPG6uE9UPBDXEGsmlpHvFfRMPeQIRglr0=;
        b=s24/Z9WJvJTqVKsrArZhkgRBWPJFCBTs+SS2vnMuEiEwnRd99uSKrRpwZFF1WU49Et
         sHm64+2bsMN7ezALM6LJRixSNJkZzCc7GoF9JAJaUrIB4VdLdp8oR6qOmyCPPoqLZ8q7
         RjPQ1AJI0IHbUuStTOH+S1jiBYQAm6/BR38HP3oX10pvRQAqfOZQ9j7dRxayAOHNMtOs
         H+TdAjoZrk2nEnXVgCGzEQm9JkopAzG3U/Jux5Qbh+D12rofsekTo1NdB8hf7mNSzOU8
         9X7GZ5T5XbDZuV/bMaj2rkSwOLZnKAPZ2vnka20sp3JhHXvMXcIzw4h/09yUHMytFtCu
         lcOg==
X-Gm-Message-State: AGi0PuY6TnExVxzzpXQWDhreQANbhnMcsnKh5qyqhZMZ168Ctgd7UXRm
        9Ip6yss91EjpL/clY28WGtXkFg==
X-Google-Smtp-Source: APiQypJVSsNxOrC49Bt1KeprvKNWUF/fOBKhWHYpgHUpDM7iS/wLjotWqC0uiFeh2vhCtRy4gCIUgQ==
X-Received: by 2002:aa7:9207:: with SMTP id 7mr4521820pfo.178.1587149327949;
        Fri, 17 Apr 2020 11:48:47 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id l185sm18924449pfl.104.2020.04.17.11.48.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 11:48:46 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        gustavo.pimentel@synopsys.com, kishon@ti.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] genirq/msi: Check null pointer before copying struct msi_msg
Date:   Fri, 17 Apr 2020 11:48:42 -0700
Message-Id: <1587149322-28104-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify __get_cached_msi_msg() to check both pointers for null before
copying the contents from the struct msi_msg pointer to the pointer
provided by caller.

Without this sanity check, __get_cached_msi_msg() crashes when invoked by
dw_edma_irq_request() in drivers/dma/dw-edma/dw-edma-core.c running on a
Linux-based PCIe endpoint device. MSI interrupt are not received by PCIe
endpoint devices. As a result, irq_get_msi_desc() returns null since there
are no cached struct msi_msg entry on the endpoint side.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 kernel/irq/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index eb95f6106a1e..f39d42ef0d50 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -58,7 +58,8 @@ void free_msi_entry(struct msi_desc *entry)
 
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
-	*msg = entry->msg;
+	if (entry && msg)
+		*msg = entry->msg;
 }
 
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
-- 
2.7.4

