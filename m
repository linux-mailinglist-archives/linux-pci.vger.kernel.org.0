Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D95A27390E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 05:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgIVDDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 23:03:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36552 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIVDDC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 23:03:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id x69so16363822lff.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 20:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sv86L4tTF46gtQtrszbDEkK4c/C/syy/IBF1mCGf558=;
        b=U6rb7/FJwYaVYJxwoclYr+mMXkKFSGUuD8ggtBqLZb/SytFZ3kTyov4nNcPi0IGr42
         ASmWo/rnlUq1awvx9ae6HzWtaV8zwie9nRnZhIDBzyX5fbBVRPSzm1UmJbxslPWCAFxq
         aKsvNBtGUtsU9sE4r3eqmFZNirT2eM9DZZIQBtU4n8ERzg2QjvoSaAN8ZxBQWJtRJ9Za
         3ZGTjPAM5oXUEv8ppbNnvgBicsJ4LkbkGr+dfHLUaEX+UO3REfzybJNljQ/5eQE+h5Bs
         zFKtab4QYA0NpGBScY8C48mms7OjQzGugXJYrD60O/GhaHhpAtJfIVn3UfSMHXgNDlmu
         xy6A==
X-Gm-Message-State: AOAM532uw5jSUTiC92+J9BHVgNNgp+hfm5d3Rh0Kmq/zk+Fe+VD1p5ES
        PeB0dP6oW22fv85AuJPEN/3wGW2cWvSUqZBp
X-Google-Smtp-Source: ABdhPJwGDbRO+HsTtwpB0nXT2IF+OzNsAkcIv2Irj6ntf+GN/JSlMlShMDRaXFbIJomByo4sL8ekrQ==
X-Received: by 2002:ac2:4250:: with SMTP id m16mr843681lfl.565.1600743779766;
        Mon, 21 Sep 2020 20:02:59 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u17sm3020878lfl.283.2020.09.21.20.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 20:02:59 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Toan Le <toan@os.amperecomputing.com>
Cc:     Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: xgene: Remove unused assignment to variable msi_val
Date:   Tue, 22 Sep 2020 03:02:57 +0000
Message-Id: <20200922030257.459898-1-kw@linux.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The value assigned to msi_val after the inner loop finishes its run is
never used for anything, and it is also immediately overridden in the
line that follows with the return value from the xgene_msi_int_read()
function.

Since the value of msi_val following the inner loop completion is never
used in any meaningful way the assignment can be removed.

Addresses-Coverity-ID: 1437183 ("Unused value")
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pci-xgene-msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 02271c6d17a1..2470782cb01a 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -493,8 +493,8 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	 */
 	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
 		for (msi_idx = 0; msi_idx < IDX_PER_GROUP; msi_idx++)
-			msi_val = xgene_msi_ir_read(xgene_msi, irq_index,
-						    msi_idx);
+			xgene_msi_ir_read(xgene_msi, irq_index, msi_idx);
+
 		/* Read MSIINTn to confirm */
 		msi_val = xgene_msi_int_read(xgene_msi, irq_index);
 		if (msi_val) {
-- 
2.28.0

