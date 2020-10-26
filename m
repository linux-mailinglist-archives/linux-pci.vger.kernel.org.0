Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99681299165
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 16:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772998AbgJZPsy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 11:48:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41692 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772941AbgJZPsy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 11:48:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id k65so10372711oih.8
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2020 08:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZICek0X4B3jCPtijry9tBbjapQjJymUCN2iqq5UaQOk=;
        b=Hj1mlPTr8mrry4YPYB8mD55NyE6enEzcv/MG6qs0zikvoDTVp2pw2JfFpE95ggjU1e
         k/J25oVdbrH4AATbwbqIN09Cwy4lojxQTnHDpscJpUZewI3MggHZeJCr5zrBHFTL7lCd
         hjnakC0QcpM9NR3W68mx/4MAIXIEAWmkgEmtUToWwmIXR3pF/JWyzMstHiCPtyCkHrn0
         O9qqibxy8p1s6xOlNBVg7ALWPjUMZvyJkcIKxMJWw49vh+S7wB2VPK2D094bWWW3cNoU
         cMCIhbqG/QLWdIOPlFLUFlZjNHcUTAL0IasJkQEUGQ7zfJFM4ekE+vKyv7AOV1khe8s9
         1ZTg==
X-Gm-Message-State: AOAM531OHJJICxvr3rH6PxK1zUImKZdSBQwRJ61LZmTUIaVBybforD/h
        u0WHf6RFAOvUPb9uXUVMKYlLpTgRnA==
X-Google-Smtp-Source: ABdhPJwfpilOszVpK7xjg3EcPj4tyWnuwSY66NHJrJUcCeNseDw5pMNHKtBJCvv0OwTBG+ySjFmSTg==
X-Received: by 2002:aca:b9c2:: with SMTP id j185mr14645338oif.83.1603727333563;
        Mon, 26 Oct 2020 08:48:53 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id b17sm4245328oog.25.2020.10.26.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 08:48:52 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: dwc: Restore ATU memory resource setup to use last entry
Date:   Mon, 26 Oct 2020 10:48:52 -0500
Message-Id: <20201026154852.221483-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Prior to commit 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI
resources"), the DWC driver was setting up the last memory resource
rather than the first memory resource. This doesn't matter for most
platforms which only have 1 memory resource, but it broke Tegra194 which
has a 2nd (prefetchable) memory region which requires an ATU entry. The
first region on Tegra194 relies on the default 1:1 pass-thru of outbound
transactions which doesn't need an ATU entry.

Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
Reported-by: Vidya Sagar <vidyas@nvidia.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 674f32db85ca..44c2a6572199 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -586,8 +586,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * ATU, so we should not program the ATU here.
 	 */
 	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
-		struct resource_entry *entry =
-			resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+		struct resource_entry *tmp, *entry = NULL;
+
+		/* Get last memory resource entry */
+		resource_list_for_each_entry(tmp, &pp->bridge->windows)
+			if (resource_type(tmp->res) == IORESOURCE_MEM)
+				entry = tmp;
 
 		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, entry->res->start,
-- 
2.25.1

