Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CFB43654D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhJUPOB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhJUPOA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:14:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2C3C061348;
        Thu, 21 Oct 2021 08:11:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m21so567766pgu.13;
        Thu, 21 Oct 2021 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FA4eEA0vKwb58YOkbLP9K2NVmJYtwGLqPjb+iaCxg5k=;
        b=MSAARfVkkBFaa5Ke5ob3e1LwRETvIsI33C2lnbjRTuAmIo3JjMsSIGohrcEr7GesQo
         YBiVfDVx92ElvZl+8rczQScmVzoG5ry6w4RPZDxetXdzQQ/GfEuoXZ6SIWaD8XMUt6J9
         J7HWgg3KkLAqTEwfg9rVkAdV55stFrUiQmOhjyfbrU/lRuEh/OCtlWGos+FHtYDiOpqM
         KHqMpDUE03pkwqD8tn8d1Tiw5l5YYGKHSz+UsxK435/gmfmdvW5MaWFKGd02PPO4gi+X
         saQGEi++av2pKzxu+zMV/B/auaPuRaTGKq+9CCwCD+0nUS25WJhsnriyYWdRkffmiE1B
         3XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FA4eEA0vKwb58YOkbLP9K2NVmJYtwGLqPjb+iaCxg5k=;
        b=jPKhROLj/8tmuY+Q9wGnLP9hebpeRANC9VaVMYqmHtuEtvrP+1+PON73dwdVsFgiBp
         AyxahYRNY+37VVxKSMLILtmpDMjGnOaLyeDbxFrEpSyaXLzHaax3tGmy/2LSP+AsO++9
         V5r3hwDd7b8FI0l/SdNo5inURHF3eVmuA2rbqxpH4D0W1hxWfp2wmiDeQESihiZVOtTt
         rjflLB8YBwurCmSjbhaxtzDJdSd6opz4T4WAf4G+N2ZAoODuOLwIDJcj8YSMzDVh9g0q
         bPBvpPwJGt2wIzOEhhEGP0sqTRtbXJ27iGhRwzvGT0ckRPgRm/peA6J24cbeYIvm6eYI
         lMLw==
X-Gm-Message-State: AOAM5321QJXndRnG+L99Z4QB19hp2N4TmQsNMOl3gIhpFRfujnDn10gV
        lPZppPlyh4i6jep3ChVCl8s=
X-Google-Smtp-Source: ABdhPJyxy0wACLRRPNq4NQsmW2piR/kvR+jFJ+L5zv+lm1gRag0Yd1GGflUXQdo2Igoo8j39CZvaHA==
X-Received: by 2002:a05:6a00:1248:b0:44c:84cd:f795 with SMTP id u8-20020a056a00124800b0044c84cdf795mr6283222pfi.79.1634829104274;
        Thu, 21 Oct 2021 08:11:44 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:11:43 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v3 09/25] PCI: histb: Remove redundant error fabrication when device read fails
Date:   Thu, 21 Oct 2021 20:37:34 +0530
Message-Id: <0e8d665e676717cc69394c6153aa85dbb4d02ca1.1634825082.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/dwc/pcie-histb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 86f9d16c50d7..410555dccb6d 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -127,10 +127,8 @@ static int histb_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
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

