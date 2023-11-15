Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7E7EBF4D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 10:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjKOJQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 04:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjKOJQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 04:16:45 -0500
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B2518C
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 01:16:39 -0800 (PST)
X-ASG-Debug-ID: 1700039775-1eb14e538e15da0001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id NCSNkDLaKjybgSav (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 15 Nov 2023 17:16:15 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 15 Nov
 2023 17:16:15 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 15 Nov
 2023 17:16:13 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
        <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linux.dev>
CC:     <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <ErosZhang@zhaoxin.com>, <LeoLiu@zhaoxin.com>,
        LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH 0/3] Parse the HEST PCIe AER and set to relevant registers
Date:   Wed, 15 Nov 2023 17:16:09 +0800
X-ASG-Orig-Subj: [PATCH 0/3] Parse the HEST PCIe AER and set to relevant registers
Message-ID: <20231115091612.580685-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1700039775
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1038
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.116774
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

According to the Section 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI SPEC r6.5,
the register value form HEST PCI Express AER Structure should be written to
relevant PCIe Device's AER Capabilities. So the purpose of the patch set is
to extract register value from HEST PCI Express AER structures and program
them into PCIe Device's AER registers. Refer to the ACPI SPEC r6.5 for the
more detailed description.

leoliu-oc (3):
  ACPI/APEI: Add hest_parse_pcie_aer()
  PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
  PCI/ACPI: Add pci_acpi_program_hest_aer_params()

 drivers/acpi/apei/hest.c      |  77 +++++++++++++++++++++++++-
 drivers/pci/pci-acpi.c        | 100 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   9 +++
 drivers/pci/probe.c           |   1 +
 include/acpi/actbl1.h         |   7 +++
 include/acpi/apei.h           |   8 +++
 include/uapi/linux/pci_regs.h |   3 +
 7 files changed, 203 insertions(+), 2 deletions(-)

-- 
2.34.1

