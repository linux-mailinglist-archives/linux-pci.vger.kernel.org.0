Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEE443653A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhJUPNR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUPNQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:13:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BA8C0613B9;
        Thu, 21 Oct 2021 08:11:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e10so618450plh.8;
        Thu, 21 Oct 2021 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3o5gBqF0m60j/685v1gCV+85CWmYdPsbI4M53MCV74=;
        b=i2E12Gf3MradRaA6L+Vcc5Lo6XtZ/fVf/ZWnm8oDtjsE4xTJqRT+l19jozuA+esT+h
         PJFe/cy5U/ogFT/dPLmB/2eJP5WH67mC0Sc6YJpFdLeE4wCg+AtGoUkNW5E763Ake4L1
         0mcJ4mk+yV5TKnLMWZUW0IFVz7ar2ciGv/Idb1uiTPEGS3aWtW0BH2zd2XvhO4uuGgqo
         c7t7w0ryMTIwqzsTWcp4XZqpzvVnoYlrP76HIhR4rwn5vX9hP2pa4b+gPjiRbyKUUKcL
         9NH1RMGqUzPBQky4qUSGPv/4fbzQrRqvp4yp0IaUz2uFsJ/p2EIPz94JzBz5Js1HQjDE
         u5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3o5gBqF0m60j/685v1gCV+85CWmYdPsbI4M53MCV74=;
        b=3XyYOStHxqYX3ROqZBWIK7d993kIMWVp5pXJ6B1UG9nNGwnjoGHDWHH5yDqbOjIFHE
         LzuAny2DMMSw3SZCzFpEx6Xp4lOvYWtcPOWdkP+FVueIMrelSt/dYU3NKiw+6pHO4P+K
         iQcAsmh8u+alWmpP4txR3sGhltZwr5DlwzrmqbXgCo1+Pdys9YcPXvkwCJRqtv+AKKpa
         fmudTPR7tvBrxIl4ys8/MU0KrEa7EHMZTpFazmkKkjjWDA9rbXO28emo8RInsRepY2yF
         idHZz1k/ROvMWc8EMWYzw5yti96tUstIo7Ssly/U4f6Teq78k2yM8BTLDkEeJgFdZ4ZU
         7j1w==
X-Gm-Message-State: AOAM533Yp0kPHvZ9AVCHwCzhhlgVKC7OqkNfErUGiUlRvLxh7fS6LR2r
        Un8K0hy5Z2pzPUaXIYG74Bk=
X-Google-Smtp-Source: ABdhPJxFk7e1vtp4qHS3c1Zxn06yJuOA57fAM3iyNvU3T73javJynq35EJA8Ilbs3c18IIVc7E5eZQ==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr7304004pjb.7.1634829060352;
        Thu, 21 Oct 2021 08:11:00 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:10:59 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE)
Subject: [PATCH v3 06/25] PCI: iproc: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:31 +0530
Message-Id: <cbcbde500a34fe5ca3996449ec4e1d78d02f5628.1634825082.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/pcie-iproc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 30ac5fbefbbf..e3d86416a4fb 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -659,10 +659,8 @@ static int iproc_pci_raw_config_read32(struct iproc_pcie *pcie,
 	void __iomem *addr;
 
 	addr = iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	*val = readl(addr);
 
-- 
2.25.1

