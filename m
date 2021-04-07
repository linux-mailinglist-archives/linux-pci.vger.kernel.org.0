Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25503356CFF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhDGNNI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhDGNNH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 09:13:07 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6307C061756
        for <linux-pci@vger.kernel.org>; Wed,  7 Apr 2021 06:12:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r20so20632696ljk.4
        for <linux-pci@vger.kernel.org>; Wed, 07 Apr 2021 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z5cqK4hvOZb7E6bD/AeT0kN1Xy5Qj2MXLt/K/loAd68=;
        b=Jl+PCE4F8u0LgGQ0yRKsEzjmEl7P0KW5+FTCeO0qTbr05aQhxTRBN6pUbNrRYH39lT
         VcEam1jT8M+wuETXgtjaxqdSIayIdhHaIiFT08TJlgH7NZ8GHRvKeEYj/SliUcAvz8XT
         14PU3dkcvy/RNkYRYHUWvU2CtmGYyaHyzduvo08fX0bQz6kAgC9lxAvLkmHZl4HhAsie
         0Vitsx63bJ0Na1DeYIRebdWVNZNyEpy08KBuInb+7WzKScfqYmwa+u3nsYnSKBipDnQY
         1WNkuR70SO59gE0ma3VtCRgWx9Ha0d6rQzXoZzCXm4PDa8p5ExVdSLspZR8MCOWRLbve
         w/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z5cqK4hvOZb7E6bD/AeT0kN1Xy5Qj2MXLt/K/loAd68=;
        b=N8VFM3TkMPjP/nrdBLStP1ScP4kGFS/NCQXZNZUM666QPPf7TsiLcl/TdMUuGSdo8q
         26sr19eqg+VlPmxkGNnLQsCpIAU6m7Zs/YsroZqbuigmOxhWCa8Tp8RfFB8pReh8528F
         JOuRfeh9CG4auzn52fVWaZbvqLmdzixlbPO4F7YmieBLAHNbR27fFtDTDpK3cpY8EXsQ
         1p2EkN02JpGGyMGrqn/5rWj9C5mc2h5Ii6j4tBD+py9v5D3dRtO/UZpUD3LN4LS7TTha
         KHsKz3lli3St3sTbLO3YC5mmKbTrV2KuawcCNJZCdDKArmEtfFTcAluzKmaN2HThAVaY
         Z9Lw==
X-Gm-Message-State: AOAM53265aNrrk34o3buPhx9Wt7G7eNw6v9Miw2pYl2dV/5mFehRxLTC
        GWkIAoTsROMl25Own7/tkUt7eg==
X-Google-Smtp-Source: ABdhPJzsJS23hBPUD6FfGLzc2mb6o8zaknb3dCcHg9tXK5Td5kDRG95ZCvVIf1v/BQi2PcdrkmxC4A==
X-Received: by 2002:a2e:b811:: with SMTP id u17mr2141031ljo.324.1617801176361;
        Wed, 07 Apr 2021 06:12:56 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p13sm2572146ljc.72.2021.04.07.06.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:12:55 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] PCI: dwc: move dw_pcie_iatu_detect() after host_init callback
Date:   Wed,  7 Apr 2021 16:12:55 +0300
Message-Id: <20210407131255.702054-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The commit 9ea483375ded ("PCI: dwc: Move forward the iATU detection
process") broke PCIe support on Qualcomm SM8250 (and maybe other
platforms) since it moves the call to dw_pcie_iatu_detect() at the
beginning of the dw_pcie_host_init(), before ops->host_init() callback.
Accessing PCIe registers at this point causes the board to reboot since
not all clocks are enabled, making PCIe registers unavailable.

Move dw_pcie_iatu_detect() call after calling ops->host_init() callback,
so that all register are accessible.

Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Fixes: 9ea483375ded ("PCI: dwc: Move forward the iATU detection process")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 52f6887179cd..24192b40e3a2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -319,8 +319,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			return PTR_ERR(pci->dbi_base);
 	}
 
-	dw_pcie_iatu_detect(pci);
-
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
@@ -400,6 +398,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		if (ret)
 			goto err_free_msi;
 	}
+	dw_pcie_iatu_detect(pci);
 
 	dw_pcie_setup_rc(pp);
 	dw_pcie_msi_init(pp);
-- 
2.30.2

