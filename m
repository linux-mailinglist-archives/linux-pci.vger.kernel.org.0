Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0B444898
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhKCSwf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhKCSwc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 14:52:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DEAC061714;
        Wed,  3 Nov 2021 11:49:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t11so3064503plq.11;
        Wed, 03 Nov 2021 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kVoHPfQnodZ3/LWe6f7ZKVgKp7X363UiJlEFSvrGKys=;
        b=gCEi8Sy5N/Mk9eVvupjNy+ymn4U1vqg+Aj7EWLvoP69wUHBSwDzLRbIUC8MZTYi2st
         BU1+tpQHQU7vgWAcz6drBp/rD4mUTdLB+qWWi8IOdBGzytGmEbvRxONyR4E36OeJ9Cpm
         +CXAjCvpfRuirwkSTB42gvUCrEwCSdYloBce5squFWnQ0pxapJ8obllZ5ZfGdt+KmyxC
         Cu0P5h2iMi1ho5elmlrxk/HD/DJZl95hyOcnG8LypJ9pi7LNQ4NxNSCIJTQktFlYp2DT
         jtWEaB4kD3oQUCu0XKJ7o5doa+QGDMgpPz1V7FBPeAFTOxRBzhZWRLgYA8wXpLZsdmTS
         5ZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kVoHPfQnodZ3/LWe6f7ZKVgKp7X363UiJlEFSvrGKys=;
        b=OGykd+kAcxkkmFQqehOwKrnwxNeBauJOVVUkoETjakeVYekaz8a+9MD5Xu7gx7c+/m
         CF38IVpJ0DlUBpK7n6+3ZuPCPN89O32ZVbkW91ThovCL2vZtjcfONzweXYNZf5gQMN/k
         5LI9/+K9lTSfH3m85AafIq0h9vwbHtlkStRrh3UDow/b4P4Bi5ynMnY4cXrX0Sb0azpJ
         U70sTe2nZSlvrqhG0VZiZbBbuMjswu8V+JMzQixG55zpTNcQ/OeWPa2/gQ3EM1gYyrEj
         QnFAE69n42hTNLeUkVIgpkQgzIF4P6SxQjuAw1Tj5EPnu7OoDAjO2MpwduR6Ekq4Hx/x
         yKYg==
X-Gm-Message-State: AOAM532mI0MTOHRgcwyZxBqHSpR3XilhJ2GdbgE/vtQoFse0yc4K9auu
        EaItFXkoGuTq+R7qnxe/zhusMnefkqwuUA==
X-Google-Smtp-Source: ABdhPJzshArmo/48IhJdPKAnbwwXSdLIecSzkTpe89usHqdHIxb4sn9w2GLV2y0gtzbssrMCx68EwA==
X-Received: by 2002:a17:903:18d:b0:142:8ab:d11f with SMTP id z13-20020a170903018d00b0014208abd11fmr12951026plg.47.1635965395238;
        Wed, 03 Nov 2021 11:49:55 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j6sm2379065pgq.0.2021.11.03.11.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:49:54 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 4/7] PCI: pci_alloc_child_bus() return NULL if ->add_bus() returns -ENOLINK
Date:   Wed,  3 Nov 2021 14:49:34 -0400
Message-Id: <20211103184939.45263-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103184939.45263-1-jim2101024@gmail.com>
References: <20211103184939.45263-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, if the call to the pci_ops add_bus() method returns an error, a
WARNING and dev_err() occurs.  We keep this behavior for all errors except
-ENOLINK; for -ENOLINK we want to skip the WARNING and immediately return
NULL.  The argument for this case is that one does not want to continue
enumerating if pcie-link has not been established.  The real reason is that
without doing this the pcie-brcmstb.c driver panics when the dev/id is
read, as this controller panics on such accesses rather than returning
0xffffffff.

It appears that there are only a few uses of the pci_ops add_bus() method
in the kernel and none of them currently return -ENOLINK so it should be
safe to do this.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d9fc02a71baa..fdc3f42634b7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1122,6 +1122,9 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 
 	if (child->ops->add_bus) {
 		ret = child->ops->add_bus(child);
+		/* Don't return the child if w/o pcie link-up */
+		if (ret == -ENOLINK)
+			return NULL;
 		if (WARN_ON(ret < 0))
 			dev_err(&child->dev, "failed to add bus: %d\n", ret);
 	}
-- 
2.17.1

