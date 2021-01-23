Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75C93011EB
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jan 2021 02:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhAWBQe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 20:16:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:27056 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbhAWBQ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 20:16:28 -0500
IronPort-SDR: dLMcPFoAvKaiWG7ZEZZ6I6cDtu21aE8k/POlLgDvTstono/LalZfwuh7Y8kP6NX2JBtWw90CxV
 tI8eSKaKdhbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="176962174"
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="176962174"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:20 -0800
IronPort-SDR: o+4R9H1AqMz5s2c5cDjFhoe8ECfqo7T7KnEKEDipoL5PtC1Dfs+41yQKoFaqZER+j/toSS4QOe
 uxDOOg+MjoBA==
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="386084677"
Received: from usundar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.36.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:20 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v13 1/5] PCI/DPC: Ignore devices with no AER Capability
Date:   Fri, 22 Jan 2021 17:11:09 -0800
Message-Id: <c81f2497fabb8cc312b766600343480e16fe9b1b.1611364025.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Downstream Ports may support DPC regardless of whether they support AER
(see PCIe r5.0, sec 6.2.10.2).  Previously, if the user booted with
"pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
depends on the AER Capability.

dpc_probe() previously failed if:

  !pcie_aer_is_native(pdev) && !pcie_ports_dpc_native
  !(pcie_aer_is_native() || pcie_ports_dpc_native)    # by De Morgan's law

so it succeeded if:

  pcie_aer_is_native() || pcie_ports_dpc_native

Fail dpc_probe() if the device has no AER Capability.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Olof Johansson <olof@lixom.net>
---
 drivers/pci/pcie/dpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e05aba86a317..ed0dbc43d018 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -287,6 +287,9 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
+	if (!pdev->aer_cap)
+		return -ENOTSUPP;
+
 	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
 
-- 
2.25.1

