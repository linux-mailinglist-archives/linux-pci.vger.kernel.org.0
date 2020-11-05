Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240292A8894
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 22:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgKEVMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 16:12:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37787 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 16:12:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id m17so3188098oie.4
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2020 13:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQyia8yFxJFo/T6o8CYQ5VyHneaAbbvX2dVIUGSCMQQ=;
        b=a40U9rrhDA+P7B96epW8sb4Xf36OEJ89cqzudeqCezRBTfGpzI7luo9Y6ftJkZ+ClK
         S+Wye4cysk9Ou5nUgPCtSrDOjs3shYPMgjPSdVXfcj+TtLpVHQFFCbLdmhM3rIh5X6Io
         y+K/tGJntp+xI1pTLpUe6PbT3QSFAjnKmYWCEvw1uAdFNghCBk7suS0QClUNzeqNqM9o
         qK/H0a2lKy17V/t3Q70nipdpE4H1Ex8BbpZkWnpVoUpcDK+t/K+kwzyGmplNh+6O+tHQ
         CG9SAiDeSiKaui28UlV+ckd+QAgaZl1U1peSkqg4W3Jw3mcLjsggfs0vN+fqiEBYNTi7
         2WVw==
X-Gm-Message-State: AOAM531Q47fM70yTfQWOg7fBKWiKfTcoSE/GuwLNDZrN2IXCjmix4Csg
        Feg2GQdurb50RsoAyb08a2EE1ZGZUpY4
X-Google-Smtp-Source: ABdhPJw4E9Q1ELWOUJff4xH2dQ9+7FXQC6EFAPgit0ROAMaO991OoT3yN9MtRny4Lpbt4KvLBiGP1A==
X-Received: by 2002:aca:4849:: with SMTP id v70mr890526oia.103.1604610725035;
        Thu, 05 Nov 2020 13:12:05 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z19sm622549ooi.32.2020.11.05.13.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:12:04 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 02/16] PCI: dwc/intel-gw: Move ATU offset out of driver match data
Date:   Thu,  5 Nov 2020 15:11:45 -0600
Message-Id: <20201105211159.1814485-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105211159.1814485-1-robh@kernel.org>
References: <20201105211159.1814485-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ATU offset should be a register range in DT called 'atu', not driver
match data. Any future platforms with a different ATU offset should add
it to their DT.

This is also in preparation to do DBI resource setup in the core DWC
code, so let's move setting atu_base later in intel_pcie_rc_setup().

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 5650cb78acba..77ef88333115 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -58,7 +58,6 @@
 
 struct intel_pcie_soc {
 	unsigned int	pcie_ver;
-	unsigned int	pcie_atu_offset;
 	u32		num_viewport;
 };
 
@@ -155,11 +154,15 @@ static void intel_pcie_init_n_fts(struct dw_pcie *pci)
 
 static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
 {
+	struct dw_pcie *pci = &lpp->pci;
+
+	pci->atu_base = pci->dbi_base + 0xC0000;
+
 	intel_pcie_ltssm_disable(lpp);
 	intel_pcie_link_setup(lpp);
-	intel_pcie_init_n_fts(&lpp->pci);
-	dw_pcie_setup_rc(&lpp->pci.pp);
-	dw_pcie_upconfig_setup(&lpp->pci);
+	intel_pcie_init_n_fts(pci);
+	dw_pcie_setup_rc(&pci->pp);
+	dw_pcie_upconfig_setup(pci);
 }
 
 static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
@@ -425,7 +428,6 @@ static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
 
 static const struct intel_pcie_soc pcie_data = {
 	.pcie_ver =		0x520A,
-	.pcie_atu_offset =	0xC0000,
 	.num_viewport =		3,
 };
 
@@ -461,7 +463,6 @@ static int intel_pcie_probe(struct platform_device *pdev)
 
 	pci->ops = &intel_pcie_ops;
 	pci->version = data->pcie_ver;
-	pci->atu_base = pci->dbi_base + data->pcie_atu_offset;
 	pp->ops = &intel_pcie_dw_ops;
 
 	ret = dw_pcie_host_init(pp);
-- 
2.25.1

