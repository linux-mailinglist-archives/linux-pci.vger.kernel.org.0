Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF5760EECB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 05:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiJ0DqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 23:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiJ0Dp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 23:45:57 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3A43CBD7
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2022 20:45:51 -0700 (PDT)
X-ASG-Debug-ID: 1666840501-1eb14e7e6453440001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id 3nQPDXg0rWtNe8Ta (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 27 Oct 2022 11:15:01 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Thu, 27 Oct
 2022 11:15:01 +0800
Received: from localhost.localdomain (10.32.64.1) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Thu, 27 Oct
 2022 11:14:59 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <ying.huang@intel.com>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>
CC:     <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <ErosZhang@zhaoxin.com>, leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: [PATCH 0/5] Parse the PCIE AER structure and set to relevant registers
Date:   Thu, 27 Oct 2022 11:14:58 +0800
X-ASG-Orig-Subj: [PATCH 0/5] Parse the PCIE AER structure and set to relevant registers
Message-ID: <20221027031458.2855599-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1666840501
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 940
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4116 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.101705
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

HEST PCIE AER error source information describes the Uncorrectable Error 
Severity, CorrectableError Mask and other aer register's value to write to the
bridge's Correctable Error Mask register.

leoliu-oc (5):
  ACPI/APEI: Add apei_hest_parse_aer()
  ACPI/APEI: remove static from apei_hest_parse()
  ACPI/PCI: Add AER bits #defines for PCIE/PCI-X bridges
  ACPI/PCI: Add pci_acpi_program_hest_aer_params()
  ACPI/PCI: config pcie devices's aer register

 drivers/acpi/apei/hest.c      | 121 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci-acpi.c        |  92 ++++++++++++++++++++++++++
 drivers/pci/pci.h             |   5 ++
 drivers/pci/probe.c           |   1 +
 include/acpi/actbl1.h         |  69 +++++++++++++++++++
 include/acpi/apei.h           |   9 +++
 include/uapi/linux/pci_regs.h |   5 ++
 7 files changed, 300 insertions(+), 2 deletions(-)

-- 
2.20.1

