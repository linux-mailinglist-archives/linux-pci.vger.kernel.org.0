Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9D71DCE45
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 15:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgEUNhn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 09:37:43 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:40518 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729500AbgEUNhn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 09:37:43 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 361F540181;
        Thu, 21 May 2020 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590068263; bh=ddOvXSEAQYaEYgYVMqwHRjKBo6YBzpruN7ckn6o1zRI=;
        h=From:To:Cc:Subject:Date:From;
        b=gZ8m+RQKiNlDPgrYrexaOQRRAcjVRGSefFH8NlnHem9MjH2dgIxDF0lLTSYKslvEK
         ABJwVFFFihSL15K8lJwoJA0leUhddeEgw3CL+GfdUN81dnMqHcpKH0uegWxMjvfrOH
         sNppTF8cPLKbg+RatDydmmhtdgB4lLkeNIIYCZ556At+W4eQJc6cETJGsI4m20Y1nT
         tf2x8mBhguDhOihqpUVNtBFwAGhOJHRVDcArTBEBOkE98Wu8IEndZx69W8MoU54KEx
         I6jl+AdqH3ZW8oCogU0l8LH4ddJvDfCYWglQoPFxAlQTkMe374LnnD64G3b3DpGMrd
         BNbVAQl2lxh8w==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id AAB5CA005B;
        Thu, 21 May 2020 13:37:41 +0000 (UTC)
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     helgaas@kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Aditya Paluri <Venkata.AdityaPaluri@synopsys.com>,
        linux-pci@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] PCI/PTM: Fix PTM switch capability evaluation
Date:   Thu, 21 May 2020 15:37:30 +0200
Message-Id: <0b974380436d46ab3d8b7f4988f17e6f822079ac.1590068178.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to enable PTM feature in a PCIe Endpoint, it is required to
enable this feature as well in all devices capable (if present) in the
datapath between the Root complex and the referred Endpoint e.g. PCIe
switches.

RC <--> Switch (USP) <-> Switch (DSP) <-> EP

According to PCIe specification Rev5 (6.22.3.2) and (7.9.16), in order
to enable this feature on a PTM capable switch, it's required to write a
enable bit in the switch upstream port (USP) control register, which after
that must respond to all PTM request messages received at any of its
downstream ports (DSP).

The previous implementation verifies if the PCIe switch has the PTM
feature enabled on both streams ports (USP and DSP). Since the DSP
doesn't support PTM capability, the previous implementation doesn't
allow the PTM feature to be enabled in the Endpoint, the current patch
fixes this.

Fixes: eec097d43100 ("PCI: Add pci_enable_ptm() for drivers to enable PTM on endpoints")
Signed-off-by: Aditya Paluri <venkata.adityapaluri@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org
Cc: Joao Pinto <jpinto@synopsys.com>
---
 drivers/pci/pcie/ptm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 9361f3a..cd85d44 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -111,6 +111,14 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
 		ups = pci_upstream_bridge(dev);
+		/*
+		 * Per PCIe r5.0, sec 7.9.16, the PTM capability is not
+		 * permitted in Switch Downstream Ports
+		 */
+		if (ups && ups->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
+		    pci_pcie_type(ups) == PCI_EXP_TYPE_DOWNSTREAM)
+			ups = pci_upstream_bridge(ups);
+
 		if (!ups || !ups->ptm_enabled)
 			return -EINVAL;
 
-- 
2.7.4

