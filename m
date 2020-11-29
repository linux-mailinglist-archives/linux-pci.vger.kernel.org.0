Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C522C7BEA
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 00:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgK2XIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Nov 2020 18:08:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44542 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK2XIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Nov 2020 18:08:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id 64so13064877wra.11
        for <linux-pci@vger.kernel.org>; Sun, 29 Nov 2020 15:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uPxJqe/4fqAvPeHEi4PXiRImG9ouLArz1SvUbqNRaMU=;
        b=hGrfin1D0q77H+dg3iPBziXYB6ZFv56ENF6lWRLEWZ/MzorBS8X+nyx3yzSE/Wp4nc
         enKueNXsB8nQ8GCvFiZ+gqyu/qevU5wgSJ15GKA0bc6OLmAc5ULKsP8Hfu7ZG1cmu8FE
         AvXU6Bpk9n2LQWMGfvtQDAEh/UFxTpDAFYZyBZwu+ZsMWh3P7i6hGepGAwRnBv24h0oO
         MMCuNN6PslescoPtme3Ufz3YqQZ2N4Gl30vmeVsw08ClkDmOkpoWJAHgBCPO5kxBWZR6
         FQlBkRY+sGQdziB2xPZy2tgqyM6ZDv0uKI61/lUraxXRzYPM2vMKhimfQZMBwEbpS2f8
         ww2Q==
X-Gm-Message-State: AOAM533z0uPO2f4UijwypxtzfMHi89KET3D85tn5KlVNNfxLlSK0Bm7d
        qJiMLXatg/aoomaG75Qw3Ts=
X-Google-Smtp-Source: ABdhPJxBybijJQjc+K6GS3b05hGcfYGidU+rzn/2+1RrcEs/rkLFlqp5WDEDRPkMUSgp4rfySiTCfA==
X-Received: by 2002:adf:e912:: with SMTP id f18mr24033599wrm.79.1606691274071;
        Sun, 29 Nov 2020 15:07:54 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d2sm24831005wrn.43.2020.11.29.15.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 15:07:53 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v6 5/5] PCI: xgene: Removed unused ".bus_shift" initialisers from pci-xgene.c
Date:   Sun, 29 Nov 2020 23:07:43 +0000
Message-Id: <20201129230743.3006978-6-kw@linux.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129230743.3006978-1-kw@linux.com>
References: <20201129230743.3006978-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Removed unused ".bus_shift" initialisers from pci-xgene.c as
xgene_pcie_map_bus() did not use these.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/pci-xgene.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 8e0db84f089d..85e7c98265e8 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -257,7 +257,6 @@ static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
 }
 
 const struct pci_ecam_ops xgene_v1_pcie_ecam_ops = {
-	.bus_shift	= 16,
 	.init		= xgene_v1_pcie_ecam_init,
 	.pci_ops	= {
 		.map_bus	= xgene_pcie_map_bus,
@@ -272,7 +271,6 @@ static int xgene_v2_pcie_ecam_init(struct pci_config_window *cfg)
 }
 
 const struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
-	.bus_shift	= 16,
 	.init		= xgene_v2_pcie_ecam_init,
 	.pci_ops	= {
 		.map_bus	= xgene_pcie_map_bus,
-- 
2.29.2

