Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7311A4365B6
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhJUPR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhJUPRk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:17:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FADC079787;
        Thu, 21 Oct 2021 08:15:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id np13so726990pjb.4;
        Thu, 21 Oct 2021 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CD7r2JlbysI9wliPfrkuC0MHY1rENRMFz+j1vzlStHM=;
        b=oDFCNSD9eXmglDMVHyAk5MQTQay51LCLoU0OKnLVLIJ7VZjwfRS43u720yBteKnac1
         p/lwD3xlqwhz6jgJCIyEpcwG0woAnh4SPlq3ehA2Dp6roi1MizNQvP9UmKO5XmzgzXHh
         Yo8hCUXDbYf/vLOy2UTggbqD86Qs6k+rvdXbbW3GQfeNrWG8QOThYpWh1j/EefuDhdpi
         GYRjhfePIpEwov/eAxotQJb+gVbAmx0u3U/6QuWyGHc0mWmlXKvy0suP20VFDVbzyuvO
         8JtlUB+qUtIMOvvnBRXJARMpbYmbSTgNllBbT2hj5UdRBE7T3jLTou7IG+zlJdFAJ+xS
         Kx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CD7r2JlbysI9wliPfrkuC0MHY1rENRMFz+j1vzlStHM=;
        b=M+3u73zx2G8UWAr1L3WyaXdt1GT5xd9lZsd4tq0rmgJPLQ64PnyjvzdjIJwulxY9G2
         xUuel64SCDmJ1dqH9b9bT0sPazh0Fp/OgsHCYrJrF6+S86ta/MUoQQ+w8pxkhNdjoqz+
         lALWoruFLci7D5uv7dsT5vBu8sBfhYbCAwqWEVZGM2skYCWHp9xBg7HThwL1MZlTWc1C
         KwZzPIhxsm/86exfDlxzlYTVf/Lr36OfSpTqLideBmrVLlpqC4eebO9+92d7/BDeTyom
         jgzHEk9a16nsYJOXXwMR19TB8iZytqvS2Ma5j+i+FZfPtwdoRvIFNCw5C3te2wXcRHgS
         FvbA==
X-Gm-Message-State: AOAM530Pden5Z0jZQPkE6WXqg3qr0w46E6n1/zNgFsw8xGgBbKylhxf5
        3fJoaIodI7xufeZVGeZFjeU=
X-Google-Smtp-Source: ABdhPJxDplYpiJvMYFKBibWwNfI1+QoLMtVL4HB+4mcg+FH8MsrUv331eHciak5L7Kjd2dDJhW/DZw==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr7333076pjb.7.1634829320924;
        Thu, 21 Oct 2021 08:15:20 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:15:20 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR
        APPLIEDMICRO XGENE)
Subject: [PATCH v3 25/25] PCI: xgene: Use PCI_ERROR_RESPONSE to specify hardware error
Date:   Thu, 21 Oct 2021 20:37:50 +0530
Message-Id: <4a5e5a4625a3259e20e70f73ce9c294b695cfdde.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include PCI_ERROR_RESPONSE along with 0xffffffff in the comment to
specify a hardware error. This makes MMIO read errors easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/pci-xgene.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index e64536047b65..4b10794e1ba1 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -176,10 +176,10 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 	 * Retry Status (CRS) logic: when CRS Software Visibility is
 	 * enabled and we read the Vendor and Device ID of a non-existent
 	 * device, the controller fabricates return data of 0xFFFF0001
-	 * ("device exists but is not ready") instead of 0xFFFFFFFF
-	 * ("device does not exist").  This causes the PCI core to retry
-	 * the read until it times out.  Avoid this by not claiming to
-	 * support CRS SV.
+	 * ("device exists but is not ready") instead of
+	 * 0xFFFFFFFF (PCI_ERROR_RESPONSE) ("device does not exist"). This causes
+	 * the PCI core to retry the read until it times out.
+	 * Avoid this by not claiming to support CRS SV.
 	 */
 	if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
 	    ((where & ~0x3) == XGENE_V1_PCI_EXP_CAP + PCI_EXP_RTCTL))
-- 
2.25.1

