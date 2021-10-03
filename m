Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D961841FF47
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 04:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJCC4a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 22:56:30 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:33484 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJCC43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Oct 2021 22:56:29 -0400
Received: by mail-ed1-f51.google.com with SMTP id p13so21928462edw.0
        for <linux-pci@vger.kernel.org>; Sat, 02 Oct 2021 19:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tb0JYaOAZxreZsr7ftz6TvhnTsZs54RbRFVXYC69MIQ=;
        b=eUist2CfD2f01NKFaohwwRtL8nzcEfdyVwrrUtGOEjteDMrtncd0YwVRlv0g/zGT9T
         W8YrlZ+YTZD7KouBJHdr2qJRBn+eUXzffV+huVONiLyoT1UEGhmra/OxSv25mWQ/jmyZ
         UsjuOUSWv1J8DF2yBeztTmQ0x8V7DVOsRBJ+rHBnYoP6cdWqOWfziMIox97GE1hSc8Bc
         BMIAjmqr+x50ZhQR2jal7pt8yzaIJQAfz4zAhqH3NCw/8u0IFSbhlqrEAhD0qTiKjj0J
         bOQM9RFop5zhNyQvP+p1arkFe8YSvBRtco5KyTrf+WUmi1TZlLid8w027MSi9kiOcjV6
         JRiw==
X-Gm-Message-State: AOAM533zFtv1ovbIeJEj7YIjBNpJocwHUjoMWj9dySpRnbWdMgsEIvLD
        Zwxn12qCkIdxM9vVCK2DDn8=
X-Google-Smtp-Source: ABdhPJxyRkCB3OnTnsKwYlQSC3exOWmehjdkHvreqTAHHLadaVfoEAOzpy6BRm4Vm3Fo58Jh5f29TA==
X-Received: by 2002:a05:6402:181a:: with SMTP id g26mr8138818edy.54.1633229681836;
        Sat, 02 Oct 2021 19:54:41 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e3sm4683525ejr.118.2021.10.02.19.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 19:54:41 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: imx6: Remove unused assignment to variable ret
Date:   Sun,  3 Oct 2021 02:54:39 +0000
Message-Id: <20211003025439.84783-1-kw@linux.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously, the maximum link speed was set following an "fsl,max-link-speed"
property read, and should the read failed, then the PCIe generation was
manually set to PCIe Gen1 and thus limiting the link speed to 2.5 GT/s.

Code refactoring completed in the commit 39bc5006501c ("PCI: dwc:
Centralize link gen setting") changed to the logic that was previously
used to limit the maximum link speed leaving behind an unused assignment
to a variable "ret".

Since the value returned from the of_property_read_u32() and stored in
the variable "ret" is never used in any meaningful way, and it's also
immediately reassigned in the code that follows, the assignment can be
removed.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80fc98acf097..26f49f797b0f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1132,7 +1132,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 
 	/* Limit link speed */
 	pci->link_gen = 1;
-	ret = of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
+	of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
 
 	imx6_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx6_pcie->vpcie)) {
-- 
2.33.0

