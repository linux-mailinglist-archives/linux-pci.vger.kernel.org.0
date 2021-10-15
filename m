Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB68042F600
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhJOOrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240697AbhJOOre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:47:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5EC061570;
        Fri, 15 Oct 2021 07:45:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kk10so7364886pjb.1;
        Fri, 15 Oct 2021 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSO8fMw2XXEulSijQBNzsaO/mKtFViudcJrPIwPiUa8=;
        b=VpeS/amvYUMgnN+vcfj6j8ChB1pwWoO6uMGWOuOMw3t5zmBHwzJtCs9quAgWX82zzr
         D/DOYmnPRH3/zvIoD/chwGm/OTZmGKh7UDc5sla+AWQUDxnltegMOxxaLJ+BY+bb3DEi
         kUxKxjW7VBspT9igA7St5CiXuMYxgm1Q6RD6ymtQ98l75Bc4vY+OSN63d5ch8/fKy4od
         Y4qhkPaVGXRe7krQX38Y92Xy9pC/0uz1/ZdQjlWbnPXRMTZeXYN11L4yhHy00f8NQJJF
         VoeYU4l+491rXplUi+pwwyOq9jrtGmS4bd6qdAYxZIONa0If5nnCBE+VVpXitLj0RfDD
         adPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSO8fMw2XXEulSijQBNzsaO/mKtFViudcJrPIwPiUa8=;
        b=mDZa4SIYV0jZmYEkfkH9myPwW76MdmRc7QOlRypZF6PqEdzyHHr3kZBMzkAVUsUCXT
         jpk+2Q3vwLBIXdjQ6KNvctw7/wIyJn0ZhSCKG/quDfSaNtPzKFaOH3Q+wby7NZsxUA5m
         OSdwW1ob2eQfJHSQaaQfOppwUldOKkj3VXs/oWS5ba/eSbKNu2lFulSkrtrC4WOXwECo
         Zr0yJ5JaIujhyQubUssZswvUbwoBEQh40Rat+iRqhLTg10mLCw3B+GM4vGYhoMuT+qdK
         mSqdSeOYLsVhzbKqX9T3XTpIE7ttSxQSOQTNzIOaPf32GyR/5PsqQ6Tb7+24YvoPbwBk
         E95A==
X-Gm-Message-State: AOAM531npeN2eczBXYBkBJoBc0F/dc0HRNVwpWsZMKiQBuSYSQ4BMvdN
        HIRnnE6mIAGSkKR3Am7BvCk=
X-Google-Smtp-Source: ABdhPJwTbPdY3g2bOp7CoNi8n3DnxaNqHB7MsT+VZH6Djl1EnJi3JSClC4QlhR0Wg/UTCn6Kg2YgNg==
X-Received: by 2002:a17:90a:e547:: with SMTP id ei7mr28994508pjb.169.1634309127749;
        Fri, 15 Oct 2021 07:45:27 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:45:27 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-renesas-soc@vger.kernel.org (open list:PCI DRIVER FOR RENESAS
        R-CAR)
Subject: [PATCH v2 14/24] PCI: rcar: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:55 +0530
Message-Id: <2544a93bf8725eecbea510e7ddbff6b5a5593c84.1634306198.git.naveennaidu479@gmail.com>
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
 drivers/pci/controller/pcie-rcar-host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 8f3131844e77..1324cb984ed5 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -161,10 +161,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 
 	ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
 				      bus, devfn, where, val);
-	if (ret != PCIBIOS_SUCCESSFUL) {
-		*val = 0xffffffff;
+	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
-	}
 
 	if (size == 1)
 		*val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
-- 
2.25.1

